library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_VHDL;
use lib_VHDL.my_type.all;

entity BANK_REG is
  
  port (
    CLK           : in  std_logic;
    RST           : in  std_logic;
    busULA        : in  std_logic_vector(31 downto 0);
    busMUL        : in  std_logic_vector(31 downto 0);
    busMD         : in  std_logic_vector(31 downto 0);
    CPSR_next_ULA : in  std_logic_vector(31 downto 0);
    CPSR_next_MUL : in  std_logic_vector(31 downto 0);
    PC_next       : in  std_logic_vector(31 downto 0);
    PC_current    : in  std_logic_vector(31 downto 0);
    DA            : in  std_logic_vector(3 downto 0);
    FS_TEST       : in  std_logic;
    WR            : in  std_logic;
    S             : in  std_logic;
    LINK          : in  std_logic;
    DET_BRANCH    : in  std_logic;
    DET_ULA       : in  std_logic;
    DET_MUL       : in  std_logic;
    DET_LDR       : in  std_logic;
    DET_STR       : in  std_logic;
    Sel_BUS       : in  std_logic_vector(1 downto 0);
    CPSR          : out std_logic_vector(31 downto 0);
    REG           : out TAB_REG_OUT(0 to 15));

end BANK_REG;


architecture RTL of BANK_REG is

  signal busC        : std_logic_vector(31 downto 0);
  signal PC          : std_logic_vector(31 downto 0);
  signal DET_LDR_STR : std_logic;
  
begin  -- RTL

  DET_LDR_STR <= DET_LDR or DET_STR;
  
  -- MUX (2:1) Pour SELECTIONER Resultat d'ULA / MULT / MemoireDonnee
    busC <=   busULA when Sel_BUS="00" else
              busMUL when Sel_BUS="01" else
              busMD  when Sel_BUS="10" else
              busULA ;

  SEQ : process (CLK, RST)
  begin  -- process SEQ
    
    if CLK'event and CLK = '1' then  -- rising clock edge
      if RST = '1' then              -- synchronous reset (active high)
        CPSR    <= "00000000000000000000000000000000";
        REG(0)  <= "00000000000000000000000000000000";
        REG(1)  <= "00000000000000000000000000000000";
        REG(2)  <= "00000000000000000000000000000000";
        REG(3)  <= "00000000000000000000000000000000";
        REG(4)  <= "00000000000000000000000000000000";
        REG(5)  <= "00000000000000000000000000000000";
        REG(6)  <= "00000000000000000000000000000000";
        REG(7)  <= "00000000000000000000000000000000";
        REG(8)  <= "00000000000000000000000000000000";
        REG(9)  <= "00000000000000000000000000000000";
        REG(10) <= "00000000000000000000000000000000";
        REG(11) <= "00000000000000000000000000000000";
        REG(12) <= "00000000000000000000000000000000";
        REG(13) <= "00000000000000000000000000000000";
        REG(14) <= "00000000000000000000000000000000";
        REG(15) <= "00000000000000000000000000000000";
      else

        -- Actualise PC
        REG(15) <= PC_next;
        
        -- Gestion d'actualisation CPSR:
        if DET_LDR_STR = '0' or S = '0' then
          if DET_ULA = '1' then
            CPSR <= CPSR_next_ULA;
          elsif DET_MUL = '1' then
            CPSR <= CPSR_next_MUL;
          end if;
        end if;


       -- Problèmes de PIPELINE et gestion ici sera:
       -- BLOC DU PC DEMANDE LA COPIE DE PC+1 DANS LR et "PERDRE" le valeur actuelle de R14
        if DET_BRANCH = '1' and LINK = '1' then
          REG(14) <= std_logic_vector(unsigned(PC_current));
        end if;

        -- "Normale"
        if WR = '1' and FS_TEST = '0' and DET_STR = '0' and DET_BRANCH = '0' then -- "Laisse-faire"

          -- Sans problèmes de PIPELINE:
          -- ATTENTION: La priorite n'est pas do PC_next quand on utilise le REG15

          REG(to_integer(unsigned(DA))) <= busC;

        end if;
      end if;
      
    end if;
  end process SEQ;
end RTL;


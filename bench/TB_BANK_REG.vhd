library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

library lib_VHDL;
use lib_VHDL.all;
use lib_VHDL.my_type.all;

entity TB_BANK_REG is

end TB_BANK_REG;

architecture RTL of TB_BANK_REG is
  component BANK_REG
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
      LINK          : in  std_logic;
      DET_BRANCH    : in  std_logic;
      DET_ULA       : in  std_logic;
      DET_MUL       : in  std_logic;
      DET_LDR       : in  std_logic;
      DET_STR       : in  std_logic;
      Sel_BUS       : in  std_logic_vector(1 downto 0);
      CPSR          : out std_logic_vector(31 downto 0);
      REG           : out TAB_REG_OUT(0 to 15));
  end component;

  signal sig_CLK           : std_logic := '0';
  signal sig_RST           : std_logic;
  signal sig_busULA        : std_logic_vector(31 downto 0);
  signal sig_busMUL        : std_logic_vector(31 downto 0);
  signal sig_busMD         : std_logic_vector(31 downto 0);
  signal sig_CPSR_next_ULA : std_logic_vector(31 downto 0);
  signal sig_CPSR_next_MUL : std_logic_vector(31 downto 0);
  signal sig_PC_next       : std_logic_vector(31 downto 0);
  signal sig_PC_current    : std_logic_vector(31 downto 0);
  signal sig_DA            : std_logic_vector(3 downto 0);
  signal sig_FS_TEST       : std_logic;
  signal sig_WR            : std_logic;
  signal sig_LINK          : std_logic;
  signal sig_DET_BRANCH    : std_logic;
  signal sig_DET_ULA       : std_logic;
  signal sig_DET_MUL       : std_logic;
  signal sig_DET_LDR       : std_logic;
  signal sig_DET_STR       : std_logic;
  signal sig_Sel_BUS       : std_logic_vector(1 downto 0);
  signal sig_CPSR          : std_logic_vector(31 downto 0);
  signal sig_REG           : TAB_REG_OUT(0 to 15);
  
begin  -- RTL
  
  U0 : BANK_REG port map (sig_CLK,sig_RST,sig_busULA,sig_busMUL,sig_busMD,sig_CPSR_next_ULA,sig_CPSR_next_MUL,sig_PC_next,sig_PC_current,sig_DA,sig_FS_TEST,sig_WR,sig_LINK,sig_DET_BRANCH,sig_DET_ULA,sig_DET_MUL,sig_DET_LDR,sig_DET_STR,sig_Sel_BUS,sig_CPSR,sig_REG);

  sig_RST <= '1', '0' after 20 ns;
  sig_CLK <= not sig_CLK after 5 ns;   
  
  process
    variable i : integer range 0 to 15;
  begin
    -- Signaux de controle:
    sig_Sel_BUS     <= "00";            -- Il selectionne le BusULA
    sig_WR          <= '0';             -- Il n'écrit rien dans les REGs, sauf REG(15)
    sig_FS_TEST     <= '0';             -- Si instruction d'ULA, l'instruction n'est pas de test
    
    -- Gestion pour actualiser le CPSR:
    sig_DET_LDR <= '0';                 -- N'est pas instruction de LOAD/STORE
    sig_DET_STR <= '0';

    
    sig_DET_ULA     <= '0';             -- N'est pas instruction d'ULA
    sig_DET_MUL     <= '0';             -- N'est pas instruction de MUL

    --Gestion pour actualiser le PC:
    sig_DET_BRANCH  <= '0';             -- N'est pas instruction de BRANCH
    sig_LINK        <= '0';             -- Si BRANCH, il n'y a pas de LINK
    
    
    -- Exemples de valeurs:
    sig_CPSR_next_MUL <= "11000000000000000000000000000000";
    sig_CPSR_next_ULA <= "11110000000000000000000000000000"; 
    sig_PC_next       <= "10101010101010101010101010101010";
    sig_PC_current    <= "00001111000011110000111100001111";
    sig_DET_LDR       <= '0';
    sig_DET_STR       <= '0';
    sig_DET_MUL       <= '0';
    sig_DET_ULA       <= '0';
    sig_DET_BRANCH    <= '0';
    sig_LINK          <= '0';
    
    wait for 10 ns;

    -- ECRIRE DANS LE REGS LE VALEUR DE SORTIE DE L'ULA:

    sig_Sel_BUS     <= "00";  -- Il charge le bus_ULA (qui peut-etre imediate aussi, c'est le meme bus);
    sig_DET_LDR     <= '0';   -- N'est pas instruction LOAD/STORE 
    sig_DET_STR     <= '0';
    sig_DET_ULA     <= '1';   -- L'instruction est d'ULA, CPSR sera actualise;
    sig_DET_BRANCH  <= '0';   -- Il n'y a pas de BRANCH, donc PC recoit PC_next;
    sig_WR          <= '1';   -- Le circuit TEST_COND envoie le signal "laisse_faire";
    
    for i in 0 to 15 loop
      sig_busULA <= "0000000000000000000000000000"&std_logic_vector(to_unsigned(i,4));  
      sig_DA     <= std_logic_vector(to_unsigned(i,4));
      wait for 10 ns;
    end loop;  -- i

    -- ECRIRE DANS LE REGS LE VALEUR DE SORTIE DE L'MUL:

    sig_Sel_BUS <= "01";
    sig_DET_ULA <= '0';
    sig_DET_MUL <= '1';
    
    for i in 0 to 15 loop
      sig_busMUL <= "0000000000000000111111111111"&std_logic_vector(to_unsigned(i,4));
      sig_DA     <= std_logic_vector(to_unsigned(i,4));
      wait for 10 ns;
    end loop;  -- i

    -- ECRIRE DANS LE REGS LE VALEUR DE SORTIE DE L'MD:

    sig_Sel_BUS     <= "10";
    sig_DET_MUL     <= '0';
    sig_DET_LDR     <= '1';
    sig_DET_STR     <= '0';
    
    for i in 0 to 15 loop                   
      sig_busMD <= "1111111111111111111111111111"&std_logic_vector(to_unsigned(i,4));
      sig_DA    <= std_logic_vector(to_unsigned(i,4));
      wait for 10 ns;
    end loop;  -- i

    -- N'EST ECRIRE PAS DANS LES REGISTRES

    sig_DET_LDR     <= '0';
    sig_DET_STR     <= '0';    
    sig_DET_ULA     <= '1';   -- Si operation ULA il ecrit le CPSR 
    sig_DET_MUL     <= '0';
    sig_DET_BRANCH  <= '0';  
    sig_WR          <= '0';   -- N'ecrit pas
    sig_Sel_BUS     <= "11";  -- Essaye default

    for i in 0 to 15 loop                   
      sig_busULA <= "1111111111111111111111111111"&std_logic_vector(to_unsigned(i,4));
      sig_DA     <= std_logic_vector(to_unsigned(i,4));
      wait for 10 ns;
    end loop;  -- i

    -- TEST: BRANCH avec LINK
    -- sig_PC_current <= "00001111000011110000111100001111" = "0F0F0F0F";

    --sig_DET_ULA  <= '1';
    --sig_DET_MUL  <= '0';
    --sig_DET_LDR  <= '0';
    --sig_DET_STR  <= '0';
    
    sig_Sel_BUS    <= "00";
    sig_DA         <= "1110";
    sig_WR         <= '1';
    sig_DET_BRANCH <= '1';
    sig_LINK       <= '1';   
    wait for 10 ns;

    -- TEST: BRANCH s/ LINK

    --sig_DET_ULA     <= '1';
    --sig_DET_MUL     <= '0';
    --sig_DET_LDR  <= '0';
    --sig_DET_STR  <= '0';
    
    sig_Sel_BUS    <= "00";
    sig_DA         <= "1110";
    sig_WR         <= '1';
    sig_DET_BRANCH <= '1';
    sig_LINK       <= '0';   
    wait for 10 ns;
    
    -- NE PAS ECRIRE DANS LES REGISTRES 

    sig_WR <= '0';   -- N'ecrit pas

    for i in 0 to 15 loop                   
      sig_busULA <= "1111111111111111111111111111"&std_logic_vector(to_unsigned(i,4));
      sig_DA     <= std_logic_vector(to_unsigned(i,4));
      wait for 10 ns;
    end loop;  -- i

    -- NE PAS ECRIRE DANS LES REGISTRES 

    sig_WR      <= '1'; 
    sig_FS_TEST <= '1'; -- N'ecrit pas
    
    for i in 0 to 15 loop                   
      sig_busULA <= "1111111111111111111111111111"&std_logic_vector(to_unsigned(i,4));
      sig_DA     <= std_logic_vector(to_unsigned(i,4));
      wait for 10 ns;
    end loop;  -- i
    
    -- <!> Temps necessaire pour simuler tout ca 990 ns;
    
  end process;
end RTL;

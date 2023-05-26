library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

library lib_VHDL;
use lib_VHDL.my_type.all;

entity MEM_DONNEE is
  
  port (
    CLK       : in  std_logic;
    RST       : in  std_logic;
    busA      : in  std_logic_vector(31 downto 0);
    busB      : in  std_logic_vector(31 downto 0);
    Offset    : in  std_logic_vector(31 downto 0);
    I         : in  std_logic;
    AUT_INDEX : in  std_logic;
    WR        : in  std_logic;
    DET_LDR   : in  std_logic;
    DET_STR   : in  std_logic;
    S         : out std_logic_vector(31 downto 0));

end entity MEM_DONNEE;

architecture RTL of MEM_DONNEE is
  constant size  : integer := 100;
  signal I_AUT   : std_logic_vector(1 downto 0);
  signal LDR_STR : std_logic;
  signal ARG     : std_logic_vector(31 downto 0);
  signal MEM     : TAB_REG_OUT(0 to size);                           -- Valeur d'address doit être < 62 (111111)
                                                                   -- par ex.: offset doit etre < 111111
begin  -- architecture RTL

  LDR_STR <= (not DET_LDR) and DET_STR;
  I_AUT   <= I&AUT_INDEX;

  process (busB,Offset,I_AUT) is      -- CAL. L'ARGUMENT
    variable def_val : unsigned(31 downto 0);
  begin  -- process

    case I_AUT is
      when "00"   => def_val := unsigned(busB);
      when "01"   => def_val := unsigned(busB) + unsigned(Offset);
      when "10"   => def_val := unsigned(Offset);
      when others => def_val := unsigned(Offset);
    end case;

    ARG <= std_logic_vector(def_val);

  end process;

  process (ARG,WR,LDR_STR,MEM) is  -- LOAD
  begin  -- process
    if WR = '1' and LDR_STR = '0' then
      S <= MEM(to_integer(unsigned(ARG)));
      else
        S<=MEM(0);
    end if;
  end process;

  process (CLK, RST) is              -- STORE

  begin  -- process     
    if CLK'event and CLK = '1' then  -- rising clock edge
      if RST = '1' then

        for i in 0 to size loop
          MEM(i) <= (others => '0');
        end loop;  -- i
        
      else

        if WR = '1' and LDR_STR = '1' then
          MEM(to_integer(unsigned(ARG))) <= busA;          
        end if;

      end if;
    end if;
  end process;  
end architecture RTL;

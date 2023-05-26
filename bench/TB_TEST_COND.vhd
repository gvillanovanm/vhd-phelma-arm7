library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

library lib_VHDL;
use lib_VHDL.TEST_COND;

entity TB_TEST_COND is  
end TB_TEST_COND;

architecture RTL of TB_TEST_COND is

  component TEST_COND
    port (
      COND       : in  std_logic_vector(3 downto 0);
      CPSR       : in  std_logic_vector(3 downto 0);
      S          : in  std_logic;
      DET_STR    : in  std_logic;
      WR         : out std_logic);
  end component;
  
  signal sig_COND    : std_logic_vector(3 downto 0);
  signal sig_CPSR    : std_logic_vector(3 downto 0);
  signal sig_S       : std_logic;
  signal sig_DET_STR : std_logic := '0';
  signal sig_WR      : std_logic;
  
begin  -- RTL

  U0: TEST_COND port map (sig_COND,sig_CPSR,sig_S,sig_WR);
  
  process
    variable i : integer range 0 to 15;
    variable j : integer range 0 to 15;
  begin
    
    sig_S <= '1';                       -- C'est conditional
    for j in 0 to 15 loop
      sig_CPSR <= std_logic_vector(to_unsigned(j,4)); 
      for i in 0 to 15 loop
        sig_COND <= std_logic_vector(to_unsigned(i,4));
        wait for 10 ns;
      end loop;  -- i
    end loop;  -- j

    sig_S <= '0';                       -- N'est pas conditional
    for j in 0 to 15 loop
      sig_CPSR <= std_logic_vector(to_unsigned(j,4)); 
      for i in 0 to 15 loop
        sig_COND <= std_logic_vector(to_unsigned(i,4));
        wait for 10 ns;
      end loop;  -- i
    end loop;  -- j    


    -- <!> Temps necessaire pour simuler 5120 ns;
    
  end process;
end RTL;

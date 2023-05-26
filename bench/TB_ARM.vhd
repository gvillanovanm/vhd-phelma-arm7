library IEEE;
use IEEE.std_logic_1164.all;

library lib_VHDL;
use lib_VHDL.all;
use lib_VHDL.my_type.all;

entity TB_ARM is
end entity TB_ARM;

architecture RTL of TB_ARM is

  component ARM is
    port (
      CLK : in std_logic;
      RST : in std_logic);
  end component ARM;

  signal sig_CLK : std_logic := '0';
  signal sig_RST : std_logic;
  
begin  -- architecture RTL

  A0 : ARM port map (sig_CLK,sig_RST);
  
  sig_CLK <= not sig_CLK after 10 ns;
  sig_RST <= '1', '0' after 45 ns;

end architecture RTL;

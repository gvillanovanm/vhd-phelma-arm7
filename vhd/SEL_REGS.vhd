library IEEE;
use IEEE.std_logic_1164.all;

library lib_VHDL;
use lib_VHDL.my_type.all;

entity SEL_REGS is
  
  port (
    REGS   : in  TAB_REG_OUT(0 to 15);
    SEL_RA : in  std_logic_vector(3 downto 0);
    SEL_RB : in  std_logic_vector(3 downto 0);
    busA   : out std_logic_vector(31 downto 0);
    busB   : out std_logic_vector(31 downto 0));

end SEL_REGS;

architecture RTL of SEL_REGS is

  signal busREGS : TAB_REG_OUT(0 to 15);
  
begin  -- RTL

  busREGS <= REGS;
  
  process(REGS,SEL_RA,SEL_RB,busREGS)
  begin

    case SEL_RA is
      when "0000" => busA <= busREGS(0);
      when "0001" => busA <= busREGS(1);
      when "0010" => busA <= busREGS(2);
      when "0011" => busA <= busREGS(3);
      when "0100" => busA <= busREGS(4);
      when "0101" => busA <= busREGS(5);
      when "0110" => busA <= busREGS(6);
      when "0111" => busA <= busREGS(7);
      when "1000" => busA <= busREGS(8);
      when "1001" => busA <= busREGS(9);
      when "1010" => busA <= busREGS(10);
      when "1011" => busA <= busREGS(11);
      when "1100" => busA <= busREGS(12);
      when "1101" => busA <= busREGS(13);
      when "1110" => busA <= busREGS(14);
      when "1111" => busA <= busREGS(15);
      when others => null;                     
    end case;

    case SEL_RB is
      when "0000" => busB <= busREGS(0);
      when "0001" => busB <= busREGS(1);
      when "0010" => busB <= busREGS(2);
      when "0011" => busB <= busREGS(3);
      when "0100" => busB <= busREGS(4);
      when "0101" => busB <= busREGS(5);
      when "0110" => busB <= busREGS(6);
      when "0111" => busB <= busREGS(7);
      when "1000" => busB <= busREGS(8);
      when "1001" => busB <= busREGS(9);
      when "1010" => busB <= busREGS(10);
      when "1011" => busB <= busREGS(11);
      when "1100" => busB <= busREGS(12);
      when "1101" => busB <= busREGS(13);
      when "1110" => busB <= busREGS(14);
      when "1111" => busB <= busREGS(15);
      when others => null;                     
    end case;
    
  end process;
end RTL;
  

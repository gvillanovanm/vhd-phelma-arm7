library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Creation d'un nouveau type à partir des types dèjá existent:

package my_type is
  type TAB_REG_OUT is array(natural range <>) of std_logic_vector(31 downto 0);
end package my_type;



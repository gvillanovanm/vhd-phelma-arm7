library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

library lib_VHDL;
use lib_VHDL.BARREL_SHIFTER; 

entity TB_BARREL_SHIFTER is end TB_BARREL_SHIFTER;

architecture RTL of TB_BARREL_SHIFTER is

  component BARREL_SHIFTER
    port( busB   : in  std_logic_vector(31 downto 0);
          offset : in  std_logic_vector(31 downto 0);
          Carry  : in  std_logic;
          I      : in  std_logic;
          SS     : in  std_logic_vector(2 downto 0);
          NS     : in  std_logic_vector(2 downto 0);
          S      : out std_logic_vector(31 downto 0));
  end component;

  signal sig_busB   : std_logic_vector(31 downto 0);
  signal sig_offset : std_logic_vector(31 downto 0);
  signal sig_Carry  : std_logic;
  signal sig_I      : std_logic;
  signal sig_SS     : std_logic_vector(2 downto 0);
  signal sig_NS     : std_logic_vector(2 downto 0);
  signal sig_S      : std_logic_vector(31 downto 0);
  
begin  -- RTL

  U0  : BARREL_SHIFTER port map (sig_busB,sig_offset,sig_Carry,sig_I,sig_SS,sig_NS,sig_S);

  sig_busB   <= "10101010101010101010101010101010";
  sig_offset <= "01010101010101010101010101010101";
  sig_CARRY  <= '0';  

  process

    variable i : integer range 0 to 7;
    variable j : integer range 0 to 7;
    
  begin

    -- EN UTILISANT LE SIGNAL busB (I=0) & CARRY = 0
    sig_I      <= '0';
    sig_SS     <= "000";
    sig_NS     <= "000";

    for j in 0 to 7 loop
      for i in 0 to 7 loop
        wait for 10 ns;
        sig_SS <= std_logic_vector(to_unsigned(j,3));
        sig_NS <= std_logic_vector(to_unsigned(i,3));
      end loop;
    end loop; 

    -- EN UTILISANT LE SIGNAL offset & CARRY = 0
    sig_I      <= '1';
    sig_SS     <= "000";
    sig_NS     <= "000";

    for j in 0 to 7 loop
      for i in 0 to 7 loop
        wait for 10 ns;
        sig_SS <= std_logic_vector(to_unsigned(j,3));
        sig_NS <= std_logic_vector(to_unsigned(i,3));
      end loop;
    end loop;

    -- Temps necessaire pour simuler 1280 ns;
    
  end process;
end RTL;

library IEEE;
use     IEEE.std_logic_1164.all;

library lib_VHDL;
use lib_VHDL.ULA;

entity TB_ULA is end TB_ULA;

architecture RTL of TB_ULA is
  
  component ULA
    port ( busA          : in  std_logic_vector(31 downto 0);
           busB          : in  std_logic_vector(31 downto 0); 
           FS            : in  std_logic_vector(3 downto 0);
           CPSR          : in  std_logic_vector(31 downto 0);
           FS_TEST       : out std_logic;
           CPSR_next_ULA : out std_logic_vector(31 downto 0);
           S             : out std_logic_vector(31 downto 0));
  end component;
  
  signal sig_busA          : std_logic_vector(31 downto 0);
  signal sig_busB          : std_logic_vector(31 downto 0);
  signal sig_FS            : std_logic_vector(3 downto 0);
  signal sig_CPSR          : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
  signal sig_FS_TEST       : std_logic;
  signal sig_CPSR_next_ULA : std_logic_vector(31 downto 0);
  signal sig_S             : std_logic_vector(31 downto 0);
  
begin
  
  M1: ULA port map (sig_busA,sig_busB,sig_FS,sig_CPSR,sig_FS_TEST,sig_CPSR_next_ULA,sig_S);
  
  sig_busA  <= "00000000111111111111111111111111";
  sig_busB  <= "00001111111111111111111111111111";

  process
  begin
    
    sig_FS 	  <= "0000";
    
    wait for 10 us;

    sig_FS 	  <= "0001";
    wait for 10 us;

    sig_FS 	  <= "0010";
    wait for 10 us;

    sig_FS 	  <= "0011";
    wait for 10 us;

    sig_FS 	  <= "0100";
    wait for 10 us;

    sig_FS 	  <= "0101";
    wait for 10 us;

    sig_FS 	  <= "0110";
    wait for 10 us;

    sig_FS 	  <= "0111";
    wait for 10 us;

    sig_FS 	  <= "1000";
    wait for 10 us;

    sig_FS 	  <= "1001";
    wait for 10 us;

    sig_FS 	  <= "1010";
    wait for 10 us;

    sig_FS 	  <= "1011";
    wait for 10 us;

    sig_FS 	  <= "1100";
    wait for 10 us;

    sig_FS 	  <= "1101";
    wait for 10 us;

    sig_FS 	  <= "1110";
    wait for 10 us;

    sig_FS 	  <= "1111";
    wait for 10 us;

  end process;
end RTL;

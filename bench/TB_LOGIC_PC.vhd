library IEEE;   
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

library lib_VHDL;
use lib_VHDL.LOGIC_PC;

entity TB_LOGIC_PC is  
end TB_LOGIC_PC;

architecture RTL of TB_LOGIC_PC is

  component LOGIC_PC
    port (
      PC_Current  : in  std_logic_vector(31 downto 0);
      OFFSET      : in  std_logic_vector(31 downto 0);
      WR          : in  std_logic;
      DET_BRANCH  : in  std_logic;
      DET_MV_PCLR : in  std_logic;
      NOP         : out std_logic;
      PC_next     : out std_logic_vector(31 downto 0));
  end component;

  signal sig_PC_Current  : std_logic_vector(31 downto 0) := "00000000000000001111111111111111";
  signal sig_OFFSET      : std_logic_vector(31 downto 0) := "01010101010101010101010101010101";
  signal sig_WR          : std_logic;
  signal sig_DET_BRANCH  : std_logic;
  signal sig_DET_MV_PCLR : std_logic;
  signal sig_NOP         : std_logic;
  signal sig_PC_next     : std_logic_vector(31 downto 0);
  
begin  -- RTL

  U0: LOGIC_PC port map (sig_PC_Current,sig_OFFSET,sig_WR,sig_DET_BRANCH,sig_DET_MV_PCLR,sig_NOP,sig_PC_next);
  
  process
  begin  -- process
    sig_WR          <= '0';
    sig_DET_BRANCH  <= '0';

    wait for 10 ns;

    sig_PC_Current <= "00000000000000010000000000000000";
    sig_DET_BRANCH <= '1';

    wait for 10 ns;

    sig_PC_Current <= "00000000000000010000000000000001";
    sig_WR         <= '1';

    wait for 10 ns;
  end process;
end RTL;



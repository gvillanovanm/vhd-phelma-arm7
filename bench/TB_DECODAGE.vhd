library IEEE;
use     IEEE.std_logic_1164.all;

library lib_VHDL;
use lib_VHDL.all;

entity TB_DECODAGE is  
end entity TB_DECODAGE;

architecture RTL of TB_DECODAGE is

  component DECODAGE is
    port (
      CLK          : in  std_logic;
      RST          : in  std_logic;
      INSTRUCTION  : in  std_logic_vector(31 downto 0);
      NOP          : in  std_logic;
      DET_ULA      : out std_logic;
      DET_MUL      : out std_logic;
      DET_MOV_PCLR : out std_logic;
      DET_LDR      : out std_logic;
      DET_STR      : out std_logic;
      DET_BRANCH   : out std_logic;
      COND         : out std_logic_vector(3 downto 0);
      I            : out std_logic;
      FS           : out std_logic_vector(3 downto 0);
      S            : out std_logic;
      DA           : out std_logic_vector(3 downto 0);
      SEL_RA       : out std_logic_vector(3 downto 0);
      SEL_RB       : out std_logic_vector(3 downto 0);
      SS           : out std_logic_vector(2 downto 0);
      NS           : out std_logic_vector(2 downto 0);
      ACM          : out std_logic;
      SEL_RM       : out std_logic_vector(3 downto 0);
      AUTO_INDEX   : out std_logic;
      LINK         : out std_logic;
      OFFSET       : out std_logic_vector(23 downto 0);
      SEL_BUS      : out std_logic_vector(1 downto 0));
  end component DECODAGE;

  signal sig_CLK          : std_logic := '0';
  signal sig_RST          : std_logic;
  signal sig_INSTRUCTION  : std_logic_vector(31 downto 0);
  signal sig_NOP          : std_logic;
  signal sig_DET_ULA      : std_logic;
  signal sig_DET_MUL      : std_logic;
  signal sig_DET_MOV_PCLR : std_logic;
  signal sig_DET_LDR      : std_logic;
  signal sig_DET_STR      : std_logic;
  signal sig_DET_BRANCH   : std_logic;
  signal sig_COND         : std_logic_vector(3 downto 0);
  signal sig_I            : std_logic;
  signal sig_FS           : std_logic_vector(3 downto 0);
  signal sig_S            : std_logic;
  signal sig_DA           : std_logic_vector(3 downto 0);
  signal sig_SEL_RA       : std_logic_vector(3 downto 0);
  signal sig_SEL_RB       : std_logic_vector(3 downto 0);
  signal sig_SS           : std_logic_vector(2 downto 0);
  signal sig_NS           : std_logic_vector(2 downto 0);
  signal sig_ACM          : std_logic;
  signal sig_SEL_RM       : std_logic_vector(3 downto 0);
  signal sig_AUTO_INDEX   : std_logic;
  signal sig_LINK         : std_logic;
  signal sig_OFFSET       : std_logic_vector(23 downto 0);
  signal sig_SEL_BUS      : std_logic_vector(1 downto 0);
  
begin  -- architecture RTL

  D0: DECODAGE port map (sig_CLK,sig_RST,sig_INSTRUCTION,sig_NOP,sig_DET_ULA,sig_DET_MUL,sig_DET_MOV_PCLR,sig_DET_LDR,sig_DET_STR,sig_DET_BRANCH,sig_COND,sig_I,sig_FS,sig_S,sig_DA,sig_SEL_RA,sig_SEL_RB,sig_SS,sig_NS,sig_ACM,sig_SEL_RM,sig_AUTO_INDEX,sig_LINK,sig_OFFSET,sig_SEL_BUS);

  sig_CLK <= not sig_CLK after 10 ns;
  sig_RST <= '1','0' after 45 ns;
  sig_NOP <= '0';
  
  process is
  begin  -- process
    wait for 45 ns;

    sig_INSTRUCTION <= "00000000000000000000000000000000";  -- ULA
    wait for 20 ns;

    sig_INSTRUCTION <= "00001100000000000000000010010000";  -- MUL
    wait for 20 ns;

    sig_INSTRUCTION <= "00000100000000000000000000000000";  -- LOAD
    wait for 20 ns;
    
    sig_INSTRUCTION <= "00000100010000000000000000000000";  -- STR
    wait for 20 ns;

    sig_INSTRUCTION <= "00001000000000000000000000000000";  -- BRANCH
    wait for 20 ns;

    sig_INSTRUCTION <= "00001110000000000000000000000000";  -- NOP
    wait for 20 ns;
    
  end process;
end architecture RTL;


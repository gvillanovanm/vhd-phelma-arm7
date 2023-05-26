library IEEE;
use IEEE.std_logic_1164.all;

library lib_VHDL;
use lib_VHDL.my_type.all;

entity ARM is
  
  port (
    CLK : in std_logic;
    RST : in std_logic);
  
end entity ARM;

architecture RTL of ARM is

  component DATAPATH is
    port (
      CLK          : in  std_logic;
      RST          : in  std_logic;
      DET_ULA      : in  std_logic;
      DET_MUL      : in  std_logic;
      DET_MOV_PCLR : in  std_logic;
      DET_LDR      : in  std_logic;
      DET_STR      : in  std_logic;
      DET_BRANCH   : in  std_logic;
      COND         : in  std_logic_vector(3 downto 0);
      I            : in  std_logic;
      FS           : in  std_logic_vector(3 downto 0);
      S            : in  std_logic;
      DA           : in  std_logic_vector(3 downto 0);
      SEL_RA       : in  std_logic_vector(3 downto 0);
      SEL_RB       : in  std_logic_vector(3 downto 0);
      SS           : in  std_logic_vector(2 downto 0);
      NS           : in  std_logic_vector(2 downto 0);
      ACM          : in  std_logic;
      SEL_RM       : in  std_logic_vector(3 downto 0);
      AUTO_INDEX   : in  std_logic;
      LINK         : in  std_logic;
      OFFSET       : in  std_logic_vector(23 downto 0);
      SEL_BUS      : in  std_logic_vector(1 downto 0);
      PC_CURRENT   : out std_logic_vector(31 downto 0);
      NOP          : out std_logic);
  end component DATAPATH;  

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

  component FETCH is
    port (
      CLK         : in  std_logic;
      RST         : in  std_logic;
      PC_CURRENT  : in  std_logic_vector(31 downto 0);
      NOP         : in  std_logic;
      INSTRUCTION : out std_logic_vector(31 downto 0));
  end component FETCH;

  signal sig_CONTROL     : std_logic_vector(66 downto 0);
  signal sig_PC_CURRENT  : std_logic_vector(31 downto 0);
  signal sig_NOP         : std_logic;
  signal sig_INSTRUCTION : std_logic_vector(31 downto 0);

  
begin  -- architecture RTL

  P0 : DATAPATH port map (CLK,RST,sig_CONTROL(66),sig_CONTROL(65),sig_CONTROL(64),sig_CONTROL(63),sig_CONTROL(62),sig_CONTROL(61),sig_CONTROL(60 downto 57),sig_CONTROL(56),sig_CONTROL(55 downto 52),sig_CONTROL(51),sig_CONTROL(50 downto 47),sig_CONTROL(46 downto 43),sig_CONTROL(42 downto 39),sig_CONTROL(38 downto 36),sig_CONTROL(35 downto 33),sig_CONTROL(32),sig_CONTROL(31 downto 28),sig_CONTROL(27),sig_CONTROL(26),sig_CONTROL(25 downto 2),sig_CONTROL(1 downto 0),sig_PC_CURRENT,sig_NOP);

  D0 : DECODAGE port map (CLK,RST,sig_INSTRUCTION,sig_NOP,sig_CONTROL(66),sig_CONTROL(65),sig_CONTROL(64),sig_CONTROL(63),sig_CONTROL(62),sig_CONTROL(61),sig_CONTROL(60 downto 57),sig_CONTROL(56),sig_CONTROL(55 downto 52),sig_CONTROL(51),sig_CONTROL(50 downto 47),sig_CONTROL(46 downto 43),sig_CONTROL(42 downto 39),sig_CONTROL(38 downto 36),sig_CONTROL(35 downto 33),sig_CONTROL(32),sig_CONTROL(31 downto 28),sig_CONTROL(27),sig_CONTROL(26),sig_CONTROL(25 downto 2),sig_CONTROL(1 downto 0));

  F0 : FETCH port map (CLK,RST,sig_PC_CURRENT,sig_NOP,sig_INSTRUCTION);
  
end architecture RTL;

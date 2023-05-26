library IEEE;
use     IEEE.std_logic_1164.all;

entity DECODAGE is
  
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
  
end entity DECODAGE;

architecture RTL of DECODAGE is

  component DECODEUR is
    port (
      INSTRUCTION  : in  std_logic_vector(31 downto 0);
      DET_ULA      : out std_logic;                     -- S_DECODEUR(66)
      DET_MUL      : out std_logic;                     -- S_DECODEUR(65) 
      DET_MOV_PCLR : out std_logic;                     -- S_DECODEUR(64)
      DET_LDR      : out std_logic;                     -- S_DECODEUR(63)
      DET_STR      : out std_logic;                     -- S_DECODEUR(62)
      DET_BRANCH   : out std_logic;                     -- S_DECODEUR(61)
      COND         : out std_logic_vector(3 downto 0);  -- S_DECODEUR(60 downto 57)
      I            : out std_logic;                     -- S_DECODEUR(56)
      FS           : out std_logic_vector(3 downto 0);  -- S_DECODEUR(55 downto 52)
      S            : out std_logic;                     -- S_DECODEUR(51)
      DA           : out std_logic_vector(3 downto 0);  -- S_DECODEUR(50 downto 47)
      SEL_RA       : out std_logic_vector(3 downto 0);  -- S_DECODEUR(46 downto 43)
      SEL_RB       : out std_logic_vector(3 downto 0);  -- S_DECODEUR(42 downto 39)
      SS           : out std_logic_vector(2 downto 0);  -- S_DECODEUR(38 downto 36)
      NS           : out std_logic_vector(2 downto 0);  -- S_DECODEUR(35 downto 33)
      ACM          : out std_logic;                     -- S_DECODEUR(32)
      SEL_RM       : out std_logic_vector(3 downto 0);  -- S_DECODEUR(31 downto 28)
      AUTO_INDEX   : out std_logic;                     -- S_DECODEUR(27)
      LINK         : out std_logic;                     -- S_DECODEUR(26)
      OFFSET       : out std_logic_vector(23 downto 0); -- S_DECODEUR(25 downto 2)
      SEL_BUS      : out std_logic_vector(1 downto 0)); -- S_DECODEUR(1 downto 0)
  end component DECODEUR;

  signal S_DECODEUR : std_logic_vector(66 downto 0);
  signal S_NOP      : std_logic_vector(66 downto 0);
  signal S_MUX      : std_logic_vector(66 downto 0);
  
begin  -- architecture RTL

  D0: DECODEUR port map (INSTRUCTION,S_DECODEUR(66),S_DECODEUR(65),S_DECODEUR(64),S_DECODEUR(63),S_DECODEUR(62),S_DECODEUR(61),S_DECODEUR(60 downto 57),S_DECODEUR(56),S_DECODEUR(55 downto 52),S_DECODEUR(51),S_DECODEUR(50 downto 47),S_DECODEUR(46 downto 43),S_DECODEUR(42 downto 39),S_DECODEUR(38 downto 36),S_DECODEUR(35 downto 33),S_DECODEUR(32),S_DECODEUR(31 downto 28),S_DECODEUR(27),S_DECODEUR(26),S_DECODEUR(25 downto 2),S_DECODEUR(1 downto 0));
  
  S_NOP <= "100000"&"0000"&'0'&"1010"&'0'&"0000"&"0000"&"0000"&"000"&"000"&'0'&"0000"&'0'&'0'&"000000000000000000000000"&"00";

  -- MUX
  S_MUX <= S_DECODEUR when NOP = '0' else
           S_NOP;
  
  process (CLK, RST) is
  begin  -- process
    
    if CLK'event and CLK = '1' then     -- rising clock edge
      if RST = '1' then
        DET_ULA      <= '0';
        DET_MUL      <= '0';
        DET_MOV_PCLR <= '0';
        DET_LDR      <= '0';
        DET_STR      <= '0';
        DET_BRANCH   <= '0';
        COND         <= "0000";
        I            <= '0';
        FS           <= "0000";
        S            <= '0';
        DA           <= "0000";
        SEL_RA       <= "0000";
        SEL_RB       <= "0000";
        SS           <= "000";
        NS           <= "000";
        ACM          <= '0';
        SEL_RM       <= "0000";
        AUTO_INDEX   <= '0';
        LINK         <= '0';
        OFFSET       <= "000000000000000000000000";
        SEL_BUS      <= "00";
      else
        DET_ULA      <= S_MUX(66);
        DET_MUL      <= S_MUX(65);
        DET_MOV_PCLR <= S_MUX(64);
        DET_LDR      <= S_MUX(63);
        DET_STR      <= S_MUX(62);
        DET_BRANCH   <= S_MUX(61);
        COND         <= S_MUX(60 downto 57);
        I            <= S_MUX(56);
        FS           <= S_MUX(55 downto 52);
        S            <= S_MUX(51);
        DA           <= S_MUX(50 downto 47);
        SEL_RA       <= S_MUX(46 downto 43);
        SEL_RB       <= S_MUX(42 downto 39); 
        SS           <= S_MUX(38 downto 36); 
        NS           <= S_MUX(35 downto 33); 
        ACM          <= S_MUX(32); 
        SEL_RM       <= S_MUX(31 downto 28); 
        AUTO_INDEX   <= S_MUX(27); 
        LINK         <= S_MUX(26); 
        OFFSET       <= S_MUX(25 downto 2); 
        SEL_BUS      <= S_MUX(1 downto 0); 
      end if;
    end if;
  end process;
  
end architecture RTL;

library IEEE;
use     IEEE.std_logic_1164.all;

library lib_VHDL;
use lib_VHDL.my_type.all;

entity TB_DATAPATH is  
end entity TB_DATAPATH;

architecture RTL of TB_DATAPATH is

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

  signal sig_CLK          : std_logic := '0';
  signal sig_RST          : std_logic;
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
  signal sig_PC_CURRENT   : std_logic_vector(31 downto 0);
  signal sig_NOP          : std_logic;
    
begin  -- architecture RTL

  sig_CLK <= not sig_CLK after 10 ns;
  sig_RST <= '1','0' after 45 ns;

  D0: DATAPATH port map (sig_CLK,sig_RST,sig_DET_ULA,sig_DET_MUL,sig_DET_MOV_PCLR,sig_DET_LDR,sig_DET_STR,sig_DET_BRANCH,sig_COND,sig_I,sig_FS,sig_S,sig_DA,sig_SEL_RA,sig_SEL_RB,sig_SS,sig_NS,sig_ACM,sig_SEL_RM,sig_AUTO_INDEX,sig_LINK,sig_OFFSET,sig_SEL_BUS,sig_PC_CURRENT,sig_NOP);
  
  process
  begin
    wait for 45 ns;

    -- ADD r0,r0,r0
    
    sig_COND       <= "0000";
    sig_I          <= '0';
    sig_FS         <= "0000";           -- ADD
    sig_S          <= '0';              -- Non conditional
    sig_DA         <= "0000";
    sig_SEL_RA     <= "0000";
    sig_SEL_RB     <= "0000";
    sig_SS         <= "101";
    sig_NS         <= "000";
    sig_ACM        <= '-';
    sig_SEL_RM     <= "----";
    sig_AUTO_INDEX <= '-';
    sig_LINK       <= '-';
    sig_OFFSET     <= "000000000000000000000000";
    sig_SEL_BUS    <= "00";

    sig_DET_ULA      <= '1';
    sig_DET_MUL      <= '0';
    sig_DET_MOV_PCLR <= '0';
    sig_DET_LDR      <= '0';
    sig_DET_STR      <= '0';
    sig_DET_BRANCH   <= '0';
    
    -- MOV r0, 5;
    -- MOV r1, 10;
    -- ADD r2, r0, r1;
    
    sig_COND       <= "0000";
    sig_I          <= '1';
    sig_FS         <= "1010";           -- MOV
    sig_S          <= '0';              -- Non conditional
    sig_DA         <= "0000";
    sig_SEL_RA     <= "0000";
    sig_SEL_RB     <= "0000";
    sig_SS         <= "101";
    sig_NS         <= "000";
    sig_ACM        <= '-';
    sig_SEL_RM     <= "----";
    sig_AUTO_INDEX <= '-';
    sig_LINK       <= '-';
    sig_OFFSET     <= "000000000000000000000101";
    sig_SEL_BUS    <= "00";

    sig_DET_ULA      <= '1';
    sig_DET_MUL      <= '0';
    sig_DET_MOV_PCLR <= '0';
    sig_DET_LDR      <= '0';
    sig_DET_STR      <= '0';
    sig_DET_BRANCH   <= '0';

    wait for 20 ns;
    --------------------------------------
    
    sig_COND       <= "0000";
    sig_I          <= '1';
    sig_FS         <= "1010";           -- MOV
    sig_S          <= '0';              -- Non conditional
    sig_DA         <= "0001";
    sig_SEL_RA     <= "0000";
    sig_SEL_RB     <= "0000";
    sig_SS         <= "101";
    sig_NS         <= "000";
    sig_ACM        <= '-';
    sig_SEL_RM     <= "----";
    sig_AUTO_INDEX <= '-';
    sig_LINK       <= '-';
    sig_OFFSET     <= "000000000000000000001010";
    sig_SEL_BUS    <= "00";

    sig_DET_ULA      <= '1';
    sig_DET_MUL      <= '0';
    sig_DET_MOV_PCLR <= '0';
    sig_DET_LDR      <= '0';
    sig_DET_STR      <= '0';
    sig_DET_BRANCH   <= '0';

    wait for 20 ns;
    -----------------------------------------

    sig_COND       <= "0000";
    sig_I          <= '0';
    sig_FS         <= "0000";           -- MOV
    sig_S          <= '0';              -- Non conditional
    sig_DA         <= "0010";
    sig_SEL_RA     <= "0000";
    sig_SEL_RB     <= "0001";
    sig_SS         <= "101";
    sig_NS         <= "000";
    sig_ACM        <= '-';
    sig_SEL_RM     <= "----";
    sig_AUTO_INDEX <= '-';
    sig_LINK       <= '-';
    sig_OFFSET     <= "000000000000000000001010";
    sig_SEL_BUS    <= "00";

    sig_DET_ULA      <= '1';
    sig_DET_MUL      <= '0';
    sig_DET_MOV_PCLR <= '0';
    sig_DET_LDR      <= '0';
    sig_DET_STR      <= '0';
    sig_DET_BRANCH   <= '0';

    wait for 20 ns;
    ------------------------------------------

    -- MUL r3, r0, r1
    
    sig_COND       <= "0000";
    sig_I          <= '-';
    sig_FS         <= "----";           -- MOV
    sig_S          <= '0';              -- Non conditional
    sig_DA         <= "0011";
    sig_SEL_RA     <= "0000";
    sig_SEL_RB     <= "0001";
    sig_SS         <= "---";
    sig_NS         <= "---";
    sig_ACM        <= '1';
    sig_SEL_RM     <= "0001";
    sig_AUTO_INDEX <= '-';
    sig_LINK       <= '-';
    sig_OFFSET     <= "------------------------";
    sig_SEL_BUS    <= "01";

    sig_DET_ULA      <= '0';
    sig_DET_MUL      <= '1';
    sig_DET_MOV_PCLR <= '0';
    sig_DET_LDR      <= '0';
    sig_DET_STR      <= '0';
    sig_DET_BRANCH   <= '0';

    wait for 20 ns;
    ------------------------------------------
    
    -- STORE r3, M[r1]
    
    sig_COND       <= "0000";
    sig_I          <= '0';
    sig_FS         <= "----";           -- MOV
    sig_S          <= '0';              -- Non conditional
    sig_DA         <= "----";
    sig_SEL_RA     <= "0001";
    sig_SEL_RB     <= "0000";
    sig_SS         <= "---";
    sig_NS         <= "---";
    sig_ACM        <= '-';
    sig_SEL_RM     <= "----";
    sig_AUTO_INDEX <= '0';
    sig_LINK       <= '-';
    sig_OFFSET     <= "000000000000000000000000";
    sig_SEL_BUS    <= "10";

    sig_DET_ULA      <= '0';
    sig_DET_MUL      <= '0';
    sig_DET_MOV_PCLR <= '0';
    sig_DET_LDR      <= '0';
    sig_DET_STR      <= '1';
    sig_DET_BRANCH   <= '0';

    wait for 20 ns;
    -------------------------------------------

    -- LOAD r5, M[r1]
    
    sig_COND       <= "0000";
    sig_I          <= '0';
    sig_FS         <= "----";           
    sig_S          <= '0';              -- Non conditional
    sig_DA         <= "0101";
    sig_SEL_RA     <= "0001";
    sig_SEL_RB     <= "0000";
    sig_SS         <= "---";
    sig_NS         <= "---";
    sig_ACM        <= '-';
    sig_SEL_RM     <= "----";
    sig_AUTO_INDEX <= '0';
    sig_LINK       <= '-';
    sig_OFFSET     <= "000000000000000000000000";
    sig_SEL_BUS    <= "10";

    sig_DET_ULA      <= '0';
    sig_DET_MUL      <= '0';
    sig_DET_MOV_PCLR <= '0';
    sig_DET_LDR      <= '1';
    sig_DET_STR      <= '0';
    sig_DET_BRANCH   <= '0';

    wait for 20 ns;
    -------------------------------------------
    
    -- BRANCH s/ LINK
    
    sig_COND       <= "0000";
    sig_I          <= '-';
    sig_FS         <= "----";           
    sig_S          <= '0';              -- Non conditional
    sig_DA         <= "0000";           -- "----"
    sig_SEL_RA     <= "0000";           -- "----"
    sig_SEL_RB     <= "0000";           -- "----"
    sig_SS         <= "---";
    sig_NS         <= "---";
    sig_ACM        <= '-';
    sig_SEL_RM     <= "----";
    sig_AUTO_INDEX <= '-';
    sig_LINK       <= '0';
    sig_OFFSET     <= "000000000000000000101011";  -- On a besoin de metre un valeur que c'est possible
    sig_SEL_BUS    <= "00";

    sig_DET_ULA      <= '0';
    sig_DET_MUL      <= '0';
    sig_DET_MOV_PCLR <= '0';
    sig_DET_LDR      <= '0';
    sig_DET_STR      <= '0';
    sig_DET_BRANCH   <= '1';

    wait for 20 ns;
    -------------------------------------------
    
    -- BRANCH c/ LINK
    
    sig_COND       <= "0000";
    sig_I          <= '-';
    sig_FS         <= "----";           
    sig_S          <= '0';              -- Non conditional
    sig_DA         <= "0000";           -- "----"
    sig_SEL_RA     <= "0000";           -- "----"
    sig_SEL_RB     <= "0000";           -- "----"
    sig_SS         <= "---";
    sig_NS         <= "---";
    sig_ACM        <= '-';
    sig_SEL_RM     <= "----";
    sig_AUTO_INDEX <= '-';
    sig_LINK       <= '1';
    sig_OFFSET     <= "000000000000000000111111";  -- On a besoin de metre un valeur que c'est possible
    sig_SEL_BUS    <= "00";

    sig_DET_ULA      <= '0';
    sig_DET_MUL      <= '0';
    sig_DET_MOV_PCLR <= '0';
    sig_DET_LDR      <= '0';
    sig_DET_STR      <= '0';
    sig_DET_BRANCH   <= '1';

    wait for 20 ns;    
    -------------------------------------------

    -- TESTE CMP 

    sig_COND       <= "0000";
    sig_I          <= '0';
    sig_FS         <= "1100";           -- CMP
    sig_S          <= '0';              -- Non conditional
    sig_DA         <= "0000";
    sig_SEL_RA     <= "0000";           -- 5 - 10 = - 5 = NZCV = 1010: Le carry est '1'?
    sig_SEL_RB     <= "0001";
    sig_SS         <= "101";
    sig_NS         <= "000";
    sig_ACM        <= '-';
    sig_SEL_RM     <= "----";
    sig_AUTO_INDEX <= '-';
    sig_LINK       <= '-';
    sig_OFFSET     <= "000000000000000000000000";
    sig_SEL_BUS    <= "00";

    sig_DET_ULA      <= '1';
    sig_DET_MUL      <= '0';
    sig_DET_MOV_PCLR <= '0';
    sig_DET_LDR      <= '0';
    sig_DET_STR      <= '0';
    sig_DET_BRANCH   <= '0';

    wait for 20 ns;
    
  end process;
end architecture RTL;

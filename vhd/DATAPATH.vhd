library IEEE;
use     IEEE.std_logic_1164.all;

library lib_VHDL;
use lib_VHDL.my_type.all;

entity DATAPATH is

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

end entity DATAPATH;

architecture RTL of DATAPATH is

  component ULA is
    port ( busA          : in  std_logic_vector(31 downto 0);
           busB          : in  std_logic_vector(31 downto 0); 
           FS            : in  std_logic_vector(3 downto 0);
           CPSR          : in  std_logic_vector(31 downto 0);   -- NZCV
           FS_TEST       : out std_logic;
           CPSR_next_ULA : out std_logic_vector(31 downto 0);
           S             : out std_logic_vector(31 downto 0));    
  end component ULA;

  component BANK_REG is
    port (
      CLK           : in  std_logic;
      RST           : in  std_logic;
      busULA        : in  std_logic_vector(31 downto 0);
      busMUL        : in  std_logic_vector(31 downto 0);
      busMD         : in  std_logic_vector(31 downto 0);
      CPSR_next_ULA : in  std_logic_vector(31 downto 0);
      CPSR_next_MUL : in  std_logic_vector(31 downto 0);
      PC_next       : in  std_logic_vector(31 downto 0);
      PC_current    : in  std_logic_vector(31 downto 0);
      DA            : in  std_logic_vector(3 downto 0);
      FS_TEST       : in  std_logic;
      WR            : in  std_logic;
      S             : in  std_logic;
      LINK          : in  std_logic;
      DET_BRANCH    : in  std_logic;
      DET_ULA       : in  std_logic;
      DET_MUL       : in  std_logic;
      DET_LDR       : in  std_logic;
      DET_STR       : in  std_logic;
      Sel_BUS       : in  std_logic_vector(1 downto 0);
      CPSR          : out std_logic_vector(31 downto 0);
      REG           : out TAB_REG_OUT(0 to 15));    
  end component BANK_REG;

  component BARREL_SHIFTER is
    port (
      busB   : in  std_logic_vector(31 downto 0);
      offset : in  std_logic_vector(31 downto 0);
      Carry  : in  std_logic;
      I      : in  std_logic;
      SS     : in  std_logic_vector(2 downto 0);
      NS     : in  std_logic_vector(2 downto 0);
      S      : out std_logic_vector(31 downto 0));   
  end component BARREL_SHIFTER;

  component MUL is
    port (
      REGS          : in  TAB_REG_OUT(0 to 15);
      busA          : in  std_logic_vector(31 downto 0);
      busB          : in  std_logic_vector(31 downto 0);
      SEL_RM        : in  std_logic_vector(3 downto 0);
      ACM           : in  std_logic;
      CPSR_next_MUL : out std_logic_vector(31 downto 0);
      S             : out std_logic_vector(31 downto 0));    
  end component MUL;

  component SEL_REGS is
    port (
      REGS   : in  TAB_REG_OUT(0 to 15);
      SEL_RA : in  std_logic_vector(3 downto 0);
      SEL_RB : in  std_logic_vector(3 downto 0);
      busA   : out std_logic_vector(31 downto 0);
      busB   : out std_logic_vector(31 downto 0));
  end component SEL_REGS;

  component ZERO_FILL is
    port (
      OFFSET  : in  std_logic_vector(23 downto 0);
      DET_LDR : in  std_logic;
      DET_STR : in  std_logic;
      S_IM    : out std_logic_vector(31 downto 0));
  end component ZERO_FILL;
  
  component TEST_COND is
    port (
      COND       : in  std_logic_vector(3 downto 0);
      CPSR       : in  std_logic_vector(3 downto 0);
      S          : in  std_logic;
      DET_STR    : in  std_logic;
      WR         : out std_logic);
  end component TEST_COND;

  component LOGIC_PC is
    port (
      PC_Current  : in  std_logic_vector(31 downto 0);
      OFFSET      : in  std_logic_vector(31 downto 0);
      WR          : in  std_logic;
      DET_BRANCH  : in  std_logic;
      DET_MV_PCLR : in  std_logic;
      NOP         : out std_logic;
      PC_next     : out std_logic_vector(31 downto 0));
  end component LOGIC_PC;

  component MEM_DONNEE is
    port (
      CLK       : in  std_logic;
      RST       : in  std_logic;
      busA      : in  std_logic_vector(31 downto 0);
      busB      : in  std_logic_vector(31 downto 0);
      Offset    : in  std_logic_vector(31 downto 0);
      I         : in  std_logic;
      AUT_INDEX : in  std_logic;
      WR        : in  std_logic;
      DET_LDR   : in  std_logic;
      DET_STR   : in  std_logic;
      S         : out std_logic_vector(31 downto 0));
  end component MEM_DONNEE;

  -- Signaux internes BANK_REG:
  
  signal interne_FS_TEST       : std_logic;
  signal interne_BUS_ULA       : std_logic_vector(31 downto 0);
  signal interne_BUS_MUL       : std_logic_vector(31 downto 0);
  signal interne_BUS_MD        : std_logic_vector(31 downto 0);
  signal interne_WR            : std_logic;
  signal interne_CPSR          : std_logic_vector(31 downto 0);
  signal interne_REGISTRES     : TAB_REG_OUT(0 to 15);
  signal interne_CPSR_next_MUL : std_logic_vector(31 downto 0);
  signal interne_CPSR_next_ULA : std_logic_vector(31 downto 0);
  signal interne_PC_next       : std_logic_vector(31 downto 0);
  signal interne_BUS_A         : std_logic_vector(31 downto 0);
  signal interne_BUS_B         : std_logic_vector(31 downto 0);
  signal interne_IN_BUSB       : std_logic_vector(31 downto 0);
  signal interne_S_ZERO_FILL   : std_logic_vector(31 downto 0);
  signal interne_NOP           : std_logic;
  
begin  -- architecture RTL

  PC_CURRENT <= interne_REGISTRES(15);
  NOP        <= interne_NOP;
  
  -- BANK REGISTRES:
  B0 : BANK_REG port map (CLK,RST,interne_BUS_ULA,interne_BUS_MUL,interne_BUS_MD,interne_CPSR_next_ULA,interne_CPSR_next_MUL,interne_PC_next,interne_REGISTRES(15),DA,interne_FS_TEST,interne_WR,S,LINK,DET_BRANCH,DET_ULA,DET_MUL,DET_LDR,DET_STR,SEL_BUS,interne_CPSR,interne_REGISTRES);

  -- ULA:
  U0 : ULA port map (interne_BUS_A,interne_BUS_B,FS,interne_CPSR,interne_FS_TEST,interne_CPSR_next_ULA,interne_BUS_ULA);

  -- BARREL SHIFTER:
  S0: BARREL_SHIFTER port map (interne_IN_BUSB,interne_S_ZERO_FILL,interne_CPSR(29),I,SS,NS,interne_BUS_B);

  -- MUL:
  M0: MUL port map (interne_REGISTRES,interne_BUS_A,interne_IN_BUSB,SEL_RM,ACM,interne_CPSR_next_MUL,interne_BUS_MUL);

  -- SEL REGS:
  R0: SEL_REGS port map (interne_REGISTRES,SEL_RA,SEL_RB,interne_BUS_A,interne_IN_BUSB);

  -- ZERO FILL:
  Z0: ZERO_FILL port map (OFFSET,DET_LDR,DET_STR,interne_S_ZERO_FILL);

  -- TEST COND:
  T0: TEST_COND port map (COND,interne_CPSR(31 downto 28),S,DET_STR,interne_WR);

  -- LOGIC PC:
  L0: LOGIC_PC port map (interne_REGISTRES(15),interne_S_ZERO_FILL,interne_WR,DET_BRANCH,DET_MOV_PCLR,interne_NOP,interne_PC_next);

  -- MEM DONNEE:
  D0: MEM_DONNEE port map (CLK,RST,interne_BUS_A,interne_BUS_B,interne_S_ZERO_FILL,I,AUTO_INDEX,interne_WR,DET_LDR,DET_STR,interne_BUS_MD);
  
end RTL;

library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

library lib_VHDL;
use     lib_VHDL.my_type.all;

entity TB_MEM_DONNEE is
end entity TB_MEM_DONNEE;

architecture RTL of TB_MEM_DONNEE is

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

  signal sig_CLK       : std_logic := '0';
  signal sig_RST       : std_logic;
  signal sig_busA      : std_logic_vector(31 downto 0) := "01010101010101010101010101010101"; -- Data
  signal sig_busB      : std_logic_vector(31 downto 0) := "00000000000000000000000000000011";
  signal sig_Offset    : std_logic_vector(31 downto 0) := "00000000000000000000000000001100";
  signal sig_I         : std_logic;
  signal sig_AUT_INDEX : std_logic;
  signal sig_WR        : std_logic;
  signal sig_DET_LDR   : std_logic := '0';
  signal sig_DET_STR   : std_logic := '0';
  signal sig_S         : std_logic_vector(31 downto 0);
  
begin  -- architecture RTL

  U0 : MEM_DONNEE port map (sig_CLK,sig_RST,sig_busA,sig_busB,sig_Offset,sig_I,sig_AUT_INDEX,sig_WR,sig_DET_LDR,sig_DET_STR,sig_S);
    
  sig_CLK <= not sig_CLK after 10 ns;
  sig_RST <= '1', '0' after 50 ns;

  process
  begin
    wait for 65 ns;

    -- Def. ARG:
    sig_I <= '0';
    sig_AUT_INDEX <= '0';
    -- Hab. gravation:
    sig_WR <= '1';
    -- Selectionne STORE:
    sig_DET_STR <= '1';
    wait for 20 ns;

    -- Def. ARG:
    sig_I <= '0';
    sig_AUT_INDEX <= '1';
    -- Hab. gravation:
    sig_WR <= '1';
    -- Selectionne STORE:
    sig_DET_STR <= '1';
    wait for 20 ns;

    -- Def. ARG:
    sig_I <= '1';
    --sig_AUT_INDEX <= '1';
    -- Hab. gravation:
    sig_WR <= '1';
    -- Selectionne STORE:
    sig_DET_STR <= '1';
    wait for 20 ns;

    -- LIRE
    -- Def. ARG:
    sig_I <= '0';
    sig_AUT_INDEX <= '0';
    -- Hab. gravation:
    -- sig_WR <= '1';
    -- Selectionne LOAD:
    sig_DET_STR <= '0';
    sig_DET_LDR <= '1';
    wait for 20 ns;

    -- Def. ARG:
    sig_I <= '0';
    sig_AUT_INDEX <= '1';
    -- Hab. gravation:
    -- sig_WR <= '1';
    -- Selectionne LOAD:
    sig_DET_STR <= '0';
    sig_DET_LDR <= '1';
    wait for 20 ns;

    -- Def. ARG:
    sig_I <= '1';
    sig_AUT_INDEX <= '0';
    -- Hab. gravation:
    -- sig_WR <= '1';
    -- Selectionne LOAD:
    sig_DET_STR <= '0';
    sig_DET_LDR <= '1';
    wait for 20 ns;

    -- 145 ns
  end process;
end architecture RTL;

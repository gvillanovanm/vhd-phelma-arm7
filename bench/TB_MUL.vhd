library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

library lib_VHDL;
use lib_VHDL.my_type.all;

entity TB_MUL is
end TB_MUL;

architecture RTL of TB_MUL is

  component MUL
    port (
      REGS          : in  TAB_REG_OUT(0 to 15);
      busA          : in  std_logic_vector(31 downto 0);
      busB          : in  std_logic_vector(31 downto 0);
      SEL_RM        : in  std_logic_vector(3 downto 0);
      ACM           : in  std_logic;
      CPSR_next_MUL : out std_logic_vector(31 downto 0);
      S             : out std_logic_vector(31 downto 0)); 
  end component;
  
  signal sig_REGS          : TAB_REG_OUT(0 to 15);
  signal sig_busA          : std_logic_vector(31 downto 0);
  signal sig_busB          : std_logic_vector(31 downto 0);
  signal sig_SEL_RM        : std_logic_vector(3 downto 0);
  signal sig_ACM           : std_logic;
  signal sig_CPSR_next_MUL : std_logic_vector(31 downto 0);
  signal sig_S             : std_logic_vector(31 downto 0);
  
begin  -- RTL

  U0 : MUL port map (sig_REGS,sig_busA,sig_busB,sig_SEL_RM,sig_ACM,sig_CPSR_next_MUL,sig_S);

  process
  begin  -- process

    -- "RESET EXTERN"
    sig_REGS(0)  <= (others => '0');
    sig_REGS(1)  <= (others => '0');
    sig_REGS(2)  <= (others => '0');
    sig_REGS(3)  <= (others => '0');
    sig_REGS(4)  <= (others => '0');
    sig_REGS(5)  <= (others => '0');
    sig_REGS(6)  <= (others => '0');
    sig_REGS(7)  <= (others => '0');
    sig_REGS(8)  <= (others => '0');
    sig_REGS(9)  <= (others => '0');
    sig_REGS(10) <= (others => '0');
    sig_REGS(11) <= (others => '0');
    sig_REGS(12) <= (others => '0');
    sig_REGS(13) <= (others => '0');
    sig_REGS(14) <= (others => '0');
    sig_REGS(15) <= (others => '0');


    sig_busA   <= (others => '0');
    sig_busB   <= (others => '0');
    sig_SEL_RM <= "0000";
    sig_ACM    <= '0';

    wait for 10 ns;

    sig_busA    <= "00000000000000000010101000011111";
    sig_busB    <= "00000000000000000001011110101110";
    
    wait for 10 ns;

    sig_REGS(0) <= "00000000000000001111111111111111";
    sig_ACM     <= '1';

    wait for 10 ns;

    sig_ACM     <= '0';
    sig_REGS(0) <= "10000000000000001111111111111111";
    
    wait for 10 ns;

    sig_ACM     <= '1';
    
    wait for 10 ns;
  end process;
end RTL;


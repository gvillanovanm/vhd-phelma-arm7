library IEEE;
use     IEEE.std_logic_1164.all;

entity TEST_COND is
  
  port (
    COND       : in  std_logic_vector(3 downto 0);
    CPSR       : in  std_logic_vector(3 downto 0);
    S          : in  std_logic;
    DET_STR    : in  std_logic;
    WR         : out std_logic);

end TEST_COND;

architecture RTL of TEST_COND is

  signal NEGATIVE        : std_logic;
  signal ZERO            : std_logic;
  signal CARRY           : std_logic;
  signal OVERFLOW        : std_logic;
  signal N_xnor_V        : std_logic;
  signal N_xor_V         : std_logic;
  signal notC_or_C_and_Z : std_logic;
  signal C_and_notZ      : std_logic;
  
begin  -- RTL

  NEGATIVE <= CPSR(3);
  ZERO     <= CPSR(2);
  CARRY    <= CPSR(1);
  OVERFLOW <= CPSR(0);

  N_xor_V         <= CPSR(3) xor CPSR(0);
  N_xnor_V        <= not (CPSR(3) xor CPSR(0));
  C_and_notZ      <= CPSR(1) and (not CPSR(2));
  notC_or_C_and_Z <= (not CPSR(1)) or (CPSR(1) and CPSR(2));
  
  process (COND,CPSR,S,DET_STR,NEGATIVE,ZERO,CARRY,OVERFLOW,N_xnor_V,N_xor_V,C_and_notZ,notC_or_C_and_Z)
  begin

    WR <= '0';
    
    if DET_STR = '1' then               -- DET_SRT: 1 => DANS LE BANK_REGISTRES ON N'ECRIT RIEN!
      
      if S = '0' then                   -- Non-Conditional

        WR <= '1';

      else

        if COND = "0000" and ZERO = '1' then
          WR <= '1';
        elsif COND = "0001" and ZERO = '0' then
          WR <= '1';
        elsif COND = "0010" and CARRY = '1' then
          WR <= '1';
        elsif COND = "0011" and CARRY = '0' then
          WR <= '1';
        elsif COND = "0100" and NEGATIVE = '1' then
          WR <= '1';
        elsif COND = "0101" and NEGATIVE = '0' then
          WR <= '1';
        elsif COND = "0110" and OVERFLOW = '1' then
          WR <= '1';
        elsif COND = "0111" and OVERFLOW = '0' then
          WR <= '1';
        elsif COND = "1000" and C_and_notZ = '1' then
          WR <= '1';
        elsif COND = "1001" and notC_or_C_and_Z = '1' then
          WR <= '1';
        elsif COND = "1010" and N_xnor_V = '1' then
          WR <= '1';
        elsif COND = "1011" and N_xor_V = '1' then
          WR <= '1';
        elsif COND = "1100" and N_xnor_V = '1' and ZERO = '0' then
          WR <= '1';
        elsif COND = "1101" and N_xor_V = '1' and ZERO = '1' then
          WR <= '1';
        end if;
      end if;
      
    else
      
      if S = '0' then                     -- Non-Conditional: Faire toujours

        WR <= '1';                        

      else                                -- Conditional

        if COND = "0000" and ZERO = '1' then
          WR <= '1';
        elsif COND = "0001" and ZERO = '0' then
          WR <= '1';
        elsif COND = "0010" and CARRY = '1' then
          WR <= '1';
        elsif COND = "0011" and CARRY = '0' then
          WR <= '1';
        elsif COND = "0100" and NEGATIVE = '1' then
          WR <= '1';
        elsif COND = "0101" and NEGATIVE = '0' then
          WR <= '1';
        elsif COND = "0110" and OVERFLOW = '1' then
          WR <= '1';
        elsif COND = "0111" and OVERFLOW = '0' then
          WR <= '1';
        elsif COND = "1000" and C_and_notZ = '1' then
          WR <= '1';
        elsif COND = "1001" and notC_or_C_and_Z = '1' then
          WR <= '1';
        elsif COND = "1010" and N_xnor_V = '1' then
          WR <= '1';
        elsif COND = "1011" and N_xor_V = '1' then
          WR <= '1';
        elsif COND = "1100" and N_xnor_V = '1' and ZERO = '0' then
          WR <= '1';
        elsif COND = "1101" and N_xor_V = '1' and ZERO = '1' then
          WR <= '1';
        end if;
      end if;
    end if;
  end process;
end RTL;

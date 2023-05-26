library IEEE;
use     IEEE.std_logic_1164.all;

entity ZERO_FILL is
  
  port (
    OFFSET      : in  std_logic_vector(23 downto 0);
    DET_LDR     : in  std_logic;
    DET_STR     : in  std_logic;
    S_IM        : out std_logic_vector(31 downto 0));
  
end ZERO_FILL;

architecture RTL of ZERO_FILL is

  signal DET_LDR_STR : std_logic;
  signal S_auxOP     : std_logic_vector(31 downto 0);
  signal S_auxLS     : std_logic_vector(31 downto 0);
  
begin  -- RTL

  DET_LDR_STR <= (not DET_LDR) and DET_STR;
  
  S_auxOP <= "00000000000000000000000000"&OFFSET(5 downto 0);
  S_auxLS <= "00000000"&OFFSET;
  
  process (OFFSET,DET_LDR,DET_STR,DET_LDR_STR,S_auxOP,S_auxLS)
  begin  -- process

    case DET_LDR_STR is
      when '0' => S_IM <= S_auxOP;
      when '1' => S_IM <= S_auxLS;
      when others => null;
    end case;
    
  end process;
end RTL;

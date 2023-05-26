library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

entity LOGIC_PC is
  
  port (
    PC_Current  : in  std_logic_vector(31 downto 0);
    OFFSET      : in  std_logic_vector(31 downto 0);
    WR          : in  std_logic;
    DET_BRANCH  : in  std_logic;
    DET_MV_PCLR : in  std_logic;
    NOP         : out std_logic;
    PC_next     : out std_logic_vector(31 downto 0));

end LOGIC_PC;

architecture RTL of LOGIC_PC is
  
begin  -- RTL

  process (PC_Current,OFFSET,WR,DET_BRANCH,DET_MV_PCLR)

    variable PC : unsigned(31 downto 0);
    
  begin  
    NOP <= '0';                    -- Default
    
    if DET_BRANCH = '1' then

      if WR = '1' then                  -- Le bloc "TEST_COND" a envoyé le signal laisser-faire

        PC := unsigned(OFFSET);
        NOP <= '1';
        
      else
        PC := unsigned(PC_Current) + 1;
      end if;

    else
      PC := unsigned(PC_Current) + 1;
    end if;

    if DET_MV_PCLR = '1' then
      NOP <= '1';
    end if;
      
    PC_next <= std_logic_vector(PC);
    
  end process;
end RTL;

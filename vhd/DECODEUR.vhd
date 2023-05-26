library IEEE;
use     IEEE.std_logic_1164.all;

entity DECODEUR is

  port (
    INSTRUCTION  : in  std_logic_vector(31 downto 0);
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

end entity DECODEUR;

architecture RTL of DECODEUR is

begin  -- architecture RTL

  process (INSTRUCTION) is
  begin 

    -- FLAGS Default:
    DET_ULA      <= '0';
    DET_MUL      <= '0';
    DET_MOV_PCLR <= '0';
    DET_LDR      <= '0';
    DET_STR      <= '0';
    DET_BRANCH   <= '0';

    SEL_BUS <= "00";
    
    if INSTRUCTION(27 downto 26) = "00" then  -- ULA

      COND       <= INSTRUCTION(31 downto 28);
      I          <= INSTRUCTION(25);
      FS         <= INSTRUCTION(24 downto 21);
      S          <= INSTRUCTION(20);
      DA         <= INSTRUCTION(19 downto 16);
      SEL_RA     <= INSTRUCTION(15 downto 12);
      SEL_RB     <= INSTRUCTION(9 downto 6);
      SS         <= INSTRUCTION(5 downto 3);
      NS         <= INSTRUCTION(2 downto 0);
      ACM        <= '-';
      SEL_RM     <= "----";
      AUTO_INDEX <= '-';
      LINK       <= '-';
      OFFSET     <= "000000000000000000"&INSTRUCTION(11 downto 6);
      SEL_BUS    <= "00";
      
      DET_ULA <= '1';
      
      if INSTRUCTION(24 downto 21) = "1010" and INSTRUCTION(19 downto 16) = "1111" and INSTRUCTION(9 downto 6) = "1110" then
        DET_MOV_PCLR <= '1';
      end if;
      
    elsif INSTRUCTION(27 downto 22) = "110000" and INSTRUCTION(7 downto 4) = "1001" then -- MUL

      COND       <= INSTRUCTION(31 downto 28);
      I          <= '-';
      FS         <= "----";
      S          <= INSTRUCTION(20);
      DA         <= INSTRUCTION(19 downto 16);
      SEL_RA     <= INSTRUCTION(15 downto 12);
      SEL_RB     <= INSTRUCTION(11 downto 8);
      SS         <= "---";
      NS         <= "---";
      ACM        <= INSTRUCTION(21);
      SEL_RM     <= INSTRUCTION(3 downto 0);
      AUTO_INDEX <= '-';
      LINK       <= '-';
      OFFSET     <= "------------------------";
      SEL_BUS    <= "01";
      
      DET_MUL <= '1';
      
    elsif INSTRUCTION(27 downto 26) = "01" and INSTRUCTION(24 downto 23) = "00" then  -- LOAD/STORE

      COND       <= INSTRUCTION(31 downto 28);
      I          <= INSTRUCTION(25);
      FS         <= "----";
      S          <= INSTRUCTION(21);
      DA         <= INSTRUCTION(19 downto 16);
      SEL_RA     <= INSTRUCTION(19 downto 16);
      SEL_RB     <= INSTRUCTION(15 downto 12);
      SS         <= "---";
      NS         <= "---";
      ACM        <= '-';
      SEL_RM     <= "----";
      AUTO_INDEX <= INSTRUCTION(20);
      LINK       <= '-';
      OFFSET     <= "000000000000"&INSTRUCTION(11 downto 0);
      SEL_BUS    <= "10";
      
      if INSTRUCTION(22) = '0' then
        DET_LDR <= '1';
      else
        DET_STR <= '1';
      end if;
      
    elsif INSTRUCTION(27 downto 26) = "10" then  -- BRANCH

      COND       <= INSTRUCTION(31 downto 28);
      I          <= '-';
      FS         <= "----";
      S          <= INSTRUCTION(25);
      DA         <= "----";
      SEL_RA     <= "----";
      SEL_RB     <= "----";
      SS         <= "---";
      NS         <= "---";
      ACM        <= '-';
      SEL_RM     <= "----";
      AUTO_INDEX <= '-';
      LINK       <= INSTRUCTION(24);
      OFFSET     <= INSTRUCTION(23 downto 0);
  
      DET_BRANCH <= '1';
      
    else                                -- NOP

      COND       <= "----";
      I          <= '0';
      FS         <= "1010";
      S          <= '0';
      DA         <= "0000";
      SEL_RA     <= "0000";
      SEL_RB     <= "0000";
      SS         <= "---";
      NS         <= "---";
      ACM        <= '-';
      SEL_RM     <= "----";
      AUTO_INDEX <= '-';
      LINK       <= '-';
      OFFSET     <= "------------------------";
      SEL_BUS    <= "00";

      DET_ULA <= '1';
            
    end if;  

  end process;
end architecture RTL;

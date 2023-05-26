library IEEE;
use     IEEE.std_logic_1164.all;

-- I : Selectioner si on utilise busB ou offset
-- SS: Selectioner l'operation de décalage (6 operations)
-- NS: Selectioner la quntité de bits pour décaler (0 - 5 bits)


entity BARREL_SHIFTER is
  
  port (
    busB   : in  std_logic_vector(31 downto 0);
    offset : in  std_logic_vector(31 downto 0);
    Carry  : in  std_logic;
    I      : in  std_logic;
    SS     : in  std_logic_vector(2 downto 0);
    NS     : in  std_logic_vector(2 downto 0);
    S      : out std_logic_vector(31 downto 0));

end BARREL_SHIFTER;


architecture RTL of BARREL_SHIFTER is

  signal RESULT : std_logic_vector(31 downto 0);

begin  -- RTL
  
  BARREL: process (busB,offset,Carry,I,SS,NS)
  begin  -- process BARREL
  
    if I = '0' then

      case SS is
        when "000" =>
          if NS = "000" then
            RESULT <= busB;
          elsif NS = "001" then
            RESULT <= busB(30 downto 0)&'0';
          elsif NS = "010" then
            RESULT <= busB(29 downto 0)&"00";
          elsif NS = "011" then
            RESULT <= busB(28 downto 0)&"000";
          elsif NS = "100" then
            RESULT <= busB(27 downto 0)&"0000";
          elsif NS = "101" then
            RESULT <= busB(26 downto 0)&"00000";
          elsif NS = "110" then
            RESULT <= busB(25 downto 0)&"000000";
          elsif NS = "111" then
            RESULT <= busB(24 downto 0)&"0000000";
          else
            RESULT <= busB;
          end if;
        when "001" =>
          if NS = "000" then
            RESULT <= busB;
          elsif NS = "001" then
            RESULT <= '0'&busB(31 downto 1);
          elsif NS = "010" then
            RESULT <= "00"&busB(31 downto 2);
          elsif NS = "011" then
            RESULT <= "000"&busB(31 downto 3);
          elsif NS = "100" then
            RESULT <= "0000"&busB(31 downto 4);
          elsif NS = "101" then
            RESULT <= "00000"&busB(31 downto 5);
          elsif NS = "110" then
            RESULT <= "000000"&busB(31 downto 6);
          elsif NS = "111" then
            RESULT <= "0000000"&busB(31 downto 7);
          else
            RESULT <= busB;
          end if;
        when "010" =>
          RESULT <= busB(31)&busB(31 downto 1);
        when "011" =>
          RESULT <= busB(0)&busB(31 downto 1);
        when "100" =>
          RESULT <= Carry&busB(31 downto 1);
        when others =>
          RESULT <= busB;
      end case;
      
    else
      
      case SS is
        when "000" =>
          if NS = "000" then
            RESULT <= offset;
          elsif NS = "001" then
            RESULT <= offset(30 downto 0)&'0';
          elsif NS = "010" then
            RESULT <= offset(29 downto 0)&"00";
          elsif NS = "011" then
            RESULT <= offset(28 downto 0)&"000";
          elsif NS = "100" then
            RESULT <= offset(27 downto 0)&"0000";
          elsif NS = "101" then
            RESULT <= offset(26 downto 0)&"00000";
          elsif NS = "110" then
            RESULT <= offset(25 downto 0)&"000000";
          elsif NS = "111" then
            RESULT <= offset(24 downto 0)&"0000000";
          else
            RESULT <= offset;
          end if;
        when "001" =>
          if NS = "000" then
            RESULT <= offset;
          elsif NS = "001" then
            RESULT <= '0'&offset(31 downto 1);
          elsif NS = "010" then
            RESULT <= "00"&offset(31 downto 2);
          elsif NS = "011" then
            RESULT <= "000"&offset(31 downto 3);
          elsif NS = "100" then
            RESULT <= "0000"&offset(31 downto 4);
          elsif NS = "101" then
            RESULT <= "00000"&offset(31 downto 5);
          elsif NS = "110" then
            RESULT <= "000000"&offset(31 downto 6);
          elsif NS = "111" then
            RESULT <= "0000000"&offset(31 downto 7);
          else
            RESULT <= offset;
          end if;
        when "010" =>
          RESULT <= offset(31)&offset(31 downto 1);
        when "011" =>
          RESULT <= offset(0)&offset(31 downto 1);
        when "100" =>
          RESULT <= Carry&offset(31 downto 1);
        when others =>
          RESULT <= offset;
      end case;
    end if;
  end process BARREL;

  S <= RESULT;
  
end RTL;

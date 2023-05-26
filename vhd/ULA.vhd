library IEEE;
use     IEEE.std_logic_1164.all;
use 	IEEE.numeric_std.all;

entity ULA is
  port ( busA          : in  std_logic_vector(31 downto 0);
         busB          : in  std_logic_vector(31 downto 0); 
         FS            : in  std_logic_vector(3 downto 0);
         CPSR          : in  std_logic_vector(31 downto 0);   -- NZCV
         FS_TEST       : out std_logic;
         CPSR_next_ULA : out std_logic_vector(31 downto 0);
         S             : out std_logic_vector(31 downto 0));
end ULA;

architecture RTL of ULA is

  signal FLAGS  : std_logic_vector(3 downto 0);         -- NZCV
  signal CARRY  : std_logic_vector(32 downto 0);

begin                                                   -- RTL
  
  process(busA,busB,FS,CPSR)
    variable RESULT_sig   : signed(32 downto 0);
    variable RESULT_unsig : unsigned(32 downto 0);
  begin
    
    FLAGS   <= "0000"; 	
    CARRY   <= "00000000000000000000000000000000"&CPSR(29);
    FS_TEST <= '0';
    
    case FS is
      when "0000" => 
        RESULT_sig   := signed(busA(31)&busA) + signed(busB(31)&busB);
        RESULT_unsig := unsigned('0'&busA) + unsigned('0'&busB);
      when "0001" =>
        RESULT_sig   := signed(busA(31)&busA) + signed(busB(31)&busB) + signed(CARRY);
        RESULT_unsig := unsigned('0'&busA) + unsigned('0'&busB) + unsigned(CARRY);
      WHEN "0010" =>
        RESULT_sig   := signed(busA(31)&busA) - signed(busB(31)&busB);
        RESULT_unsig := unsigned('0'&busA) - unsigned('0'&busB);
      when "0011" =>
        RESULT_sig   := signed(busA(31)&busA) - signed(busA(31)&busB) + signed(CARRY) - 1;
        RESULT_unsig := unsigned('0'&busA) - unsigned('0'&busB) + unsigned(CARRY) - 1;
      when "0100" =>
        RESULT_sig   := signed(busB(31)&busB) - signed(busA(31)&busA);
        RESULT_unsig := unsigned('0'&busB) - unsigned('0'&busA);
      when "0101" =>
        RESULT_sig   := signed(busB(31)&busB) - signed(busA(31)&busA) + signed(CARRY) - 1;
        RESULT_unsig := unsigned('0'&busB) - unsigned('0'&busA) + unsigned(CARRY) - 1;
      when "0110" =>
        RESULT_sig   := signed(busA(31)&(busA)) and signed(busB(31)&(busB));
        RESULT_unsig := unsigned('0'&(busA)) and unsigned('0'&(busB));
      when "0111" =>
        RESULT_sig   := signed(busA(31)&busA) or signed(busB(31)&busB);
        RESULT_unsig := unsigned('0'&busA) or unsigned('0'&busB);
      when "1000" =>
        RESULT_sig   := signed(busA(31)&busA) xor signed(busA(31)&busB);
        RESULT_unsig := unsigned('0'&busA) xor unsigned('0'&busB);
      when "1001" =>
        RESULT_sig   := signed(busA(31)&busA) and (not signed(busB(31)&busB));
        RESULT_unsig := unsigned('0'&busA) and (not unsigned('0'&busB));
      when "1010" =>
        RESULT_sig   := signed(busB(31)&busB);
        RESULT_unsig := unsigned('0'&busB);
      when "1011" =>
        RESULT_sig   := (not signed(busB(31)&busB));
        RESULT_unsig := (not unsigned('0'&busB));
      when "1100" =>
        FS_TEST <= '1';
        RESULT_sig   := signed(busA(31)&busA) - signed(busB(31)&busB);
        RESULT_unsig := unsigned('0'&busA) - unsigned('0'&busB);
      when "1101" =>
        FS_TEST <= '1';
        RESULT_sig   := signed(busA(31)&busA) + signed(busB(31)&busB);
        RESULT_unsig := unsigned('0'&busA) + unsigned('0'&busB);
      when "1110" =>
        FS_TEST <= '1';
        RESULT_sig   := signed(busA(31)&busA) and signed(busB(31)&busB);
        RESULT_unsig := unsigned('0'&busA) and unsigned('0'&busB);
      when "1111" =>
        FS_TEST <= '1';
        RESULT_sig   := signed(busA(31)&busA) xor signed(busB(31)&busB);
        RESULT_unsig := unsigned('0'&busA) xor unsigned('0'&busB);
      when others => null;
    end case;
    
    FLAGS(0) <= std_logic(RESULT_sig(32)) xor std_logic(RESULT_sig(31));  -- V: VOIR RESULTAT SIGNED 
    FLAGS(1) <= std_logic(RESULT_unsig(32));                              -- V: VOIR RESULTAT UNSIGNED 
    FLAGS(3) <= std_logic(RESULT_sig(31));                                -- N 
    
    if RESULT_sig(31 downto 0) = "000000000000000000000000000000000" then
      
      FLAGS(2) <= '1';
      
    end if;
    
    S <= std_logic_vector(RESULT_sig(31 downto 0));

  end process;
  
  CPSR_next_ULA <= FLAGS&"0000000000000000000000000000";

end RTL;

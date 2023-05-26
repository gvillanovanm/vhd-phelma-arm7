library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

library lib_VHDL;
use lib_VHDL.my_type.all;

entity MUL is
  
  port (
    REGS          : in  TAB_REG_OUT(0 to 15);
    busA          : in  std_logic_vector(31 downto 0);
    busB          : in  std_logic_vector(31 downto 0);
    SEL_RM        : in  std_logic_vector(3 downto 0);
    ACM           : in  std_logic;
    CPSR_next_MUL : out std_logic_vector(31 downto 0);
    S             : out std_logic_vector(31 downto 0));

end MUL;

architecture RTL of MUL is

  signal FLAGS  : std_logic_vector(3 downto 0);  -- NZCV
  signal SORTIE : std_logic_vector(31 downto 0);
 
  
begin  -- RTL
  
  process (REGS,busA,busB,SEL_RM,ACM)
    
    variable S_auxA  : signed(63 downto 0);
    variable S_auxAb : signed(63 downto 0);
    variable MAX16A  : unsigned(31 downto 0);
    variable MAX16Ab : unsigned(31 downto 0);
    variable BUS_RM : std_logic_vector(31 downto 0);
  
  begin  -- process

    -- Default:
    FLAGS(3) <= '0';
    FLAGS(2) <= '0';
    FLAGS(1) <= '0';
    FLAGS(0) <= '0';
    
    BUS_RM := REGS(to_integer(unsigned(SEL_RM)));

    S_auxA  := signed(busA) * signed(busB) + signed(BUS_RM);
    S_auxAb := signed(busA) * signed(busB);
    
    MAX16A  := unsigned(S_auxA(63 downto 32)); 
    MAX16Ab := unsigned(S_auxAb(63 downto 32)); 


    if ACM = '0' then

      SORTIE   <= std_logic_vector(S_auxAb(31 downto 0));
      FLAGS(3) <= std_logic(S_auxA(31)); 

      if MAX16Ab /= "00000000000000000000000000000000" then

        -- Overflow:
        FLAGS(0) <= '1';  

      end if;

    else

      SORTIE   <= std_logic_vector(S_auxA(31 downto 0));
      FLAGS(3) <= std_logic(S_auxA(31));

      if MAX16A /= "00000000000000000000000000000000" then

        -- Overflow:
        FLAGS(0) <= std_logic(S_auxA(32)) xor std_logic(S_auxA(31));

      end if;

    end if;

    if busA = "00000000000000000000000000000000" or busB = "00000000000000000000000000000000" then
      FLAGS(0) <= '1';
    end if;
    
  end process;

  S <= SORTIE;
  CPSR_next_MUL <= FLAGS&"0000000000000000000000000000";
  
end RTL;

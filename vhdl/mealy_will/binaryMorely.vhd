library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mealyAdder is 
    Port (clk : in STD_LOGIC;
          clr : in STD_LOGIC;
          a : in STD_LOGIC;
          b : in STD_LOGIC;
          sum : out STD_LOGIC;
          c : out STD_LOGIC);
end mealyAdder;

architecture Behavioral of mealyAdder is 
type state_type is (s1, s2);
signal current_s, next_s : state_type;

begin 

process(clk)
begin  
    if (clr = '1') then
        current_s <= s1;
    elsif (rising_edge(clk)) then
        current_s <= next_s;
    end if;
end process;

process(current_s, a,b)
variable aux : STD_LOGIC_vector (1 downto 0);
begin  
aux:= a&b;
    case current_s is
        when s1 =>
            if (aux = "00") then
                sum <= '0';
                next_s <= s1;
            elsif (aux = "01" or aux = "10") then
                sum <= '1';
                next_s <= s1;
            else
                sum <= '0';
                next_s <= s2;
            end if;
        when s2 =>
            if (aux = "11") then
                sum <= '1';
                next_s <= s2;
            elsif (aux = "01" or aux = "10") then
                sum <= '0';
                next_s <= s2;
            else
                sum <= '1';
                next_s <= s1;
            end if;
    end case;
    if (current_s = s1 and next_s = s1) then 
        c <= '0';
    elsif (current_s = s1 and next_s = s2) then 
        c <= '1';
    elsif (current_s = s2 and next_s = s2) then
        c <= '1';
    else
        c <= '0';
    end if;
end process;

end Behavioral;
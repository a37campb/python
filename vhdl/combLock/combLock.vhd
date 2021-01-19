library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- Imports the standard textio package

--entity definitions (input and output ports would go here)
entity combLock is 
    port (
        clk,clr : in std_logic;
        comb : in std_logic_vector (1 downto 0);
        y : out std_logic_vector (1 downto 0)
    );
end combLock;

architecture behaviour of combLock is 
type state_type is (s1,s2,s3,s4);
signal cur_s, new_s : state_type;

begin

    process (clk)
    begin  
        if (clr = '1') then 
            cur_s <= s1;
        elsif (rising_edge(clk)) then  
            cur_s <= new_s;
        end if;
    end process;

    process (cur_s,comb)
        begin
            case cur_s is
                when s1 => y <= "00";
                    if comb = "10" then
                        new_s <= s2;
                    elsif comb = "00" then 
                        new_s <= s1;
                    else
                        new_s <= s4;
                    end if;
                when s2 => y <= "00";
                    if comb = "10" then
                        new_s <= s2;
                    elsif comb = "11" then 
                        new_s <= s3;
                    else
                        new_s <= s4;
                    end if;
                when s3 => y <= "10";
                    new_s <= s3;
                when s4 => y <= "01";
                    new_s <= s4;
            end case;
    end process;
end behaviour;
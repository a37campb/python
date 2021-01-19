library ieee;
use ieee.std_logic_1164.all;

entity comboLock is
    port(
        a,b,clr,clk: in std_logic;
        y : out std_logic_vector (1 downto 0)
    );
end comboLock;

architecture behave of comboLock is 
type states is (s1,s2,s3,s4);
signal cur,nex : states;

begin
    
    process(clk)
    begin
        if (clr = '1') then
            cur <= s1;
        elsif (rising_edge(clk)) then
            cur <= nex;
        end if;
    end process;
    process(a,b,cur)
    variable com : std_logic_vector (1 downto 0);
    begin
        com := a&b;
        case cur is
            when s1 => y <= "00";
                if (com = "10") then 
                    nex <= s2;
                elsif (com = "00") then 
                    nex <= s1;
                else 
                    nex <= s4;
                end if;
            when s2 => y <= "00";
                if (com = "10") then 
                    nex <= s2;
                elsif (com = "11") then 
                    nex <= s3;
                else 
                    nex <= s4;
                end if;
            when s3 => y <= "10";
                nex <= s3;
            when s4 => y <= "01";
                nex <= s4;
        end case;
    end process;
end behave;
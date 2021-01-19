library ieee;
use ieee.std_logic_1164.all;

entity syncM is
    port (
        clk: in std_logic;
        clr: in std_logic;
        a: in std_logic;
        y1: out std_logic
    );
end syncM;

architecture behave of syncM is
type states is (s1,s2);
signal cur_s, nex_s : states;

begin
    process (clk)
    begin
        if (clr = '1') then
            cur_s <= s1;
        elsif (rising_edge(clk)) then
            cur_s <= nex_s;
        end if;
    end process;

    process(a,cur_s,nex_s)
    begin
        case cur_s is
            when s1 => y1 <= '0';
                if (a = '1') then 
                    nex_s <= s2;
                else
                    nex_s <= s1;
                end if;
            when s2 => y1 <= '1';
                if (a = '0') then 
                    nex_s <= s1;
                else
                    nex_s <= s1;
                end if;
        end case;
    end process;
end behave;
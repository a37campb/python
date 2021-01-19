library ieee;
use ieee.std_logic_1164.all;

entity twoMux_if is
    port(
        s,a,b: in std_logic;
        o: out std_logic
    );
end twoMux_if;

architecture behave of twoMux_if is
    begin
        mux:process(s,a,b)
        begin
            if (s='0') then
                o <= b;
            elsif (s='1') then
                o <= a;
            else
                o<='X';
            end if;
        end process mux;
end behave;
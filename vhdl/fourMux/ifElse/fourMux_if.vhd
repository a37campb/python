library ieee;
use ieee.std_logic_1164.all;

entity fourMux_if is
    port(
        x1,x2,x3,x4,c1,c0: in std_logic;
        o: out std_logic
    );
end fourMux_if;

architecture behave of fourMux_if is
    begin
        mux:process(c0,c1)
        begin
            if ((c1 = '0') and (c0 = '0')) then
                o <= x1;
            elsif ((c1 = '0') and (c0 = '1'))  then
                o <= x2;
            elsif ((c1 = '1') and (c0 = '0'))  then
                o <= x3;
            elsif ((c1 = '1') and (c0 = '1'))  then 
                o <= x4;
            else
                o <= 'X';
            end if;
        end process mux;
    end behave;
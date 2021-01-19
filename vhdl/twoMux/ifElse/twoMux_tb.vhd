library ieee;
use ieee.std_logic_1164.all;

entity twoMux_tb is
end twoMux_tb;

architecture behave of twoMux_tb is

    component twoMux_if
        port(
            s,a,b: in std_logic;
            o:out std_logic
        );
    end component;

    signal s: std_logic := '0';
    signal a: std_logic := '0';
    signal b: std_logic := '0';

    signal o: std_logic;

    begin
        uut:twoMux_if port map(
            s=>s,
            a=>a,
            b=>b,
            o=>o);

        process
        begin
            for i in std_logic range '0' to '1' loop
                for j in std_logic range '0' to '1' loop
                    for k in std_logic range '0' to '1' loop
                        s <= i;
                        a <= j;
                        b <= k;
                        wait for 10 ns;
                    end loop;
                end loop;
            end loop;
            wait;
        end process;
    end;
    
library ieee;
use ieee.std_logic_1164.all;

entity fourMux_tb is
end fourMux_tb;

architecture behave of fourMux_tb is
    component fourMux_if
        port(
            x1,x2,x3,x4,c1,c0: in std_logic;
            o: out std_logic);
    end component;

    signal x1 : std_logic := '0';
    signal x2 : std_logic := '0';
    signal x3 : std_logic := '0';
    signal x4 : std_logic := '0';
    signal c0 : std_logic := '0';
    signal c1 : std_logic := '0';

    signal o : std_logic;

    begin
        uut: fourMux_if port map(
            x1 => x1,
            x2 => x2,
            x3 => x3,
            x4 => x4,
            c0 => c0,
            c1 => c1);

        sim:process
        begin
            for i in std_logic range '0' to '1' loop
                for j in std_logic range '0' to '1' loop
                    for k in std_logic range '0' to '1' loop
                        for l in std_logic range '0' to '1' loop
                            for m in std_logic range '0' to '1' loop
                                for n in std_logic range '0' to '1' loop
                                    c1 <= i; c0 <= j;
                                    x1 <= k;x2 <= l;x3 <= m;x4 <= n;
                                    wait for 10 ns;
                                end loop;
                            end loop;
                        end loop;
                    end loop;
                end loop;
            end loop;
            wait;
        end process sim;
    end;

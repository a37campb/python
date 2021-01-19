library ieee;
use ieee.std_logic_1164.all;

entity fourMux_clk_tb is
end fourMux_clk_tb;

architecture behave of fourMux_clk_tb is
    component fourMux_clk
        port(
            x1,x2,x3,x4: in std_logic;
            s: in std_logic_vector (1 downto 0);
            o: out std_logic;
            clk: in std_logic);
    end component;

    signal x1 : std_logic := '0';
    signal x2 : std_logic := '0';
    signal x3 : std_logic := '0';
    signal x4 : std_logic := '0';
    signal s : std_logic_vector(1 downto 0) := (others => '0');
    signal clk : std_logic := '0';
    --Clock period def--
    constant clk_period : time := 10 ns;


    signal o : std_logic;

    begin
        uut: fourMux_clk port map(
            x1 => x1,
            x2 => x2,
            x3 => x3,
            x4 => x4,
            s => s,
            o => o,
            clk => clk);
        
        --setting up the clock process
        clk_process:process
        begin 
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end process;

        sim:process
        begin
            for i in std_logic range '0' to '1' loop
                for j in std_logic range '0' to '1' loop
                    for k in std_logic range '0' to '1' loop
                        for l in std_logic range '0' to '1' loop
                            for m in std_logic range '0' to '1' loop
                                for n in std_logic range '0' to '1' loop
                                    s(1) <= i; s(0) <= j;
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

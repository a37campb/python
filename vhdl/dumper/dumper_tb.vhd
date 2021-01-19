library ieee;
use ieee.std_logic_1164.all;

entity dumper_tb is
end dumper_tb;

architecture behave of dumper_tb is

component dumper
    port(
        x1,x2,x3 : in std_logic;
        clr,clk : in std_logic;
        y : out std_logic_vector (2 downto 0)
    );
end component;

--Input signals 
signal x1 : std_logic := '1';
signal x2 : std_logic := '1';
signal x3 : std_logic := '1';
signal clr : std_logic := '0';
signal clk : std_logic := '0';

--Output signals
signal y : std_logic_vector (2 downto 0);

constant clk_period : time := 50 ns;

begin
    uut : dumper port map(
        x1 => x1,
        x2 => x2,
        x3 => x3,
        clr => clr,
        clk => clk,
        y => y
    );

    ticks:process --definition of the clock process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    reset:process --reset process
    begin
        wait for clk_period/2;
        clr <= '1';
        wait for clk_period/2;
        clr <= '0';
        wait;
    end process;

    sim:process
    begin
        for i in std_logic range '0' to '1' loop
            for j in std_logic range '0' to '1' loop
                for k in std_logic range '0' to '1' loop
                    x1 <= i;
                    x2 <= j;
                    x3 <= k;
                    wait for 3*clk_period;
                end loop;
            end loop;
        end loop;
        wait for 2*clk_period;
        for i in std_logic range '0' to '1' loop
            for j in std_logic range '0' to '1' loop
                for k in std_logic range '0' to '1' loop
                    x1 <= k;
                    x2 <= j;
                    x3 <= i;
                    wait for 3*clk_period;
                end loop;
            end loop;
        end loop;
    end process;
end behave;
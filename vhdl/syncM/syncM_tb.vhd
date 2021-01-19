library ieee;
use ieee.std_logic_1164.all;

entity syncM_tb is
end syncM_tb;

architecture behave of syncM_tb is
component syncM
    port (
        clk: in std_logic;
        clr: in std_logic;
        a: in std_logic;
        y1: out std_logic
    );
end component;

signal clk: std_logic := '0';
signal clr: std_logic := '0';
signal a: std_logic;

signal y1: std_logic;

constant clk_period : time := 50 ns;

begin
    uut : syncM port map(
        clk => clk,
        clr => clr,
        a => a,
        y1 => y1
    );

    clock:process --defining the clock system
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    reset:process --reseting the system
    begin
        wait for clk_period;
        clr <= '1';
        wait for clk_period;
        clr <= '0';
        wait;
    end process;

    simu:process --actual test case
    begin
        a <= '0';
        wait for 3*clk_period;
        a <= '1';
        wait for 3*clk_period;
        a <= '0';
        wait;
    end process;
end behave;

library ieee;
use ieee.std_logic_1164.all;

entity flipflop_tb is
end flipflop_tb ;

architecture behave of flipFlop_tb is
component flipflop
    port (
        clk,clr,D : in std_logic;
        q,not_q : out std_logic
    ) ;
end component;

--Input signals
signal clk : std_logic := '0';
signal clr : std_logic := '0';
signal D : std_logic := '1';

--Output signals
signal not_q : std_logic;
signal q : std_logic;

--clock constant
constant clk_period : time := 10 ns; 

begin
    UUT: flipflop port map(
        clk => clk,
        clr => clr,
        D => D,
        not_q => not_q,
        q => q
    );

    tictoc : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process ; -- tictoc

    clear : process
    begin
        wait for clk_period/2;
        clr <= '1';
        wait for clk_period/2;
        clr <= '0';
        wait;
    end process ; -- clear

    sim : process
    begin
        D <= '1';
        wait for clk_period;
        D <= '0';
        wait for clk_period;
        D <= '0';
        wait for clk_period;
        D <= '1';
        wait for clk_period;
    end process ; -- sim


end architecture ; -- arch
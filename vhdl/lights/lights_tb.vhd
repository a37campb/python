library ieee;
use ieee.std_logic_1164.all;

entity lights_tb is
end lights_tb;

architecture behave of lights_tb is

component lights 
    port (
        clk,clr,a: in std_logic;
        y: out std_logic_vector (2 downto 0)
    ) ;
end component;

-- input signals
signal clk : std_logic := '0';
signal clr : std_logic := '0';
signal a : std_logic := '0';

-- output signals 
signal y : std_logic_vector (2 downto 0);

-- clock period
constant clk_period : time := 50 ns;

begin
    uut : lights port map(
        clk => clk,
        clr => clr,
        a => a,
        y => y
    );

    reset : process--( sensitivity_list )
    begin
        wait for clk_period/2;
        clr <= '1';
        wait for clk_period/2;
        clr <= '0';
        wait;
    end process ; -- reset

    tictoc : process--( sensitivity_list )
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process ; -- tictoc

    simulation : process--( sensitivity_lit )
    begin
        a <= '0';
        wait for 3*clk_period;
        a <= '1';
        wait;
    end process ; -- simulation
end behave ; -- behave
library ieee; 
use ieee.std_logic_1164.all;

entity bulb_tb is
end bulb_tb;

architecture behave of bulb_tb is

component bulb
    port (
        clk,clr,a : in std_logic;
        y : out std_logic_vector (2 downto 0) -- this is the output (concatenated for bulb 1, bulb 2, bulb 3)
    ) ;
end component;

--Input signals
signal clk : std_logic := '0';
signal clr : std_logic := '0';
signal a : std_logic := '0';

--Output signals
signal y : std_logic_vector (2 downto 0);

--clock constant
constant clk_period : time := 10 ns; 

begin
    UUT: bulb port map(
        clk => clk,
        clr => clr,
        a => a,
        y => y
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
        a <= '1';
        wait for 10*clk_period;
        a <= '0';
        wait;
    end process ; -- sim
end behave ; -- arch
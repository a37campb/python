library ieee;
use ieee.std_logic_1164.all;

entity comboLock_tb is
end comboLock_tb;

architecture behave of comboLock_tb is
component comboLock
    port(
        clk,clr,a,b: in std_logic;
        y: out std_logic_vector (1 downto 0)
    );
end component;

--Input signals
signal clk : std_logic := '0';
signal clr : std_logic := '0';
signal a : std_logic;
signal b : std_logic;

--Output singals
signal y : std_logic_vector (1 downto 0);
--Clock period def
constant clk_p : time := 50 ns;

begin
    UUT: comboLock port map(
        clk => clk,
        clr => clr,
        a => a,
        b => b,
        y => y
    );

    clock_works:process
    begin 
        clk <= '1';
        wait for clk_p/2;
        clk <= '0';
        wait for clk_p/2;
    end process;

    reset:process
    begin
        wait for clk_p/2;
        clr <= '1';
        wait for clk_p/2;
        clr <= '0';
        wait;
    end process;

    working:process
    begin 
        a <= '0';
        b <= '0';
        wait for 3*clk_p;
        a <= '1';
        b <= '0';
        wait for 3*clk_p;
        a <= '0';
        b <= '0';
        wait for 3*clk_p;
    end process;
end behave;
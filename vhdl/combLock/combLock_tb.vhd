library ieee;
use ieee.std_logic_1164.all;

entity combLock_tb is
end combLock_tb;

architecture behave of combLock_tb is
    component combLock
        port(
            clr,clk: in std_logic;
            comb : in std_logic_vector (1 downto 0);
            y: out std_logic_vector (1 downto 0)
        );
    end component;

    signal comb : std_logic_vector (1 downto 0) := "00";
    signal clr : std_logic := '0';
    signal y : std_logic_vector (1 downto 0);
    signal clk : std_logic := '0';
    --Clock period def--
    constant clk_period : time := 50 ns;

    begin
        uut: combLock port map(
            comb => comb,
            clr => clr,
            clk => clk,
            y => y);
        
        --setting up the clock process
        clk_process:process
        begin 
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end process;

        reset:process
        begin
            wait for clk_period/2;
            clr <= '1';
            wait for clk_period/2;
            clr <= '0';
            wait;
        end process reset;
        
        sim:process
        begin
            comb <= "00";
            wait for 3*clk_period;
            comb <= "10";
            wait for 3*clk_period;
            comb <= "11";
            wait for 3*clk_period;
        end process sim;
    end;

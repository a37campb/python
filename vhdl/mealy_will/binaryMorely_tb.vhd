LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY binaryMorely_tb IS
END binaryMorely_tb;
ARCHITECTURE behavior OF binaryMorely_tb IS --Component Declaration for the Unit Under Test (UUT)

COMPONENT mealyAdder
PORT(
    clk : IN  std_logic;
    clr : IN  std_logic;
    a : IN  std_logic;
    b : IN  std_logic;
    sum : OUT  std_logic;
    c : OUT  std_logic);
END COMPONENT;


--Inputs
signal clk : std_logic := '0';
signal clr : std_logic := '0';
signal a : std_logic := '0';
signal b : std_logic := '0';
--Outputs
signal sum : std_logic;
signal c : std_logic;
--Clock period definitions
constant clk_period : time := 50 ns;
BEGIN
--Instantiate the Unit Under Test (UUT)
    uut: mealyAdder PORT MAP (
        clk => clk,
        clr => clr,
        a => a,
        b => b,
        sum => sum,
        c => c);
--Clock process definitions
clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

reset_proc: process
begin
    wait for clk_period/2;
    clr <= '1';
    wait for clk_period/2;
    clr <= '0';
    wait;
end process;

proc:process
begin
    a <= '0';
    b <= '0';
    wait for 3*clk_period;

    a <= '0';
    b <= '1';
    wait for 3*clk_period;

    a <= '1';
    b <= '0';
    wait for 3*clk_period;

    a <= '1';
    b <= '1';
    wait for 3*clk_period;

    a <= '0';
    b <= '1';
    wait for 3*clk_period;

    a <= '1';
    b <= '0';
    wait for 3*clk_period;

    a <= '1';
    b <= '1';
    wait for 3*clk_period;

    a <= '0';
    b <= '0';
    wait for 3*clk_period;
    wait;
end process;
end;

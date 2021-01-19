library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- Imports the standard textio package

entity adder_tb is
end adder_tb;

architecture behaviour of adder_tb is

    component adder 
    port(
        a,b,c_in : in std_logic;
        c_out,s : out std_logic
    );
    end component;

    --Define the signals for the I/O 
    signal a : std_logic := '0';
    signal b : std_logic := '0';
    signal c_in : std_logic := '0';

    signal s : std_logic;
    signal c_out : std_logic;

begin
--port mapping
    adder_0: adder port map (
        a => a,
        b => b,
        c_in => c_in,
        s => s,
        c_out => c_out
    );
--this is the test case scenario
    process
    begin  
        for i in std_logic range '0' to '1' loop
            for j in std_logic range '0' to '1' loop
                for k in std_logic range '0' to '1' loop
                    a <= i;
                    b <= j;
                    c_in <= k;
                end loop;
            end loop;
        end loop;
        wait;
    end process;
end;
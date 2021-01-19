library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- Imports the standard textio package

entity heater_tb is 
end heater_tb;

architecture behave of heater_tb is
    component heater_if
    port(
        a,b,c,d : in std_logic;
        s1,s2,s3,s4 : out std_logic
    );
    end component;
    --Signals
    signal a : std_logic := '0';
    signal b : std_logic := '0';
    signal c : std_logic := '0';
    signal d : std_logic := '0';

    signal s1 : std_logic;
    signal s2 : std_logic;
    signal s3 : std_logic;
    signal s4 : std_logic;

begin
    -- Port Mapping
    heater_0: heater_if port map(
        a => a,
        b => b,
        c => c,
        d => d,
        s1 => s1,
        s2 => s2,
        s3 => s3,
        s4 => s4
    );

    --test case stuff now
    process
    begin
        for i in std_logic range '0' to '1' loop
            for j in std_logic range '0' to '1' loop
                for k in std_logic range '0' to '1' loop
                    for l in std_logic range '0' to '1' loop
                        a <= i;
                        b <= j;
                        c <= k;
                        d <= l;
                        wait for 10 ns;
                    end loop;
                end loop;
            end loop;
        end loop;
        wait;
    end process;
end;
    
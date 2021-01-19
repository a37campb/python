library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- Imports the standard textio package

entity heater_bool is
    port(
        a,b,c,d : in std_logic;
        s1,s2,s3,s4 : out std_logic
    );
end heater_bool;

architecture behave of heater_bool is
    begin
        s1 <= not a;
        s2 <= not d or (not a and c);
        s3 <= b;
        s4 <= b or not c;
    end behave;
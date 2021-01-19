library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- Imports the standard textio package

--entity definitions (input and output ports would go here)
entity adder is 
    port (
        a,b,c_in : in std_logic;
        s,c_out : out std_logic
    );
end adder;

architecture behaviour of adder is 
begin
    s <= (a xor b) xor c_in; -- boolean for the sum
    c_out <= (a and b) or (b and c_in) or (a and c_in); -- boolean for the carry out
end behaviour;
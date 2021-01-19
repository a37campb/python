--D type flip flop

library ieee;
use ieee.std_logic_1164.all;

entity flipFlop is
  port (
    clk,clr,D : in std_logic;
    q,not_q : out std_logic
  ) ;
end flipFlop;

architecture behave of flipFlop is
type states is (s1,s2);
signal cur, nex : states;

--state 1 is when q is 0, state 2 is when q is 1
-- then we vary the next state for q and have that toggle the async process
begin
    reseting : process( clk )
    begin
        if (clr = '1') then
            cur <= s1;
        elsif (rising_edge(clk)) then
                cur <= nex;
        end if ;
    end process ; -- reseting

    working : process (clk)
    begin
        case( cur ) is
        
            when s1 => 
                not_q <= '0';
                if D = '1' then
                    nex <= s1;
                else
                    nex <= s2;
                end if ;
        
            when s2 => 
                not_q <= '1';
                if D = '0' then
                    nex <= s2;
                else
                    nex <= s1;
                end if ;
        end case ;
        if cur = s1 and nex = s1 then
            q <= '1';
        elsif cur = s1 and nex = s2 then
            q <= '0';
        elsif cur = s2 and nex = s1 then
            q <= '0';
        elsif cur = s2 and nex = s1 then
            q <= '1';
        end if ;
    end process ; -- working
end behave ; -- behave
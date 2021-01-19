--program a D type flip flop and then use it for a moore machine
-- program question 4 from the final

library ieee;
use ieee.std_logic_1164.all; 

entity bulb is
  port (
    clk,clr,a : in std_logic;
    y : out std_logic_vector (2 downto 0) -- this is the output (concatenated for bulb 1, bulb 2, bulb 3)
  ) ;
end bulb ;

architecture behave of bulb is
type states is (s1,s2,s3,s4);
signal cur, nex : states;

begin

    reseting : process( clk )
    begin
        if (clr = '1') then
            cur <= s1;
        elsif (rising_edge(clk)) then
            cur <= nex;
        end if ;
    end process ; -- reseting

    working : process(a,clk)
    begin
        case cur is
        
            when s1 => y <= "000";
                if (a = '1') then
                    nex <= s2;
                elsif (a = '0') then
                    nex <= s1;
                else
                    nex <= s1;
                end if ;
            when s2 => y <= "100";
                if (a = '1') then
                    nex <= s3;
                elsif (a = '0') then
                    nex <= s1;
                else
                    nex <= s1;
                end if ;
            when s3 => y <= "110";
                if (a = '1') then
                    nex <= s4;
                elsif (a = '0') then
                    nex <= s2;
                else
                    nex <= s2;
                end if ;
            when s4 => y <= "111";
                if (a = '1') then
                    nex <= s4;
                elsif (a = '0') then
                    nex <= s3;
                else
                    nex <= s3;
                end if ;
        end case ;
    end process ; -- working

end behave ; -- arch
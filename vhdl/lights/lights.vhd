library ieee;
use ieee.std_logic_1164.all;

entity lights is
  port (
    clk,clr,a: in std_logic;
    y: out std_logic_vector (2 downto 0)
  ) ;
end lights ;

architecture arch of lights is
type states  is (s0,s1,s2,s3);
signal cur, nex : states;

begin
    state_definition : process( clk )
    begin
        if clr = '1' then
            cur <= s0;
        elsif rising_edge(clk) then
            cur <= nex;
        end if ;
    end process ; -- state definition

    method : process--( cur, a )
    begin
        case( cur ) is
            when s0 => y <= "000";
                if a = '1' then
                    nex <= s1;
                else
                    nex <= s0;    
                end if ;
            when s1 => y <= "100";
                if a = '1' then
                    nex <= s2;
                else
                    nex <= s0;
                end if ;
            when s2 => y <= "110";
                if a = '1' then
                    nex <= s3;
                else
                    nex <= s1;    
                end if ;
            when s3 => y <= "111";
                if a = '1' then
                    nex <= s3;
                else
                    nex <= s1;    
                end if ;
        end case ;
    end process ; -- method

end architecture ; -- arch
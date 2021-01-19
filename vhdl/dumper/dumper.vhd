library ieee;
use ieee.std_logic_1164.all;

entity dumper is
    port(
        x1,x2,x3 : in std_logic;
        clr,clk : in std_logic;
        y : out std_logic_vector (2 downto 0)
    );
end dumper;

architecture behave of dumper is
type states is (s1,s2,s3,s0);
signal cur, nex : states;

begin
    process(clk) --this is the clock process
    begin
        if (clr = '1') then
            cur <= s1;
        elsif (rising_edge(clk)) then
            cur <= nex;
        end if;
    end process;

    process(x1,x2,x3) --this is the operation of the machine
    variable sense : std_logic_vector (2 downto 0);
    begin 
        sense := x1&x2&x3;
        case cur is
            when  s0 => y <= "000";
                if (sense = "000" or sense = "XXX") then 
                    nex <= s0;
                elsif (sense = "001") then 
                    nex <= s3;
                elsif (sense = "010" or sense = "011") then
                    nex <= s2;
                else
                    nex <= s1;
                end if; 
            when  s1 => y <= "100";
                if (sense = "100" or sense = "XXX") then 
                    nex <= s1;
                elsif (sense = "000") then 
                    nex <= s0;
                elsif (sense = "101" or sense = "001") then
                    nex <= s3;
                else
                    nex <= s2;
                end if; 
            when  s2 => y <= "010";
                if (sense = "010" or sense = "XXX") then 
                    nex <= s2;
                elsif (sense = "000") then 
                    nex <= s0;
                elsif (sense = "001" or sense = "011" or sense = "111") then
                    nex <= s3;
                else
                    nex <= s1;
                end if; 
            when  s3 => y <= "001";
                if (sense = "001" or sense = "XXX") then 
                    nex <= s3;
                elsif (sense = "000") then 
                    nex <= s0;
                elsif (sense = "011" or sense = "010") then
                    nex <= s2;
                else
                    nex <= s1;
                end if;
        end case;
    end process;
end behave;
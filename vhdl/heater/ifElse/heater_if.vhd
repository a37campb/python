library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- Imports the standard textio package

entity heater_if is
    port(
        a,b,c,d : in std_logic;
        s1,s2,s3,s4 : out std_logic
    );
end heater_if;

architecture behave of heater_if is
    signal state : std_logic_vector (3 downto 0);
begin
    state <= a&b&c&d;
    process (state) is
        begin
            if (state = "0000") then
                s1 <= '1';s2<='1';s3<='0';s4<='1';
            elsif (state = "0001") then
                s1 <= '1';s2<='0';s3<='0';s4<='1';
            elsif (state = "0011") then
                s1 <= 'X';s2<='1';s3<='0';s4<='0';
            elsif (state = "0111") then
                s1 <= '1';s2<='1';s3<='1';s4<='0';
            elsif (state = "1111") then
                s1 <= '0';s2<='0';s3<='1';s4<='1';
            else
                s1 <= 'X';s2<='X';s3<='X';s4<='X';
            end if;
    end process;
end behave;
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
--state:=a&b&c&d;    

begin

state<=a&b&c&d; 
with state select
        s1  <=  '1' when "0000",
                '1' when "0001",    
                '1' when "0111",
                '0' when "1111",
                'X' when others;
    with state select
        s2  <=  '1' when "0000",
                '0' when "0001",  
                '1' when "0011",  
                '1' when "0111",
                '0' when "1111",
                'X' when others;
    with state select
        s3  <=  '0' when "0000",
                '0' when "0001",  
                '0' when "0011",  
                '1' when "0111",
                '1' when "1111",
                'X' when others;
    with state select
        s4  <=  '1' when "0000",
                '1' when "0001",  
                '0' when "0011",  
                '0' when "0111",
                '1' when "1111",
                'X' when others;
end behave;
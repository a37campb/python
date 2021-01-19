library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- Imports the standard textio package

entity heater_case is
    port(
        a,b,c,d : in std_logic;
        s1,s2,s3,s4 : out std_logic
    );
end heater_case;

architecture behave of heater_case is
    signal state : std_logic_vector (3 downto 0);
begin
    state <= a&b&c&d;
    process (state) is
        begin
            case state is
                when "0000" =>
                            s1 <= '1';
                            s2 <= '1';
                            s3 <= '0';
                            s4 <= '1';
                when "0001" =>
                            s1 <= '1';
                            s2 <= '0';
                            s3 <= '0';
                            s4 <= '1';
                when "0011" =>
                            s1 <= 'X';
                            s2 <= '1';
                            s3 <= '0';
                            s4 <= '0';       
                when "0111" =>
                            s1 <= '1';
                            s2 <= '1';
                            s3 <= '1';
                            s4 <= '0';  
                when "1111" =>
                            s1 <= '0';
                            s2 <= '0';
                            s3 <= '1';
                            s4 <= '1'; 
                when others =>
                            s1 <= 'X';
                            s2 <= 'X';
                            s3 <= 'X';
                            s4 <= 'X';              
            end case;
    end process;
end behave;
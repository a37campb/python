library ieee;
use ieee.std_logic_1164.all;

entity fourMux_clk is
    port(
        x1,x2,x3,x4: in std_logic;
        s: in std_logic_vector (1 downto 0);
        clk: in std_logic;
        o: out std_logic
    );
end fourMux_clk;

architecture behave of fourMux_clk is
begin
    process (clk) is
    begin
        if (rising_edge(clk)) then
            case s is
                when "00" => o <= x1;
                when "01" => o <= x2;
                when "10" => o <= x3;
                when "11" => o <= x4;
                when others => o <= 'X';
            end case;
        end if;
    end process;
end behave;
            
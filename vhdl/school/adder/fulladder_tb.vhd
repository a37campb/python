library ieee;
use ieee.std_logic_1164.all;

entity fulladder_tb is
end fulladder_tb;

architecture main of fulladder_tb is
  signal a, b, cin, the_sum, cout : std_logic;
begin
  
  uut : entity work.fulladder(main)
  port map (
    i_a   => a,
    i_b   => b,
    i_cin => cin,
    o_sum => the_sum,
    o_cout => cout
  );
  
sim : process
begin
    for i in std_logic range '0' to '1' loop
        for j in std_logic range '0' to '1' loop
            for k in std_logic range '0' to '1' loop
                a <= i; b <= j; cin <= k;
                wait for 10 ns;
            end loop ; --  
        end loop ; --  
    end loop ; --  
end process ; -- sim

end architecture;
library ieee;
use ieee.std_logic_1164.all;

entity add2_tb is
end add2_tb;

architecture main of add2_tb is
   signal a, b : std_logic_vector(1 downto 0);
   signal cin  : std_logic;
   signal sum  : std_logic_vector(1 downto 0);
   signal cout : std_logic;
begin
  
   uut : entity work.add2(main)
     port map (
       i_a    => a,
       i_b    => b,
       i_cin  => cin,
       o_sum  => sum,
       o_cout => cout
     );

   -- insert VHDL testbench code here
   sim : process
   begin
    -- --------------------
    a <= "00"; b <= "00"; cin <= '0';
    wait for 10 ns;
    -- --------------------
    a <= "10"; b <= "10"; cin <= '0';
    wait for 10 ns;
    -- --------------------
    a <= "11"; b <= "00"; cin <= '1';
    wait for 10 ns;
    -- --------------------
    a <= "00"; b <= "11"; cin <= '1';
    wait for 10 ns;
    -- --------------------
   end process ; -- sim
end main;

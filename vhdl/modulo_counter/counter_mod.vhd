library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;

entity counter_mod is
  generic(n : positive);
  port(clk, reset, load : in  std_logic;
       data_in          : in  std_logic_vector(natural(ceil(log2(real(n))))-1 downto 0);
       q                : out std_logic_vector(natural(ceil(log2(real(n))))-1 downto 0));
end counter_mod;

architecture behavioral of counter_mod is
begin
  process(clk, reset, load)
    variable count : std_logic_vector(data_in'range) := (others => '0');
  begin
    if reset = '1' then
      count := (others => '0');
    elsif load = '1' then
      count := data_in;
    elsif rising_edge(clk) then
      if count = n-1 then
        count := (others => '0');
      else
        count := count+1;
      end if;
    end if;
    q <= count;
  end process;
end architecture;
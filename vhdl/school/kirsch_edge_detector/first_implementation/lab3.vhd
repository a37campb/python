library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab3 is
  port (
    clk       : in  std_logic;             -- the system clock
    reset     : in  std_logic;             -- reset
    i_valid   : in  std_logic;             -- input data is valid
    i_data    : in  unsigned(7 downto 0);  -- input data
    o_done    : out std_logic;             -- done processing
    o_data    : out unsigned(7 downto 0)   -- output data
  );
end entity lab3;

architecture main of lab3 is

-- State definitions for the system
type state_type is (s0,s1,s2,s3,s4);
signal curr_st, next_st : state_type;
subtype memstate is std_logic_vector (2 downto 0); -- state definitions for the memory bank 
signal membank : memstate;
signal mem_addr : unsigned (3 downto 0);
signal p_count: unsigned (7 downto 0);
signal bytes : unsigned (8 downto 0);
signal p,p1,p2,p3 : signed (10 downto 0);
signal wr_en : std_logic_vector (2 downto 0);
signal o0, o1, o2 : std_logic_vector (7 downto 0);
signal max_addr_chk, max_byte_chk: std_logic; 

constant m0 : memstate := (0 => '1',  others => '0');
constant m1 : memstate := (1 => '1',  others => '0');
constant m2 : memstate := (2 => '1',  others => '0');
constant min_byte : integer := 32; -- constants to check byte sizes
constant max_byte : integer := 256;
constant max_addr : unsigned  (3 downto 0):= (others => '1'); -- max address size.

begin
  max_addr_chk <= '1' when mem_addr = max_addr else '0';
  max_byte_chk <= '1' when to_integer(bytes)=max_byte else '0'; 

  u_mem0: entity work.mem( main )
  port map (
    clk      => clk,
    wr_en    => wr_en(0),
    addr     => mem_addr, 
    i_data   => std_logic_vector(i_data),
    o_data   => o0
  );
  u_mem1: entity work.mem( main )
  port map (
    clk      => clk,
    wr_en    => wr_en(1),
    addr     => mem_addr, 
    i_data   => std_logic_vector(i_data),
    o_data   => o1
  );
  u_mem2: entity work.mem( main )
  port map (
    clk      => clk,
    wr_en    => wr_en(2),
    addr     => mem_addr, 
    i_data   => std_logic_vector(i_data),
    o_data   => o2
  );
  wr_en <= (0 => '1', others => '0') when (i_valid and membank(0)) else
      (1 => '1', others => '0') when (i_valid and membank(1)) else
      (2 => '1', others => '0') when (i_valid and membank(2)) else
      (others => '0');

  process
  begin
    wait until rising_edge(clk);
    if reset = '1' then
      membank <= m0;
    elsif max_addr_chk='1' then
      membank <= membank(1 downto 0) & membank(2);
    elsif curr_st=s3 and max_byte_chk='1' then
      membank <= m0;
    end if;
  end process ; -- memstate

  process
  begin
    wait until rising_edge(clk);
    if reset = '1' then
      mem_addr <= (others => '0');
    elsif i_valid then
      if max_addr_chk then 
        mem_addr <= (others => '0');
      else
        mem_addr <= mem_addr + 1;
      end if;
    elsif curr_st=s3 and max_byte_chk='1' then
      mem_addr <= (others => '0');
    end if ;
  end process ; -- addr_chg
  
  process
  begin
    wait until rising_edge(clk); 
    if reset = '1' then
      bytes <= (others => '0');
    elsif max_byte_chk then 
      bytes <= (others => '0');
    elsif i_valid = '1' then
      bytes <= bytes + 1;
    end if;
  end process ; -- byte_cnter
      
  p <= p1 when membank(2)='1' else
        p2 when membank(1)='1' else
        p3 when membank(0)='1' else
        (others => '0');
  p1 <= to_signed(to_integer(unsigned(o0))  - to_integer(unsigned(o1)) + to_integer(i_data), 11);
  p2 <= to_signed(to_integer(i_data) - to_integer(unsigned(o0)) + to_integer(unsigned(o2)), 11);
  p3 <= to_signed(to_integer(unsigned(o1)) - to_integer(unsigned(o2)) + to_integer(i_data), 11);

  process
  begin
    wait until rising_edge(clk); 
    if reset = '1' then
      p_count <= (others => '0');
    elsif (p>=0) and (curr_st=s2) and i_valid='1' then
      p_count <= p_count + 1; 
    elsif curr_st=s4 and i_valid='1' then
      p_count <= (others => '0');
    end if;
  end process ; -- p_cnter
  
  process
  begin
    wait until rising_edge(clk);
    if reset ='1' then
      next_st <= s0;
    else
      case( curr_st ) is
        when s0 => if i_valid = '1' then
            next_st <= s1;
          else
            next_st <= s0;
          end if ;
        when s1 => if to_integer(bytes) < min_byte then
            next_st <= s0;
          else
            next_st <= s2;
          end if ;
        when s2 => if i_valid='1' then
          next_st <= s3;
        else
          next_st <= s2;
        end if ;
        when s3 => if to_integer(bytes) < max_byte then
            next_st <= s2;
          else
            next_st <= s4;
          end if ;
        when s4 => if i_valid='1' then
          next_st <= s1;
        else
          next_st <= s4;
        end if ;
      end case ;
    end if ;
  end process ; -- states 
  
  process(next_st)
  begin
    curr_st <= next_st;
  end process ; -- next_state

  o_done <= '1' when curr_st=s4 else '0';
  o_data <= p_count when o_done='1' else (others => 'X');

end architecture main;

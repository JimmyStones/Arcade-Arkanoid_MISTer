library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.all;

entity dpram_en is

	generic 
	(
		DATA_WIDTH : natural := 8;
		ADDR_WIDTH : natural := 10
	);

	port 
	(
		clk_a  : in  std_logic;
		addr_a : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
		data_a : in  std_logic_vector((DATA_WIDTH - 1) downto 0);
		q_a    : out std_logic_vector((DATA_WIDTH - 1) downto 0);
		we_a   : in  std_logic := '0';
		re_a   : in  std_logic := '0';
		
		clk_b  : in  std_logic;
		addr_b : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
		data_b : in  std_logic_vector((DATA_WIDTH - 1) downto 0);
		q_b    : out std_logic_vector((DATA_WIDTH - 1) downto 0);
		we_b   : in  std_logic := '0';
		re_b   : in  std_logic := '0'
	);

end dpram_en;

architecture rtl of dpram_en is

	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;

	shared variable ram : memory_t;

begin

	process(clk_a)
	begin
	if(rising_edge(clk_a)) then 
		if(we_a = '1') then
			ram(to_integer(unsigned(addr_a))) := data_a;
			q_a <= data_a;
		elsif(re_a = '1') then
			q_a <= ram(to_integer(unsigned(addr_a)));
		else
			q_a <= (others => '1');
		end if;
	end if;
	end process;
	
	process(clk_b)
	begin
	if(rising_edge(clk_b)) then 
		if(we_b = '1') then
			ram(to_integer(unsigned(addr_b))) := data_b;
			q_b <= data_b;
		elsif(re_b = '1') then
			q_b <= ram(to_integer(unsigned(addr_b)));
		else
			q_b <= (others => '1');
		end if;
	end if;
	end process;

end rtl;

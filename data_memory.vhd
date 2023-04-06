library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_port_ram is
 port( i_CLK: 		in std_logic;
       i_RD: 		in std_logic;
		 i_WR:		in std_logic;
       i_ADDR: 	in std_logic_vector(7 downto 0);
		 i_W_DATA: 	in std_logic_vector(15 downto 0);
       o_R_DATA: 	out std_logic_vector(15 downto 0));
end single_port_ram;

architecture ram of single_port_ram is 
 
  type t_Memory is array(255 downto 0) of std_logic_vector(15 downto 0);
  signal w_Memory : t_Memory := (others=>(others=>'0'));
  signal w_Addr: std_logic_vector(7 downto 0);

begin
	w_Addr <= i_ADDR(7 downto 0);
	process (i_CLK, i_RD, i_WR)
	  begin
		if(rising_edge(i_Clk)) then
			if(i_WR = '1' and i_RD = '0') then
				w_Memory(to_integer(unsigned(w_Addr))) <= i_W_DATA;
			end if;
		end if;
	end process;
	
	o_R_DATA <= w_Memory(to_integer(unsigned(w_Addr)));
	
--	process(i_RD, i_WR)
--		begin
--		if(i_RD = '1' and i_WR = '0') then
--				
--		end if;
--  end process;
end ram;
library ieee;
use ieee.std_logic_1164.all;

entity reg is
port(	i_I:		in std_logic_vector (15 downto 0);
		i_CLK:	in std_logic;
		i_CLR:	in std_logic;
		i_LD:		in std_logic;
		o_Q:		out std_logic_vector (15 downto 0));	
end reg;

architecture registrador of reg is
begin
	process(i_I, i_LD, i_CLK, i_CLR)
		begin
		if(i_CLR = '1') then
			o_Q <= "0000000000000000";
		elsif(rising_edge(i_CLK)) then
			if(i_LD = '1') then
				o_Q <= i_I;
			end if;
		end if;
	end process;
end registrador;
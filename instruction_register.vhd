library ieee;
use ieee.std_logic_1164.all;

entity instruction_register is
port(	i_IR:		in std_logic_vector (15 downto 0);
		i_CLK:	in std_logic;
		i_CLR:	in std_logic;
		i_LD:		in std_logic;
		o_IR:		out std_logic_vector (15 downto 0));	
end instruction_register;

architecture ir of instruction_register is
begin
	process(i_IR, i_LD, i_CLK, i_CLR)
		begin
		if(i_CLR = '1') then
			o_IR <= "0000000000000000";
		elsif(rising_edge(i_CLK)) then
			if(i_LD = '1') then
				o_IR <= i_IR;
			end if;
		end if;
	end process;
end ir;
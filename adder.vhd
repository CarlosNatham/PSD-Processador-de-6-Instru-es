library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity adder is
port(	i_A:		in std_logic_vector (7 downto 0);
		i_B:		in std_logic_vector (15 downto 0);
		o_PC:		out std_logic_vector (15 downto 0));
end adder;

architecture soma of adder is

begin
	process(i_A, i_B)
		begin
		o_PC <= i_A + i_B;
	end process;
end soma;
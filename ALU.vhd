library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is
port(	i_A:			in std_logic_vector (15 downto 0);
		i_B:			in std_logic_vector (15 downto 0);
		i_S0:			in std_logic;
		i_S1:			in std_logic;
		o_S:			out std_logic_vector (15 downto 0));
end alu;

architecture ula of alu is

--signal w_SOMA, w_SUB: std_logic_vector (15 downto 0);

begin
	--w_SOMA <= i_A + i_B;
	--w_SUB <= i_A - i_B;
	process(i_A, i_B, i_S0, i_S1)
		begin
		if(i_S0 = '0' and i_S1 = '0') then
			o_S <= i_A;
		elsif(i_S0 = '1' and i_S1 = '0') then
			o_S <= i_A + i_B;
		elsif(i_S0 = '0' and i_S1 = '1') then
			o_S <= i_A - i_B;
		end if;
	end process;
end ula;
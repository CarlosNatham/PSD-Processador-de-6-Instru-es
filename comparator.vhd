library ieee;
use ieee.std_logic_1164.all;

entity comparator is
port(	i_RP_DATA:		in std_logic_vector (15 downto 0);
		o_RF_RP_ZERO:	out std_logic);
end comparator;

architecture comp of comparator is

begin
	process(i_RP_DATA)
		begin
		if(i_RP_DATA = "0000000000000000") then
			o_RF_RP_ZERO <= '1';
		else
			o_RF_RP_ZERO <= '0';
		end if;
	end process;
end comp;
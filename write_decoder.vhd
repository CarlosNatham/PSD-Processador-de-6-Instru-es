library IEEE;
use IEEE.std_logic_1164.all;

entity write_decoder is
port(	i_ADDR:	in std_logic_vector (3 downto 0);	
		i_WR:		in std_logic;
		o_S: 		out std_logic_vector (15 downto 0));
end write_decoder;

architecture wd of write_decoder is
begin
	process(i_ADDR, i_WR)
		begin
		if(i_WR = '1') then
			if(i_ADDR(0) = '0' and i_ADDR(1) = '0' and i_ADDR(2) = '0' and i_ADDR(3) = '0') then
				o_S <= "0000000000000001";
			elsif(i_ADDR(0) = '1' and i_ADDR(1) = '0' and i_ADDR(2) = '0' and i_ADDR(3) = '0') then
				o_S <= "0000000000000010";
			elsif(i_ADDR(0) = '0' and i_ADDR(1) = '1' and i_ADDR(2) = '0' and i_ADDR(3) = '0') then
				o_S <= "0000000000000100";
			elsif(i_ADDR(0) = '1' and i_ADDR(1) = '1' and i_ADDR(2) = '0' and i_ADDR(3) = '0') then
				o_S <= "0000000000001000";
			elsif(i_ADDR(0) = '0' and i_ADDR(1) = '0' and i_ADDR(2) = '1' and i_ADDR(3) = '0') then
				o_S <= "0000000000010000";
			elsif(i_ADDR(0) = '1' and i_ADDR(1) = '0' and i_ADDR(2) = '1' and i_ADDR(3) = '0') then
				o_S <= "0000000000100000";
			elsif(i_ADDR(0) = '0' and i_ADDR(1) = '1' and i_ADDR(2) = '1' and i_ADDR(3) = '0') then
				o_S <= "0000000001000000";
			elsif(i_ADDR(0) = '1' and i_ADDR(1) = '1' and i_ADDR(2) = '1' and i_ADDR(3) = '0') then
				o_S <= "0000000010000000";
			elsif(i_ADDR(0) = '0' and i_ADDR(1) = '0' and i_ADDR(2) = '0' and i_ADDR(3) = '1') then
				o_S <= "0000000100000000";
			elsif(i_ADDR(0) = '1' and i_ADDR(1) = '0' and i_ADDR(2) = '0' and i_ADDR(3) = '1') then
				o_S <= "0000001000000000";
			elsif(i_ADDR(0) = '0' and i_ADDR(1) = '1' and i_ADDR(2) = '0' and i_ADDR(3) = '1') then
				o_S <= "0000010000000000";
			elsif(i_ADDR(0) = '1' and i_ADDR(1) = '1' and i_ADDR(2) = '0' and i_ADDR(3) = '1') then
				o_S <= "0000100000000000";
			elsif(i_ADDR(0) = '0' and i_ADDR(1) = '0' and i_ADDR(2) = '1' and i_ADDR(3) = '1') then
				o_S <= "0001000000000000";
			elsif(i_ADDR(0) = '1' and i_ADDR(1) = '0' and i_ADDR(2) = '1' and i_ADDR(3) = '1') then
				o_S <= "0010000000000000";
			elsif(i_ADDR(0) = '0' and i_ADDR(1) = '1' and i_ADDR(2) = '1' and i_ADDR(3) = '1') then
				o_S <= "0100000000000000";
			elsif(i_ADDR(0) = '1' and i_ADDR(1) = '1' and i_ADDR(2) = '1' and i_ADDR(3) = '1') then
				o_S <= "1000000000000000";
			end if;
		else
			o_S <= "0000000000000000";
		end if;
	end process;
end wd;
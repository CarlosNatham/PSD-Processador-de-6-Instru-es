library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux16_1 is
port ( i_RD:		in std_logic_vector (15 downto 0);
		 i_0:			in std_logic_vector (15 downto 0);
		 i_1:			in std_logic_vector (15 downto 0);
		 i_2:			in std_logic_vector (15 downto 0);
		 i_3:			in std_logic_vector (15 downto 0);
		 i_4:			in std_logic_vector (15 downto 0);
		 i_5:			in std_logic_vector (15 downto 0);
		 i_6:			in std_logic_vector (15 downto 0);
		 i_7:			in std_logic_vector (15 downto 0);
		 i_8:			in std_logic_vector (15 downto 0);
		 i_9:			in std_logic_vector (15 downto 0);
		 i_10:		in std_logic_vector (15 downto 0);
		 i_11:		in std_logic_vector (15 downto 0);
		 i_12:		in std_logic_vector (15 downto 0);
		 i_13:		in std_logic_vector (15 downto 0);
		 i_14:		in std_logic_vector (15 downto 0);
		 i_15:		in std_logic_vector (15 downto 0);
       o_S: 		out std_logic_vector (15 downto 0));
end mux16_1;

architecture mux2 of mux16_1 is 
begin 
	process(i_RD, i_0, i_1, i_2, i_3, i_4, i_5, i_6, i_7, i_8, i_9, i_10, i_11, i_12, i_13, i_14, i_15)
      begin 
		if(i_RD(15) = '1') then
			o_S <= i_15;
		elsif(i_RD(14) = '1') then
			o_S <= i_14;
		elsif(i_RD(13) = '1') then
			o_S <= i_13;
		elsif(i_RD(12) = '1') then
			o_S <= i_12;
		elsif(i_RD(11) = '1') then
			o_S <= i_11;
		elsif(i_RD(10) = '1') then
			o_S <= i_10;
		elsif(i_RD(9) = '1') then
			o_S <= i_9;
		elsif(i_RD(8) = '1') then
			o_S <= i_8;
		elsif(i_RD(7) = '1') then
			o_S <= i_7;
		elsif(i_RD(6) = '1') then
			o_S <= i_6;
		elsif(i_RD(5) = '1') then
			o_S <= i_5;
		elsif(i_RD(4) = '1') then
			o_S <= i_4;
		elsif(i_RD(3) = '1') then
			o_S <= i_3;
		elsif(i_RD(2) = '1') then
			o_S <= i_2;
		elsif(i_RD(1) = '1') then
			o_S <= i_1;
		else
			o_S <= i_0;
		end if;
    end process;
end mux2;
library ieee;
use ieee.std_logic_1164.all;

entity testbench is

end testbench;

architecture tb of testbench is

component processor is
port(	i_CLK:	in std_logic;
		i_CLR:	in std_logic);
end component;

signal w_i_CLR: std_logic := '1';

signal w_i_CLK: std_logic := '0';

constant c_CLKP : time    := 10ns;

begin
  w_i_CLK <= not w_i_CLK after c_CLKP / 2;
  w_i_CLR <= '0' after c_CLKP;
  u_0: processor
    port map (i_CLK    => w_i_CLK,
              i_CLR    => w_i_CLR);
end tb;
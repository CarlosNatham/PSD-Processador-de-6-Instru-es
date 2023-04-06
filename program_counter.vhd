library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity program_counter is 
port(	i_LD: 		in  std_logic;
		i_CLK: 		in  std_logic;
      i_CLR: 		in  std_logic;
      i_UP: 		in  std_logic;
      i_PC: 		in  std_logic_vector(15 downto 0);
      o_PC: 		out std_logic_vector(15 downto 0));
end program_counter;


architecture arch_1 of program_counter is

signal w_O_PC : std_logic_vector(15 downto 0);

begin
  process(i_CLR, i_CLK, i_LD, i_UP)
  begin
    if(i_CLR = '1') then
      w_O_PC <= (others => '0');
    elsif (rising_edge(i_CLK)) then
      if(i_LD = '1') then
         w_O_PC <= i_PC - 1;
        elsif(i_UP = '1') then
          w_O_pc <= w_O_PC + 1;
      end if;
    end if;
  end process;

  o_PC <= w_O_PC;

end arch_1;
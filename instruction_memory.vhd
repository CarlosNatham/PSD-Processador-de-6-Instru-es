library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_port_rom is
generic(	addr_width : integer := 10;
			addr_bits  : integer := 16;
			data_width : integer := 16 );
port(	i_ADDR: 	in std_logic_vector(addr_bits-1 downto 0);
		i_RD: 	in std_logic;
		o_DATA: 	out std_logic_vector(data_width-1 downto 0));
end single_port_rom;

architecture arch of single_port_rom is

    type rom_type is array (0 to addr_width-1) of std_logic_vector(data_width-1 downto 0);

    signal instruction_rom : rom_type := (
                            "0011000000000000",	-- MOV R0, #0      - iniciando resultado em zero
                            "0011000100000010",	-- MOV R1, #2      - constante 2 para incremento
									 "0011001100000001",	-- MOV R3, #1      - constante 1 para decremento
									 "0010000000000001",	-- ADD R0, R0, R1  - se não for zero, tem um incremento
									 "0100000000000011", -- SUB R0, R0, R3  - depois tem um decremento
									 "0101000000000010",	-- JMPZ R0, rot2   - se for zero, salta para proxima instrução
									 "0010000000000001",	-- ADD, R0, R0, R1 - se não for zero, tem um incremento
									 "0100000000000011",	-- SUB R0, R0, R3  - depois tem um decremento
									 "0001000000001001", -- rot2: MOV 9, R0 - armazena o resultado na posição 9 da memoria de dados
									 "0000100100000000"	-- MOV R0, 9		 - carrega a posição 9 da memoria de dados
									 );
begin
  process(i_RD)
  begin
    if(i_RD = '1') then
      o_DATA <= instruction_rom(to_integer(unsigned(i_ADDR)));
     end if;
  end process;
end arch;
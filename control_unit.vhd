library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
port(	i_DATA:			in std_logic_vector (15 downto 0);
		i_RF_RP_ZERO:	in std_logic;
		i_CLK:			in std_logic;
		i_CLR:			in std_logic;
		o_D_ADDR: 		out std_logic_vector (7 downto 0);
		o_D_RD:			out std_logic;
		o_D_WR:			out std_logic;
		o_RF_W_DATA:	out std_logic_vector (7 downto 0);
		o_RF_S0:			out std_logic;
		o_RF_S1:			out std_logic;
		o_RF_W_ADDR:	out std_logic_vector (3 downto 0);
		o_RF_W_WR:		out std_logic;
		o_RF_RP_ADDR:	out std_logic_vector (3 downto 0);
		o_RF_RP_RD:		out std_logic;
		o_RF_RQ_ADDR:	out std_logic_vector (3 downto 0);
		o_RF_RQ_RD:		out std_logic;
		o_ALU_S0:		out std_logic;
		o_ALU_S1:		out std_logic;
		o_RD:				out std_logic;
		o_ADDR:			out std_logic_vector (15 downto 0));
end control_unit;

architecture control of control_unit is

component instruction_register is
port(	i_IR:		in std_logic_vector (15 downto 0);
		i_CLK:	in std_logic;
		i_CLR:	in std_logic;
		i_LD:		in std_logic;
		o_IR:		out std_logic_vector (15 downto 0));	
end component;

component fsm_control is
port(	i_RF_RP_ZERO:  in std_logic;
		i_IR_ID:			in std_logic_vector (15 downto 0);
		i_CLK:			in std_logic;
		i_CLR:			in std_logic;
		o_RF_W_ADDR:	out std_logic_vector (3 downto 0);
		o_RF_W_WR:		out std_logic;
		o_RF_RP_ADDR:	out std_logic_vector (3 downto 0);
		o_RF_RP_RD:		out std_logic;
		o_RF_RQ_ADDR:	out std_logic_vector (3 downto 0);
		o_RF_RQ_RD:		out std_logic;
		o_D_ADDR:		out std_logic_vector (7 downto 0);
		o_D_RD:			out std_logic;
		o_D_WR:			out std_logic;
		o_RF_W_DATA:	out std_logic_vector (7 downto 0);
		o_RF_S0:			out std_logic;
		o_RF_S1:			out std_logic;
		o_ALU_S0:		out std_logic;
		o_ALU_S1:		out std_logic;
		o_IR_ID:			out std_logic;
		o_I_RD:			out std_logic;
		o_PC_INC:		out std_logic;
		o_PC_CLR:		out std_logic;
		o_PC_LD:			out std_logic);
end component;

component program_counter is
port(	i_PC:		in std_logic_vector (15 downto 0);
		i_CLK:	in std_logic;
		i_CLR:	in std_logic;
		i_LD:		in std_logic;
		i_UP:		in std_logic;
		o_PC:		out std_logic_vector (15 downto 0));	
end component;

component adder is
port(	i_A:		in std_logic_vector (7 downto 0);
		i_B:		in std_logic_vector (15 downto 0);
		o_PC:		out std_logic_vector (15 downto 0));
end component;

signal w_IR, w_PC, w_ADDR: std_logic_vector (15 downto 0);
signal w_AUX: std_logic_vector (7 downto 0);
signal w_LD, w_PC_INC, w_PC_CLR, w_PC_LD: std_logic;  

begin
	ir: instruction_register port map(	i_IR	=> i_DATA,
													i_CLK	=> i_CLK,
													i_CLR	=> i_CLR,
													i_LD	=> w_LD,
													o_IR	=> w_IR);
												
	fsm: fsm_control port map(	i_RF_RP_ZERO	=> i_RF_RP_ZERO,
										i_IR_ID			=> w_IR,
										i_CLK				=> i_CLK,
										i_CLR				=> i_CLR,
										o_RF_W_ADDR		=> o_RF_W_ADDR,
										o_RF_W_WR		=> o_RF_W_WR,
										o_RF_RP_ADDR	=> o_RF_RP_ADDR,
										o_RF_RP_RD		=> o_RF_RP_RD,
										o_RF_RQ_ADDR	=> o_RF_RQ_ADDR,
										o_RF_RQ_RD		=> o_RF_RQ_RD,
										o_D_ADDR			=> o_D_ADDR,
										o_D_RD			=> o_D_RD,
										o_D_WR			=> o_D_WR,
										o_RF_W_DATA		=> o_RF_W_DATA,
										o_RF_S0			=> o_RF_S0,
										o_RF_S1			=> o_RF_S1,
										o_ALU_S0			=> o_ALU_S0,
										o_ALU_S1			=> o_ALU_S1,
										o_IR_ID			=> w_LD,
										o_I_RD			=> o_RD,
										o_PC_INC			=> w_PC_INC,
										o_PC_CLR			=> w_PC_CLR,
										o_PC_LD			=> w_PC_LD);
										
	pc: program_counter port map(	i_PC	=> w_PC,
											i_CLK	=> i_CLK,
											i_CLR	=> w_PC_CLR,
											i_LD	=> w_PC_LD,
											i_UP	=> w_PC_INC,
											o_PC	=> w_ADDR);
											
	w_AUX <= w_IR(7) & w_IR(6) & w_IR(5) & w_IR(4) & w_IR(3) & w_IR(2) & w_IR(1) & w_IR(0);
											
	ad: adder port map(	i_A	=> w_AUX,
								i_B	=> w_ADDR,
								o_PC	=> w_PC);
								
	o_ADDR <= w_ADDR;
	
end control;
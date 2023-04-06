library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity processor is
port(	i_CLK:	in std_logic;
		i_CLR:	in std_logic);
end processor;

architecture arch of processor is

component datapath is
port(	i_CLK:			in std_logic;
		i_CLR:			in std_logic;
		i_RF_W_DATA:	in std_logic_vector (7 downto 0);
		i_RF_S0:			in std_logic;
		i_RF_S1:			in std_logic;
		i_RF_W_ADDR:	in std_logic_vector (3 downto 0);
		i_RF_W_WR:		in std_logic;
		i_RF_RP_ADDR:	in std_logic_vector (3 downto 0);
		i_RF_RP_RD:		in std_logic;
		i_RF_RQ_ADDR:	in std_logic_vector (3 downto 0);
		i_RF_RQ_RD:		in std_logic;
		i_R_DATA:		in std_logic_vector (15 downto 0);
		i_ALU_S0:		in std_logic;
		i_ALU_S1:		in std_logic;
		o_W_DATA:		out std_logic_vector (15 downto 0);
		o_RF_RP_ZERO:	out std_logic);
end component;

component control_unit is
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
end component;

component single_port_ram is
port(	i_CLK: 		in std_logic;
      i_RD: 		in std_logic;
		i_WR:			in std_logic;
      i_ADDR: 		in  std_logic_vector(7 downto 0);
		i_W_DATA: 	in  std_logic_vector(15 downto 0);
      o_R_DATA: 	out std_logic_vector(15 downto 0));
end component;

component single_port_rom is
generic(	addr_width : integer := 10;
			addr_bits  : integer := 16;
			data_width : integer := 16 );
port(	i_ADDR: 	in std_logic_vector(addr_bits-1 downto 0);
		i_RD: 	in std_logic;
		o_DATA: 	out std_logic_vector(data_width-1 downto 0));
end component;

signal w_RDATA, w_WDATA, w_DATA, w_ADDR: std_logic_vector (15 downto 0);
signal w_W_DATA, w_D_ADDR: std_logic_vector (7 downto 0);
signal w_W_ADDR, w_RP_ADDR, w_RQ_ADDR: std_logic_vector (3 downto 0);
signal w_S0, w_S1, w_WR, w_RP_RD, w_RQ_RD, w_ALU_S0, w_ALU_S1, w_ZERO, w_D_RD, w_D_WR,
w_RD: std_logic;

begin
	u_0: datapath port map(	i_CLK				=> i_CLK,
									i_CLR				=> i_CLR,
									i_RF_W_DATA		=> w_W_DATA,
									i_RF_S0			=> w_S0,
									i_RF_S1			=> w_S1,
									i_RF_W_ADDR		=> w_W_ADDR,
									i_RF_W_WR		=> w_WR,
									i_RF_RP_ADDR	=> w_RP_ADDR,
									i_RF_RP_RD		=> w_RP_RD,
									i_RF_RQ_ADDR	=> w_RQ_ADDR,
									i_RF_RQ_RD		=> w_RQ_RD,
									i_R_DATA			=> w_RDATA,
									i_ALU_S0			=> w_ALU_S0,
									i_ALU_S1			=> w_ALU_S1,
									o_W_DATA			=> w_WDATA,
									o_RF_RP_ZERO	=> w_ZERO);
																	
									
	u_1: control_unit port map(	i_DATA			=> w_DATA,
											i_RF_RP_ZERO	=> w_ZERO,
											i_CLK				=> i_CLK,
											i_CLR				=> i_CLR,
											o_D_ADDR			=> w_D_ADDR,
											o_D_RD			=> w_D_RD,
											o_D_WR			=> w_D_WR,
											o_RF_W_DATA		=> w_W_DATA,
											o_RF_S0			=> w_S0,
											o_RF_S1			=> w_S1,
											o_RF_W_ADDR		=> w_W_ADDR,
											o_RF_W_WR		=> w_WR,
											o_RF_RP_ADDR	=> w_RP_ADDR,
											o_RF_RP_RD		=> w_RP_RD,
											o_RF_RQ_ADDR	=> w_RQ_ADDR,
											o_RF_RQ_RD		=> w_RQ_RD,
											o_ALU_S0			=> w_ALU_S0,
											o_ALU_S1			=> w_ALU_S1,
											o_RD				=> w_RD,
											o_ADDR			=> w_ADDR);
													
											
	u_2: single_port_ram port map(	i_CLK			=> i_CLK,
												i_ADDR		=> w_D_ADDR,
												i_W_DATA		=> w_WDATA,
												i_WR			=> w_D_WR,
												i_RD			=> w_D_RD,
												o_R_DATA		=> w_RDATA);
												
	u_3: single_port_rom port map(	i_ADDR		=> w_ADDR,
												i_RD			=> w_RD,
												o_DATA		=> w_DATA);	
												
end arch;
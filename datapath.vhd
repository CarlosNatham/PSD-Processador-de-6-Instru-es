library ieee;
use ieee.std_logic_1164.all;

entity datapath is
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
end datapath;

architecture arch_1 of datapath is

component mux3_1 is
port ( i_S0: 	in std_logic;	
		 i_S1: 	in std_logic;
       i_2: 	in std_logic_vector (7 downto 0);
		 i_1:		in std_logic_vector (15 downto 0);
		 i_0:		in std_logic_vector (15 downto 0);
       o_S: 	out std_logic_vector (15 downto 0));
end component;

component rf_16x16 is
port(	i_W_DATA:	in std_logic_vector (15 downto 0);
		i_W_ADDR:	in std_logic_vector (3 downto 0);
		i_W_WR:		in std_logic;
		i_RP_ADDR:	in std_logic_vector (3 downto 0);
		i_RP_RD:		in std_logic;
		i_RQ_ADDR:	in std_logic_vector (3 downto 0);
		i_RQ_RD:		in std_logic;
		i_CLK:		in std_logic;
		i_CLR:		in std_logic;
		o_RP_DATA:	out std_logic_vector (15 downto 0);
		o_RQ_DATA:	out std_logic_vector (15 downto 0));
end component;

component alu is
port(	i_A:			in std_logic_vector (15 downto 0);
		i_B:			in std_logic_vector (15 downto 0);
		i_S0:			in std_logic;
		i_S1:			in std_logic;
		o_S:			out std_logic_vector (15 downto 0));
end component;

component comparator is
port(	i_RP_DATA:		in std_logic_vector (15 downto 0);
		o_RF_RP_ZERO:	out std_logic);
end component;

signal w_SMUX, w_RPDATA, w_RQDATA, w_SALU : std_logic_vector (15 downto 0);

begin

	u_0: mux3_1 port map(	i_S0	=> i_RF_S0,
									i_S1	=> i_RF_S1,
									i_2	=> i_RF_W_DATA,
									i_1	=> i_R_DATA,
									i_0	=> w_SALU,
									o_S	=> w_SMUX);
									
	u_1: rf_16x16 port map(	i_W_DATA		=> w_SMUX,
									i_W_ADDR		=> i_RF_W_ADDR,
									i_W_WR		=> i_RF_W_WR,
									i_RP_ADDR	=>	i_RF_RP_ADDR,
									i_RP_RD		=> i_RF_RP_RD,
									i_RQ_ADDR	=> i_RF_RQ_ADDR,
									i_RQ_RD		=> i_RF_RQ_RD,
									i_CLK			=> i_CLK,
									i_CLR			=> i_CLR,
									o_RP_DATA	=> w_RPDATA,
									o_RQ_DATA	=> w_RQDATA);
									
	u_2: alu port map(	i_A 	=> w_RPDATA,
								i_B	=> w_RQDATA,
								i_S0	=> i_ALU_S0,
								i_S1	=> i_ALU_S1,
								o_S	=> w_SALU);

								
	u_3: comparator port map(	i_RP_DATA		=> w_RPDATA,
										o_RF_RP_ZERO	=> o_RF_RP_ZERO);
										
	o_W_DATA <= W_RPDATA;

end arch_1;

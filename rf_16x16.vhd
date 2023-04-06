library ieee;
use ieee.std_logic_1164.all;

entity rf_16x16 is
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
end rf_16x16;

architecture rf of rf_16x16 is

component write_decoder is
port(	i_ADDR:	in std_logic_vector (3 downto 0);	
		i_WR:		in std_logic;
		o_S: 		out std_logic_vector (15 downto 0));
end component;

component read_decoder is
port(	i_ADDR:	in std_logic_vector (3 downto 0);	
		i_RD:		in std_logic;
		o_S: 		out std_logic_vector (15 downto 0));
end component;

component reg is
port(	i_I:		in std_logic_vector (15 downto 0);
		i_CLK:	in std_logic;
		i_CLR:	in std_logic;
		i_LD:		in std_logic;
		o_Q:		out std_logic_vector (15 downto 0));	
end component;

component mux16_1 is
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
end component;

signal w_REG0, w_REG1, w_REG2, w_REG3, w_REG4, w_REG5, w_REG6, w_REG7, w_REG8, w_REG9, 
w_REG10, w_REG11, w_REG12, w_REG13, w_REG14, w_REG15: std_logic_vector (15 downto 0);

signal w_WR, w_RP, w_RQ: std_logic_vector (15 downto 0);

begin
	wr_decoder: write_decoder port map(	i_ADDR 	=> i_W_ADDR,	
													i_WR		=> i_W_WR,
													o_S		=> w_WR);
													
	rd_decoder1: read_decoder port map(	i_ADDR	=> i_RP_ADDR,
													i_RD		=> i_RP_RD,
													o_S		=> w_RP);
													
	rd_decoder2: read_decoder port map(	i_ADDR	=> i_RQ_ADDR,
													i_RD		=> i_RQ_RD,
													o_S		=> w_RQ);
	
	reg_0: reg port map(	i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(0),
								o_Q	=>	w_REG0);
	
	reg_1: reg port map(	i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(1),
								o_Q	=>	w_REG1);
								
	reg_2: reg port map(	i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(2),
								o_Q	=>	w_REG2);							
								
	reg_3: reg port map(	i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(3),
								o_Q	=>	w_REG3);
								
	reg_4: reg port map(	i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(4),
								o_Q	=>	w_REG4);							
								
	reg_5: reg port map(	i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(5),
								o_Q	=>	w_REG5);							
								
	reg_6: reg port map(	i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(6),
								o_Q	=>	w_REG6);							
								
	reg_7: reg port map(	i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(7),
								o_Q	=>	w_REG7);							
								
	reg_8: reg port map(	i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(8),
								o_Q	=>	w_REG8);							
								
	reg_9: reg port map(	i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(9),
								o_Q	=>	w_REG9);
								
	reg_10: reg port map(i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(10),
								o_Q	=>	w_REG10);
								
	reg_11: reg port map(i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(11),
								o_Q	=>	w_REG11);
	
	reg_12: reg port map(i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(12),
								o_Q	=>	w_REG12);
								
	reg_13: reg port map(i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(13),
								o_Q	=>	w_REG13);
	
	reg_14: reg port map(i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(14),
								o_Q	=>	w_REG14);
								
	reg_15: reg port map(i_I	=> i_W_DATA,
								i_CLK	=>	i_CLK,
								i_CLR	=>	i_CLR,
								i_LD	=> w_WR(15),
								o_Q	=>	w_REG15);
													
	mux1: mux16_1 port map(	 i_RD		=> w_RP,
									 i_0		=> w_REG0,
									 i_1		=> w_REG1,
									 i_2		=> w_REG2,
									 i_3		=> w_REG3,
									 i_4		=> w_REG4,
									 i_5		=> w_REG5,
									 i_6		=> w_REG6,
									 i_7		=> w_REG7,
									 i_8		=> w_REG8,
									 i_9		=> w_REG9,
									 i_10		=> w_REG10,
									 i_11		=> w_REG11,
									 i_12		=> w_REG12,
									 i_13		=> w_REG13,
									 i_14		=> w_REG14,
									 i_15		=> w_REG15,
									 o_S		=> o_RP_DATA);
									 
	mux2: mux16_1 port map(	 i_RD		=> w_RQ,
									 i_0		=> w_REG0,
									 i_1		=> w_REG1,
									 i_2		=> w_REG2,
									 i_3		=> w_REG3,
									 i_4		=> w_REG4,
									 i_5		=> w_REG5,
									 i_6		=> w_REG6,
									 i_7		=> w_REG7,
									 i_8		=> w_REG8,
									 i_9		=> w_REG9,
									 i_10		=> w_REG10,
									 i_11		=> w_REG11,
									 i_12		=> w_REG12,
									 i_13		=> w_REG13,
									 i_14		=> w_REG14,
									 i_15		=> w_REG15,
									 o_S		=> o_RQ_DATA);
									 
end rf;	
library ieee;
use ieee.std_logic_1164.all;

entity fsm_control is
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
end fsm_control;

architecture fsm of fsm_control is

	type state_type is (s_0, s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9);
 	signal r_STATE_REG  : state_type;
	signal s_NEXT_STATE : state_type;
	
	begin
		p_STATE_REG : process(i_CLK, i_CLR)
    	begin
        	if(i_CLR = '1') then
            	r_STATE_REG <= s_0; 
         elsif (rising_edge(i_CLK)) then
             	r_STATE_REG <= s_NEXT_STATE;
         end if;
      end process;
			
		p_NEXT_STAGE : process (r_STATE_REG, i_RF_RP_ZERO, i_IR_ID)
    	begin
        	case(r_STATE_REG) is
				when s_0 => s_NEXT_STATE <= s_1;
				
				when s_1 => s_NEXT_STATE <= s_2;
				
				when s_2 => if(i_IR_ID(15 downto 12) = "0000") then
									s_NEXT_STATE <= s_3;
								elsif(i_IR_ID(15 downto 12)  = "0001") then
									s_NEXT_STATE <= s_4;
								elsif(i_IR_ID(15 downto 12)  = "0010") then
									s_NEXT_STATE <= s_5;
								elsif(i_IR_ID(15 downto 12)  = "0011") then
									s_NEXT_STATE <= s_6;
								elsif(i_IR_ID(15 downto 12)  = "0100") then
									s_NEXT_STATE <= s_7;
								elsif(i_IR_ID(15 downto 12)  = "0101") then
									s_NEXT_STATE <= s_8;
								else
									s_NEXT_STATE <= s_0;
								end if;
									
				when s_3 => s_NEXT_STATE <= s_1;
				
				when s_4 => s_NEXT_STATE <= s_1;
				
				when s_5 => s_NEXT_STATE <= s_1;
				
				when s_6 => s_NEXT_STATE <= s_1;
				
				when s_7 => s_NEXT_STATE <= s_1;
				
				when s_8 => if(i_RF_RP_ZERO = '1') then
									s_NEXT_STATE <= s_9;
								else
									s_NEXT_STATE <= s_1;
								end if;
				
				when s_9 => s_NEXT_STATE <= s_1;
			end case;
		end process;
		
		o_PC_CLR <= '1' when (r_STATE_REG = s_0) else '0';
		
		o_I_RD <= '1' when (r_STATE_REG = s_1) else '0';
		
		o_PC_INC <= '1' when (r_STATE_REG = s_1) else '0';
		
		o_IR_ID <= '1' when (r_STATE_REG = s_1) else '0';
		
		o_D_ADDR <= i_IR_ID(7 downto 0) when (r_STATE_REG = s_3 or r_STATE_REG = s_4) else "00000000";
		
		o_D_RD <= '1' when (r_STATE_REG = s_3) else '0';
		
		o_RF_S0 <= '1' when (r_STATE_REG = s_3) else '0';
		
		o_RF_S1 <= '1' when (R_STATE_REG = s_6) else '0';
		
		o_RF_W_ADDR <= i_IR_ID(11 downto 8) when (r_STATE_REG = s_3 or r_STATE_REG = s_5 or r_STATE_REG = s_6 
		or r_STATE_REG = s_7) else "0000";
		
		o_RF_W_WR <= '1' when (r_STATE_REG = s_3 or r_STATE_REG = s_5 or r_STATE_REG = s_6 or r_STATE_REG = s_7) else '0';
		
		o_D_WR <= '1' when (r_STATE_REG = s_4) else '0';
		
		o_RF_RP_ADDR <= i_IR_ID(11 downto 8) when (r_STATE_REG = s_4 or r_STATE_REG = s_8) else i_IR_ID(7 downto 4);
		
		o_RF_RP_RD <= '1' when (r_STATE_REG = s_4 or r_STATE_REG = s_5 or r_STATE_REG = s_7 or r_STATE_REG = s_8) else '0';
		
		o_RF_RQ_ADDR <= i_IR_ID(3 downto 0) when (r_STATE_REG = s_5 or r_STATE_REG = s_7) else "0000";
		
		o_RF_RQ_RD <= '1' when (r_STATE_REG = s_5 or r_STATE_REG = s_7) else '0';
		
		o_ALU_S0 <= '1' when (r_STATE_REG = s_5) else '0';
		
		o_ALU_S1 <= '1' when (r_STATE_REG = s_7) else '0';
		
		o_PC_LD <= '1' when (r_STATE_REG = s_9) else '0';
		
		o_RF_W_DATA <= i_IR_ID(7 downto 0);

end fsm;
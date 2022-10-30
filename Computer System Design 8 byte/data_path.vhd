library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity data_path is 
	port(
	--INPUTS:
		clk : in std_logic;
		rst : in std_logic;
		IR_Load : in std_logic; --Komut register yukle commend
		MAR_LOAD: in std_logic;
		PC_Load :in std_logic;
		Pc_Inc : in std_logic;
		A_Load :in std_logic;
		B_Load :in std_logic;
		ALU_Sel : in std_logic_vector(2 downto 0);
		CCR_Load : in std_logic;
		BUS1_Sel : in std_logic_vector(1 downto 0 );
		Bus2_Sel : in std_logic_vector(1 downto 0 );
		from_memory : in std_logic_vector(7 downto 0 );
	--OUTPUTS:
		IR :  out std_logic_vector(7 downto 0 );
		adress :  out std_logic_vector(7 downto 0 );--bellege giden adress
		CCR_Result : out std_logic_vector(3 downto 0 );--NCVZ
		to_memory : out std_logic_vector (7 downto 0) --bellege giden veri
		
		
		
		
		
		
		
	);



end entity; 


architecture arch of data_path is

component ALU is 
	port(
	--INPUTS:
		A : in std_logic_vector(7 downto 0);
		B : in std_logic_vector(7 downto 0);
		ALU_sel : in std_logic_vector (2 downto 0);
	--OUTPUTS:
		NZVC : out std_logic_vector (3 downto 0 );
		ALU_result : out std_logic_vector (7 downto 0)
	
	
	);



end component; 

--DATA PATH INTERRUPT SIGNALS:
signal BUS1:  std_logic_vector (7 downto 0);
signal BUS2:  std_logic_vector (7 downto 0);
signal ALU_result :  std_logic_vector (7 downto 0 );
signal Mar: std_logic_vector (7 downto 0 );
signal PC : std_logic_vector (7 downto 0 );
signal A_Reg : std_logic_vector (7 downto 0 );
signal B_Reg : std_logic_vector (7 downto 0 );
signal CCR   : std_logic_vector(3 downto 0);
signal CCR_in : std_logic_vector (3 downto 0 );


begin

--BUS1 Mux:
	BUS1 <= PC when BUS1_Sel <= "00" else
			A_Reg when BUS1_Sel <= "01" else
			B_Reg when BUS1_Sel <= "10" else (others => '0');
	
--BUS2 Mux:
	BUS2 <= ALU_result when Bus2_Sel <= "00" else
			BUS1 when Bus2_Sel <= "01" else
			from_memory when Bus2_Sel <= "10" else (others => '0');
			
			
--KOMUT REGISTER (IR)
	process(clk,rst)
	begin
		if (rst = '1') then
			IR <= (others => '0');
		elsif (rising_edge(clk)) then
			if (IR_Load = '1') then
			IR<= BUS2;
			end if;
			
		
		end if;
	
	end process;
	
	
	
--Memory Access Register (MAR):
	process(clk,rst)
	begin
		if (rst = '1') then
			MAR <= (others => '0');
		elsif (rising_edge(clk)) then
			if (MAR_LOAD = '1') then
			MAR<= BUS2;
			
			end if;
			
		
		end if;
	
	end process;
	adress <= MAR;
	
	
--Program Counter (PC):
	process(clk,rst)
	begin
		if (rst = '1') then
			PC <= (others => '0');
		elsif (rising_edge(clk)) then
			if (PC_LOAD = '1') then
			PC<= BUS2;
			elsif (PC_INC = '1') then
				PC <= PC + x"01";
			
			end if;
			
		
		end if;
	
	end process;
	
	
	
-- A REG 
	process(clk,rst)
	begin
		if (rst = '1') then
			A_reg <= (others => '0');
		elsif (rising_edge(clk)) then
			if (A_LOAD = '1') then
			A_reg<= BUS2;
			
			end if;
			
		
		end if;
	
	end process;	
	
-- B REG 
	process(clk,rst)
	begin
		if (rst = '1') then
			B_reg <= (others => '0');
		elsif (rising_edge(clk)) then
			if (B_LOAD = '1') then
			B_reg <= BUS2;
			
			end if;
			
		
		end if;
	
	end process;	



--ALU
ALU_U: ALU port map
			(
				A  => B_Reg,
                B => BUS1,
                ALU_sel => ALU_Sel,
               
                NZVC  => CCR_in,
                ALU_result => ALU_result
			);




	
-- CCR REG
	process(clk,rst)
	begin
		if (rst = '1') then
			CCR <= (others => '0');
		elsif (rising_edge(clk)) then
			if (CCR_LOAD = '1') then
			CCR<= CCR_in; --NZVC FLAG;
			
			end if;
			
		
		end if;
	
	end process;
	CCR_Result <= CCR;
	

	to_memory <= BUS1;

end architecture;
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity CPU is 
	port(
	clk         : in std_logic;
	rst         : in std_logic;
	from_memory : in std_logic_vector (7 downto 0);
	write_en    : out std_logic;	
	to_memory   : out std_logic_vector (7 downto 0);
	adress      : out std_logic_vector (7 downto 0)
	
	
	
	);



end entity;

architecture arch of CPU is 


component data_path is 

	port(
	--INPUTS:
		clk        : in std_logic;
		rst        : in std_logic;
		IR_Load    : in std_logic; 
		MAR_LOAD   : in std_logic;
		PC_Load    :in std_logic;
		Pc_Inc     : in std_logic;
		A_Load     :in std_logic;
		B_Load     :in std_logic;
		ALU_Sel    : in std_logic_vector(2 downto 0);
		CCR_Load   : in std_logic;
		BUS1_Sel   : in std_logic_vector(1 downto 0 );
		Bus2_Sel   : in std_logic_vector(1 downto 0 );
		from_memory: in std_logic_vector(7 downto 0 );
	--OUTPUTS:
		IR         :  out std_logic_vector(7 downto 0 );
		adress     :  out std_logic_vector(7 downto 0 );
		CCR_Result : out std_logic_vector(3 downto 0 );--NCVZ
		to_memory  : out std_logic_vector (7 downto 0) 
		
		
		
		
		
		
		
	);

end component; 

component control_unit is

	port(
	IR         : in std_logic_vector(7 downto 0 );
	clk        : in std_logic;
	rst        : in std_logic;
	CCR_Result : in std_logic_vector(3 downto 0);
	IR_Load    :     out std_logic;
	MAR_LOAD   : out std_logic;
	PC_Load    : out std_logic;
	Pc_Inc     :  out std_logic;
	A_Load     :  out std_logic;
	B_Load     :  out std_logic;
	ALU_Sel    : out std_logic_vector(2 downto 0);
	CCR_Load   :out std_logic;
	BUS1_Sel   :out std_logic_vector(1 downto 0 ); 
	Bus2_Sel   :out std_logic_vector(1 downto 0 );
	write_en   : out std_logic
	
	
	
	
	
	);




end component;

-- DATA PATH

signal IR_Load    :  std_logic; 
signal IR    :  std_logic_vector (7 downto 0);
signal MAR_LOAD   :  std_logic;
signal PC_Load    : std_logic;
signal Pc_Inc     :  std_logic;
signal A_Load     : std_logic;
signal B_Load     : std_logic;
signal ALU_Sel    :  std_logic_vector(2 downto 0);
signal CCR_Load   :  std_logic;
signal CCR_Result :  std_logic_vector(3 downto 0 );--NCVZ
signal BUS1_Sel   :  std_logic_vector(1 downto 0 );
signal Bus2_Sel   :  std_logic_vector(1 downto 0 );

begin
--Control Unit :
control_unit_module: control_unit port map(
					IR           => IR,
                    clk          => clk,
                    rst          => rst,
                    CCR_Result   => CCR_Result,
                    IR_Load      => IR_Load,
					MAR_LOAD  	 =>MAR_LOAD,  
					PC_Load   	 =>PC_Load ,
					Pc_Inc    	 =>Pc_Inc  ,
					A_Load    	 =>A_Load  ,
					B_Load    	 =>B_Load  ,
					ALU_Sel   	 =>ALU_Sel ,
					CCR_Load  	 =>CCR_Load,
					BUS1_Sel  	 =>BUS1_Sel,
					Bus2_Sel  	 =>Bus2_Sel,
					write_en  	 =>write_en
						);
--DATA PATH:
data_path_module : data_path port map (
					clk           =>  clk         ,
                    rst           =>  rst         ,
                    IR_Load       =>  IR_Load     ,
                    MAR_LOAD      =>  MAR_LOAD    ,
                    PC_Load       =>  PC_Load     ,
                    Pc_Inc        =>  Pc_Inc      ,
                    A_Load        =>  A_Load      ,
                    B_Load        =>  B_Load      ,
                    ALU_Sel       =>  ALU_Sel     ,
                    CCR_Load      =>  CCR_Load    ,
					BUS1_Sel   	  =>  BUS1_Sel    ,
					Bus2_Sel   	  =>  Bus2_Sel    ,
					from_memory	  =>  from_memory	,	
					IR            =>  IR          ,
                    adress        =>  adress      ,
                    CCR_Result    =>  CCR_Result  ,
                    to_memory     =>  to_memory  
					);

	



end architecture;
 

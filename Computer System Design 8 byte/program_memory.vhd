library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity memory is -- rw_96x8_sync.vhd
	port(
		--INPUTS:
		adress : in std_logic_vector(7 downto 0);
		clk    : in std_logic;
		data_in : in std_logic_vector (7 downto 0);
		write_en   : in std_logic; --CPU tarafindan gonderilecek
		rst : in std_logic;
		
		--PORT INPUTS:
		port_in_00 : in std_logic_vector(7 downto 0);
		port_in_01 : in std_logic_vector(7 downto 0);
		port_in_02 : in std_logic_vector(7 downto 0);
		port_in_03 : in std_logic_vector(7 downto 0);
		port_in_04 : in std_logic_vector(7 downto 0);
		port_in_05 : in std_logic_vector(7 downto 0);
		port_in_06 : in std_logic_vector(7 downto 0);
		port_in_07 : in std_logic_vector(7 downto 0);
		port_in_08 : in std_logic_vector(7 downto 0);
		port_in_09 : in std_logic_vector(7 downto 0);
		port_in_10 : in std_logic_vector(7 downto 0);
		port_in_11 : in std_logic_vector(7 downto 0);
		port_in_12 : in std_logic_vector(7 downto 0);
		port_in_13 : in std_logic_vector(7 downto 0);
		port_in_14 : in std_logic_vector(7 downto 0);
		port_in_15 : in std_logic_vector(7 downto 0);
		
		--OUTPUTS:
		data_out : out std_logic_vector(7 downto 0);
		--PORT OUTPUTS:
		port_out_00 : out std_logic_vector(7 downto 0);
		port_out_01 : out std_logic_vector(7 downto 0);
		port_out_02 : out std_logic_vector(7 downto 0);
		port_out_03 : out std_logic_vector(7 downto 0);
		port_out_04 : out std_logic_vector(7 downto 0);
		port_out_05 : out std_logic_vector(7 downto 0);
		port_out_06 : out std_logic_vector(7 downto 0);
		port_out_07 : out std_logic_vector(7 downto 0);
		port_out_08 : out std_logic_vector(7 downto 0);
		port_out_09 : out std_logic_vector(7 downto 0);
		port_out_10 : out std_logic_vector(7 downto 0);
		port_out_11 : out std_logic_vector(7 downto 0);
		port_out_12 : out std_logic_vector(7 downto 0);
		port_out_13 : out std_logic_vector(7 downto 0);
		port_out_14 : out std_logic_vector(7 downto 0);
		port_out_15 : out std_logic_vector(7 downto 0)
		
		
	);
	
end entity;


architecture arch of memory is 


--PROGRAM MEMORY: ROM
component program_memory is -- rom_128x8_sync.vhd
	port(
		--INPUTS:
		adress : in std_logic_vector(7 downto 0);
		clk    : in std_logic;
		--OUTPUTS:
		data_out : out std_logic_vector(7 downto 0)
		
	);
	
end component;

--DATA MEMORY: --RAM
component data_memory is -- rw_96x8_sync.vhd
	port(
		--INPUTS:
		adress : in std_logic_vector(7 downto 0);
		clk    : in std_logic;
		data_in : in std_logic_vector (7 downto 0);
		write_en   : in std_logic; 
		--OUTPUTS:
		data_out : out std_logic_vector(7 downto 0)
		
	);
	
end component;

--OUTPUTS PORT:
component output_ports is -- rw_96x8_sync.vhd
	port(
		--INPUTS:
		adress : in std_logic_vector(7 downto 0);
		clk    : in std_logic;
		data_in : in std_logic_vector (7 downto 0);
		write_en   : in std_logic; 
		rst : in std_logic;
		--OUTPUTS:
		port_out_00 : out std_logic_vector(7 downto 0);
		port_out_01 : out std_logic_vector(7 downto 0);
		port_out_02 : out std_logic_vector(7 downto 0);
		port_out_03 : out std_logic_vector(7 downto 0);
		port_out_04 : out std_logic_vector(7 downto 0);
		port_out_05 : out std_logic_vector(7 downto 0);
		port_out_06 : out std_logic_vector(7 downto 0);
		port_out_07 : out std_logic_vector(7 downto 0);
		port_out_08 : out std_logic_vector(7 downto 0);
		port_out_09 : out std_logic_vector(7 downto 0);
		port_out_10 : out std_logic_vector(7 downto 0);
		port_out_11 : out std_logic_vector(7 downto 0);
		port_out_12 : out std_logic_vector(7 downto 0);
		port_out_13 : out std_logic_vector(7 downto 0);
		port_out_14 : out std_logic_vector(7 downto 0);
		port_out_15 : out std_logic_vector(7 downto 0)
		
		
	);
	
end component;
signal rom_out	: std_logic_vector(7 downto 0);
signal ram_out	: std_logic_vector(7 downto 0);


begin

ROM_U: program_memory port map( -- ROM_U = ROM UNIT
	adress => adress,
	clk => clk,
	data_out => rom_out
);


RAM_U: data_memory port map(
	adress => adress,
	clk => clk,
	data_in => data_in,
	write_en => write_en,
	data_out => ram_out
);

OUT_U: output_ports port map(
	adress => adress,
	clk => clk,
	rst => rst,
	data_in => data_in,
	write_en => write_en,
	port_out_00 => port_out_00,
	port_out_01 => port_out_01,
	port_out_02 => port_out_02,
	port_out_03 => port_out_03,
	port_out_04 => port_out_04,
	port_out_05 => port_out_05,
	port_out_06 => port_out_06,
	port_out_07 => port_out_07,
	port_out_08 => port_out_08,
	port_out_09 => port_out_09,
	port_out_10 => port_out_10,
	port_out_11 => port_out_11,
	port_out_12 => port_out_12,
	port_out_13 => port_out_13,
	port_out_14 => port_out_14,
	port_out_15 => port_out_15
	);
	
	
	
--MUX TANIMI
MUX :process(adress, rom_out, ram_out, port_in_00, port_in_01,port_in_02,port_in_03,
			port_in_04,port_in_05,port_in_06,port_in_07,
			port_in_08,port_in_09,port_in_10,port_in_11,
			port_in_12,port_in_13,port_in_14,port_in_15)
begin
	if (adress >= x"00" and adress <= x"7F") then
		data_out <= rom_out;
	
	elsif (adress >= x"80" and adress <= x"DF") then
		data_out <= ram_out;
	--INPUT ROUTING:	
	elsif (adress = x"F0") then
		data_out <= port_in_00;
	elsif (adress = x"F1") then
		data_out <= port_in_01;
	elsif (adress = x"F2") then
		data_out <= port_in_02;
	elsif (adress = x"F3") then
		data_out <= port_in_03;
	elsif (adress = x"F4") then
		data_out <= port_in_04;
	elsif (adress = x"F5") then
		data_out <= port_in_05;
	elsif (adress = x"F6") then
		data_out <= port_in_06;
	elsif (adress = x"F7") then
		data_out <= port_in_07;
	elsif (adress = x"F8") then
		data_out <= port_in_08;
	elsif (adress = x"F9") then
		data_out <= port_in_09;
	elsif (adress = x"FA") then
		data_out <= port_in_10;
	elsif (adress = x"FB") then
		data_out <= port_in_11;
	elsif (adress = x"FC") then
		data_out <= port_in_12;
	elsif (adress = x"FD") then
		data_out <= port_in_13;
	elsif (adress = x"FE") then
		data_out <= port_in_14;
	elsif (adress = x"FF") then
		data_out <= port_in_15;
		
	else
		data_out <= x"00";
		
	end if;
	
end process;	
	
	
	
	
	
	




end architecture;



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity data_memory is -- rw_96x8_sync.vhd
	port(
		--INPUTS:
		adress : in std_logic_vector(7 downto 0);
		clk    : in std_logic;
		data_in : in std_logic_vector (7 downto 0);
		write_en   : in std_logic; 
		--OUTPUTS:
		data_out : out std_logic_vector(7 downto 0)
		
	);
	
end entity;


architecture arch of data_memory is

type ram_type is array (128 to 223) of std_logic_vector(7 downto 0); --96x8 bytes
signal RAM : ram_type := (others => x"00") ; 
signal enable : std_logic;
begin
 process(adress)
 begin
	if (adress >= x"80"   and adress <= x"DF") then
		enable <= '1';
	
	
	
	else
	   enable <= '0';
	end if;
 
 end process;
	
	
process(clk)
begin
	if (rising_edge(clk)) then
		if (enable = '1' and write_en = '1') then  --WRITE
			RAM(to_integer(unsigned(adress))) <= data_in;
		elsif (enable = '1' and write_en = '0') then --READ
			data_out <= RAM(to_integer(unsigned(adress)));
        end if;
	end if;
	
	
	
end process;








end architecture;
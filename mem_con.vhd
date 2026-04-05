LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
ENTITY mem_con IS
PORT (
    data    : IN std_logic_vector(15 downto 0);
    address : IN std_logic_vector(31 downto 0);
    we : in bit;
	 clk : IN std_logic;
    q       : OUT std_logic_vector(15 downto 0));
END mem_con;
 
ARCHITECTURE rtl OF mem_con IS
   TYPE mem_t IS ARRAY(0 to 31) OF std_logic_vector(15 downto 0);
   SIGNAL ram : mem_t;
	attribute ram_init_file : string;
	attribute ram_init_file of ram:
	signal is "pamiec.mif";
   BEGIN
   PROCESS(clk)
   BEGIN
      if(clk'event and clk='1') then
        IF(we = '1') THEN ram(address) <= data;
        END IF;
		  q <= ram(address); 
		  end if;
   END PROCESS;
END rtl;
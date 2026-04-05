library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity busint is
port
(
     ADR : in std_logic_vector(31 downto 0);
     DO : in std_logic_vector(15 downto 0);
	  
     Smar, Smbr, WRin, RDin : in std_logic;
     
	  AD : out std_logic_vector(31 downto 0);
     D : inout std_logic_vector(15 downto 0);
     DI : out std_logic_vector(15 downto 0);
     WR, RD : out std_logic
);
end entity;
 
architecture rtl of busint is
begin
   process(Smar, ADR, Smbr, DO, D, WRin, RDin)
           variable MBRin, MBRout: std_logic_vector(15 downto 0);
           variable MAR : std_logic_vector(31 downto 0);
   begin
        if(Smar='1') then MAR := ADR; end if;
        if(Smbr='1') then MBRout := DO; end if;
        if (RDin='1') then MBRin := D; end if;
        if (WRin='1') then D <= MBRout;
        else D <= "ZZZZZZZZZZZZZZZZ";
        end if;
 
        DI <= MBRin;
        AD <= MAR;
        WR <= WRin;
        RD <= RDin;
   end process;
end rtl;
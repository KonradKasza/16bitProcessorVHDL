library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ALU is
port (
      A : in std_logic_vector(15 downto 0);
      B : in std_logic_vector(15 downto 0);
      Salu : in std_logic_vector (4 downto 0);
      LDF : in std_logic;
      clk : in std_logic;
      Y : out std_logic_vector (15 downto 0);
		
		--test
		--denable : in std_logic;
		--d1 : in std_logic;
		--d2 : in std_logic;
		
		segmenty : out std_logic_vector(27 downto 0);	
      C,Z,S : inout std_logic
);
end entity;
 
architecture rtl of ALU is


	function segmentkod(input : std_logic_vector(3 downto 0)) return std_logic_vector is
	variable segments : std_logic_vector(6 downto 0);
	begin
	case input is
	when "0000" => segments := "1000000"; -- 0
	when "0001" => segments := "1111001"; -- 1
	when "0010" => segments := "0100100"; -- 2
	when "0011" => segments := "0110000"; -- 3
	when "0100" => segments := "0011001"; -- 4
	when "0101" => segments := "0010010"; -- 5
	when "0110" => segments := "0000010"; -- 6
	when "0111" => segments := "1111000"; -- 7
	when "1000" => segments := "0000000"; -- 8
	when "1001" => segments := "0010000"; -- 9
	when "1010" => segments := "0001000"; -- A
	when "1011" => segments := "0000011"; -- B
	when "1100" => segments := "1000110"; -- C
	when "1101" => segments := "0100001"; -- D
	when "1110" => segments := "0000110"; -- E
	when "1111" => segments := "0001110"; -- F
	when others => segments := "1111111"; -- nic
	end case;
	return segments;
	end segmentkod; 




	
	
begin
	
  process (Salu, A, B, clk)
       variable res, AA, BB,CC: signed (16 downto 0);
       variable CF,ZF,SF : std_logic;
       begin
		 
		
		
		
         AA(16) := A(15);
         AA(15 downto 0) := signed(A);
         BB(16) := B(15);
         BB(15 downto 0) := signed(B);
         CC(0) := CF;
         CC(16 downto 1) := "0000000000000000";
			
--	if denable = '1' then -- wlaczenie testowania na przyciskach
--			if (d1 = '0') then
--				  AA := to_signed(3, 17);
--			 else
--				  AA := to_signed(-1, 17);
--			 end if;
--
--			 if (d2 = '0') then
--				  BB := to_signed(3, 17); 
--			 else
--				  BB := to_signed(65535,17); 
--			 end if;
--
--	end if;

				
				
         case Salu is
             when "00000" => res := AA;	
             when "00001" => res := BB;
             when "00010" => res := AA + BB;
             when "00011" => res := AA - BB;
             when "00100" => res := AA or BB;
				 when "00101" => res := AA and BB;
				 when "00110" => res := AA xor BB;
				 when "00111" => res := AA xnor BB;
				 when "01000" => res := not AA;
				 when "01001" => res := -AA;
				 when "01010" => res := to_signed(0,res'length);
				 when "01011" => res := AA+BB+CC;
				 when "01100" => res := AA-BB-CC;
				 when "01101" => res := AA+1;
				 when "01110" => res := shift_left(AA,1);
				 when "01111" => res := shift_right(AA,1);
				 when "10000" => res := AA mod BB; 	 -- dzielenie modularne
				 when "10001" => 					 -- COMP AA = BB
					if AA = BB then
						res := "00000000000000001";
					else 
						res := "00000000000000000";
					end if;
				 when "10010" => res := AA-1;
             when "11111" => res(16) := AA(16);
             when others => res := (others => '0');
				 res(15 downto 0) := AA(16 downto 1);
         end case;
         Y <= std_logic_vector(res(15 downto 0));
         Z <= ZF;
         S <= SF;
         C <= CF;
			segmenty(6 downto 0) <= segmentkod(std_logic_vector(res(3 downto 0)));
			segmenty(13 downto 7) <= segmentkod(std_logic_vector(res(7 downto 4)));
			segmenty(20 downto 14) <= segmentkod(std_logic_vector(res(11 downto 8)));
			segmenty(27 downto 21) <= segmentkod(std_logic_vector(res(15 downto 12)));
         if (clk'event and clk='1') then
             if (LDF='1') then
                 if (res = "00000000000000000") then ZF:='1';
                 else ZF:='0';
                 end if;
             if (res(16)='1') then SF:='1';
             else SF:='0'; end if;
             CF := res(16) xor res(15);
             end if;
         end if;
  end process;
end rtl;


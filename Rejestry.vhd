

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Rejestry is
   port
   (
        clk : in std_logic;
        DI : in std_logic_vector (15 downto 0);
        BA : in std_logic_vector (15 downto 0);
        Sbb : in std_logic_vector (4 downto 0);
        Sbc : in std_logic_vector (4 downto 0);
        Sba : in std_logic_vector (4 downto 0);
        Sid : in std_logic_vector (2 downto 0);
        Sa : in std_logic_vector (1 downto 0);
        BB : out std_logic_vector (15 downto 0);
        BC : out std_logic_vector (15 downto 0);
        ADR : out std_logic_vector (31 downto 0);
        IRout : out std_logic_vector (15 downto 0)
--	testInit : in std_logic
   );
end entity;
 
architecture rtl of Rejestry is
begin
process (clk, Sbb, Sbc, Sba, Sid, Sa, DI)
         variable IR, TMP, A, B, C, D, E, F,G,H,I,J,K,L,M,N,O,P: std_logic_vector (15 downto 0);
         variable AD, PC, SP, ATMP : signed (31 downto 0);
       begin
       if (clk'event and clk='1') then
		 
--case testInit is 
--			when '1' => AD := "00000000000000000000000000000000";
--							PC := "00000000000000000000000000000000";
--							SP := "00000000000000000000000000000000";
--							ATMP := "00000000000000000000000000000000";
--							IR := "0000000000000000";
--							TMP := "0000000000000000";
--							A := "0000000000000001";
--							B := "0000000000000011";
--							C := "0000000000000111";
--							D := "0000000000001111";
--							E := "0000000000011111";
--							F := "0000000000111111";
--							G := "0000000001111111";
--							H := "0000000011111111";
--							I := "0000000111111111";
--							J := "0000001111111111";
--							K := "0000011111111111";
--							L := "0000111111111111";
--							M := "0001111111111111";
--							N := "0011111111111111";
--							O := "0111111111111111";
--							P := "1111111111111111";
--			when others => null;
--		end case;		
								
         case Sid is
                   when "001" => PC := PC + 1;
                   when "010" => SP := SP + 1;
                   when "011" => SP := SP -1;
						 when "100" => AD := AD + 1;
						 when "101" => AD:= AD-1;
                   when others =>
                       null;
         end case;
			
         case Sba is
                   when "00000" => IR := BA;
                   when "00001" => TMP := BA;
                   when "00010" => A := BA;
                   when "00011" => B := BA;
                   WHEN "00100" => C := BA;
						 WHEN "00101" => D := BA;
						 WHEN "00110" => E := BA;
						 WHEN "00111" => F := BA;
						 WHEN "01000" => G := BA;
						 WHEN "01001" => H := BA;
						 WHEN "01010" => I := BA;
						 WHEN "01011" => J := BA;
						 WHEN "01100" => K := BA;
						 WHEN "01101" => L := BA;
						 WHEN "01110" => M := BA;
						 WHEN "01111" => N := BA;
						 WHEN "10000" => O := BA;
						 WHEN "10001" => P := BA;
						
						 WHEN "10010" => PC(31 DOWNTO 16) := signed(BA);
						 WHEN "10011" => PC(15 DOWNTO 0) :=  signed(BA);
						 WHEN "10100" => SP(31 DOWNTO 16) := signed(BA);
						 WHEN "10101" => SP(15 DOWNTO 00) := signed(BA);
						 WHEN "10110" => AD(31 DOWNTO 16) := signed(BA);
						 WHEN "10111" => AD(15 DOWNTO 0) := signed(BA);
						 when "11000" => ATMP(31 downto 16) := signed(BA);
						 when "11001" => ATMP(15 downto 0 ) := signed(BA);
						 when others => null;
         end case;
       end if;
         case Sbb is
                   when "00000" => BB <= DI;
                   when "00001" => BB <= TMP;
                   when "00010" => BB <= A;
                   when "00011" => BB <= B;
                   when "00100" => BB <= C;
                   when "00101" => BB <= D;
						 when "00110" => BB <= E;
						 when "00111" => BB <= F;
						 WHEN "01000" => BB <= G;
						 WHEN "01001" => BB <= H;
						 WHEN "01010" => BB <= I;
						 WHEN "01011" => BB <= J;
						 WHEN "01100" => BB <= K;
						 WHEN "01101" => BB <= L;
						 WHEN "01110" => BB <= M;
						 WHEN "01111" => BB <= N;
						 WHEN "10000" => BB <= O;
						 WHEN "10001" => BB <= P;
						 
						 WHEN "10010" => BB <= std_logic_vector(PC(31 DOWNTO 16)); 
						 WHEN "10011" => BB <= std_logic_vector(PC(15 DOWNTO 0) );
						 WHEN "10100" => BB <= std_logic_vector(SP(31 DOWNTO 16));
						 WHEN "10101" => BB <= std_logic_vector(SP(15 DOWNTO 0) );
						 WHEN "10110" => BB <= std_logic_vector(AD(31 DOWNTO 16)); 
						 WHEN "10111" => BB <= std_logic_vector(AD(15 DOWNTO 0))	;
						 when "11000" => BB <= std_logic_vector(ATMP(31 downto 16));
						 when "11001" => BB <= std_logic_vector(ATMP(15 downto 0));
						 WHEN OTHERS => NULL;
         end case;
         case Sbc is
                   when "00000" => BC <= DI;
                   when "00001" => BC <= TMP;
                   when "00010" => BC <= A;
                   when "00011" => BC <= B;
                   when "00100" => BC <= C;
                   when "00101" => BC <= D;
						 when "00110" => BC <= E;
						 when "00111" => BC <= F;
						 WHEN "01000" => BC <= G;
						 WHEN "01001" => BC <= H;
						 WHEN "01010" => BC <= I;
						 WHEN "01011" => BC <= J;
						 WHEN "01100" => BC <= K;
						 WHEN "01101" => BC <= L;
						 WHEN "01110" => BC <= M;
						 WHEN "01111" => BC <= N;
						 WHEN "10000" => BC <= O;
						 WHEN "10001" => BC <= P;
						
						 WHEN "10010" => BC <= std_logic_vector(PC(31 DOWNTO 16));
						 WHEN "10011" => BC <= std_logic_vector(PC(15 DOWNTO 0) );
						 WHEN "10100" => BC <= std_logic_vector(SP(31 DOWNTO 16));
						 WHEN "10101" => BC <= std_logic_vector(SP(15 DOWNTO 0) );
						 WHEN "10110" => BC <= std_logic_vector(AD(31 DOWNTO 16));
						 WHEN "10111" => BC <= std_logic_vector(AD(15 DOWNTO 0) );
						 when "11000" => BC <= std_logic_vector(ATMP(31 downto 16));
						 when "11001" => BC <= std_logic_vector(ATMP(15 downto 0));
						 WHEN OTHERS => NULL;
         end case;
         case Sa is
                  when "00" => ADR <= std_logic_vector(AD);
                  when "01" => ADR <= std_logic_vector(PC);
                  when "10" => ADR <= std_logic_vector(SP);
                  when "11" => ADR <= std_logic_vector(ATMP);
						WHEN OTHERS => NULL;
         end case;
         IRout <= IR;
end process;
end rtl;


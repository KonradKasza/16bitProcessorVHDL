

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity control is
port(
     clk : in std_logic;
     IR :	in std_logic_vector(15 downto 0);
     reset, C, Z, S, INT : in std_logic;
     Salu, Sbb, Sbc, Sba : out std_logic_vector(4 downto 0);
     Sid : out std_logic_vector(2 downto 0);
     Sa : out std_logic_vector(1 downto 0);
     LDF, Smar, Smbr, WR, RD, INTA, MIO : out std_logic
);
end entity;
 
architecture rtl of control is
type state_type is (m0, m1, m10, m11, m12, m13, m14, m15, m16, m17, m20, m21, m22, m23, m24, m25, m26, m27, m28,
m29, m30, m31, m32, m33, m34, m35, m36, m37, m38, m40, m41, m50,m51,m52,m53, m60, m61, m62, m63, m64, m65, m66, m67, m68, m80, m81, m82, m83, m84,m85,m86,m87,m88,m89,m90, m9);
signal state : state_type;






begin
process (clk, reset)
   begin
     if reset = '1' then
        state <= m0;
     elsif (clk'event and clk='1') then
        case state is
           when m0=>
              state <= m1;
           when m1=>
              case IR(15 downto 13) is
                 when "000" =>
                    case IR(12 downto 11) is
                      when "00" =>
                        if(INT='0') then state <= m0;
                        else state <= m9;
                        end if;
                      when "01" => state <= m10;
                      when "10" => state <= m11;
                      when "11" => state <= m15;
                    end case;
                 when "001" =>
                    case IR(12 downto 8) is
                           when "00000" => state <= m20;
                           when "00001" => state <= m21;
                           when "00010" => state <= m23;
                           when "00011" => state <= m24;
                           when "00100" => state <= m25;
                           when "00101" => state <= m26;
                           when "00110" => state <= m27;
                           when "00111" => state <= m28;
                           when "01000" => state <= m29;
                           when "01001" => state <= m30;
                           when "01010" => state <= m31;
                           when "01011" => state <= m32;
                           when "01100" => state <= m33;
                           when "01101" => state <= m34;
                           when "01110" => state <= m35;
                           when "01111" => state <= m36;
                           when "10000" => state <= m37;
                           when "10001" => state <= m38;
                           when others => state <= m0;
                     end case;
                 when "010" => state <= m40;
                 when "011" => state <= m50;
                 when "100" => state <= m60;
                 when "101" => state <= m80;
                 when others => state <= m0;
              end case;
           when m10=>
              if INT = '1' then state <= m9;
              else state <= m10;
              end if;
           when m11 => state <= m12;
           when m12 => state <= m13;
           when m13 => state <= m14;
           when m14 =>
              if INT = '1' then state <= m9;
              else state <= m0;
              end if;
           when m15 => state <= m16;
			  when m16 => state <= m17;
			  when m17 => if INT = '1' THEN
								state <= m9;
								else state <= m0;
								end if;
			  when m20 => 
				  if INT = '1' then
				  state <= m9;
				  else state <= m9;
				  end if;
			  when m21 => state <= m22;
			  when m22 => 
					if INT = '1' then
						state <= m9;
						else state <= m0;
						end if;
			  when m23 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
			  when m24 => 
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
			  when m25 => 
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m26 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m27 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m28 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m29 =>
				if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m30 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m31 => 
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m32 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m33 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m34 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m35 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m36 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m37 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m38 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				
				when m40 =>
					if IR(12 downto 11) = "00" then
						state <= m41;
					elsif IR(12 downto 11) = "01" AND C = '1' then
						state <= m41;
					elsif IR(12 downto 11) = "10" and Z = '1' then
						state <= m41;
					elsif IR(12 downto 11) = "11" and S = '1' then
						state <=m41;
					elsif INT = '1' then
						state <= m9;
					else 
						state <= m9;
					end if;
				when m41 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
					
				when m50 => state <= m51;
				when m51 => state <= m52;
				when m52 => state <= m53;
				when m53 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m60 =>
					case IR(12 downto 10) is
						when "000" => state <= m61;
						when "001" => state <= m62;
						when "010" => state <= m63;
						when "011" => state <= m64;
						when "100" => state <= m65;
						when "101" => state <= m66;
						when "110" => state <= m67;
						when "111" => state <= m68;
					end case;
				when m61 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m62 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m63 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m64 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m65 => 
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m66 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m67 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m68 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m80 =>
					case IR(12 downto 9) is
						when "0000" => state <= m81;
						when "0001" => state <= m82;
						when "0010" => state <= m83;
						when "0011" => state <= m84;
						when "0100" => state <= m85;
						when "0101" => state <= m86;
						when "0110" => state <= m87;
						when "0111" => state <= m88;
						when "1000" => state <= m89;
						when "1001" => state <= m90;
						when others => state <= m9;
					end case;
				when m81 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m82 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m83 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m84 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m85 => 
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m86 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m87 => 
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m88 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m89 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m90 =>
					if INT = '1' then
					state <= m9;
					else state <= m0;
					end if;
				when m9 => state <= m9;
		  end case;
     end if;
end process;
 
process (state)
begin
    case state is
        when m0 => --fetch
           Sa <= "01";
			  Sbb <= "00000";
			  Sba <= "00000";
			  Sid <="001";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
        when m1 =>
           Sa <= "00";
			  Sbb <= "00000";
			  Sba <= "00000";
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
        when m10 => -- WAIT 
           Sa <= "00";
			  Sbb <= "00000";
			  Sba <= "00000";
			  Sid <="000"; 
			  Sbc <="00000";
			  MIO <='0';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0'; 
			  RD <='0'; 
			  Salu <="00000"; 
			  LDF <='0'; 
			  INTA <='0';
        when m11 => -- CALL
           Sa <= "10";
			  Sbb <= "10011";
			  Sba <= "00001";
			  Sid <="011";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '1';
			  WR <='1';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
        when m12 =>
           Sa <= "10";
			  Sbb <= "10010";
			  Sba <= "00001";
			  Sid <="011";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '1';
			  WR <='1';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
        when m13 =>
           Sa <= "00";
			  Sbb <= "10010";
			  Sba <= "10011";
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
        when m14 =>
           Sa <= "00";
			  Sbb <= "10110";
			  Sba <= "10010";
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
        when m15 => -- RET 
           Sa <= "00";
			  Sbb <= "00000";
			  Sba <= "00000";
			  Sid <="010";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
        when m16 =>
           Sa <= "10";
			  Sbb <= "00000";
			  Sba <= "10010";
			  Sid <="010";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
        when m17 =>
           Sa <= "10";
			  Sbb <= "00000";
			  Sba <= "10011";
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
        
		  when m20 => -- PUSH R
           Sa <= "10";
			  Sbb <= IR(4 downto 0);
			  Sba <= "00001";
			  Sid <="011";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '1';
			  WR <='0';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
        
		  when m21 => --POP R
           Sa <= "00";
			  Sbb <= "00000";
			  Sba <= "00001";
			  Sid <="010";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
		  when m22 =>
           Sa <= "10";
			  Sbb <= "00000";
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
		  when m23 => -- NEG R
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="01001";
			  LDF <='0';
			  INTA <='0';
		  when m24 => -- INC R
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="01101";
			  LDF <='0';
			  INTA <='0';
		  when m25 => -- DEC R
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="10010";
			  LDF <='0';
			  INTA <='0';
			when m26 => -- NOT R
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="01000";
			  LDF <='0';
			  INTA <='0';
		  when m27 => -- SHR R
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="01111";
			  LDF <='0';
			  INTA <='0';
		  when m28 => -- SHL R
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="01110";
			  LDF <='0';
			  INTA <='0';
		 when M29 => -- MOV  R,RM
           Sa <= "00";
			  Sbb <= "00000";
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
		when M30 => -- MOV  RM,R
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= "00001";
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '1';
			  WR <='1';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';

		when M31 => -- ADD R,RM
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00010";
			  LDF <='1';
			  INTA <='0';
		 when M32 => -- SUB R, RM
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00011";
			  LDF <='1';
			  INTA <='0';
		when M33 => -- CMP R,RM
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= "00001";
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00011";
			  LDF <='1';
			  INTA <='0';
		  when M34 => -- AND R,RM
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00101";
			  LDF <='1';
			  INTA <='0';
		  when M35 => -- OR R,RM
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00100";
			  LDF <='1';
			  INTA <='0';
		  when M36 => -- XOR R,RM
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00110";
			  LDF <='1';
			  INTA <='0';
		  when M37 => -- IN R,RM
           Sa <= "00";
			  Sbb <= "00000";
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='0';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
		  when M38 => -- OUT R,RM
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= "00001";
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='0';
           Smar <='1';
			  Smbr <= '1';
			  WR <='1';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
			  
		  -- rozkazy skokow
		  -- 1. Odczyt REL
			--2. PC ← PC + REL 
		  when M40 => -- 
           Sa <= "01";
			  Sbb <= "00000";
			  Sba <= "00001";
			  Sid <="001";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
		  when M41 => -- 
           Sa <= "01";
			  Sbb <= "10011";
			  Sba <= "10011";
			  Sid <="001";
			  Sbc <="00001";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00010";
			  LDF <='1';
			  INTA <='0';
		  
		   --rozkazy skoku dlugiego4
			-- 1. Odczyt st32
			--2. PC ← st32
			--M50 : MAR ← PC, MBR ← D, ATMPL ← MBR, PC ← PC + 1
			--M51 : MAR ← PC, MBR ← D, ATMPH ← MBR
			--M52 : PCL ← ATMPL
			--M53 : PCH ← ATMPH 
		  when M50 => -- 
           Sa <= "01";
			  Sbb <= "00000";
			  Sba <= "11001";
			  Sid <="001";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
		  when M51 => -- 
           Sa <= "01";
			  Sbb <= "00000";
			  Sba <= "11000";
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
		  
		  when M52 => -- 
           Sa <= "00";
			  Sbb <= "11001";
			  Sba <= "10011";
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
			when M53 => -- 
           Sa <= "00";
			  Sbb <= "11000";
			  Sba <= "10011";
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
			  
		  -- M60 : Rozkazy dwuargumentowe : R i st16
		  --when m60 => 100
			--		case IR(12 downto 10) is
			--			when "000" => state <= m61;
			--			when "001" => state <= m62;
		--				when "010" => state <= m63;
		--				when "011" => state <= m64;
		--				when "100" => state <= m65;
		--				when "101" => state <= m66;
		--				when "110" => state <= m67;
		--				when "111" => state <= m68;
		--			end case;
		  when M60 => -- 
           Sa <= "00";
			  Sbb <= "00001";
			  Sba <= "00001";
			  Sid <="001";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
		  when M61 => -- MOV R, ST16
           Sa <= "00";
			  Sbb <= "00001";
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
		  when M62 => -- MOV R, ST(R) 
           Sa <= "00";
			  Sbb <= "10111";
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
		  when M63 => -- ADD
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00001";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00010";
			  LDF <='1';
			  INTA <='0';
		  when M64 => -- SUB
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00001";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00011";
			  LDF <='1';
			  INTA <='0';
		  when M65 => -- CMP
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= "00001";
			  Sid <="000";
			  Sbc <="00001";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00011";
			  LDF <='1';
			  INTA <='0';
		  when M66 => -- AND
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00001";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00101";
			  LDF <='0';
			  INTA <='0';
		  when M67 => -- OR
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00001";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00100";
			  LDF <='0';
			  INTA <='0';
			  
			when M68 => -- XOR
           Sa <= "00";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00001";
			  MIO <='1';
           Smar <='0';
			  Smbr <= '0';
			  WR <='0';
			  RD <='0';
			  Salu <="00110";
			  LDF <='0';
			  INTA <='0';
			  
			  --M80 : Rozkazy dwuargumentowe : R i adr32
			  -- 1. Odczytaj adr32
				--2. Odczytaj MEM(adr32)
				--3. Wykonaj rozkaz 
		  --when m80 =>
			--		case IR(12 downto 9) is
			--			when "0000" => state <= m81; mov r, m
			--			when "0001" => state <= m82; mov m, r
			--			when "0010" => state <= m83; add 
			--			when "0011" => state <= m84; sub
			--			when "0100" => state <= m85; cmp
			--			when "0101" => state <= m86; and
		   --		   when "0110" => state <= m87; or
			--			when "0111" => state <= m88; xor
			--			when "1000" => state <= m89; in 
			--			when "1001" => state <= m90; out
			--			when others => state <= m9;
			--		end case;
			when M80 => -- 
           Sa <= "01";
			  Sbb <= "00000";
			  Sba <= "00001";
			  Sid <="001";
			  Sbc <="00001";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
			 when M81 => -- mov r m
           Sa <= "01";
			  Sbb <= "00000";
			  Sba <= "11001";
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
			when M82 => -- mov m r
           Sa <= "11";
			  Sbb <= "00000";
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
			when M83 => -- add
           Sa <= "11";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00010";
			  LDF <='1';
			  INTA <='0';
		  when M84 => -- sub
           Sa <= "11";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00011";
			  LDF <='1';
			  INTA <='0';
		  when M85 => -- cmp
           Sa <= "11";
			  Sbb <= IR(4 downto 0);
			  Sba <= "00001";
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00011";
			  LDF <='1';
			  INTA <='0';
		  when M86 => -- and
           Sa <= "11";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00101";
			  LDF <='0';
			  INTA <='0';
		  when M87 => -- or
           Sa <= "11";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00100";
			  LDF <='1';
			  INTA <='0';
		  when M88 => -- xor 
           Sa <= "11";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0';
			  RD <='1';
			  Salu <="00110";
			  LDF <='1';
			  INTA <='0';
		  when M89 => -- in
           Sa <= "11";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='0';
           Smar <='1';
			  Smbr <= '0';
			  WR <='0'; 
			  RD <='1';					--
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
		  when M90 => -- out
           Sa <= "11";
			  Sbb <= IR(4 downto 0);
			  Sba <= IR(4 downto 0);
			  Sid <="000";
			  Sbc <="00000";
			  MIO <='1';
           Smar <='1';
			  Smbr <= '0';
			  WR <='1';					--
			  RD <='0';
			  Salu <="00000";
			  LDF <='1';
			  INTA <='0';
		  when M9 =>
				Sa <= "01";
				Sbb <= "00000";
				Sba <= "00000";
				Sid <="001";
			  Sbc <="00000";
			  MIO <='1';
			  Smar <='1';
			  Smbr <= '0';
			  WR <='0';					--
			  RD <='1';
			  Salu <="00000";
			  LDF <='0';
			  INTA <='0';
			  
        when others =>
           Sa <= "00"; Sbb <= "00000"; Sba <= "00000"; Sid <="000"; Sbc <="00000"; MIO <='1';
           Smar <='0'; Smbr <= '0'; WR <='0'; RD <='0'; Salu <="00000"; LDF <='0'; INTA <='0';
    end case;
end process;
end rtl;















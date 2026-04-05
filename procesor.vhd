library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity procesor is
port (
	clk,reset : in std_logic;
	adres : out std_logic_vector(7 downto 0);
	values, IRoutput : out std_logic_vector(15 downto 0);
	segmentyOut : out std_logic_vector(27 downto 0)	
	);
end procesor;

architecture rtl of procesor is

component alu is
port (
      A : in std_logic_vector(15 downto 0);
      B : in std_logic_vector(15 downto 0);
      Salu : in std_logic_vector (4 downto 0);
      LDF : in std_logic;
      clk : in std_logic;
      Y : out std_logic_vector (15 downto 0);
		segmenty : out std_logic_vector(27 downto 0);	
      C,Z,S : inout std_logic
);
end component;
component Rejestry is
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
);
end component;
component control is
port(
     clk : in std_logic;
     IR :	in std_logic_vector(15 downto 0);
     reset, C, Z, S, INT : in std_logic;
     Salu, Sbb, Sbc, Sba : out std_logic_vector(4 downto 0);
     Sid : out std_logic_vector(2 downto 0);
     Sa : out std_logic_vector(1 downto 0);
     LDF, Smar, Smbr, WR, RD, INTA, MIO : out std_logic
);
end component;
component busint is
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
end component;
component ramconnect is
port(
	address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	clock		: IN STD_LOGIC  := '1';
	data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
	wren		: IN STD_LOGIC ;
	q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
);
end component;

signal wireLDF, wireC, wireZ, wireS, wireSmar, wireSmbr, wireWRin, wireRDin, wireINT, wireINTA, wireMIO, wireWR, wireRD : std_logic;
signal wire16bb,wire16bc,wire16y,wire16di,wire16irout,wire16d : std_logic_vector(15 downto 0);
signal wire5salu,wire5sba,wire5sbb,wire5sbc : std_logic_vector(4 downto 0);
signal wire32adr, wire32ad : std_logic_vector(31 downto 0);
signal wire3sid : std_logic_vector(2 downto 0);
signal wire2sa : std_logic_vector(1 downto 0);

begin

P1: alu port map (
	A => wire16bb,
	B => wire16bc,
	Salu => wire5salu,
	LDF => wireLDF,
	clk => clk,
	Y => wire16y,
	segmenty => segmentyOut,
	C => wireC,
	Z => wireZ,
	S => wireS
);

P2: busint port map(
	ADR => wire32adr,
	DO => wire16y,
	Smar => wireSmar,
	Smbr => wireSmbr,
	WRin => wireWRin,
	RDin => wireRDin,
	AD => wire32ad,
	D => wire16D,
	DI => wire16di,
	WR => wireWR,
	RD => wireRD
);
P3: Rejestry port map(
	clk => clk,
	DI => wire16di,
	BA => wire16y,
	Sbb => wire5sbb,
	Sbc => wire5sbc,
	Sba => wire5sba,
	Sid => wire3sid,
	Sa => wire2Sa,
	BB => wire16bb,
	BC => wire16bc,
	ADR => wire32adr,
	IRout => wire16irout
);
P4 : control port map(
	clk => clk,
	IR => wire16irout,
	reset => reset,
	C => wireC,
	Z => wireZ,
	S => wireS,
	INT => wireINT,
	Salu => wire5salu,
	Sbb => wire5sbb,
	Sbc => wire5Sbc,
	Sba => wire5Sba,
	Sid => wire3sid,
	Sa => wire2sa,
	LDF => wireLDF,
	Smar => wireSmar,
	Smbr => wireSmbr,
	WR => wireWRin,
	RD => wireRDin,
	INTA => wireINTA,
	MIO => wireMIO
);
P5 : ramconnect port map(
	address => wire32ad(7 downto 0),
	clock => clk,
	data => wire16d,
	wren => wireWR,
	q => wire16d
);
	adres <= wire32ad(7 downto 0);
	values <= wire16d;
	IRoutput <= wire16irout;
end rtl;
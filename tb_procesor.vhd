-- VHDL-2008
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_procesor is
end entity;

architecture sim of tb_procesor is
    constant T : time := 20 ns;

    type mem_t is array (0 to 255) of std_logic_vector(15 downto 0);

    -- 0: NOP (jednoczesnie dane = 5)
    -- 1..12: operacje ALU na A i pamieci [AD=0]
    -- 13: JZ +2 (pomija 15..16)
    -- 17..22: INC/XOR, zapis A, odczyt do D, AD=1, zapis D
    -- 23: JMP -2 (petla koncowa)
    constant PROG : mem_t := (
        0  => x"0005",
        1  => x"2A02",
        2  => x"2302",
        3  => x"2402",
        4  => x"2202",
        5  => x"2502",
        6  => x"2702",
        7  => x"2602",
        8  => x"2E02",
        9  => x"2D02",
        10 => x"2B02",
        11 => x"2A02",
        12 => x"2C02",
        13 => x"5000", 14 => x"0002",
        15 => x"2502",
        16 => x"0000",
        17 => x"2302",
        18 => x"2F02",
        19 => x"2902",
        20 => x"2A05",
        21 => x"2317",
        22 => x"2905",
        23 => x"4000", 24 => x"FFFE",
        others => x"0000"
    );

    signal mem : mem_t := PROG;

    signal clk, reset : std_logic := '0';
    signal C, Z, S : std_logic;
    signal LDF, Smar, Smbr, WRin, RDin, WR, RD, INTA, MIO : std_logic;
    signal Salu, Sbb, Sbc, Sba : std_logic_vector(4 downto 0);
    signal Sid : std_logic_vector(2 downto 0);
    signal Sa : std_logic_vector(1 downto 0);
    signal BB, BC, Y, DI, IR, D : std_logic_vector(15 downto 0);
    signal ADR, AD : std_logic_vector(31 downto 0);
    signal Dmem : std_logic_vector(15 downto 0);
    signal segmenty : std_logic_vector(27 downto 0);

begin

    clk <= not clk after T / 2;
    reset <= '1', '0' after T / 4;

    ALU0 : entity work.alu
        port map (
            A => BB, B => BC, Salu => Salu, LDF => LDF,
            clk => clk, Y => Y, segmenty => segmenty, C => C, Z => Z, S => S
        );

    BUS0 : entity work.busint
        port map (
            ADR => ADR, DO => Y, Smar => Smar, Smbr => Smbr,
            WRin => WRin, RDin => RDin, AD => AD, D => D,
            DI => DI, WR => WR, RD => RD
        );

    REG0 : entity work.Rejestry
        port map (
            clk => clk, DI => DI, BA => Y, Sbb => Sbb, Sbc => Sbc,
            Sba => Sba, Sid => Sid, Sa => Sa, BB => BB, BC => BC,
            ADR => ADR, IRout => IR
        );

    CTRL : entity work.control
        port map (
            clk => clk, IR => IR, reset => reset, C => C, Z => Z, S => S,
            INT => '0', Salu => Salu, Sbb => Sbb, Sbc => Sbc, Sba => Sba,
            Sid => Sid, Sa => Sa, LDF => LDF, Smar => Smar, Smbr => Smbr,
            WR => WRin, RD => RDin, INTA => INTA, MIO => MIO
        );

    -- pamiec: odczyt kombinacyjny, zapis synchroniczny
    Dmem <= (others => 'Z') when WR = '1' else
            (others => '0') when is_x(AD(7 downto 0)) else
            mem(to_integer(unsigned(AD(7 downto 0))));
    D <= Dmem;

    process (clk)
    begin
        if rising_edge(clk) and WR = '1' then
            mem(to_integer(unsigned(AD(7 downto 0)))) <= D;
        end if;
    end process;

    process
    begin
        wait for 3 us; -- czas na wykonanie programu
        assert mem(0) = x"0003" report "Blad: ALU, skok lub zapis A" severity error;
        assert mem(1) = x"0003" report "Blad: odczyt D lub zapis D" severity error;
        report "Koniec testu" severity note;
        std.env.finish;
    end process;

end architecture;

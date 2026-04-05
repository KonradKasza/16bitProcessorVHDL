# 16-bit processor in VHDL

Multi-cycle processor with a 16-bit word, written in VHDL and targeted at the Intel MAX 10 device (`10M50DAF484C6GES`, Quartus Prime 23.1 Lite). Top-level entity: `procesor`.

## Architecture

```
                 ┌──────────────┐
      clk ───────┤     ALU      │── Y (16b) ──┐
      reset      │  (alu.vhd)   │             │
                 └──────┬───────┘             ▼
                  C,Z,S │              ┌──────────────┐   D (16b, inout)   ┌────────────┐
                        │              │   busint     │───────────────────►│ ramconnect │
                 ┌──────▼──────────┐   │ (busint.vhd) │   AD, WR, RD       │ 256 × 16 b │
                 │ control         │◄──┤              │                    └────────────┘
                 │ (control.vhd)   │   └──────────────┘
                 │ state machine   │           ▲ DI
                 └──────┬──────────┘           │
                        │ control signals     │
                 ┌──────▼──────────────────────┴───┐
                 │      Registers (Rejestry.vhd)   │
                 │ IR, TMP, A…P (16b), PC/SP/AD/ATMP│
                 └─────────────────────────────────┘
```

The `PC`, `SP`, `AD` and `ATMP` registers are 32-bit, all others are 16-bit. The RAM is addressed using only the lower address byte (256 words).

## Blocks

| File | Description |
|---|---|
| `procesor.vhd` | top-level entity; component wiring only |
| `alu.vhd` | 22 operations selected by `Salu` (5 b), flags `C`, `Z`, `S` latched when `LDF='1'`; also contains a 7-segment encoder for the result |
| `Rejestry.vhd` | register bank, read multiplexers `Sba`/`Sbb`/`Sbc`, write port `Sid`, address selection `Sa` |
| `control.vhd` | control state machine (`m0`…`m90`); two processes: state transitions and output decoding |
| `busint.vhd` | MAR/MBR registers, tri-state bus `D`, outputs `AD`, `DI`, `WR`, `RD` |
| `ramconnect.vhd` | `altsyncram` IP, single port, 256 words × 16 b, initialised from `pamiec.mif` |
| `pamiec.mif` | memory contents (addresses 0–255, test data) |

`ram.vhd` (two-port RAM) and `mem_con.vhd` (simple memory model) are not part of the project. The ALU also has a separate test project `alu.qsf`.

## Registers

| Code | Register |
|---|---|
| `00000` | `IR` |
| `00001` | `TMP` |
| `00010`–`10001` | `A` … `P` (16 general-purpose registers) |
| `10010`/`10011` | `PC` high / low half |
| `10100`/`10101` | `SP` high / low half |
| `10110`/`10111` | `AD` high / low half |
| `11000`/`11001` | `ATMP` high / low half |

The address driven onto the bus is selected by `Sa`: `00` → `AD`, `01` → `PC`, `10` → `SP`, `11` → `ATMP`.

## Instruction cycle

`reset` forces state `m0`. Every instruction starts with two common states:

- `m0` — fetch: `MAR ← PC`, memory read, `IR ← M[PC]`, `PC ← PC + 1`
- `m1` — decode: `ADR ← AD`, branch selected by `IR(15..13)`

The instruction-specific sequence follows (1 to 4 cycles). An instruction takes 3–6 clock cycles in total.

## Instruction set

| `IR(15..13)` | Group | Contents |
|---|---|---|
| `000` | control | `NOP`, `WAIT`, `CALL`, `RET` (`IR(12..11)`) |
| `001` | register | `IR(12..8)`: `PUSH`, `POP`, `NEG`, `INC`, `DEC`, `NOT`, `SHR`, `SHL`, `MOV R,M`, `MOV M,R`, `ADD`, `SUB`, `CMP`, `AND`, `OR`, `XOR`, `IN`, `OUT`; `IR(4..0)` = register number |
| `010` | conditional jump | `IR(12..11)`: unconditional / `C` / `Z` / `S` |
| `011` | long jump | 32-bit address taken from two consecutive memory words |
| `100` | 16-bit operand | `MOV R, imm`, `MOV R, [R]`, `ADD`, `SUB`, `CMP`, `AND`, `OR`, `XOR` (`IR(12..10)`) |
| `101` | 32-bit operand | `MOV R, M`, `MOV M, R`, `ADD`, `SUB`, `CMP`, `AND`, `OR`, `XOR`, `IN`, `OUT` (`IR(12..9)`) |

In group `001` the second ALU operand is read from memory at address `AD`. The `MIO` and `INTA` signals are driven by the state machine but are not connected to any peripheral.

## Example

Instruction `ADD A, [AD]` — group `001`, subcode `01010`, register `00010`:

```
IR = 001 01010 00010
```

Assumptions: `A = 0x0007`, `AD = 0x0010`, `M[0x0010] = 0x0003`.

| State | Signals | Effect |
|---|---|---|
| `m0` | `Sa=01`, `Sbb=00000`, `Sba=00000`, `Sid=001`, `Smar=1`, `RD=1` | `ADR ← PC`, `IR ← M[PC]`, `PC ← PC + 1` |
| `m1` | `Sa=00`, all others inactive | `ADR ← AD`, decode `IR(15..13)=001` |
| `m31` | `Sbb=00010`, `Sbc=00000`, `Sba=00010`, `Salu=00010`, `LDF=1`, `Smar=1`, `RD=1` | `BB ← A`, `BC ← M[AD]`, `Y = A + B = 0x000A`, `A ← 0x000A`, update `Z`, `S`, `C` |

Sequence:

1. `m0` — the processor fetches the instruction from the address in `PC` and increments `PC`.
2. `m1` — the upper bits of `IR` select group `001`, so the state machine moves to `m31`.
3. `m31` — `MAR ← AD`, memory drives `0x0003` onto bus `D`, `busint` forwards it to `DI` and then to the `BC` input of the register bank. The ALU adds `0x0007 + 0x0003`, and the result `0x000A` is written back to `A`. `LDF=1` latches the flags: `Z=0`, `S=0`, `C=0`.

After the final state the machine returns to `m0` (or to `m9` if `INT` is asserted).


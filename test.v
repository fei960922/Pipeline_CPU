
// full_adder.v

module full_adder (a, b, ci, s, co);

input 	a, b, ci;
output	s;
output	co;

wire 	a, b, ci, s, co;
wire 	p;

assign	p = a ^ b;
assign 	s = p ^ ci;
assign 	co = (p & ci)|(!p & a);

endmodule

// full_adder_t.v
`include "full_adder.v"

module full_adder_t;

reg 	a, b, ci;
wire 	s, co;

full_adder dut (a, b, ci, s, co);

initial
  begin
  	a = 0;
    forever #10 a = !a;
  end
initial
  begin
  	b = 0;
    forever #20 b = !b;
  end
initial
  begin
  	ci = 0;
    forever #40 ci = !ci;
  end

endmodule

wire [31 : 0] bpc, jpc, npc, pc4 , ins , dpc4 , inst , da, db, dimm, ea, eb, eimm;
wire
wire
wire
wire
[31 :0]
[ 4: 0]
[3:0]
[ 1 : 0]
epc4 , mb, mmo, wmo, wdi ;
drn, ernO , ern, mrn, wrn ;
da1uc, ea1uc; // da1uc = a1uc
pcsource ;
wire wpClr;
wire dwreg, dm2reg, dwmem, da1uimm, dshift , dja1 ;
wire ewreg ， em2r呵， ewmem ， ea1uimm ， eshift ， eja1 ;
wi r e mwreg, mm2reg, mwmem;
wire wwreg, wm2reg;


pipepc prog_cηt (npc, wpcir, c1ock , resetn, pc) ;

pipeif if_stage (pcsource , pc, bpc , da , jpc, npc, pc4 , ins );

pipeir inst_reg (pc4 , ins , wpcir, c1ock, resetn, dpc4 , inst) ;

pipeid id_ stage (mwreg, mrn, ern, e wreg, em2reg, mm2reg, d pc4 , inst ,
wrn, wdi , ea1u, ma1u, mmo, wwreg , c1ock, resetn,
bpc, jpc, pcsource, wpcir , dwreg, dm2reg, dwmem,
da1uc , da1uimm, d a , db, dimm, drn, dshi ft , dja1 ) ;

pipedereg de_ r eg (dwreg, dm2reg, dwmem, da1uc, da1uimm, da, db, dimm,
d rn, dshift , dja1 , dpc4 , c1ock, resetn ,
ewreg, em2reg, ewmem, ea1uc, ea1uimm, ea, e b , eimm,
ernO , eshift , eja1 , epc4);

pipeexe exe_stage (ea1uc, ea1uimm, ea , eb, eimm, eshift , ernO , epc4 ,
eja1 , ern, ea1u) ;

pipeemreg em_reg (ewreg, em2reg, ewmem, ea1u, eb, ern , c1ock, resetn,
mwreg, mm2 r eg, mwmem, ma1u,mb , mrn);

pipemem mem_ stage (mwmem,ma1u, mb, c1ock , memc1ock, memc1ock, mmo);

pipemwreg mw_reg (mwreg, mm2reg, mmo , ma1u , mrn, c1ock , resetn,
wwreg, wm2reg, wmo, wa1u , wrn);

mux2x32 wb_ stage (wa1u , wmo , wm2reg, wdi) ;

Files required:

alu.v     The core of the CPU. Working "+", "-", ...
AluCtr.v
Ctr.v
data_memory.v
IDEX.v
IFID.v
inst_memory.v
iseconfig
isim
oth
pc.v
register.v
signext.v
Top.v
Top_synthesis.v
Top_tb.v


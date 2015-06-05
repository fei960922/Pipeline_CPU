
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
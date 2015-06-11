/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Module
	File name:	A simple memory I/O without cache, for 32 bits only.

	Version:
        0.1     2015/6/11    Struct established;
		
*/

module mem_simple(clock_me, pc, wmem, in, out);

	input 	[31:0]	pc, in;
	input	clock_me, wmem;
	output	[31:0]	out;

	reg 	[31:0]	memorys[0:1024];

	assign out = memorys[pc >> 2];

	always @(posedge clock_me)
		if (enable)
			memorys[pc] <= in;

	// For simulate only.
	initial begin
		memorys[0] = 
	end

endmodule
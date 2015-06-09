/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Module
	File name:	Register Array 
	Note:		A 32-length register array with two input and one output.

	Version:
        0.1     2015/6/6    Version Alpha;
		
*/

module reg_array (clock, reset_0, enable, addr_a, addr_b, addr_w, data_w, data_a, data_b);

	input	clock, reset_0, enable;
	input 	[31:0]	data_w;
	input	[4:0]	addr_a, addr_b, addr_w;

	output	[31:0]	data_a, data_b;
	reg 	[31:0]	data[0:31];
	integer i;

	assign 	data_a = data[addr_a];
	assign 	data_b = data[addr_b];

	always @(negedge reset_0 or posedge clock)
		if (reset_0 == 0) begin
			for (i=0;i<32;i=i+1)
				data[i] <= 0;
		end else if (enable)
			data[addr_w] <= data_w;

endmodule
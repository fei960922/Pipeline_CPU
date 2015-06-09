/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Module
	File name:	Register Cell 
	Note:		A single register with 32 bits.
				P138, P51

	Version:
        0.1     2015/6/6    Version Alpha;
		
*/

module reg_cell (clock, reset_0, enable, data_in, data);

	input 	[31:0]	data_in;
	input	clock, reset_0, enable;
	output	[31:0]	data;
	reg 	[31:0]	data;

	always @(negedge reset_0 or posedge clock)
		if (reset_0 == 0) begin
			data <= 0;
		end else begin
			if (enable) data <= data_in;
		end

endmodule
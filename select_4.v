/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Tool
	File name:	4 to 1 selector
	Note:		Select 4 to 1 with 32 bits data.

	Version:
        0.1     2015/6/6    Version Alpha;
		
*/

module select_4 (data_1, data_2, data_3, data_4, selector, data_w);

	input 	[31:0]	data_1, data_2, data_3, data_4;
	input 	[1:0]	selector;
	output	[31:0]	data_w;

	always @(data_1 or data_2 or data_3 or data_4 or selector)
		case (selector) 
			2'b00 : data_w = data_1;
			2'b01 : data_w = data_2;
			2'b10 : data_w = data_3;
			2'b11 : data_w = data_4;
		endcase
		
endmodule
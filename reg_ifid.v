/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Stage TRS
	File name:	Stage 1-2 --- IF->ID Register

	Version:
        0.1     2015/6/6    Version alpha;
        1.0 	2015/6/18 	Bug fixed;
		
*/

module reg_ifid (clock, reset_0, enable, pc4_if, instr_if, pc4_id, instr_id); 

	input	[31:0]	pc4_if, instr_if; 
	input	clock, reset_0, enable;

	output reg 	[31:0]	pc4_id, instr_id;
	
	always @(negedge reset_0 or posedge clock)
		if (reset_0 == 0) begin
			pc4_id <= 0;
			instr_id <= 0;
		end else if (enable) begin
			pc4_id <= pc4_if;
			instr_id <= instr_if;
		end

endmodule
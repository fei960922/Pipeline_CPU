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
		
*/

module reg_ifid (clock, reset_0, enable, pc_if, instr_if, pc_id, instr_id); 

	input	[31:0]	pc_if, instr_if; 
	input	clock, reset_0, enable;

	output	[31:0]	pc_id, instr_id;

	reg_cell a (clock, reset_0, enable, pc_if, pc_id);
	reg_cell b (clock, reset_0, enable, instr_if, instr_id);


endmodule
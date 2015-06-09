/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Stage
	File name:	Stage 1 --- IF

	Version:
        0.1     2015/6/5    Struct established;
        0.2		2015/6/6	Version alpha;
		
*/


module stage_if (pc_select, pc, pc_b, pc_r, pc_j, pc_next, pc_add4, instr); 

	input	[31:0] 	pc, pc_b, pc_r, pc_j; 
	input	[1:0]	pc_select;

	output	[31:0]	pc_next, pc_add4, instr;

	assign 	pc_add4 = pc + 4;
	assign 	instr = fetch_instr_mem(pc);

	select_4 s4 (pc_add4, pc_b, pc_r, pc_j, pc_select, pc_next);

	function [31:0] fetch_instr_mem;

		input [31:0] pc;
		// Writing...
		
		// fetch the instruction from the memory.

	endfunciton

endmodule
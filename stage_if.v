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


module stage_if (clock_me, pc_select, pc, pc_b, pc_r, pc_j, pc_next, pc4, instr, stall_me); 

	input	[31:0] 	pc, pc_b, pc_r, pc_j; 
	input	[1:0]	pc_select;
	input 	clock_me;

	output	[31:0]	pc_next, pc4, instr;
	output 	stall_me;

	assign 	pc4 = pc + 4;
	
	select_4 s4 (pc4, pc_b, pc_r, pc_j, pc_select, pc_next);

	mem_simple m (clock_me, pc, 1'b0, pc, instr);
	//mem_advanced m (clock_me, pc, 1'b1, 1'b0, pc, instr, stall_me);	

endmodule
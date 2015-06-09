/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Module
	File name:	Pipeline Top

	Version:
        0.1     2015/6/5    Struct established;
		
*/


module pipeline (clock, clock_memory, resetn, pc, inst, ?,?,?);

	input 	clock, clock_memory, resetn;
	output 	[31:0] 	pc, inst, ???;

	wire 	[31:0]	

	wire	[4:0]	
	wire	[3:0]
	wire	[1:0]
	wire	wreg_id, m2reg_id, wmem_id, aluimm_id, shift_id, jal_id;
	wire	wreg_ex, m2reg_ex, wmem_ex, aluimm_ex, shift_ex, jal_ex;
	wire	wreg_me, m2reg_me, wmem_me, wreg_wb, m2reg_wb;


	// IF
	reg_cell	a 	(pc_next, stall, clock, reset_0, pc);
	stage_if	b 	(pc_select, pc, pc_b, a_id, pc_j, pc_next, pc_add4, instr_if);
	// ID
	reg_ifid	c 	()
	// ID system
	stage_id
	
	stage_exe
	stage_mem
	stage_wb

	reg_
		pipeline_ir
	pipeline_reg
	

	pipeline_mreg
	
	pipeline_mwreg



endmodule
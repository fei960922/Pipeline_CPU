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
	wire

	// IF system
	stage_if
	// PC register
	pipeline_pc 
	// Instruction provider
	pipeline_imem

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
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

    Note: 
    	reg_name is named as follow:
    		name_x:
    			x = if / id / ex / me / wb
    			which represent using in each stage. (only few of them used transitive)
    	name :
			wreg: Writing Register or not;
			regrt	

    	Special name:
    		clock: 		CPU clock;
    		clock_me:	Memory clock;
    		reset_0:	To reset CPU with all reg.;
    		pc

		
*/


module pipeline (clock, clock_me, reset_0, pc, instr_id, ans_ex, ans_me, ans_wb);

	input 	clock, clock_me, reset_0;
	output 	[31:0] 	pc, instr_id, ans_ex, ans_me, ans_wb;

	wire 	[31:0]	pc_b, pc_j, pc_next, pc4_if, pc4_id, pc4_ex, instr_if, instr_id;
	wire	[31:0]	a_id, b_id, imm_id, a_ex, b_ex, imm_ex, b_me, data_w, mo_me, mo_wb;
	wire	[4:0]	rw_id, rw_in, rw_ex, rw_me, rw_wb;
	wire	[3:0]	op_id, op_ex;
	wire	[1:0]	pc_select;
	wire	wreg_id, m2reg_id, wmem_id, aluimm_id, shift_id, jal_id;
	wire	wreg_ex, m2reg_ex, wmem_ex, aluimm_ex, shift_ex, jal_ex;
	wire	wreg_me, m2reg_me, wmem_me, wreg_wb, m2reg_wb;
	wire 	stall; 

	// IF
	reg_cell	a 	(clock, reset_0, ~stall, pc_next, pc);
	stage_if	b 	(clock_me, pc_select, pc, pc_b, a_id, pc_j, pc_next, pc4_if, instr_if);
	// ID
	reg_ifid	c 	(clock, reset_0, ~stall, pc4_if, instr_if, pc4_id, instr_id);
	stage_id	d 	(clock, reset_0, pc4_id, instr_id, data_w, ans_ex, ans_me, mo_me,
						rw_ex, rw_me, rw_wb, wreg_ex, wreg_me, wreg_wb, m2reg_ex, m2reg_me,
						pc_b, pc_j, a_id, b_id, imm_id, rw_id, op_id, pc_select, 
						stall, wreg_id, m2reg_id, wmem_id, aluimm_id, shift_id, jal_id);
	// EX
	reg_idex	e 	(clock, reset_0, a_id, b_id, imm_id, pc4_id, rw_id, op_id, wreg_id, m2reg_id, wmem_id, aluimm_id, shift_id, jal_id,
								 	 a_ex, b_ex, imm_ex, pc4_ex, rw_in, op_ex, wreg_ex, m2reg_ex, wmem_ex, aluimm_ex, shift_ex, jal_ex);
	stage_ex	f 	(op_ex, aluimm_ex, a_ex, b_ex, imm_ex, shift_ex, rw_in, pc4_ex, jal_ex, rw_ex, ans_ex);
	// ME
	reg_exme 	g 	(clock, reset_0, ans_ex, b_ex, rw_ex, wreg_ex, m2reg_ex, wmem_ex,
								 	 ans_me, b_me, rw_me, wreg_me, m2reg_me, wmem_me); 
	stage_me	h 	(clock, clock_me, wmem_me, ans_me, b_me, mo_me);
	// WB
	reg_mewb 	i 	(clock, reset_0, ans_me, rw_me, wreg_me, m2reg_me, mo_me,
									 ans_wb, rw_wb, wreg_wb, m2reg_wb, mo_wb);
	assign data_w = m2reg_wb ? mo_wb : ans_wb;

endmodule
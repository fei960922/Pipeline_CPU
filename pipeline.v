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

    	Special name:
    		clock	: 	CPU clock;
    		reset_0	:	To reset CPU with all reg.;
    		pc 		: 	Instruction address;
    			pc4 		Next pc if nothing happens(pc + 4);
    			pc_b 		Next pc if Branch happens;
    			pc_j 		Next pc if Jump happens;
    			pc_r 		Next pc if Jr 	happens;
    			pc_next 	Real next pc;
    			pc_select 	Select the real next pc;
    		instr 	:	Instructions;


		
*/


module pipeline (clock, reset, pc, instr_id, ans_ex, ans_me, ans_wb);

	input 	clock, reset;
	output 	[31:0] 	pc, instr_id, ans_ex, ans_me, ans_wb;

	wire 	[31:0]	pc_b, pc_j, pc_next, pc4_if, pc4_id, pc4_ex, instr_if, instr_id;
	wire	[31:0]	a_id, b_id, imm_id, a_ex, b_ex, imm_ex, b_me, data_w, mo_me, mo_wb;
	wire	[4:0]	rw_id, rw_in, rw_ex, rw_me, rw_wb;
	wire	[3:0]	op_id, op_ex;
	wire	[1:0]	pc_select;
	wire	wreg_id, rmem_id, wmem_id, aluimm_id, shift_id, jal_id;
	wire	wreg_ex, rmem_ex, wmem_ex, aluimm_ex, shift_ex, jal_ex;
	wire	wreg_me, rmem_me, wmem_me, wreg_wb, rmem_wb;
	wire 	stall, stall_id, stall_me, stall_if, reset_0; 

	// IF
	reg_cell	a 	(clock, reset_0, ~stall, pc_next, pc);
	stage_if	b 	(clock, pc_select, pc, pc_b, a_id, pc_j, pc_next, pc4_if, instr_if, stall_if);
	// ID
	reg_ifid	c 	(clock, reset_0, ~stall, pc4_if, instr_if, pc4_id, instr_id);
	stage_id	d 	(clock, reset_0, ~stall_me, pc4_id, instr_id, data_w, ans_ex, ans_me, mo_me,
					rw_ex, rw_me, rw_wb, wreg_ex, wreg_me, wreg_wb, rmem_ex, rmem_me,
					bp_taken_ex, bp_succ_ex, bp_isbranch_ex, bp_taken_id, bp_isbeq_id, bp_isbranch_id,
					pc_b, pc_j, a_id, b_id, imm_id, rw_id, op_id, pc_select, 
					stall_id, wreg_id, rmem_id, wmem_id, aluimm_id, shift_id, jal_id);
	// EX
	reg_idex	e 	(clock, reset_0, a_id, b_id, imm_id, pc4_id, rw_id, op_id, wreg_id, rmem_id, wmem_id, aluimm_id, shift_id, jal_id, bp_taken_id, bp_isbeq_id, bp_isbranch_id,
						  ~stall_me, a_ex, b_ex, imm_ex, pc4_ex, rw_in, op_ex, wreg_ex, rmem_ex, wmem_ex, aluimm_ex, shift_ex, jal_ex, bp_taken_in, bp_isbeq_ex, bp_isbranch_ex);
	stage_ex	f 	(op_ex, aluimm_ex, a_ex, b_ex, imm_ex, shift_ex, rw_in, pc4_ex, jal_ex,
					 bp_taken_in, bp_isbeq_ex, bp_taken_ex, bp_succ_ex, rw_ex, ans_ex);
	// ME
	reg_exme 	g 	(clock, reset_0, ans_ex, b_ex, rw_ex, wreg_ex, rmem_ex, wmem_ex,
						  ~stall_me, ans_me, b_me, rw_me, wreg_me, rmem_me, wmem_me); 

	//mem_simple h  (clock, ans_me, wmem_me, b_me, mo_me);
	mem_advanced h 	(clock, reset_0, ans_me, rmem_me, wmem_me, b_me, mo_me, stall_me);

	// WB
	reg_mewb 	i 	(clock, reset_0, ans_me, rw_me, wreg_me, rmem_me, mo_me,
						  ~stall_me, ans_wb, rw_wb, wreg_wb, rmem_wb, mo_wb);
	
	assign data_w = rmem_wb ? mo_wb : ans_wb;
	assign stall = stall_id | stall_me | stall_if;
	assign reset_0 = reset & (op_id !== 4'b1111);

endmodule
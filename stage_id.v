/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Stage
	File name:	Stage 2 --- ID

	Version:
        0.1     2015/6/6    Version alpha;
		
*/

module stage_id (clock, reset_0, pc4_id, instr_id, data_w, ans_ex, ans_me, mo_me,
				rw_ex, rw_me, rw_wb, wreg_ex, wreg_me, wreg_wb, m2reg_ex, m2reg_me,
				pc_b, pc_j, a_id, b_id, imm_id, rw_id, op_id, pc_select, 
				stall, wreg_id, m2reg_id, wmem_id, aluimm_id, shift_id, jal_id); 

	input	[31:0]	pc4_id, instr_id, data_w, ans_ex, ans_me, mo_me;
	input	[4:0]	rw_ex, rw_me, rw_wb;
	input	wreg_ex, wreg_me, wreg_wb, m2reg_ex, m2reg_me;
	input	clock, reset_0;

	output	[31:0]	pc_b, pc_j, a_id, b_id, imm_id;
	output 	[4:0]	rw_id;
	output	[3:0]	op_id;
	output	[1:0]	pc_select;
	output	stall, wreg_id, m2reg_id, wmem_id, aluimm_id, shift_id, jal_id;

	wire	[31:0]	data_a, data_b, br, imm;
	wire	[5:0]	op, func;
	wire	[4:0]	rs, rt, rd;
	wire	[1:0]	a_select, b_select;
	wire	rw_select, sext, srtequ;

	assign op = instr_id[31:26];
	assign rs = instr_id[25:21];
	assign rt = instr_id[20:16];
	assign rd = instr_id[15:11];
	assign func = instr_id[5:0];

	assign pc_j = {pc4_id[31:28], instr_id[25:0], 2'b00};
	assign rw = rw_select?rt:rd;
	assign srtequ = ~|(a_id^b_id);	//???
	assign imm = {{16{sext & instr_id[15]}}, instr_id[15:0]};	//???
	assign br = {imm[29:0], 2'b00};
	assign pc_b = pc4_id + br;

	reg_array 	rf	(~clock, reset_0, wreg_wb, rs, rt, rw_wb, data_w, data_a, data_b);
	select_4 alu_a	(data_a, ans_ex, ans_me, mo_me, a_select, a_id);
	select_4 alu_b	(data_b, ans_ex, ans_me, mo_me, b_select, b_id);
	stage_id_ex ex  (wreg_me, rw_me, rw_ex, wreg_ex, m2reg_ex, m2reg_me, srtequ, func,
					op, rs, rt, wreg_id, m2reg_id, wmem_id, op_id, rw_select, aluimm_id,
					a_select, b_select, stall, sext, pc_select, shift_id, jal_id);

endmodule

module stage_id_ex	(wreg_me, rw_me, rw_ex, wreg_ex, m2reg_ex, m2reg_me, srtequ, func,
					op, rs, rt, wreg_id, m2reg_id, wmem_id, op_id, rw_select, aluimm_id,
					a_select, b_select, stall, sext, pc_select, shift_id, jal_id);
	input	[5:0]	func, op;
	input	[4:0]	rw_me, rw_ex, rs, rt;
	input	wreg_me, wreg_ex, m2reg_ex, m2reg_me, srtequ;

	output	[3:0]	op_id;
	output	[1:0]	pc_select, a_select, b_select;
	output 	wreg_id, m2reg_id, wmem_id, rw_select, aluimm_id;
	output 	sext, shift_id, jal_id, stall;
	

endmodule

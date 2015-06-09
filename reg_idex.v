/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Stage TRS
	File name:	Stage 2-3 --- ID->EX Register

	Version:
        0.1     2015/6/8    Version alpha;
		
*/

module reg_idex (clock, reset_0, a_id, b_id, imm_id, pc_id, rw_id, op_id, wreg_id, m2reg_id, wmem_id, aluimm_id, shift_id, jal_id,
								 a_ex, b_ex, imm_ex, pc_ex, rw_ex, op_ex, wreg_ex, m2reg_ex, wmem_ex, aluimm_ex, shift_ex, jal_ex); 

	input	[31:0]	a_id, b_id, imm_id, pc_id;
	input 	[4:0]	rw_id;
	input	[3:0]	op_id;
	input	wreg_id, m2reg_id, wmem_id, aluimm_id, shift_id, jal_id;
	input	clock, reset_0;

	output	[31:0]	a_ex, b_ex, imm_ex, pc_ex;
	output 	[4:0]	rw_ex;
	output	[3:0]	op_ex;
	output	wreg_ex, m2reg_ex, wmem_ex, aluimm_ex, shift_ex, jal_ex;

	reg 	[31:0]	a_ex, b_ex, imm_ex, pc_ex;
	reg  	[4:0]	rw_ex;
	reg 	[3:0]	op_ex;
	reg 	wreg_ex, m2reg_ex, wmem_ex, aluimm_ex, shift_ex, jal_ex;

	always @(negedge reset_0 or posedge clock)
		if (reset_0 == 0) begin
			a_ex <= 0;
			b_ex <= 0;
			imm_ex <= 0;
			pc_ex <= 0;
			rw_ex <= 0;
			op_ex <= 0;
			wreg_ex <= 0;
			m2reg_ex <= 0;
			wmem_ex <= 0;
			aluimm_ex <= 0;
			shift_ex <= 0;
			jal_ex <= 0;
		end else begin
			a_ex <= a_id;
			b_ex <= b_id;
			imm_ex <= imm_id;
			pc_ex <= pc_id;
			rw_ex <= rw_id;
			op_ex <= op_id;
			wreg_ex <= wreg_id;
			m2reg_ex <= m2reg_id;
			wmem_ex <= wmem_id;
			aluimm_ex <= aluimm_id;
			shift_ex <= shift_id;
			jal_ex <= jal_id;
		end

endmodule
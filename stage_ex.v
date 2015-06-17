/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Stage
	File name:	Stage 3 --- EX

	Version:
        0.1     2015/6/8    Version alpha;
		
*/

module stage_ex (op_ex, aluimm_ex, a_ex, b_ex, imm_ex, shift_ex, rw_in, pc4_ex, jal_ex, 
				 bp_taken_in, bp_isbeq_ex, bp_taken_ex, bp_succ_ex, rw_ex, ans_ex);

	input	[31:0]	a_ex, b_ex, imm_ex, pc4_ex;
	input 	[4:0]	rw_in;
	input	[3:0]	op_ex;
	input	aluimm_ex, shift_ex, jal_ex, bp_taken_in, bp_isbeq_ex;

	output	[31:0]	ans_ex;
	output	[4:0]	rw_ex;
	output 	bp_taken_ex, bp_succ_ex;
	wire	[31:0]	a_calc, b_calc, alu;

	assign a_calc = shift_ex	? {imm_ex[5:0],imm_ex[31:6]} : a_ex;
	assign b_calc = aluimm_ex	? imm_ex : b_ex;
	assign ans_ex = jal_ex		? (pc4_ex + 4) : alu;
	assign rw_ex = rw_in | {5{jal_ex}};
	
	assign bp_taken_ex = ~((a_ex==b_ex) ^ bp_isbeq_ex);
	assign bp_succ_ex = ~(bp_taken_ex ^ bp_taken_in);

	stage_ex_alu au (a_calc, b_calc, op_ex, alu);

endmodule

module stage_ex_alu	(a, b, op, ans);

	input	[31:0]	a, b;
	input	[3:0]	op;
	output	[31:0]	ans;
	wire	[31:0]	op_1, op_2;
	reg		[31:0]	op_3;

	always @* begin
		if (!op[3]) begin
			op_3 = b << a[4:0];
		end else if (op[2]) begin
			op_3 = $signed(b) >>> a[4:0];
		end else begin
			op_3 = b >> a[4:0];
		end
	end

	select_4 o1(a+b, a-b, a*b, a/b, op[3:2], op_1);
	select_4 o2(a&b, a|b, a^b, {b[15:0],16'h0}, op[3:2], op_2);
	select_4 o5(op_1, op_2, op_3, a, op[1:0], ans);

	/*
		This table is defined in stage_id.v

		ADD 0000;
		SUB 0100;
		MUL 1000;
		DIV 1100;
		AND 0001;
		OR	0101;
		XOR	1001;
		??? 1101;
		SLL	0010;
		SRL 1110;
		SRA 1010;
	*/

endmodule
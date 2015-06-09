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

module stage_ex (op_ex, aluimm_ex, a_ex, b_ex, imm_ex, shift_ex, rw_in, pc4_ex, jal_ex, rw_ex, ans_ex);

	input	[31:0]	a_ex, b_ex, imm_ex, pc_ex;
	input 	[4:0]	rw_in;
	input	[3:0]	op_ex;
	input	aluimm_ex, shift_ex, jal_ex;

	output	[31:0]	ans_ex;
	output	[4:0]	rw_ex;
	wire	[31:0]	a_calc, b_calc, alu;

	assign a_calc = shift_ex	? a_ex : {imm_ex[5:0],imm_ex[31:6]}; //???
	assign b_calc = aluimm_ex	? b_ex : imm_ex;
	stage_ex_alu au (a_calc, b_calc, op_in, alu);
	assign ans_ex = jal_ex		? alu  : (pc_ex + 4);
	assign rw_ex = rw_in | {5{jal_ex}};

endmodule

module stage_ex_alu	(a, b, op, ans);

	input	[31:0]	a, b;
	input	[3:0]	op;
	output	[31:0]	ans;
	wire	[31:0]	op_1, op_2, op_3;

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

endmodule
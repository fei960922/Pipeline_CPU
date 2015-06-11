/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Stage TRS
	File name:	Stage 3-4 --- EX->ME Register

	Version:
        0.1     2015/6/8    Version alpha;
		
*/

module reg_exme (clock, reset_0, ans_ex, b_ex, rw_ex, wreg_ex, m2reg_ex, wmem_ex,
								 ans_me, b_me, rw_me, wreg_me, m2reg_me, wmem_me); 

	input	[31:0]	ans_ex, b_ex;
	input 	[4:0]	rw_ex;
	input	wreg_ex, m2reg_ex, wmem_ex;
	input	clock, reset_0;

	output	[31:0]	ans_me, b_me;
	output 	[4:0]	rw_me;
	output	wreg_me, m2reg_me, wmem_me;

	reg 	[31:0]	ans_me, b_me;
	reg  	[4:0]	rw_me;
	reg 	wreg_me, m2reg_me, wmem_me;

	always @(negedge reset_0 or posedge clock)
		if (reset_0 == 0) begin
			ans_me <= 0;
			b_me <= 0;
			rw_me <= 0;
			wreg_me <= 0;
			m2reg_me <= 0;
			wmem_me <= 0;
		end else begin
			ans_me <= ans_ex;
			b_me <= b_ex;
			rw_me <= rw_ex;
			wreg_me <= wreg_ex;
			m2reg_me <= m2reg_ex;
			wmem_me <= wmem_ex;
		end

endmodule
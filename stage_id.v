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

module stage_id (clock, reset_0, ); 

	input	[31:0]	pc_add4, instr, rw_select, 

	input	
	input	clock, reset_0;

	output	[31:0]	pc_b, pc_j, out_a, out_b, imm;
	output 	[4:0]	rw;
	output	[3:0]	

	assign op = instr[31:26];
	assign rs = instr[25:21];
	assign rt = instr[20:16];
	assign rd = instr[15:11];
	assign func = instr[5:0];

	assign pc_j = {pc_add4[31:28], instr[25:0], 2'b00};
	assign rw = rw_select?rt:rd;
	assign srtequ = ~|(a^b);	//???
	assign imm = {16{sext & isntr[15]}, instr[15:0]};	//???
	assign br_offset = {imm[29:0], 2'b00};

	reg_array 	rf	(~clock, reset_0, enable, rs, rt, rw, data_w, data_a, data_b);
	select_4 alu_a	(data_a, ealu, malu, mmo, a_select, out_a);
	select_4 alu_b	(data_b, ealu, malu, mmo, b_select, out_b);
	stage_id_ex ex  ();
	

endmodule

module stage_id_ex();

	

endmodule

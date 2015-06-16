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
		
    Note: 
    	Wire function: (Silimiar with P146)
    		ans:		Answer of ALU;
    		mo:			Memory output;
    		rw: 			
    		wreg: 		Write register or not;
    		rmem: 		Whether memory will be read or not;
    		wmem:		Whether memory will be write or not;
    		rw_select: 	1 = Select rt ; 0 = Select rd;
    		jal: 		1 = The op. is jal ; 0 = not;
    		shift: 		1 = ALU a used for shift; 0 = register;
    		aluimm 		1 = ALU b use imm.; 0 = register;


*/

module stage_id (clock, reset_0, stall_me, pc4_id, instr_id, data_w, ans_ex, ans_me, mo_me,
				rw_ex, rw_me, rw_wb, wreg_ex, wreg_me, wreg_wb, rmem_ex, rmem_me,
				pc_b, pc_j, a_id, b_id, imm_id, rw_id, op_id, pc_select, 
				stall, wreg_id, rmem_id, wmem_id, aluimm_id, shift_id, jal_id); 

	input	[31:0]	pc4_id, instr_id, data_w, ans_ex, ans_me, mo_me;
	input	[4:0]	rw_ex, rw_me, rw_wb;
	input	wreg_ex, wreg_me, wreg_wb, rmem_ex, rmem_me;
	input	clock, reset_0, stall_me;

	output	[31:0]	pc_b, pc_j, a_id, b_id, imm_id;
	output 	[4:0]	rw_id;
	output	[3:0]	op_id;
	output	[1:0]	pc_select;
	output	stall, wreg_id, rmem_id, wmem_id, aluimm_id, shift_id, jal_id;

	wire	[31:0]	data_a, data_b, br;
	wire	[5:0]	op, func;
	wire	[4:0]	rs, rt, rd;
	wire	[1:0]	a_select, b_select;
	wire	rw_select, sext, equal;

	assign op = instr_id[31:26];
	assign rs = instr_id[25:21];
	assign rt = instr_id[20:16];
	assign rd = instr_id[15:11];
	assign func = instr_id[5:0];

	assign pc_j = {pc4_id[31:28], instr_id[25:0], 2'b00};
	assign rw_id = rw_select?rt:rd;
	assign equal = a_id==b_id; //~|(a_id^b_id);	
	assign imm_id = {{16{sext & instr_id[15]}}, instr_id[15:0]};	
	assign br = {imm_id[29:0], 2'b00};
	assign pc_b = pc4_id + br;

	assign pc_select[1] = (op[5:1]==5'b00001) | (op == 0 & func ==6'b001000);
	assign pc_select[0] = (op==6'b000100 & equal) | (op==6'b000101 & ~equal) | (op[5:1]==5'b00001);

	reg_array 	rf	(~clock, reset_0, wreg_wb & stall_me, rs, rt, rw_wb, data_w, data_a, data_b);
	select_4 alu_a	(data_a, ans_ex, ans_me, mo_me, a_select, a_id);
	select_4 alu_b	(data_b, ans_ex, ans_me, mo_me, b_select, b_id);
	stage_id_ex ex  (clock, wreg_me, rw_me, rw_ex, wreg_ex, rmem_ex, rmem_me, equal, func,
					op, rs, rt, wreg_id, rmem_id, wmem_id, op_id, rw_select, aluimm_id,
					a_select, b_select, stall, sext, shift_id, jal_id);

endmodule

module stage_id_ex	(clock, wreg_me, rw_me, rw_ex, wreg_ex, rmem_ex, rmem_me, equal, func,
					op, rs, rt, wreg_id, rmem_id, wmem_id, op_id, rw_select, aluimm_id,
					a_select, b_select, stall, sext, shift_id, jal_id);
	input	[5:0]	func, op;
	input	[4:0]	rw_me, rw_ex, rs, rt;
	input	wreg_me, wreg_ex, rmem_ex, rmem_me, equal;
	input 	clock;

	output	[3:0]	op_id;
	output	[1:0]	a_select, b_select;
	output 	wreg_id, wmem_id, rmem_id, rw_select, aluimm_id;
	output 	sext, shift_id, jal_id, stall;

	reg		[3:0]	op_id;
	reg		[1:0]	a_select, b_select;
	reg 	wreg_id, wmem_id, rmem_id, rw_select, aluimm_id;
	reg 	sext, shift_id, jal_id, stall;

	reg 	use_rt, use_rs;
	
	always @(op or func or wreg_ex or wreg_me or 
			 rw_ex or rw_me or rmem_ex or rmem_me or rs or rt) begin

		use_rt = 0;
		use_rs = 0;
		wreg_id = 0;
		wmem_id = 0;
		rmem_id = 0;
		rw_select = 0;
		aluimm_id = 0;
		sext = 0;
		shift_id = 0;
		jal_id = 0;
		stall = 0;
		op_id = 4'b0000;
		//pc_select = 2'b00;
		case (op) 
			6'b000000: begin
				case (func)
					6'b100000: begin 	// add
						wreg_id = 1;
						op_id = 4'b0000;
						use_rt = 1;
						use_rs = 1;
					end
					6'b100010: begin 	// sub
						wreg_id = 1;
						op_id = 4'b0100;
						use_rt = 1;
						use_rs = 1;
					end
					6'b100100: begin 	// and
						wreg_id = 1;
						op_id = 4'b0001;
						use_rt = 1;	
						use_rs = 1;					
					end
					6'b100101: begin 	// or
						wreg_id = 1;
						op_id = 4'b0101;
						use_rt = 1;	
						use_rs = 1;					
					end
					6'b100110: begin 	// xor
						wreg_id = 1;
						op_id = 4'b1001;
						use_rt = 1;		
						use_rs = 1;				
					end
					6'b000111: begin 	// sll !! Diff with common MIPS code.
						wreg_id = 1;
						shift_id = 1;
						op_id = 4'b0010;
						use_rt = 1;
					end
					6'b000010: begin 	// srl
						wreg_id = 1;
						shift_id = 1;
						op_id = 4'b1110;
						use_rt = 1;
					end
					6'b000011: begin 	// sra
						wreg_id = 1;
						shift_id = 1;
						op_id = 4'b1010;
						use_rt = 1;
					end
					6'b001000: begin 	// jr
						//pc_select = 2'b10;
						use_rs = 1;
					end
				endcase
			end
			6'b001000: begin 			// addi
				wreg_id = 1;
				rw_select = 1;
				aluimm_id = 1;
				sext = 1;
				op_id = 4'b0000;
				use_rs = 1;
			end
			6'b001100: begin 			// andi
				wreg_id = 1;
				rw_select = 1;
				aluimm_id = 1;
				op_id = 4'b0001;
				use_rs = 1;
			end
			6'b001101: begin 			// ori
				wreg_id = 1;
				rw_select = 1;
				aluimm_id = 1;
				op_id = 4'b0101;
				use_rs = 1;
			end
			6'b001110: begin 			// xori
				wreg_id = 1;
				rw_select = 1;
				aluimm_id = 1;
				op_id = 4'b1001;
				use_rs = 1;
			end
			6'b100011: begin 			// lw
				wreg_id = 1;
				rmem_id = 1;
				rw_select = 1;
				aluimm_id = 1;
				use_rs = 1;
				sext = 1;
			end
			6'b101011: begin 			// sw
				aluimm_id = 1;
				sext = 1;
				wmem_id = 1;
				use_rt = 1;
				use_rs = 1;
			end
			6'b000100: begin 			// beq
				sext = 1;
				use_rt = 1;
				use_rs = 1;
				//pc_select = (equal)? 2'b01 : 2'b00;
			end
			6'b000101: begin 			// bne
				sext = 1;
				use_rt = 1;	
				use_rs = 1;
				//pc_select = (equal)? 2'b00 : 2'b01;
			end
			6'b001111: begin 			// lui
				wreg_id = 1;
				rw_select = 1;
				aluimm_id = 1;
				op_id = 4'b1101;
			end
			6'b000010: begin 			// j
				//pc_select = 2'b11;
			end
			6'b000011: begin 			// jal
				wreg_id	= 1;
				jal_id = 1;
				//pc_select = 2'b11;
			end
		endcase
		// bypassing
		a_select = 2'b00;
		b_select = 2'b00;
		if (wreg_ex & (rw_ex != 0) & (rw_ex == rs) & ~rmem_ex) 
			a_select = 2'b01;
		else if (wreg_me & (rw_me != 0) & (rw_me == rs) & ~rmem_me)
			a_select = 2'b10;
		else if (wreg_me & (rw_me != 0) & (rw_me == rs) & rmem_me)
			a_select = 2'b11;
		if (wreg_ex & (rw_ex != 0) & (rw_ex == rt) & ~rmem_ex) 
			b_select = 2'b01;
		else if (wreg_me & (rw_me != 0) & (rw_me == rt) & ~rmem_me)
			b_select = 2'b10;
		else if (wreg_me & (rw_me != 0) & (rw_me == rt) & rmem_me)
			b_select = 2'b11;
		stall = wreg_ex & rmem_ex & (rw_ex != 0) & ((use_rs & (rw_ex == rs)) | (use_rt & (rw_ex == rt)));
		wmem_id = wmem_id & ~stall;
		wreg_id = wreg_id & ~stall;
	end

endmodule

	/*
		ADD 0000;
		SUB 0100;
		MUL 1000;
		DIV 1100;
		AND 0001;
		OR	0101;
		XOR	1001;
		LUI 1101;
		SLL	0010;
		SRL 1110;
		SRA 1010;
	*/
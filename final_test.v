/*
	
	  Computer System (1) ------ Final Project
		MIPS 5-Level Pipeline CPU (Advanced)

		Author: 	Xu Yifei	&	Zhang Yiyi
		Stu. ID:	5130309056	&	5132409031
		Class: 		F1324004(ACM2013)
		College:	Zhiyuan College
		University: Shanghai Jiao Tong University

		File type:	Verilog --- Test
		File name:	Final Test
		
*/

`include "pipeline.v"

module final_test;

	reg 	clock, clock_me, reset_0;
	wire 	[31:0]	pc, instr_id, ans_ex, ans_me, ans_wb;
	reg 	[7:0] 	reg1;
	integer file;

	pipeline p (clock, clock_me, reset_0, pc, instr_id, ans_ex, ans_me, ans_wb);

	initial begin
		clock = 0;
		reset_0 = 0;
    	forever #10 clock = !clock;
   	end
   	initial begin
	  	clock_me = 0;
	    forever #10 clock_me = !clock_me;
	end
	initial begin
		file = $fopen("data.txt", "r");
		while (!$feof(file)) begin
			$fscanf(file, "%d", reg1);
 	     	$display("%d", reg1);
		end
		$fclose(file);
	end

endmodule
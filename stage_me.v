/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Stage
	File name:	Stage 4 --- ME

	Version:
        0.1     2015/6/9    Version alpha;
		
*/

module stage_me (clock, clock_me, wmem_me, addr, in_me, mo_me);

	input	[31:0]	addr, in_me;
	input	wmem_me, clock, clock_me;
	output	[31:0]	mo_me;

	mem_simple m (clock_me, addr, wmem_me, in_me, mo_me);

endmodule
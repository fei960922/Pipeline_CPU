/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Module
	File name:	A simple memory I/O without cache, for 32 bits only.

	Version:
        0.1     2015/6/11    Struct established;
		
*/

module mem_simple(clock_me, pc, wmem, in, out);

	input 	[31:0]	pc, in;
	input	clock_me, wmem;
	output	[31:0]	out;

	reg 	[31:0]	memorys[0:1024];
	integer i, file, file_mips;

	assign out = memorys[pc >> 2];

	always @(posedge clock_me)
		if (wmem)
			memorys[pc] <= in;

	// For simulate only.
	initial begin
		file = $fopen("C:/Programming/ModelSim/examples/Pipeline_CPU/data.txt", "r");
		file_mips = $fopen("C:/Programming/ModelSim/examples/Pipeline_CPU/mips.txt", "r");
		for (i = 0; i < 100; i = i + 1) begin
			memorys[i] = 0;
		end
		i = 100;
		while (!$feof(file)) begin
			$fscanf(file, "%d", memorys[i]);
			i = i + 1;
		end
		$display("Data load : %d lines", i - 100);
		i = 0;
		while (!$feof(file_mips)) begin
			$fscanf(file_mips, "%b", memorys[i]);
			i = i + 1;
			if (i>100) begin
				$display("Instruction number outbound! (>100 lines is not supported)");
			end
		end
		$display("Instruction load : %d lines", i);
		
		$fclose(file);
		$fclose(file_mips);
	end

endmodule
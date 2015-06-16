/*
	
	Computer System (1) ------ Final Project
	MIPS 5-Level Pipeline CPU (Advanced)

	Author: 	Xu Yifei	&	Zhang Yiyi
	Stu. ID:	5130309056	&	5132409031
	Class: 		F1324004(ACM2013)
	College:	Zhiyuan College
	University: Shanghai Jiao Tong University

	File type:	Verilog --- Module
	File name:	A memory I/O with L1 cache, for 32 bits only.

	Version:
        0.1     2015/6/14    Struct established;

    Note:
    	According to i5-3317U(Intel Ivy bridge):
    		The L1 cache is 32KB data and 32KB instruction.
    		The block size of it is 64Bytes.
    	That is equals to 16 words per block and total 512 blocks in each cache.
    	We use direct-mapping and write-back.
		
*/

module mem_advanced(clock_me, reset_0, addr, rmem, wmem, data_in, data_out, stall_me);

	input 	[31:0]	addr, data_in;
	input	clock_me, rmem, wmem, reset_0;
	output	[31:0]	data_out;
	output reg	stall_me;

	reg 	[31:0]	memory[0:1024];

	reg		[31:0]	cache[0:512][0:15];
	reg		[16:0]	cache_tag[0:512];
	reg				cache_dirty[0:512];
	reg		temp;

	wire 	[16:0]	tags;
	wire 	[8:0] 	mods;
	wire 	[3:0]	offs;
	integer i, j, file, file_mips;

	assign tags = addr[31:15];
	assign mods = addr[14:6];
	assign offs = addr[5:2];
	assign data_out = cache[mods][offs];

	always @(reset_0) begin
		for (i=0;i<512;i=i+1) begin
			if (cache_dirty[i])
				for (j=0;j<16;j=j+1) begin
					memory[{cache_tag[i], i, 4'h0} + j] = cache[i][j];
					cache[i][j] = 0;
				end
			cache_tag[i] = 17'hxxxxx;
			cache_dirty[i] = 0;
		end
	end
	always @(negedge clock_me) begin
		stall_me = (tags !== cache_tag[mods]) & (rmem | wmem);
		if (stall_me & temp) begin
			temp = 1'b0;
			#400;
			temp = 1'b1;
			for (i=0;i<16;i=i+1) begin
				if (cache_dirty[mods])
					memory[{cache_tag[mods], mods, 4'h0} + i] = cache[mods][i];
				cache[mods][i] = memory[{addr[31:6], 4'h0} + i];
			end
			if (wmem) begin
				cache[mods][offs] <= data_in;
				cache_dirty[mods] <= 1'b1;
			end else 
				cache_dirty[mods] <= 1'b0;
			cache_tag[mods] = tags;
		end	else if (wmem) begin
			cache[mods][offs] <= data_in;
			cache_dirty[mods] <= 1'b1; 
		end
	end
	// For simulate only.
	initial begin
		temp = 1'b1;

		file = $fopen("C:/Programming/ModelSim/examples/Pipeline_CPU/data.txt", "r");
		file_mips = $fopen("C:/Programming/ModelSim/examples/Pipeline_CPU/mips.txt", "r");
		for (i = 0; i < 100; i = i + 1) begin
			memory[i] = 0;
		end
		for (i = 0; i < 512; i = i + 1) begin
			cache_dirty[i] = 1'b0;
		end
		i = 100;
		while (!$feof(file)) begin
			$fscanf(file, "%d", memory[i]);
			i = i + 1;
		end
		$display("Data load : %d lines", i - 100);
		i = 0;
		while (!$feof(file_mips)) begin
			$fscanf(file_mips, "%b", memory[i]);
			i = i + 1;
			if (i>100) begin
				$display("Instruction number outbound! (>100 lines is not supported)");
			end
		end
		$display("Inst load : %d lines", i);
		$fclose(file);
		$fclose(file_mips);
	end

endmodule
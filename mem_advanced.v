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
    	That is equals to 8 words per block and total 512 blocks in each cache.
    	We use direct-mapping and write-back.
		
*/

module mem_advanced(clock_me, addr, rmem, wmem, data_in, data_out, stall_me);

	input 	[31:0]	addr, data_in;
	input	clock_me, rmem, wmem;
	output	[31:0]	data_out;
	output 	stall_me;

	reg 	[31:0]	memory[0:1024];

	reg		[31:0]	cache[0:512][0:7];
	reg		[17:0]	cache_tag[0:512];
	reg				cache_dirty[0:512];

	wire 	[17:0]	tags;
	wire 	[8:0] 	mods;
	wire 	[2:0]	offs;
	integer i, j, file, file_mips;

	assign tags = addr[31:14];
	assign mods = addr[13:5];
	assign offs = addr[4:2];
	assign data_out = cache[mods][offs];
	assign stall_me = (tags !== cache_tag[mods]) & (rmem | wmem);

	always @(posedge clock_me) begin
		if (stall_me) begin
			#40;			// For debug, use 20 cycle instead.
			for (i=0;i<8;i=i+1) begin
				if (cache_dirty[mods])
					memory[{cache_tag[mods], mods, 3'b000} + i] = cache[mods][i];
				cache[mods][i] = memory[{addr[31:5],3'b000} + i];
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
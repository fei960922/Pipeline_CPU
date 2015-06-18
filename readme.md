
# MIPS 5-Level Pipelined CPU (Advanced)

## Introduction

This is a MIPS 5-Level Pipelined CPU with a few advanced features.
There are following features:

	- Full bypassing supported;
	- 2-Level branch predictor;
	- 1-level cache provided;

This CPU support the following MIPS code:

	- lw
	- sw
	- add
	- sub
	- mul
	- div
	- beq
	- bne
	......(undecided)

This CPU is written in Verilog HDL and will be simulated with ModelSim 10.4a Student Edition.

This project is a final project of Computer System (1) by Xiaoyao Liang in Spring 2015.

- Data through: 2015.06.01 - 2015.06.19
- Presentation: 2015.06.19 11:00 - 11:15

## Goals

The requiry of the project is : [Project requiry](http://www.cs.sjtu.edu.cn/~liang-xy/ms108/project.pdf)

The C++ code runs is :

	int main() {
		int e = 200;
		int ans = 0;
		do {
			int x = memory[i];
			i++;
			ans += x;
		} while (i != 200)
		memory[e] = ans;
	}

The mips code runs is :

	ori $10, $0, 800
	ori	$11, $0, 0
	ori	$12, $0, 400
	lw 	$13, 0($12)
	addi$12, $12, 4
	add $11, $11, $13
	bne	$12, $10, -4
	sw 	$11, 0($10)

The binary code runs is :

	001101 00000 01010 00000 01100 100000	//04
	001101 00000 01011 00000 00000 000000	//08
	001101 00000 01100 00000 00110 010000	//0C
	100011 01100 01101 00000 00000 000000	//10
	001000 01100 01100 00000 00000 000100	//14
	000000 01011 01101 01011 00000 100000	//18
	000101 01100 01010 11111 11111 111100 	//1C
	101011 01010 01011 00000 00000 000000	//20

## Author

	- Author: 		Xu Yifei	&	Zhang Yiyi
	- Stu. ID:		5130309056	&	5132409031
	- Class: 		F1324004(ACM2013)
	- College:		Zhiyuan College
	- University:	Shanghai Jiao Tong University

## Timetable

	- 2015.06.01 	Project Started.
	- 2015.06.03 	Reference reading.
	- 2015.06.05 	Repository established.
	- 2015.06.13 	Basic Version release.
	- 2015.06.15 	Version Alpha release.
	>>>>>>>>>>>>>>> Predicted >>>>>>>>>>>>>>>>
	- 2015.06.16	Version Beta release.
	- 2015.06.18	Final Version release.
	- 2015.06.19 	Final DDL. Presentation.

## Project Outlines

	This project include :

	- top level
		- pipeline.v
		- final_test.v
	- stage level
		- stage_if.v
		- stage_id.v
		- stage_ex.v
	- module level
		- if_pc.v
		- ......
	- tool level
		- reg_array.v
		- reg_cell.v
		- select_4.v

	(Undecided)

## Reference

Computer Principles and Design in Verilog HDL  [Download](http://vdisk.weibo.com/s/z4a2gWe6ECIsn)

Computer Architecture Experiment Instruction (LAB1-6)  (Download: Restricted)

Verilog for Ditigal Circuits  [Download](http://www.cs.sjtu.edu.cn/~liang-xy/ms108/Verilog%20for%20Ditigal%20Circuits.pdf)

Thanks to: Many Guys.

## Reports

### Branch Prediction

Traditionally, branch instruction should be done in EX stage because we won't know whether we take the branch or not before we compare the conditions in EX stage. Stall will happened until the branch is complete, which makes our pipeline too slow. 

A 2-bit global branch prediction is added into our design. 

When we face a branch instruction(That is 'bp_isbranch_id' == 1). We will do following:

(1) Fetch result from branch prediction(The result is 'bp_taken_id').

	if the prediction result is TAKEN: Let pc_select = 2'b01 which mean pc_b will be selected;
	Otherwise, pc_select = 2'b00 which mean pc4 will be selected;

(2) Storage another PC into the branch prediction.

	if prediction result is TAKEN, storage pc4.
	Otherwise, storage pc_b instead.

(3) Transmit 'bp_taken_id', 'bp_isbeq_id', 'bp_isbranch_id' to EX stage.

*** Next cycle ***

(4) In EX stage, we calculate the condition and output these:

	bp_taken_ex = ((a_ex == b_ex) ^ bp_isbeq_ex); 	// Whether this branch should be TAKEN.
	bp_succ_ex = ~(bp_taken_ex ^ bp_taken_in);		// Whether this branch is predicted correctlly.
													// * bp_taken_in is the predict result.

	These wire will be linked to ID stage.

(5) Decide whether the new instruction in ID stage is correct or not.

	bp_reset = (~bp_isbranch_ex) | bp_succ_ex; 		// If the previous instruction is a branch and its prediction failed.

	If the prediction is failed (bp_reset==0):

		a) Clean the current instruction because it is a wrong one. 

			instr_true = instr_id & {32{bp_reset}};

		b) Modify next pc to a correct one. Notice another PC we storage in the branch prediction is a correct one.

			pc_b = (bp_reset) ? (pc4_id + {imm_id[29:0], 2'b00}) : pc_bf; 	// pc_bf is the storaged PC.
			if (bp_reset) pc_select = 2'b01; 								// We transmit this PC by pc_b.
	
	Whatever the prediction is success or not, we should give the branch prediction a feedback. 'bp_taken_ex' is transmitted to the branch prediction.


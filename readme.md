
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
- [Project requiry](http://www.cs.sjtu.edu.cn/~liang-xy/ms108/project.pdf)

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
	>>>>>>>>>>>>>>> Predicted >>>>>>>>>>>>>>>>
	- 2015.06.07	Basic Version release.
	- 2015.06.14 	Version Alpha release.
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
		- stage_me.v
		- stage_wb.v
	- module level
		- if_pc.v
		- ......
	- tool level
		- dffe32
		- mux2x32.v
		- mux4x32.v
		- ......

	(Undecided)

## Reference

Computer Principles and Design in Verilog HDL  [Download](http://vdisk.weibo.com/s/z4a2gWe6ECIsn)

Computer Architecture Experiment Instruction (LAB1-6)  (Download: Restricted)

Verilog for Ditigal Circuits  [Download](http://www.cs.sjtu.edu.cn/~liang-xy/ms108/Verilog%20for%20Ditigal%20Circuits.pdf)

Thanks to: Many Guys.


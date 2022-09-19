// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// Put your code here.

//set i to 0
@i
M=0

//set sum to 0
@sum
M=0

(LOOP)
//if i = R1, JUMP to end
@i
D=M
@R1
D=D-M
@END
D;JEQ

// if not, add up sum and i
// add up sum
@R0
D=M
@sum
M = D+M

//add up i
@i
M = M+1

//jump to loop
@LOOP
0;JMP

(END)
//assign sum to R2
@sum 
D=M
@R2
M=D

(END2)
@END2
0;JMP
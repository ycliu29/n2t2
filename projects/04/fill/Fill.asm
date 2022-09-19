// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// set i to 16384
@16384
D=A
@i
M=D

(LOOP)
@24576
D=A
@i
D=D-M
@RESET
D;JEQ

@24576
D=M
@WHITE
D;JEQ
@i
A=M
M=-1
@i
M=M+1

@LOOP
0;JMP

(WHITE)
@i
A=M
M=0
@i
M=M+1
@LOOP
0;JMP

//set i to 16384
(RESET)
@8192
D=A
@i
M=M-D
@LOOP
0;JMP
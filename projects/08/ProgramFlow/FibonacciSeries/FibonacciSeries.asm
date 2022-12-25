// push argument 1 (line: 11)
@1 // target = ARG+index
D = A
@ARG
D = D+M
@ARG11
M = D
@ARG11 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop pointer 1 (line: 12)
@SP // SP--, THAT = SP*
M = M-1
A = M
D = M
@THAT
M = D

// push constant 0 (line: 14)
@0 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop that 0 (line: 15)
@0 // target = THAT+index
D = A
@THAT
D = D+M
@THAT15
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@THAT15
A = M
M = D

// push constant 1 (line: 16)
@1 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop that 1 (line: 17)
@1 // target = THAT+index
D = A
@THAT
D = D+M
@THAT17
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@THAT17
A = M
M = D

// push argument 0 (line: 19)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG19
M = D
@ARG19 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 2 (line: 20)
@2 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// sub (line: 21)
@SP // sp--
M = M-1
@SP // (SP-1)* - SP*
A = M
D = M 
@SP
A = M-1
M = M-D

// pop argument 0 (line: 22)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG22
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@ARG22
A = M
M = D

// label MAIN_LOOP_START (line: 24)
(MAIN_LOOP_START) // create a label

// push argument 0 (line: 26)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG26
M = D
@ARG26 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// if-goto COMPUTE_ELEMENT (line: 27)
@SP // sp --
M = M-1
A = M // D = sp*
D = M
@COMPUTE_ELEMENT
D;JNE

// goto END_PROGRAM (line: 28)
@END_PROGRAM 
0;JEQ

// label COMPUTE_ELEMENT (line: 30)
(COMPUTE_ELEMENT) // create a label

// push that 0 (line: 32)
@0 // target = THAT+index
D = A
@THAT
D = D+M
@THAT32
M = D
@THAT32 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push that 1 (line: 33)
@1 // target = THAT+index
D = A
@THAT
D = D+M
@THAT33
M = D
@THAT33 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// add (line: 34)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// pop that 2 (line: 35)
@2 // target = THAT+index
D = A
@THAT
D = D+M
@THAT35
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@THAT35
A = M
M = D

// push pointer 1 (line: 37)
@THAT // *SP = THAT, SP++
D = M
@SP
A = M
M = D
@SP
M = M+1

// push constant 1 (line: 38)
@1 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// add (line: 39)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// pop pointer 1 (line: 40)
@SP // SP--, THAT = SP*
M = M-1
A = M
D = M
@THAT
M = D

// push argument 0 (line: 42)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG42
M = D
@ARG42 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 1 (line: 43)
@1 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// sub (line: 44)
@SP // sp--
M = M-1
@SP // (SP-1)* - SP*
A = M
D = M 
@SP
A = M-1
M = M-D

// pop argument 0 (line: 45)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG45
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@ARG45
A = M
M = D

// goto MAIN_LOOP_START (line: 47)
@MAIN_LOOP_START 
0;JEQ

// label END_PROGRAM (line: 49)
(END_PROGRAM) // create a label


// push constant 10 (line: 7)
@10 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop local 0 (line: 8)
@0 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL8
M = D

@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@LOCAL8
A = M
M = D

// push constant 21 (line: 9)
@21 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 22 (line: 10)
@22 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop argument 2 (line: 11)
@2 // target = ARG+index
D = A
@ARG
D = D+M
@ARG11
M = D

@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@ARG11
A = M
M = D

// pop argument 1 (line: 12)
@1 // target = ARG+index
D = A
@ARG
D = D+M
@ARG12
M = D

@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@ARG12
A = M
M = D

// push constant 36 (line: 13)
@36 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop this 6 (line: 14)
@6 // target = THIS+index
D = A
@THIS
D = D+M
@THIS14
M = D

@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@THIS14
A = M
M = D

// push constant 42 (line: 15)
@42 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 45 (line: 16)
@45 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop that 5 (line: 17)
@5 // target = THAT+index
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

// pop that 2 (line: 18)
@2 // target = THAT+index
D = A
@THAT
D = D+M
@THAT18
M = D

@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@THAT18
A = M
M = D

// push constant 510 (line: 19)
@510 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop temp 6 (line: 20)
@6 // target = 5+index
D = A
@5
D = D+A
@TEMP20
M = D

@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@TEMP20
A = M
M = D

// push local 0 (line: 21)
@0 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL21
M = D

@LOCAL21 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push that 5 (line: 22)
@5 // target = THAT+index
D = A
@THAT
D = D+M
@THAT22
M = D

@THAT22 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// add (line: 23)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// push argument 1 (line: 24)
@1 // target = ARG+index
D = A
@ARG
D = D+M
@ARG24
M = D

@ARG24 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// sub (line: 25)
@SP // sp--
M = M-1
@SP // (SP-1)* - SP*
A = M
D = M 
@SP
A = M-1
M = M-D

// push this 6 (line: 26)
@6 // target = THIS+index
D = A
@THIS
D = D+M
@THIS26
M = D

@THIS26 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push this 6 (line: 27)
@6 // target = THIS+index
D = A
@THIS
D = D+M
@THIS27
M = D

@THIS27 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// add (line: 28)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// sub (line: 29)
@SP // sp--
M = M-1
@SP // (SP-1)* - SP*
A = M
D = M 
@SP
A = M-1
M = M-D

// push temp 6 (line: 30)
@6 // target = 5+index
D = A
@5
D = D+A
@TEMP30
M = D

@TEMP30 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// add (line: 31)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D


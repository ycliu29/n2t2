// function Sys.init 0 (line: 8)
(Sys.init) // create function label

@0 // save index to a variable
D = A
@FUNC8
M = D

(STARTSys.init)
@FUNC8 // leave loop if variable is 0
D = M
@EXITSys.init
D;JEQ

@SP // sp* = 0, sp ++
A = M
M = 0
@SP 
M = M + 1
@FUNC8
M = M - 1

@STARTSys.init
0;JMP

(EXITSys.init)

// push constant 4000 (line: 9)
@4000 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop pointer 0 (line: 10)
@SP // SP--, THIS = SP*
M = M-1
A = M
D = M
@THIS
M = D

// push constant 5000 (line: 11)
@5000 // *sp = i
D = A
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

// call Sys.main 0 (line: 13)

@RetAddr13 // push returnAddress(SP ++)
D = M
@SP 
A = M
M = D
@SP
M = M + 1

@LCL // push LCL
D = M 
@SP
A = M
M = D
@SP
M = M + 1

@ARG // push ARG
D = M 
@SP
A = M
M = D
@SP
M = M + 1

@THIS // push THIS
D = M 
@SP
A = M
M = D
@SP
M = M + 1

@THAT // push THAT
D = M 
@SP
A = M
M = D
@SP
M = M + 1

@5 // ARG = SP - 5 - nArgs
D = A
@SP 
M = A
D = M - D  // D = SP - 5
@ARG13
M = D
@0 // - nArgs
D = A
@ARG13
M = M - D
D = M
@ARG
M = D 

@SP // LCL = SP
D = M 
@LCL
M = D

@Sys.main // goto functionName
0 ; JMP

(RetAddr13) // (returnAddress)

// pop temp 1 (line: 14)
@1 // target = 5+index
D = A
@5
D = D+A
@TEMP14
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@TEMP14
A = M
M = D

// label LOOP (line: 15)
(LOOP) // create a label

// goto LOOP (line: 16)
@LOOP 
0;JEQ

// function Sys.main 5 (line: 26)
(Sys.main) // create function label

@5 // save index to a variable
D = A
@FUNC26
M = D

(STARTSys.main)
@FUNC26 // leave loop if variable is 0
D = M
@EXITSys.main
D;JEQ

@SP // sp* = 0, sp ++
A = M
M = 0
@SP 
M = M + 1
@FUNC26
M = M - 1

@STARTSys.main
0;JMP

(EXITSys.main)

// push constant 4001 (line: 27)
@4001 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop pointer 0 (line: 28)
@SP // SP--, THIS = SP*
M = M-1
A = M
D = M
@THIS
M = D

// push constant 5001 (line: 29)
@5001 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop pointer 1 (line: 30)
@SP // SP--, THAT = SP*
M = M-1
A = M
D = M
@THAT
M = D

// push constant 200 (line: 31)
@200 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop local 1 (line: 32)
@1 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL32
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@LOCAL32
A = M
M = D

// push constant 40 (line: 33)
@40 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop local 2 (line: 34)
@2 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL34
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@LOCAL34
A = M
M = D

// push constant 6 (line: 35)
@6 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop local 3 (line: 36)
@3 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL36
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@LOCAL36
A = M
M = D

// push constant 123 (line: 37)
@123 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// call Sys.add12 1 (line: 38)

@RetAddr38 // push returnAddress(SP ++)
D = M
@SP 
A = M
M = D
@SP
M = M + 1

@LCL // push LCL
D = M 
@SP
A = M
M = D
@SP
M = M + 1

@ARG // push ARG
D = M 
@SP
A = M
M = D
@SP
M = M + 1

@THIS // push THIS
D = M 
@SP
A = M
M = D
@SP
M = M + 1

@THAT // push THAT
D = M 
@SP
A = M
M = D
@SP
M = M + 1

@5 // ARG = SP - 5 - nArgs
D = A
@SP 
M = A
D = M - D  // D = SP - 5
@ARG38
M = D
@1 // - nArgs
D = A
@ARG38
M = M - D
D = M
@ARG
M = D 

@SP // LCL = SP
D = M 
@LCL
M = D

@Sys.add12 // goto functionName
0 ; JMP

(RetAddr38) // (returnAddress)

// pop temp 0 (line: 39)
@0 // target = 5+index
D = A
@5
D = D+A
@TEMP39
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@TEMP39
A = M
M = D

// push local 0 (line: 40)
@0 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL40
M = D
@LOCAL40 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push local 1 (line: 41)
@1 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL41
M = D
@LOCAL41 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push local 2 (line: 42)
@2 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL42
M = D
@LOCAL42 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push local 3 (line: 43)
@3 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL43
M = D
@LOCAL43 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push local 4 (line: 44)
@4 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL44
M = D
@LOCAL44 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// add (line: 45)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// add (line: 46)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// add (line: 47)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// add (line: 48)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// return   (line: 49)
@LCL // endFrame = LCL
D = M
@EndFrame49
M = D

@5 // retAddr = *(endFrame - 5)
D = A
@EndFrame49
D = M - D
A = D
D = M
@RetAddr49
M = D

@SP // *ARG = pop()
M = M - 1
A = M
D = M
@ARG
A = M
M = D

@ARG // SP = ARG + 1
D = M + 1
@SP
M = D

@EndFrame49  // THAT = *(endFrame -1 )
D = M - 1
A = D
D = M
@THAT
M = D

@2  // THIS = *(endFrame -2 )
D = A
@EndFrame49
D = M - D
A = D
D = M
@THIS
M = D

@3 // ARG = *(endFrame -3 )
D = A
@EndFrame49  
D = M - D
A = D
D = M
@ARG
M = D

@4 // LCL = *(endFrame -4 )
D = A
@EndFrame49  
D = M - D
A = D
D = M
@LCL
M = D

@RetAddr49
A = M
0;JMP

// function Sys.add12 0 (line: 55)
(Sys.add12) // create function label

@0 // save index to a variable
D = A
@FUNC55
M = D

(STARTSys.add12)
@FUNC55 // leave loop if variable is 0
D = M
@EXITSys.add12
D;JEQ

@SP // sp* = 0, sp ++
A = M
M = 0
@SP 
M = M + 1
@FUNC55
M = M - 1

@STARTSys.add12
0;JMP

(EXITSys.add12)

// push constant 4002 (line: 56)
@4002 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop pointer 0 (line: 57)
@SP // SP--, THIS = SP*
M = M-1
A = M
D = M
@THIS
M = D

// push constant 5002 (line: 58)
@5002 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop pointer 1 (line: 59)
@SP // SP--, THAT = SP*
M = M-1
A = M
D = M
@THAT
M = D

// push argument 0 (line: 60)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG60
M = D
@ARG60 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 12 (line: 61)
@12 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// add (line: 62)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// return   (line: 63)
@LCL // endFrame = LCL
D = M
@EndFrame63
M = D

@5 // retAddr = *(endFrame - 5)
D = A
@EndFrame63
D = M - D
A = D
D = M
@RetAddr63
M = D

@SP // *ARG = pop()
M = M - 1
A = M
D = M
@ARG
A = M
M = D

@ARG // SP = ARG + 1
D = M + 1
@SP
M = D

@EndFrame63  // THAT = *(endFrame -1 )
D = M - 1
A = D
D = M
@THAT
M = D

@2  // THIS = *(endFrame -2 )
D = A
@EndFrame63
D = M - D
A = D
D = M
@THIS
M = D

@3 // ARG = *(endFrame -3 )
D = A
@EndFrame63  
D = M - D
A = D
D = M
@ARG
M = D

@4 // LCL = *(endFrame -4 )
D = A
@EndFrame63  
D = M - D
A = D
D = M
@LCL
M = D

@RetAddr63
A = M
0;JMP


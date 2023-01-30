// writeInit | SP = 256
@256
D = A
@SP
M = D

// Call Sys.init 0

@RetAddr0 // push returnAddress(SP ++)
D = A
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

@Sys.init // goto functionName
0 ; JMP

(RetAddr0) // (returnAddress)

// function Main.fibonacci 0 (line: 11)
(Main.fibonacci) // create function label

@0 // save index to a variable
D = A
@FUNC11
M = D

(STARTMain.fibonacci)
@FUNC11 // leave loop if variable is 0
D = M
@EXITMain.fibonacci
D;JEQ

@SP // sp* = 0, sp ++
A = M
M = 0
@SP 
M = M + 1
@FUNC11
M = M - 1

@STARTMain.fibonacci
0;JMP

(EXITMain.fibonacci)

// push argument 0 (line: 12)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG12
M = D
@ARG12 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 2 (line: 13)
@2 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// lt (line: 14)
@SP // sp--
M = M-1
@SP // (SP-1)* < SP* ?  
A = M
D = M
@SP
A = M-1
D = M-D
@LT14
D;JLT
@SP // (SP-1)* = 0
A = M-1
M = 0
@END14
0;JEQ
(LT14) // (SP-1)* = -1
@SP
A = M-1
M = -1
(END14)

// if-goto IF_TRUE (line: 15)
@SP // sp --
M = M-1
A = M // D = sp*
D = M
@IF_TRUE
D;JNE

// goto IF_FALSE (line: 16)
@IF_FALSE 
0;JEQ

// label IF_TRUE (line: 17)
(IF_TRUE) // create a label

// push argument 0 (line: 18)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG18
M = D
@ARG18 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// return   (line: 19)
@LCL // endFrame = LCL
D = M
@EndFrame19
M = D

@5 // retAddr = *(endFrame - 5)
D = A
@EndFrame19
D = M - D
A = D
D = M
@RetAddr19
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

@EndFrame19  // THAT = *(endFrame -1 )
D = M - 1
A = D
D = M
@THAT
M = D

@2  // THIS = *(endFrame -2 )
D = A
@EndFrame19
D = M - D
A = D
D = M
@THIS
M = D

@3 // ARG = *(endFrame -3 )
D = A
@EndFrame19  
D = M - D
A = D
D = M
@ARG
M = D

@4 // LCL = *(endFrame -4 )
D = A
@EndFrame19  
D = M - D
A = D
D = M
@LCL
M = D

@RetAddr19
A = M
0;JMP

// label IF_FALSE (line: 20)
(IF_FALSE) // create a label

// push argument 0 (line: 21)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG21
M = D
@ARG21 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 2 (line: 22)
@2 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// sub (line: 23)
@SP // sp--
M = M-1
@SP // (SP-1)* - SP*
A = M
D = M 
@SP
A = M-1
M = M-D

// call Main.fibonacci 1 (line: 24)

@RetAddr24 // push returnAddress(SP ++)
D = A
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
D = M - D  // D = SP - 5
@ARG24
M = D
@1 // - nArgs
D = A
@ARG24
M = M - D
D = M
@ARG
M = D 

@SP // LCL = SP
D = M 
@LCL
M = D

@Main.fibonacci // goto functionName
0 ; JMP

(RetAddr24) // (returnAddress)

// push argument 0 (line: 25)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG25
M = D
@ARG25 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 1 (line: 26)
@1 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// sub (line: 27)
@SP // sp--
M = M-1
@SP // (SP-1)* - SP*
A = M
D = M 
@SP
A = M-1
M = M-D

// call Main.fibonacci 1 (line: 28)

@RetAddr28 // push returnAddress(SP ++)
D = A
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
D = M - D  // D = SP - 5
@ARG28
M = D
@1 // - nArgs
D = A
@ARG28
M = M - D
D = M
@ARG
M = D 

@SP // LCL = SP
D = M 
@LCL
M = D

@Main.fibonacci // goto functionName
0 ; JMP

(RetAddr28) // (returnAddress)

// add (line: 29)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// return   (line: 30)
@LCL // endFrame = LCL
D = M
@EndFrame30
M = D

@5 // retAddr = *(endFrame - 5)
D = A
@EndFrame30
D = M - D
A = D
D = M
@RetAddr30
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

@EndFrame30  // THAT = *(endFrame -1 )
D = M - 1
A = D
D = M
@THAT
M = D

@2  // THIS = *(endFrame -2 )
D = A
@EndFrame30
D = M - D
A = D
D = M
@THIS
M = D

@3 // ARG = *(endFrame -3 )
D = A
@EndFrame30  
D = M - D
A = D
D = M
@ARG
M = D

@4 // LCL = *(endFrame -4 )
D = A
@EndFrame30  
D = M - D
A = D
D = M
@LCL
M = D

@RetAddr30
A = M
0;JMP

// function Sys.init 0 (line: 41)
(Sys.init) // create function label

@0 // save index to a variable
D = A
@FUNC41
M = D

(STARTSys.init)
@FUNC41 // leave loop if variable is 0
D = M
@EXITSys.init
D;JEQ

@SP // sp* = 0, sp ++
A = M
M = 0
@SP 
M = M + 1
@FUNC41
M = M - 1

@STARTSys.init
0;JMP

(EXITSys.init)

// push constant 4 (line: 42)
@4 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// call Main.fibonacci 1 (line: 43)

@RetAddr43 // push returnAddress(SP ++)
D = A
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
D = M - D  // D = SP - 5
@ARG43
M = D
@1 // - nArgs
D = A
@ARG43
M = M - D
D = M
@ARG
M = D 

@SP // LCL = SP
D = M 
@LCL
M = D

@Main.fibonacci // goto functionName
0 ; JMP

(RetAddr43) // (returnAddress)

// label WHILE (line: 44)
(WHILE) // create a label

// goto WHILE (line: 45)
@WHILE 
0;JEQ


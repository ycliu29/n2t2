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

// function Class1.set 0 (line: 7)
(Class1.set) // create function label

@0 // save index to a variable
D = A
@FUNC7
M = D

(STARTClass1.set)
@FUNC7 // leave loop if variable is 0
D = M
@EXITClass1.set
D;JEQ

@SP // sp* = 0, sp ++
A = M
M = 0
@SP 
M = M + 1
@FUNC7
M = M - 1

@STARTClass1.set
0;JMP

(EXITClass1.set)

// push argument 0 (line: 8)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG8
M = D
@ARG8 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop static 0 (line: 9)
@SP // sp--, @Class1.0 = SP*
M = M-1
A = M
D = M
@Class1.0
M = D

// push argument 1 (line: 10)
@1 // target = ARG+index
D = A
@ARG
D = D+M
@ARG10
M = D
@ARG10 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop static 1 (line: 11)
@SP // sp--, @Class1.1 = SP*
M = M-1
A = M
D = M
@Class1.1
M = D

// push constant 0 (line: 12)
@0 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// return   (line: 13)
@LCL // endFrame = LCL
D = M
@EndFrame13
M = D

@5 // retAddr = *(endFrame - 5)
D = A
@EndFrame13
D = M - D
A = D
D = M
@RetAddr13
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

@EndFrame13  // THAT = *(endFrame -1 )
D = M - 1
A = D
D = M
@THAT
M = D

@2  // THIS = *(endFrame -2 )
D = A
@EndFrame13
D = M - D
A = D
D = M
@THIS
M = D

@3 // ARG = *(endFrame -3 )
D = A
@EndFrame13  
D = M - D
A = D
D = M
@ARG
M = D

@4 // LCL = *(endFrame -4 )
D = A
@EndFrame13  
D = M - D
A = D
D = M
@LCL
M = D

@RetAddr13
A = M
0;JMP

// function Class1.get 0 (line: 16)
(Class1.get) // create function label

@0 // save index to a variable
D = A
@FUNC16
M = D

(STARTClass1.get)
@FUNC16 // leave loop if variable is 0
D = M
@EXITClass1.get
D;JEQ

@SP // sp* = 0, sp ++
A = M
M = 0
@SP 
M = M + 1
@FUNC16
M = M - 1

@STARTClass1.get
0;JMP

(EXITClass1.get)

// push static 0 (line: 17)
@Class1.0 // SP* = @Class1.0, SP++
D = M
@SP
A = M
M = D
@SP
M = M+1

// push static 1 (line: 18)
@Class1.1 // SP* = @Class1.1, SP++
D = M
@SP
A = M
M = D
@SP
M = M+1

// sub (line: 19)
@SP // sp--
M = M-1
@SP // (SP-1)* - SP*
A = M
D = M 
@SP
A = M-1
M = M-D

// return   (line: 20)
@LCL // endFrame = LCL
D = M
@EndFrame20
M = D

@5 // retAddr = *(endFrame - 5)
D = A
@EndFrame20
D = M - D
A = D
D = M
@RetAddr20
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

@EndFrame20  // THAT = *(endFrame -1 )
D = M - 1
A = D
D = M
@THAT
M = D

@2  // THIS = *(endFrame -2 )
D = A
@EndFrame20
D = M - D
A = D
D = M
@THIS
M = D

@3 // ARG = *(endFrame -3 )
D = A
@EndFrame20  
D = M - D
A = D
D = M
@ARG
M = D

@4 // LCL = *(endFrame -4 )
D = A
@EndFrame20  
D = M - D
A = D
D = M
@LCL
M = D

@RetAddr20
A = M
0;JMP

// function Sys.init 0 (line: 28)
(Sys.init) // create function label

@0 // save index to a variable
D = A
@FUNC28
M = D

(STARTSys.init)
@FUNC28 // leave loop if variable is 0
D = M
@EXITSys.init
D;JEQ

@SP // sp* = 0, sp ++
A = M
M = 0
@SP 
M = M + 1
@FUNC28
M = M - 1

@STARTSys.init
0;JMP

(EXITSys.init)

// push constant 6 (line: 29)
@6 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 8 (line: 30)
@8 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// call Class1.set 2 (line: 31)

@RetAddr31 // push returnAddress(SP ++)
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
@ARG31
M = D
@2 // - nArgs
D = A
@ARG31
M = M - D
D = M
@ARG
M = D 

@SP // LCL = SP
D = M 
@LCL
M = D

@Class1.set // goto functionName
0 ; JMP

(RetAddr31) // (returnAddress)

// pop temp 0 (line: 32)
@0 // target = 5+index
D = A
@5
D = D+A
@TEMP32
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@TEMP32
A = M
M = D

// push constant 23 (line: 33)
@23 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 15 (line: 34)
@15 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// call Class2.set 2 (line: 35)

@RetAddr35 // push returnAddress(SP ++)
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
@ARG35
M = D
@2 // - nArgs
D = A
@ARG35
M = M - D
D = M
@ARG
M = D 

@SP // LCL = SP
D = M 
@LCL
M = D

@Class2.set // goto functionName
0 ; JMP

(RetAddr35) // (returnAddress)

// pop temp 0 (line: 36)
@0 // target = 5+index
D = A
@5
D = D+A
@TEMP36
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@TEMP36
A = M
M = D

// call Class1.get 0 (line: 37)

@RetAddr37 // push returnAddress(SP ++)
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
@ARG37
M = D
@0 // - nArgs
D = A
@ARG37
M = M - D
D = M
@ARG
M = D 

@SP // LCL = SP
D = M 
@LCL
M = D

@Class1.get // goto functionName
0 ; JMP

(RetAddr37) // (returnAddress)

// call Class2.get 0 (line: 38)

@RetAddr38 // push returnAddress(SP ++)
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
@ARG38
M = D
@0 // - nArgs
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

@Class2.get // goto functionName
0 ; JMP

(RetAddr38) // (returnAddress)

// label WHILE (line: 39)
(WHILE) // create a label

// goto WHILE (line: 40)
@WHILE 
0;JEQ

// function Class2.set 0 (line: 47)
(Class2.set) // create function label

@0 // save index to a variable
D = A
@FUNC47
M = D

(STARTClass2.set)
@FUNC47 // leave loop if variable is 0
D = M
@EXITClass2.set
D;JEQ

@SP // sp* = 0, sp ++
A = M
M = 0
@SP 
M = M + 1
@FUNC47
M = M - 1

@STARTClass2.set
0;JMP

(EXITClass2.set)

// push argument 0 (line: 48)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG48
M = D
@ARG48 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop static 0 (line: 49)
@SP // sp--, @Class2.0 = SP*
M = M-1
A = M
D = M
@Class2.0
M = D

// push argument 1 (line: 50)
@1 // target = ARG+index
D = A
@ARG
D = D+M
@ARG50
M = D
@ARG50 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop static 1 (line: 51)
@SP // sp--, @Class2.1 = SP*
M = M-1
A = M
D = M
@Class2.1
M = D

// push constant 0 (line: 52)
@0 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// return   (line: 53)
@LCL // endFrame = LCL
D = M
@EndFrame53
M = D

@5 // retAddr = *(endFrame - 5)
D = A
@EndFrame53
D = M - D
A = D
D = M
@RetAddr53
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

@EndFrame53  // THAT = *(endFrame -1 )
D = M - 1
A = D
D = M
@THAT
M = D

@2  // THIS = *(endFrame -2 )
D = A
@EndFrame53
D = M - D
A = D
D = M
@THIS
M = D

@3 // ARG = *(endFrame -3 )
D = A
@EndFrame53  
D = M - D
A = D
D = M
@ARG
M = D

@4 // LCL = *(endFrame -4 )
D = A
@EndFrame53  
D = M - D
A = D
D = M
@LCL
M = D

@RetAddr53
A = M
0;JMP

// function Class2.get 0 (line: 56)
(Class2.get) // create function label

@0 // save index to a variable
D = A
@FUNC56
M = D

(STARTClass2.get)
@FUNC56 // leave loop if variable is 0
D = M
@EXITClass2.get
D;JEQ

@SP // sp* = 0, sp ++
A = M
M = 0
@SP 
M = M + 1
@FUNC56
M = M - 1

@STARTClass2.get
0;JMP

(EXITClass2.get)

// push static 0 (line: 57)
@Class2.0 // SP* = @Class2.0, SP++
D = M
@SP
A = M
M = D
@SP
M = M+1

// push static 1 (line: 58)
@Class2.1 // SP* = @Class2.1, SP++
D = M
@SP
A = M
M = D
@SP
M = M+1

// sub (line: 59)
@SP // sp--
M = M-1
@SP // (SP-1)* - SP*
A = M
D = M 
@SP
A = M-1
M = M-D

// return   (line: 60)
@LCL // endFrame = LCL
D = M
@EndFrame60
M = D

@5 // retAddr = *(endFrame - 5)
D = A
@EndFrame60
D = M - D
A = D
D = M
@RetAddr60
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

@EndFrame60  // THAT = *(endFrame -1 )
D = M - 1
A = D
D = M
@THAT
M = D

@2  // THIS = *(endFrame -2 )
D = A
@EndFrame60
D = M - D
A = D
D = M
@THIS
M = D

@3 // ARG = *(endFrame -3 )
D = A
@EndFrame60  
D = M - D
A = D
D = M
@ARG
M = D

@4 // LCL = *(endFrame -4 )
D = A
@EndFrame60  
D = M - D
A = D
D = M
@LCL
M = D

@RetAddr60
A = M
0;JMP


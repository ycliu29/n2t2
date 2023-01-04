// function SimpleFunction.test 2 (line: 7)
(SimpleFunction.test) // create function label
@SP // set LCL = SP
D = M 
@LCL 
M = D

@2 // save index to a variable
D = A
@FUNC7
M = D

(STARTSimpleFunction.test)
@FUNC7 // leave loop if variable is 0
D = M
@EXITSimpleFunction.test
D;JEQ

@SP // sp* = 0, sp ++
A = M
M = 0
@SP 
M = M + 1
@FUNC7
M = M - 1

@STARTSimpleFunction.test
0;JMP

(EXITSimpleFunction.test)

// push local 0 (line: 8)
@0 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL8
M = D
@LOCAL8 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push local 1 (line: 9)
@1 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL9
M = D
@LOCAL9 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// add (line: 10)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// not (line: 11)
@SP // (SP-1)* = !(SP-1)*
A = M-1
M = !M

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

// add (line: 13)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// push argument 1 (line: 14)
@1 // target = ARG+index
D = A
@ARG
D = D+M
@ARG14
M = D
@ARG14 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// sub (line: 15)
@SP // sp--
M = M-1
@SP // (SP-1)* - SP*
A = M
D = M 
@SP
A = M-1
M = M-D

// return   (line: 16)
@LCL // endFrame = LCL
D = M
@endFrame16
M = D

@5 // retAddr = *(endFrame - 5)
D = A
@endFrame16
D = M - D
A = D
D = M
@retAddr16
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

@endFrame16  // THAT = *(endFrame -1 )
D = M - 1
A = D
D = M
@THAT
M = D

@2  // THIS = *(endFrame -2 )
D = A
@endFrame16
D = M - D
A = D
D = M
@THIS
M = D

@3 // ARG = *(endFrame -3 )
D = A
@endFrame16  
D = M - D
A = D
D = M
@ARG
M = D

@4 // LCL = *(endFrame -4 )
D = A
@endFrame16  
D = M - D
A = D
D = M
@LCL
M = D

@retAddr16
0;JMP


// push constant 3030 (line: 8)
@3030 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1
// pop pointer 0 (line: 9)
@SP // SP--, THIS = SP*
M = M-1
A = M
D = M
@THIS
M = D
// push constant 3040 (line: 10)
@3040 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1
// pop pointer 1 (line: 11)
@SP // SP--, THAT = SP*
M = M-1
A = M
D = M
@THAT
M = D
// push constant 32 (line: 12)
@32 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1
// pop this 2 (line: 13)
@2 // target = THIS+index
D = A
@THIS
D = D+M
@THIS13
M = D

@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@THIS13
A = M
M = D
// push constant 46 (line: 14)
@46 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1
// pop that 6 (line: 15)
@6 // target = THAT+index
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
// push pointer 0 (line: 16)
@THIS // *SP = THIS, SP++
D = M
@SP
A = M
M = D
@SP
M = M+1
// push pointer 1 (line: 17)
@THAT // *SP = THAT, SP++
D = M
@SP
A = M
M = D
@SP
M = M+1
// add (line: 18)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D
// push this 2 (line: 19)
@2 // target = THIS+index
D = A
@THIS
D = D+M
@THIS19
M = D

@THIS19 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1
// sub (line: 20)
@SP // sp--
M = M-1
@SP // (SP-1)* - SP*
A = M
D = M 
@SP
A = M-1
M = M-D
// push that 6 (line: 21)
@6 // target = THAT+index
D = A
@THAT
D = D+M
@THAT21
M = D

@THAT21 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1
// add (line: 22)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

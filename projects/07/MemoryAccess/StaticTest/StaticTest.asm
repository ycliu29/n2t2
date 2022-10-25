// push constant 111 (line: 7)
@111 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1
// push constant 333 (line: 8)
@333 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1
// push constant 888 (line: 9)
@888 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1
// pop static 8 (line: 10)
@SP // sp--, @StaticTest.8 = SP*
M = M-1
A = M
D = M
@StaticTest.8
M = D
// pop static 3 (line: 11)
@SP // sp--, @StaticTest.3 = SP*
M = M-1
A = M
D = M
@StaticTest.3
M = D
// pop static 1 (line: 12)
@SP // sp--, @StaticTest.1 = SP*
M = M-1
A = M
D = M
@StaticTest.1
M = D
// push static 3 (line: 13)
@StaticTest.3 // SP* = @StaticTest.3, SP++
D = M
@SP
A = M
M = D
@SP
M = M+1
// push static 1 (line: 14)
@StaticTest.1 // SP* = @StaticTest.1, SP++
D = M
@SP
A = M
M = D
@SP
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
// push static 8 (line: 16)
@StaticTest.8 // SP* = @StaticTest.8, SP++
D = M
@SP
A = M
M = D
@SP
M = M+1
// add (line: 17)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

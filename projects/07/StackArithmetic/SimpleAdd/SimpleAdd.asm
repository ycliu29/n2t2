// push constant 7
@7 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 8
@8 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// add
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D


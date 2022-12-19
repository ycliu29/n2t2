// push constant 0 (line: 9)
@0 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// pop local 0 (line: 10)
@0 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL10
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@LOCAL10
A = M
M = D

{:commandType=>"C_LABEL", :arg1=>nil, :segment=>nil, :index=>nil}// push argument 0 (line: 12)
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

// push local 0 (line: 13)
@0 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL13
M = D
@LOCAL13 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// add (line: 14)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// pop local 0 (line: 15)
@0 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL15
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@LOCAL15
A = M
M = D

// push argument 0 (line: 16)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG16
M = D
@ARG16 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 1 (line: 17)
@1 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// sub (line: 18)
@SP // sp--
M = M-1
@SP // (SP-1)* - SP*
A = M
D = M 
@SP
A = M-1
M = M-D

// pop argument 0 (line: 19)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG19
M = D
@SP // sp--
M = M-1
A = M // target* = sp*
D = M 
@ARG19
A = M
M = D

// push argument 0 (line: 20)
@0 // target = ARG+index
D = A
@ARG
D = D+M
@ARG20
M = D
@ARG20 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1

{:commandType=>"C_IF", :arg1=>nil, :segment=>nil, :index=>nil}// push local 0 (line: 22)
@0 // target = LCL+index
D = A
@LCL
D = D+M
@LOCAL22
M = D
@LOCAL22 // sp* = target*
A = M
D = M
@SP
A = M
M = D
@SP // sp++
M = M+1


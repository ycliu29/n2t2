// push constant 17 (line: 8)
@17 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 17 (line: 9)
@17 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// eq (line: 10)
@SP // sp--
M = M-1
@SP // SP* == (SP-1)* ?
A = M
D = M
@SP
A = M-1
D = D-M
@EQ10
D;JEQ
@SP // (SP-1)* = 0
A = M-1
M = 0
@END10
0;JEQ
(EQ10) // (SP-1)* = -1
@SP
A = M-1
M = -1
(END10)

// push constant 17 (line: 11)
@17 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 16 (line: 12)
@16 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// eq (line: 13)
@SP // sp--
M = M-1
@SP // SP* == (SP-1)* ?
A = M
D = M
@SP
A = M-1
D = D-M
@EQ13
D;JEQ
@SP // (SP-1)* = 0
A = M-1
M = 0
@END13
0;JEQ
(EQ13) // (SP-1)* = -1
@SP
A = M-1
M = -1
(END13)

// push constant 16 (line: 14)
@16 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 17 (line: 15)
@17 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// eq (line: 16)
@SP // sp--
M = M-1
@SP // SP* == (SP-1)* ?
A = M
D = M
@SP
A = M-1
D = D-M
@EQ16
D;JEQ
@SP // (SP-1)* = 0
A = M-1
M = 0
@END16
0;JEQ
(EQ16) // (SP-1)* = -1
@SP
A = M-1
M = -1
(END16)

// push constant 892 (line: 17)
@892 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 891 (line: 18)
@891 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// lt (line: 19)
@SP // sp--
M = M-1
@SP // (SP-1)* < SP* ?  
A = M
D = M
@SP
A = M-1
D = M-D
@LT19
D;JLT
@SP // (SP-1)* = 0
A = M-1
M = 0
@END19
0;JEQ
(LT19) // (SP-1)* = -1
@SP
A = M-1
M = -1
(END19)

// push constant 891 (line: 20)
@891 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 892 (line: 21)
@892 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// lt (line: 22)
@SP // sp--
M = M-1
@SP // (SP-1)* < SP* ?  
A = M
D = M
@SP
A = M-1
D = M-D
@LT22
D;JLT
@SP // (SP-1)* = 0
A = M-1
M = 0
@END22
0;JEQ
(LT22) // (SP-1)* = -1
@SP
A = M-1
M = -1
(END22)

// push constant 891 (line: 23)
@891 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 891 (line: 24)
@891 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// lt (line: 25)
@SP // sp--
M = M-1
@SP // (SP-1)* < SP* ?  
A = M
D = M
@SP
A = M-1
D = M-D
@LT25
D;JLT
@SP // (SP-1)* = 0
A = M-1
M = 0
@END25
0;JEQ
(LT25) // (SP-1)* = -1
@SP
A = M-1
M = -1
(END25)

// push constant 32767 (line: 26)
@32767 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 32766 (line: 27)
@32766 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// gt (line: 28)
@SP // sp--
M = M-1
@SP // (SP-1)* > SP* ?  
A = M
D = M
@SP
A = M-1
D = M-D
@GT28
D;JGT
@SP // (SP-1)* = 0
A = M-1
M = 0
@END28
0;JEQ
(GT28) // (SP-1)* = -1
@SP
A = M-1
M = -1
(END28)

// push constant 32766 (line: 29)
@32766 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 32767 (line: 30)
@32767 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// gt (line: 31)
@SP // sp--
M = M-1
@SP // (SP-1)* > SP* ?  
A = M
D = M
@SP
A = M-1
D = M-D
@GT31
D;JGT
@SP // (SP-1)* = 0
A = M-1
M = 0
@END31
0;JEQ
(GT31) // (SP-1)* = -1
@SP
A = M-1
M = -1
(END31)

// push constant 32766 (line: 32)
@32766 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 32766 (line: 33)
@32766 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// gt (line: 34)
@SP // sp--
M = M-1
@SP // (SP-1)* > SP* ?  
A = M
D = M
@SP
A = M-1
D = M-D
@GT34
D;JGT
@SP // (SP-1)* = 0
A = M-1
M = 0
@END34
0;JEQ
(GT34) // (SP-1)* = -1
@SP
A = M-1
M = -1
(END34)

// push constant 57 (line: 35)
@57 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 31 (line: 36)
@31 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// push constant 53 (line: 37)
@53 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// add (line: 38)
@SP // sp--
M = M-1
@SP // SP* + (SP-1)*
A = M
D = M
@SP
A = M-1
M = M+D

// push constant 112 (line: 39)
@112 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// sub (line: 40)
@SP // sp--
M = M-1
@SP // (SP-1)* - SP*
A = M
D = M 
@SP
A = M-1
M = M-D

// neg (line: 41)
@SP
A = M-1
M = -M

// and (line: 42)
@SP // sp--
M = M-1
A = M // (SP-1)* = SP* and (SP-1)*
D = M
@SP
A = M-1
M = D&M

// push constant 82 (line: 43)
@82 // *sp = i
D = A
@SP
A = M
M = D
@SP // sp++
M = M+1

// or (line: 44)
@SP // sp--
M = M-1
A = M // (SP-1)* = SP* or (SP-1)*
D = M
@SP
A = M-1
M = D|M

// not (line: 45)
@SP // (SP-1)* = !(SP-1)*
A = M-1
M = !M


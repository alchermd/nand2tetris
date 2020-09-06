// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Return zero if either operands are zero
@R0
D=M
@ZERO
D; JEQ
@R1
D=M
@ZERO
D; JEQ

// Start the counter as R1
@R1
D=M
@counter
M=D

(LOOP)
    @counter
    D=M
    @tmp
    D=D-1
    @STOP
    D; JLT // if counter is below zero, STOP the loop

    @sum
    D=M
    @R0
    D=D+M
    @sum
    M=D // sum += R0
    @counter
    M=M-1 // counter--
    @LOOP
    0; JMP

(ZERO)
    @R2
    M=0
    
    @END
    0; JMP

(STOP)
    @sum
    D=M
    @R2
    M=D
    @sum
    M=0
    
    @END
    0; JMP

(END)
    @END
    0; JMP
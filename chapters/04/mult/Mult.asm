// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

    // Variable initializations
    // i = 1
    @i
    M=1
    // R2 = 0
    @R2
    M=0

(LOOP)
    // Jump to END if (i - R1 > 0)
    @i
    D=M
    @R1
    D=D-M
    @END
    D;JGT

    // m += R0
    // i++
    @R0
    D=M
    @R2
    M=M+D
    @i
    M=M+1

    // Jump back to the start of the LOOP
    @LOOP
    0;JMP
(END)
    // Infinite loop
    @END
    0;JMP

    // Variable initializations
    // i = 1
    @i
    M=1
    // sum = 0
    @sum
    M=0

(LOOP)
    // Jump to END if (i - 100 > 0)
    @i
    D=M
    @100
    D=D-A
    @END
    D;JGT

    // sum += i
    // i++
    @i
    D=M
    @sum
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

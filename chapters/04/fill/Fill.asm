// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

(LOOP)
    // Initialize variables.
    // i=0
    @i
    M=0
    // j=0
    @j
    M=0
    // width=256
    @8192
    D=A
    @width
    M=D
    // height=8192
    @8192
    D=A
    @height
    M=D

    (WIDTHLOOP)
        // Jump out if (i - width > 0)
        @i
        D=M
        @width
        D=D-M
        @WIDTHLOOPEND
        D;JGT

        (HEIGHTLOOP)
            // Jump out if (j - height > 0)
            @j
            D=M
            @height
            D=D-M
            @HEIGHTLOOPEND
            D;JGT

            // Listen to keypress.
            // Clear if no key pressed,
            // Write black otherwise.
            @KBD
            D=M
            @CLEAR
            D;JEQ
            @WRITE
            0;JMP

            (WRITE)
                // Write to SCREEN+i+j
                @SCREEN
                D=A
                @i
                D=D+M
                @j
                D=D+M
                A=D
                M=-1
                @POSTCHOICE
                0;JMP
            (CLEAR)
                // Write to SCREEN+i+j
                @SCREEN
                D=A
                @i
                D=D+M
                @j
                D=D+M
                A=D
                M=0
                @POSTCHOICE
                0;JMP

            (POSTCHOICE)

            // j++
            @j
            M=M+1

            // Repeat loop
            @HEIGHTLOOP
            0;JMP

        (HEIGHTLOOPEND)
        // i++
        @i
        M=M+1

        // Repeat loop
        @WIDTHLOOP
        0;JMP

    (WIDTHLOOPEND)
        // Infinite loop.
        @LOOP
        0;JMP

// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

(ONPRESS)
    // Writes 1 to R0 when a key is pressed.
    // TODO: Write to the screen instead.
    @R0
    M=1
    @POSTKEYPRESSCHECK
    0;JMP

(ONRELEASE)
    // Writes 0 to R0 when a key is pressed.
    // TODO: Write to the screen instead.
    @R0
    M=0
    @POSTKEYPRESSCHECK
    0;JMP

(LOOP)
    // Listen to keypress.
    @KBD
    D=M
    @ONPRESS
    D;JNE
    @ONRELEASE
    D; JEQ

    (POSTKEYPRESSCHECK)

    // Infinite loop.
    @LOOP
    0;JMP

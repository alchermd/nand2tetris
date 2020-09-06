// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(MAIN_LOOP)
    @8192
    D=A
    @n
    M=D // n = 8192

    @i
    M=0 // i = 0

    
    @SCREEN
    D=A
    @addr
    M=D // addr = screen's memory address
    
    // Get the current key pressed
    @KBD
    D=M

    // Write the screen as black if any key is pressed
    @WRITE_BLACK
    D; JGT

    // Write it as white otherwise
    @WRITE_WHITE
    D; JEQ

    @MAIN_LOOP
    0; JMP

    
(WRITE_WHITE)
    @i
    D=M
    @n
    D=D-M
    @MAIN_LOOP
    D; JEQ // if i == n goto MAIN_LOOP

    @addr
    A=M
    M=0 // RAM[addr]=0000000000000000

    @i
    M=M+1 // i++
    @addr
    M=M+1 // addr++
    @WRITE_WHITE
    0; JMP

(WRITE_BLACK)
    @i
    D=M
    @n
    D=D-M
    @MAIN_LOOP
    D; JEQ // if i == n goto MAIN_LOOP

    @addr
    A=M
    M=-1 // RAM[addr]=1111111111111111

    @i
    M=M+1 // i++
    @addr
    M=M+1 // addr++
    @WRITE_BLACK
    0; JMP


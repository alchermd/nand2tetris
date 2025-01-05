# Chapter 4 - Machine Language

A computer system's machine language is a formalism that is used to code low-level programs that executes on the
underlying hardware.

![](./img/cpu-reg-mem.png)

In terms of what the machine language does, it works on the `CPU`, a set of Registers, and Memory. A `CPU` fetches and
stores instructions and/or data into the Memory. For faster access to data, a set of registers are in the `CPU`'s
proximity.

### Language

**Note**: the language described in the following sections is a generic representation of what machine and assembly language looks like. Notes about the actual _Hack_ machine language is further down below.

A machine language is a readable translation of a computer instruction. On a 16-bit computer, an instruction could read
like:

```
1010001100011001
```

This could be read as four 4-bit pairs, each specifying a particular part of an instruction:

```
1010 Specifies that this is an addition instruction.
0011 Specifies that the result will be saved to Register 3
0001 Specifies the first operand is the value at Register 1
1001 and the second is at Register 9
```

The symbolic mnemonics of the language might produce the following machine language instruction:

```
ADD R3, R1, R9
```

These instructions can be fed to an _assembler_ program which will translate it back to its binary form.

### Commands

- Arithmetic and logic operations:

```
ADD R2, R1, R3   // R2 <- R1+R3
ADD R2, R1, foo  // R2 <- R1+foo (user-defined address)
AND R1, R1, R2   // R1 <- R1&R2
```

- Direct memory access:

```
LOAD R1, 67  // R1 <- M[67]
LOAD R1, bar // R1 <- M[67], assuming bar=67
```

- Immediate addressing:

```
LOADI R1, 67 // R1 <- 67 (constant value)
```

- Indirect addressing (pointers):

``` 
// x=foo[j]
ADD R1, foo, j // R1 <- foo + j (or foo[j])
LOAD* R2, R1   // R2 <- M[R1]
STR R2, x      // x <- R2
```

- Flow control (jumps)

The code block below written in C:

```c
while (R1 >= 0) {
    // code segment 1
}
// code segment 2
```

... is loosely translated to this assembly code:

```
while:
    JNG R1, endWhile
    // code segment 1
    JMP while
endWhile:
    // code segment 2
```

## Hack Machine Language

### Memory Address Space

There are two address spaces: an _instruction memory_ and _data memory_ space. Both are 16-bit wide and 15-bit
addressable.

The `CPU` can only read instructions from the instruction memory. It is a read-only device, and programs can be loaded
onto it via the hardware simulator.

### Registers

There are two 16-bit registers, the `D` and `A` registers. The `D` register can only store data, while the `A` register
can also store addresses. Given that addresses are 15-bits and Hack is a 16-bit platform, then there's not enough space
to store the commands _and_ the address it will work on. Thus, a constant `M` is used to specify the data on the current
value of the `A` register:

```
// D = M[512] + 1
A=512
D=M+1 // M refers to M[A] or M[512]
```

`A` is also used for jump instructions. In the same vein as memory addressing, storing the address in `A` and using a
jump command afterward will move the program execution on the `InstructionMemory[A]`

``` 
@foo
M=512
0;JMP // jumps to M[12]
```

An assembly program for counting `1+...+100` can be found in [Count.asm](./Count.asm).

### Instructions

There are two types of instructions in the Hack assembly language: the `A` instruction (address) and `C` instruction (
compute).

#### A Instruction

An `A` instruction is an instruction that stores a 15-bit value to the `A` register. An example of an `A` instruction is
`0000 0000 0000 0111`:

``` 
0000 // The first zero means that this is an A instruction
0000
0000
0111 // The next 15-bits is the value to be stored, which in
     // this case is the binary representation of 7.
// This example is equivalent to A=7
```

The instruction above is equivalent to `@7` in assembly.

#### C Instruction

A `C` instruction contains information that states:

1. What to compute?
2. Where to store the data?
3. What to do next?

```
111      // The first 1 means that this is an A instruction. The next two are not used.
0001110  // The next 7 bits controls what compute function to use.
         // This example computes D-1.
100      // The next 3 bits controls where to store the function's result.
         // This example stores it in the A register.
000      // The last 3 bits controls what type of jump to do.
         // This example does a null jump.
// This example is equivalent to A=D-1
```

The instruction above is equivalent to

```
@foo
M=D-1
```

### Special symbols

| Symbol | Description                               |
|--------|-------------------------------------------|
| R0-R15 | Refers to the 16 RAM registers.           |
| SP     | Alias to R0                               |
| LCL    | Alias to R1                               |
| ARG    | Alias to R2                               |
| THIS   | Alias to R3                               |
| THAT   | Alias to R4                               |
| SCREEN | Alias to RAM[16384]                       |
| KBD    | Alias to RAM[24576]                       |
| (foo)  | Label symbol used for code segments/jumps |    
| @bar   | User-defined variable symbol              |   

### Input and Output

The Hack platform is connected to a screen and keyboard. These are memory-mapped devices, which means writing and reading are done by flipping bits into their respective memory spaces. For example, drawing a particular pixel is done by writing to that pixel's particular memory address. A keyboard press is detected by whether a bit is 0/1.

#### Screen

The screen is a 256x512 pixel device. Its full address is `SCREEN` + 16K. Each row of the screen consists of 16 x 16-bits.

#### Keyboard

The currently pressed key's code is found at `KBD`. If no key is pressed, it defaults to 0.

### Project

#### Mult

The [Mult.asm](./mult/Mult.asm) program takes the values in `R0` and `R1`, multiply them, and store the result in `R2`.

This should be similar to how [Count.asm](./Count.asm) is implemented.

**Hindsight**: The tricky part is the difference between `A` and `M`.

```
// Jump to END if (i - R1 > 0)
@i
D=M
@R1
D=D-A // This is incorrect, as this is equivalent to D=i-1
@END
D;JGT
```
This can be easily overlooked when using the Count.asm program as the base point. Remember, setting the A register to a constant and then accessing it via `A` is a different thing than setting the register to an address and accessing the _value on that address_ (pointers) via `M`.

```
// Jump to END if (i - R1 > 0)
@i
D=M
@R1
D=D-M // Fixed, as this does D=i-R1
@END
D;JGT
```

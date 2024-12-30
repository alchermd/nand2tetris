# Chapter 1 - Boolean Logic

## Boolean Functions
Elementary gates such as `AND`, `OR`, and `NOT` gates are physical implementations of _boolean functions_. A boolean
function operates on binary inputs (`1` or `0`) and returns binary outputs. A boolean function can be described in a
number of ways.

### Truth Table

A truth table is a list of all possible inputs and their respective outputs of a boolean function. Below is the truth
table for the `AND` boolean function.

| x | y | out |
|---|---|-----|
| 0 | 0 | 0   |
| 1 | 0 | 0   |
| 0 | 1 | 0   |
| 1 | 1 | 1   |

### Boolean expressions

A boolean function can also be described by using boolean operators (`AND`, `OR`, `NOT`) over its input. The `NOR`
boolean function can then be written as:

```
NOT (x OR y)
```

Mathematical symbols are also used to construct these expressions

| Operator | Symbol | Example (each line are equivalent) |
|----------|--------|------------------------------------|
| `AND`    | `*`    | `x AND y`<br/> `x * y`<br/> `xy`   | 
| `OR`     | `+`    | `x OR y` <br/> `x + y`             |
| `NOT`    | `!`    | `NOT x` <br/> `!x`                 |

Note: Adding a dash on top of the variable (ex: `x̄`)is the common symbol for `NOT`, but typing it would be very
tedious, so I decided to use the more programming-prevalent `!`  instead.

As stated in the `NAND` example, parentheses are used to group operations so it follows the usual order of operations.

### Canonical Representation

A boolean function can always be reduced to its canonical representation by `AND`-ing all the rows in its truth table
that has the value of `1`. In essence, this means that all boolean function, regardless of complexity, can be
constructed by `AND`, `OR`, and `NOT` operators.

| x | y | out |
|---|---|-----|
| 0 | 0 | 1   |
| 1 | 0 | 0   |
| 0 | 1 | 1   |
| 1 | 1 | 1   |

As an example, the boolean function described with the truth table above has three rows that has the `1` output. Its
canonical representation is the following expression:

```
(!x * !y) * (!x * y) * (xy)
```

Note: this boolean function does the _"if x then y"_ operation.

### Possible functions for two boolean inputs

There are only 16 possible combinations for two boolean inputs.

![](./img/functions.png)

### The special property of NAND

Although not unique to `NAND`, a special property of it is that `OR`, `AND`, and `NOT` can be constructed by `NAND` operations alone. And with these operations, all possible boolean functions can be implemented. This implies that with a sufficient number of `NAND` gates, we can construct increasingly complex gates and components, allowing us to build a computer that can run programs such as Tetris. Thus, nand2tetris 🙂

## Gate Logic

The term _gate_ is already used in the prior text. To give it a definition, we can say that it is a physical implementation of a boolean function. If a boolean function operates on two variables and produces one result, then its gate implementation will work on two _inputs_ and produce one _output_.

The terms _gates_ and _chips_ are used interchangeably, with _gates_ used for the basic / elementary chips.

![](./img/elementary-gates.png)

### Primitive and Composite Gates

A _primitive gate_ is a standalone gate that is readily available to the designer. These primitive gates can be combined to build and satisfy the specifications of a more complex composite gate.

![](./img/primitive-composite-gates.png)

### Hardware Description Language

In order to build out the chips in this project, a Hardware Simulator that can read and run programs written in a Hardware Description Language (HDL) is supplied by the authors. Combined with the provided test scripts, this allows test-driven implementation of the chips required.

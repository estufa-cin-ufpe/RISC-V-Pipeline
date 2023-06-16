# Simulation Results

## SW

We conducted a simulation using the instructions provided in the file [sw.mif](sw.mif) and the testbench [tb_top](/verif/tb_top.sv) to evaluate the pipeline's functionality.

Also, a 32-bit data memory was introduced. The data memory is initialized with the contents of the file [data.mif](data.mif).

The obtained result matches the expected outcome, which can be verified below.

### Instructions Tested

The simulation included testing the following instructions:

```assembly
addi x7,x0,-1
sw x7,0(x0)
lw x9,0(x0)
```

### Registers/Memory State after each instruction

The following information is extracted from the simulation log and can be interpreted as demonstrated in the example below:

```shell
tt: Register [x] written with value: [hhhhhhhh] | [dddddddd]
tt: Memory [x] read with value: [hhhhhhhh] | [dddddddd]
tt: Memory [x] written with value: [hhhhhhhh] | [dddddddd]
```

In the above example, `tt` represents the simulation time, `x` represents the register/memory address number, `hhhhhhhh` represents the hexadecimal value stored in the register/memory slot, and `dddddddd` represents the same value in decimal.

---

```shell
45: Memory [  0] written with value: [ffffffff] | [4294967295]
45: Register [ 7] written with value: [ffffffff] | [4294967295]
55: Memory [  0] read with value: [xxxxxxxx] | [         x]
55: Memory [  0] read with value: [ffffaa80] | [4294945408]
60: Memory [  0] read with value: [ffffffff] | [4294967295]
65: Register [ 9] written with value: [ffffffff] | [4294967295]
```

## SB, SH

- [sb-sh.mif](sb-sh.mif)

### Instructions Tested

```assembly
addi x7,x0,0
sb x7,2(x0)
lw x9,0(x0)
sh x7,2(x0)
lw x8,0(x0)
```

### Registers/Memory State after each instruction

```shell
45: Memory [  2] written with value: [00000000] | [         0]
45: Register [ 7] written with value: [00000000] | [         0]
55: Memory [  0] read with value: [xxxxxxxx] | [         x]
55: Memory [  0] read with value: [0000ffff] | [     65535]
60: Memory [  0] read with value: [ff00aa80] | [4278233728]
65: Memory [  2] written with value: [00000000] | [         0]
65: Register [ 9] written with value: [ff00aa80] | [4278233728]
75: Memory [  0] read with value: [ff00aa80] | [4278233728]
75: Memory [  0] read with value: [0000ffff] | [     65535]
80: Memory [  0] read with value: [0000aa80] | [     43648]
85: Register [ 8] written with value: [0000aa80] | [     43648]
```

# Simulation Results

## LB, LH, LW

We conducted a simulation using the instructions provided in the file [instruction.mif](instruction.mif) and the testbench [tb_top](/verif/tb_top.sv) to evaluate the pipeline's functionality.

Also, a 32-bit data memory was introduced. The data memory is initialized with the contents of the file [data.mif](data.mif).

The obtained result matches the expected outcome, which can be verified below.

### Instructions Tested

The simulation included testing the following instructions:

```assembly
addi x7,x0,1
addi x2,x0,4
or x4,x2,x0
lb x6,0(x7)
add x6,x4,x0
lb x7,0(x6)
lh x8,0(x6)
lw x9,0(x6)
```

### Registers/Memory State after each instruction

The following information is extracted from the simulation log and can be interpreted as demonstrated in the example below:

```shell
tt: Register [x] written with value: [hhhhhhhh] | [dddddddd]
tt: Memory [x] read with value: [hhhhhhhh] | [dddddddd]
```

In the above example, `tt` represents the simulation time, `x` represents the register/memory address number, `hhhhhhhh` represents the hexadecimal value stored in the register/memory slot, and `dddddddd` represents the same value in decimal.

---

```shell
45: Register [ 7] written with value: [00000001] | [         1]
55: Register [ 2] written with value: [00000004] | [         4]
65: Memory [  1] read with value: [xxxxxxxx] | [         x]
65: Register [ 4] written with value: [00000004] | [         4]
65: Memory [  1] read with value: [ffffffff] | [4294967295]
70: Memory [  1] read with value: [ffffff8f] | [4294967183]
75: Register [ 6] written with value: [ffffff8f] | [4294967183]
85: Register [ 6] written with value: [00000008] | [         8]
85: Memory [  8] read with value: [ffffff8f] | [4294967183]
85: Memory [  8] read with value: [fffffffb] | [4294967291]
95: Register [ 7] written with value: [fffffffb] | [4294967291]
95: Memory [  8] read with value: [ffffaafb] | [4294945531]
105: Register [ 8] written with value: [ffffaafb] | [4294945531]
105: Memory [  8] read with value: [0001aafb] | [    109307]
115: Register [ 9] written with value: [0001aafb] | [    109307]
```

## LBU, LHU
- [lbulhu.mif](lbulhu.mif)

### Instructions Tested

```assembly
addi x7,x0,1
addi x2,x0,4
or x4,x2,x0
lb x6,0(x7)
add x6,x4,x0
lbu x7,0(x6)
lhu x8,0(x6)
```

### Registers/Memory State after each instruction

```shell
45: Register [ 7] written with value: [00000001] | [         1]
55: Register [ 2] written with value: [00000004] | [         4]
65: Memory [  1] read with value: [xxxxxxxx] | [         x]
65: Register [ 4] written with value: [00000004] | [         4]
65: Memory [  1] read with value: [ffffffff] | [4294967295]
70: Memory [  1] read with value: [ffffff8f] | [4294967183]
75: Register [ 6] written with value: [ffffff8f] | [4294967183]
85: Register [ 6] written with value: [00000004] | [         4]
85: Memory [  8] read with value: [ffffff8f] | [4294967183]
85: Memory [  8] read with value: [000000fb] | [       251]
95: Register [ 7] written with value: [000000fb] | [       251]
95: Memory [  8] read with value: [0000aafb] | [     43771]
105: Register [ 8] written with value: [0000aafb] | [     43771]
```

# Simulation Results

## JAL, BEQ (taken)

We conducted a simulation using the instructions provided in the file [beqtaken.mif](beqtaken.mif) and the testbench [tb_top](/verif/tb_top.sv) to evaluate the pipeline's functionality.

The obtained result matches the expected outcome, which can be verified below.

### Instructions Tested

The simulation included testing the following instructions:

```assembly
addi x7,x0,1
addi x2,x0,4
jal x10,8
or x4,x2,x0
add x6,x4,x2
addi x7,x0,1
addi x8,x0,2
beq x7,x7,-8
or x4,x2,x0
```

### Registers after each instruction

The following information is extracted from the simulation log and can be interpreted as demonstrated in the example below:

```shell
tt: Register [x] written with value: [hhhhhhhh] | [dddddddd]
```

In the above example, `tt` represents the simulation time, `x` represents the register number, `hhhhhhhh` represents the hexadecimal value stored in the register, and `dddddddd` represents the same value in decimal.

---

```shell
45: Register [ 7] written with value: [00000001] | [         1]
55: Register [ 2] written with value: [00000004] | [         4]
65: Register [10] written with value: [0000000c] | [        12]
95: Register [ 6] written with value: [00000004] | [         4]
105: Register [ 7] written with value: [00000001] | [         1]
115: Register [ 8] written with value: [00000002] | [         2]
155: Register [ 7] written with value: [00000001] | [         1]
165: Register [ 8] written with value: [00000002] | [         2]
205: Register [ 7] written with value: [00000001] | [         1]
215: Register [ 8] written with value: [00000002] | [         2]
255: Register [ 7] written with value: [00000001] | [         1]
265: Register [ 8] written with value: [00000002] | [         2]
305: Register [ 7] written with value: [00000001] | [         1]
315: Register [ 8] written with value: [00000002] | [         2]
355: Register [ 7] written with value: [00000001] | [         1]
365: Register [ 8] written with value: [00000002] | [         2]
405: Register [ 7] written with value: [00000001] | [         1]
415: Register [ 8] written with value: [00000002] | [         2]
455: Register [ 7] written with value: [00000001] | [         1]
465: Register [ 8] written with value: [00000002] | [         2]
505: Register [ 7] written with value: [00000001] | [         1]
```

## BEQ (not taken)

- [beqntaken.mif](beqntaken.mif)

### Instructions Tested

```assembly
addi x7,x0,1
addi x2,x0,4
jal x10,8
or x4,x2,x0
add x6,x4,x2
addi x7,x0,1
addi x8,x0,2
beq x8,x7,-8
or x4,x2,x0
```

### Registers after each instruction

```shell
45: Register [ 7] written with value: [00000001] | [         1]
55: Register [ 2] written with value: [00000004] | [         4]
65: Register [10] written with value: [0000000c] | [        12]
95: Register [ 6] written with value: [00000004] | [         4]
105: Register [ 7] written with value: [00000001] | [         1]
115: Register [ 8] written with value: [00000002] | [         2]
135: Register [ 4] written with value: [00000004] | [         4]
```

## BNE (taken)
- [bnetaken.mif](bnetaken.mif)

### Instructions Tested

```assembly
addi x7,x0,1
addi x2,x0,4
jal x10,8
or x4,x2,x0
add x6,x4,x2
addi x7,x0,1
addi x8,x0,2
bne x8,x7,-8
or x4,x2,x0
```

### Registers after each instruction

```shell
45: Register [ 7] written with value: [00000001] | [         1]
55: Register [ 2] written with value: [00000004] | [         4]
65: Register [10] written with value: [0000000c] | [        12]
95: Register [ 6] written with value: [00000004] | [         4]
105: Register [ 7] written with value: [00000001] | [         1]
115: Register [ 8] written with value: [00000002] | [         2]
155: Register [ 7] written with value: [00000001] | [         1]
165: Register [ 8] written with value: [00000002] | [         2]
205: Register [ 7] written with value: [00000001] | [         1]
215: Register [ 8] written with value: [00000002] | [         2]
255: Register [ 7] written with value: [00000001] | [         1]
265: Register [ 8] written with value: [00000002] | [         2]
305: Register [ 7] written with value: [00000001] | [         1]
315: Register [ 8] written with value: [00000002] | [         2]
355: Register [ 7] written with value: [00000001] | [         1]
365: Register [ 8] written with value: [00000002] | [         2]
405: Register [ 7] written with value: [00000001] | [         1]
415: Register [ 8] written with value: [00000002] | [         2]
455: Register [ 7] written with value: [00000001] | [         1]
465: Register [ 8] written with value: [00000002] | [         2]
505: Register [ 7] written with value: [00000001] | [         1]
```

## BLT (taken)
- [blttaken.mif](blttaken.mif)

### Instructions Tested

```assembly
addi x7,x0,1
addi x2,x0,4
jal x10,8
or x4,x2,x0
add x6,x4,x2
addi x7,x0,2
addi x8,x0,1
blt x8,x7,-8
or x4,x2,x0
```

### Registers after each instruction

```shell
45: Register [ 7] written with value: [00000001] | [         1]
55: Register [ 2] written with value: [00000004] | [         4]
65: Register [10] written with value: [0000000c] | [        12]
95: Register [ 6] written with value: [00000004] | [         4]
105: Register [ 7] written with value: [00000002] | [         2]
115: Register [ 8] written with value: [00000001] | [         1]
155: Register [ 7] written with value: [00000002] | [         2]
165: Register [ 8] written with value: [00000001] | [         1]
205: Register [ 7] written with value: [00000002] | [         2]
215: Register [ 8] written with value: [00000001] | [         1]
255: Register [ 7] written with value: [00000002] | [         2]
265: Register [ 8] written with value: [00000001] | [         1]
305: Register [ 7] written with value: [00000002] | [         2]
315: Register [ 8] written with value: [00000001] | [         1]
355: Register [ 7] written with value: [00000002] | [         2]
365: Register [ 8] written with value: [00000001] | [         1]
405: Register [ 7] written with value: [00000002] | [         2]
415: Register [ 8] written with value: [00000001] | [         1]
455: Register [ 7] written with value: [00000002] | [         2]
465: Register [ 8] written with value: [00000001] | [         1]
505: Register [ 7] written with value: [00000002] | [         2]
```

## BGE (taken)
- [bgetaken.mif](bgetaken.mif)

### Instructions Tested

```assembly
addi x7,x0,1
addi x2,x0,4
jal x10,8
or x4,x2,x0
add x6,x4,x2
addi x7,x0,2
addi x8,x0,1
bge x7,x8,-8
or x4,x2,x0
```

### Registers after each instruction

```shell
45: Register [ 7] written with value: [00000001] | [         1]
55: Register [ 2] written with value: [00000004] | [         4]
65: Register [10] written with value: [0000000c] | [        12]
95: Register [ 6] written with value: [00000004] | [         4]
105: Register [ 7] written with value: [00000002] | [         2]
115: Register [ 8] written with value: [00000001] | [         1]
155: Register [ 7] written with value: [00000002] | [         2]
165: Register [ 8] written with value: [00000001] | [         1]
205: Register [ 7] written with value: [00000002] | [         2]
215: Register [ 8] written with value: [00000001] | [         1]
255: Register [ 7] written with value: [00000002] | [         2]
265: Register [ 8] written with value: [00000001] | [         1]
305: Register [ 7] written with value: [00000002] | [         2]
315: Register [ 8] written with value: [00000001] | [         1]
355: Register [ 7] written with value: [00000002] | [         2]
365: Register [ 8] written with value: [00000001] | [         1]
405: Register [ 7] written with value: [00000002] | [         2]
415: Register [ 8] written with value: [00000001] | [         1]
455: Register [ 7] written with value: [00000002] | [         2]
465: Register [ 8] written with value: [00000001] | [         1]
505: Register [ 7] written with value: [00000002] | [         2]
```

## BLTU (taken)
- [bltutaken.mif](bltutaken.mif)

### Instructions Tested

```assembly
addi x7,x0,1
addi x2,x0,4
jal x10,8
or x4,x2,x0
add x6,x4,x2
sub x7,x0,x2
addi x8,x0,1
bltu x8,x7,-8
or x4,x2,x0
```

### Registers after each instruction

```shell
45: Register [ 7] written with value: [00000001] | [         1]
55: Register [ 2] written with value: [00000004] | [         4]
65: Register [10] written with value: [0000000c] | [        12]
95: Register [ 6] written with value: [00000004] | [         4] 
105: Register [ 7] written with value: [fffffffc] | [4294967292]
115: Register [ 8] written with value: [00000001] | [         1]
155: Register [ 7] written with value: [fffffffc] | [4294967292]
165: Register [ 8] written with value: [00000001] | [         1]
205: Register [ 7] written with value: [fffffffc] | [4294967292]
215: Register [ 8] written with value: [00000001] | [         1]
255: Register [ 7] written with value: [fffffffc] | [4294967292]
265: Register [ 8] written with value: [00000001] | [         1]
305: Register [ 7] written with value: [fffffffc] | [4294967292]
315: Register [ 8] written with value: [00000001] | [         1]
355: Register [ 7] written with value: [fffffffc] | [4294967292]
365: Register [ 8] written with value: [00000001] | [         1]
405: Register [ 7] written with value: [fffffffc] | [4294967292]
415: Register [ 8] written with value: [00000001] | [         1]
455: Register [ 7] written with value: [fffffffc] | [4294967292]
465: Register [ 8] written with value: [00000001] | [         1]
505: Register [ 7] written with value: [fffffffc] | [4294967292]
```

## BGEU (not taken)
- [bgeuntaken.mif](bgeuntaken.mif)

### Instructions Tested

```assembly
addi x7,x0,1
addi x2,x0,4
jal x10,8
or x4,x2,x0
add x6,x4,x2
sub x7,x0,x2
addi x8,x0,7
bgeu x8,x7,-8
or x4,x2,x0
```

### Registers after each instruction

```shell
45: Register [ 7] written with value: [00000001] | [         1]
55: Register [ 2] written with value: [00000004] | [         4]
65: Register [10] written with value: [0000000c] | [        12]
95: Register [ 6] written with value: [00000004] | [         4]
105: Register [ 7] written with value: [fffffffc] | [4294967292]
115: Register [ 8] written with value: [00000007] | [         7]
135: Register [ 4] written with value: [00000004] | [         4]
```

## JALR
- [jalr.mif](jalr.mif)

### Instructions Tested

```assembly
addi x7,x0,-1
sw x7,0(x0)
lw x9,0(x0)
or x4,x2,x0
add x6,x4,x2
jalr x12,x0,12
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
55: Memory [  0] read with value: [00000000] | [         0]
60: Memory [  0] read with value: [ffffffff] | [4294967295]
65: Register [ 9] written with value: [ffffffff] | [4294967295]
75: Register [ 4] written with value: [00000000] | [         0]
85: Register [ 6] written with value: [00000000] | [         0]
95: Register [12] written with value: [00000018] | [        24]
125: Register [ 4] written with value: [00000000] | [         0]
135: Register [ 6] written with value: [00000000] | [         0]
145: Register [12] written with value: [00000018] | [        24]
175: Register [ 4] written with value: [00000000] | [         0]
185: Register [ 6] written with value: [00000000] | [         0]
195: Register [12] written with value: [00000018] | [        24]
225: Register [ 4] written with value: [00000000] | [         0]
235: Register [ 6] written with value: [00000000] | [         0]
245: Register [12] written with value: [00000018] | [        24]
275: Register [ 4] written with value: [00000000] | [         0]
285: Register [ 6] written with value: [00000000] | [         0]
295: Register [12] written with value: [00000018] | [        24]
325: Register [ 4] written with value: [00000000] | [         0]
335: Register [ 6] written with value: [00000000] | [         0]
345: Register [12] written with value: [00000018] | [        24]
375: Register [ 4] written with value: [00000000] | [         0]
385: Register [ 6] written with value: [00000000] | [         0]
395: Register [12] written with value: [00000018] | [        24]
425: Register [ 4] written with value: [00000000] | [         0]
435: Register [ 6] written with value: [00000000] | [         0]
445: Register [12] written with value: [00000018] | [        24]
475: Register [ 4] written with value: [00000000] | [         0]
485: Register [ 6] written with value: [00000000] | [         0]
495: Register [12] written with value: [00000018] | [        24]
```

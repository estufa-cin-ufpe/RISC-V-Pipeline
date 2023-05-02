# Resultados obtidos da Simulação 1

Foi realizada uma simulação das instruções presentes no arquivo [instruction.mif](instruction.mif), utilizando o testbench [tb_top](/verif/tb_top.sv) para testar o funcionamento do pipeline. 

O resultado obtido está condizente com o resultado esperado e foi gerado durante a simulação, estando disponível no arquivo [result.txt](result.txt).

## Instruções testadas

As seguintes instruções foram testadas durante a simulação:

```assembly
addi x0,x0,0
addi x1,x0,8
addi x2,x0,4
or x3,x1,x2
or x4,x2,x0
add x6,x4,x0
addi x4,x0,2
addi x5,x0,-2
sll x18,x1,x4
srl x19,x5,x4
sra x20,x5,x4
slt x21,x1,x2
slt x22,x2,x1
sltu x23,x5,x1
sltu x24,x1,x5
slti x25,x1,8
slti x26,x1,16
addi x5,x0,-4
sltiu x27,x1,-2
sltiu x28,x5,-2
slli x29,x5,1
srli x30,x5,1
srai x31,x5,1
xori x6,x1,10
ori x7,x1,2
andi x8,x1,10
xor x9,x1,x2
```


## Registradores após cada instrução

O arquivo gerado é sempre criado/atualizado quando algum registrador é alterado. Ele possui o seguinte formato:

```shell
Register [ x] written with value: [hhhhhhhh] | [dddddddd]
```
Onde `x` é o número do registrador, `hhhhhhhh` é o valor em hexadecimal guardado no registrador e `dddddddd` é esse mesmo valor em decimal.

---


```shell
Register [ 0] written with value: [00000000] | [         0]
Register [ 0] written with value: [00000000] | [         0]
Register [ 1] written with value: [00000008] | [         8]
Register [ 2] written with value: [00000004] | [         4]
Register [ 3] written with value: [0000000c] | [        12]
Register [ 4] written with value: [00000004] | [         4]
Register [ 6] written with value: [00000008] | [         8]
Register [ 4] written with value: [00000002] | [         2]
Register [ 5] written with value: [fffffffe] | [4294967294]
Register [18] written with value: [00000020] | [        32]
Register [19] written with value: [3fffffff] | [1073741823]
Register [20] written with value: [ffffffff] | [4294967295]
Register [21] written with value: [00000000] | [         0]
Register [22] written with value: [00000001] | [         1]
Register [23] written with value: [00000000] | [         0]
Register [24] written with value: [00000001] | [         1]
Register [25] written with value: [00000000] | [         0]
Register [26] written with value: [00000001] | [         1]
Register [ 5] written with value: [fffffffc] | [4294967292]
Register [27] written with value: [00000001] | [         1]
Register [28] written with value: [00000001] | [         1]
Register [29] written with value: [fffffff8] | [4294967288]
Register [30] written with value: [7ffffffe] | [2147483646]
Register [31] written with value: [fffffffe] | [4294967294]
Register [ 6] written with value: [00000002] | [         2]
Register [ 7] written with value: [0000000a] | [        10]
Register [ 8] written with value: [00000008] | [         8]
Register [ 9] written with value: [0000000c] | [        12]
```
# Resultados obtidos da Simulação 1.2

Foi realizada uma simulação das instruções presentes no arquivo [luiandsub.mif](luiandsub.mif), utilizando o testbench [tb_top](/verif/tb_top.sv) para testar o funcionamento do pipeline.

O resultado obtido está condizente com o resultado esperado e foi gerado durante a simulação, estando disponível no arquivo [result-lui.txt](result-lui.txt).

## Instruções testadas

```assembly
addi x1,x0,8
sub x6,x6,x1
and x7,x6,x1
lui x6,3
```

## Registradores após cada instrução

```shell
Register [ 1] written with value: [00000008] | [         8]
Register [ 1] written with value: [00000008] | [         8]
Register [ 6] written with value: [fffffff8] | [4294967288]
Register [ 7] written with value: [00000008] | [         8]
Register [ 6] written with value: [00003000] | [     12288]
```

# Resultados obtidos da Simulação 1

Foi realizada uma simulação das instruções presentes no arquivo [instruction.mif](/sim/simulation_modelsim/simulation1/instruction.mif), utilizando o testbench [tb_top](/verif/tb_top.sv) para testar o funcionamento do pipeline. 

O resultado obtido está condizente com o resultado esperado e foi gerado durante a simulação, estando disponível no arquivo [result.txt](/sim/simulation_modelsim/simulation1/result.txt).

## Instruções testadas

As seguintes instruções foram testadas durante a simulação:

```assembly
addi $0,$0,0
addi $1,$0,8
addi $2,$0,4
or $3,$1,$2
or $4,$2,$0
add $6,$4,$0
addi $4,$0,2
addi $5,$0,-2
sll $18,$1,$4
srl $19,$5,$4
sra $20,$5,$4
slt $21,$1,$2
slt $22,$2,$1
sltu $23,$5,$1
sltu $24,$1,$5
slti $25,$1,8
slti $26,$1,16
addi $5,$0,-4
sltiu $27,$1,-2
sltiu $28,$5,-2
slli $29,$5,1
srli $30,$5,1
srai $31,$5,1
xori $6,$1,10
ori $7,$1,2
andi $8,$1,10
xor $9,$1,$2
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

# Resultados obtidos da Simulação 4

## BEQ taken

Foi realizada uma simulação das instruções presentes no arquivo [beqtaken.mif](beqtaken.mif), utilizando o testbench [tb_top](/verif/tb_top.sv) para testar o funcionamento do pipeline. 

O resultado obtido está condizente com o resultado esperado e foi gerado durante a simulação, estando disponível no arquivo [beqtaken.txt](beqtaken.txt).

### Instruções testadas

As seguintes instruções foram testadas durante a simulação:

```assembly
addi x7, x0, 1
addi x2, x0, 4
jal x10, 8
or x4, x2, x0
add x6, x4, x0
addi x7, x0, 1
addi x8, x0, 2
beq x7, x7, -8
or x4, x2, x0
```

### Registradores após cada instrução

O arquivo gerado é sempre criado/atualizado quando algum registrador é alterado. Ele possui o seguinte formato:

```shell
Register [ x] written with value: [hhhhhhhh] | [dddddddd]
```
Onde `x` é o número do registrador, `hhhhhhhh` é o valor em hexadecimal guardado no registrador e `dddddddd` é esse mesmo valor em decimal.

---


```shell
Register [ 7] written with value: [00000001] | [         1]
Register [ 2] written with value: [00000004] | [         4]
Register [10] written with value: [0000000c] | [        12]
Register [ 6] written with value: [00000004] | [         4]
Register [ 7] written with value: [00000001] | [         1]
Register [ 8] written with value: [00000002] | [         2]
Register [ 7] written with value: [00000001] | [         1]
Register [ 8] written with value: [00000002] | [         2]
Register [ 7] written with value: [00000001] | [         1]
Register [ 8] written with value: [00000002] | [         2]
Register [ 7] written with value: [00000001] | [         1]
Register [ 8] written with value: [00000002] | [         2]
Register [ 7] written with value: [00000001] | [         1]
Register [ 8] written with value: [00000002] | [         2]
Register [ 7] written with value: [00000001] | [         1]
Register [ 8] written with value: [00000002] | [         2]
Register [ 7] written with value: [00000001] | [         1]
Register [ 8] written with value: [00000002] | [         2]
Register [ 7] written with value: [00000001] | [         1]
Register [ 8] written with value: [00000002] | [         2]

```

## BEQ not taken

- [beqntaken.mif](beqntaken.mif)
- [beqntaken.txt](beqntaken.txt)

### Instruções testadas

```assembly
addi x7, x0, 1
addi x2, x0, 4
jal x10, 8
or x4, x2, x0
add x6, x4, x0
addi x7, x0, 1
addi x8, x0, 2
beq x8, x7, -8
or x4, x2, x0
```

### Registradores após cada instrução

```shell
Register [ 7] written with value: [00000001] | [         1]
Register [ 2] written with value: [00000004] | [         4]
Register [10] written with value: [0000000c] | [        12]
Register [ 6] written with value: [00000004] | [         4]
Register [ 7] written with value: [00000001] | [         1]
Register [ 8] written with value: [00000002] | [         2]
Register [ 4] written with value: [00000004] | [         4]
```

## BNE taken
- [bnetaken.mif](bnetaken.mif)
- [bnetaken.txt](bnetaken.txt)

Note que é a mesma configuração do BEQ not taken, mas o resultado é diferente.

## BLT taken
- [blttaken.mif](blttaken.mif)
- [blttaken.txt](blttaken.txt)

## BGE taken
- [bgetaken.mif](bgetaken.mif)
- [bgetaken.txt](bgetaken.txt)

Note que é a mesma configuração do BLT taken, mas com os registradores invertidos.

## BLTU taken
- [bltutaken.mif](bltutaken.mif)
- [bltutaken.txt](bltutaken.txt)

## BGEU taken
- [bgeutaken.mif](bgeutaken.mif)
- [bgeutaken.txt](bgeutaken.txt)

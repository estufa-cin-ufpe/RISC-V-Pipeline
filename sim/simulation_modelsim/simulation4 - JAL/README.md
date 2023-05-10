# Resultados obtidos da Simulação 4

Foi realizada uma simulação das instruções presentes no arquivo [instruction.mif](instruction.mif), utilizando o testbench [tb_top](/verif/tb_top.sv) para testar o funcionamento do pipeline. 

O resultado obtido está condizente com o resultado esperado e foi gerado durante a simulação, estando disponível nos arquivos [result.txt](result.txt).

## Instruções testadas

As seguintes instruções foram testadas durante a simulação:

```assembly
addi x7, x0, 1
addi x2, x0, 4
jal x10, 8
or x4, x2, x0
add x6, x4, x0
addi x7, x0, 1
addi x8, x0, 2
```

## Registradores após cada instrução

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
Register [ 8] written with value: [00000002] | [         2]
```

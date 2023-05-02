# Resultados obtidos da Simulação 3

Foi realizada uma simulação das instruções presentes no arquivo [instruction.mif](/sim/simulation_modelsim/simulation3/instruction.mif), utilizando o testbench [tb_top](/verif/tb_top.sv) para testar o funcionamento do pipeline. 

O resultado obtido está condizente com o resultado esperado e foi gerado durante a simulação, estando disponível nos arquivos [result.txt](/sim/simulation_modelsim/simulation3/result.txt).

## Instruções testadas

As seguintes instruções foram testadas durante a simulação:

```assembly
    addi x1,x0,8
    sub x6,x6,x1
    and x7,x6,x1
    auipc x6,3
```

## Registradores após cada instrução

O arquivo gerado é sempre criado/atualizado quando algum registrador é alterado. Ele possui o seguinte formato:

```shell
Register [ x] written with value: [hhhhhhhh] | [dddddddd]
```
Onde `x` é o número do registrador, `hhhhhhhh` é o valor em hexadecimal guardado no registrador e `dddddddd` é esse mesmo valor em decimal.

---


```shell
Register [ 1] written with value: [00000008] | [         8]
Register [ 6] written with value: [fffffff8] | [4294967288]
Register [ 7] written with value: [00000008] | [         8]
Register [ 6] written with value: [0000300c] | [     12300]
```

# Resultados obtidos da Simulação 5

## SW

Foi realizada uma simulação das instruções presentes no arquivo [sw.mif](sw.mif), utilizando o testbench [tb_top](/verif/tb_top.sv) para testar o funcionamento do pipeline.

O resultado obtido está condizente com o resultado esperado e foi gerado durante a simulação, estando disponível no arquivo [sw.txt](sw.txt).

### Instruções testadas

As seguintes instruções foram testadas durante a simulação:

```assembly
addi x7, x0, -1
sw x7, 0(x0)
lw x9, 0(x0)
```

### Registradores após cada instrução

O arquivo gerado é sempre criado/atualizado quando algum registrador é alterado. Ele possui o seguinte formato:

```shell
Register [ x] written with value: [hhhhhhhh] | [dddddddd]
```
Onde `x` é o número do registrador, `hhhhhhhh` é o valor em hexadecimal guardado no registrador e `dddddddd` é esse mesmo valor em decimal.

---

```shell
Register [ 7] written with value: [ffffffff] | [4294967295]
Register [ 9] written with value: [ffffffff] | [4294967295]
```

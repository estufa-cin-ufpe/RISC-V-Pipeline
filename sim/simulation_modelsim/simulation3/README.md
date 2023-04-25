# Resultados obtidos da Simulação 3

Foi realizada uma simulação das instruções presentes no arquivo [instruction.mif](/sim/simulation_modelsim/simulation3/instruction.mif), utilizando o testbench [tb_top](/verif/tb_top.sv) para testar o funcionamento do pipeline. 

A memória de dados é inicializada com o conteúdo do arquivo [data.mif](/sim/simulation_modelsim/simulation3/data.mif).

O resultado obtido está condizente com o resultado esperado e foi gerado durante a simulação, estando disponível nos arquivos [result.txt](/sim/simulation_modelsim/simulation3/result.txt) e [resultData.txt](/sim/simulation_modelsim/simulation3/resultData.txt).

## Instruções testadas

As seguintes instruções foram testadas durante a simulação:

```assembly

```

## Registradores após cada instrução

O arquivo gerado é sempre criado/atualizado quando algum registrador é alterado. Ele possui o seguinte formato:

```shell
Register [ x] written with value: [hhhhhhhh] | [dddddddd]
```
Onde `x` é o número do registrador, `hhhhhhhh` é o valor em hexadecimal guardado no registrador e `dddddddd` é esse mesmo valor em decimal.

---


```shell

```

## Operações na memória

O arquivo gerado é sempre criado/atualizado quando algum dado é escrito ou lido da memória. Ele possui o seguinte formato:

```shell
Read value: [hhhhhhhh] | [bbbbbbbb]
Write value: [hhhhhhhh] | [bbbbbbbb] on address [ x]
```

No caso de leitura, `hhhhhhhh` é o valor em hexadecimal lido da memória e `bbbbbbbb` é esse mesmo valor em binário.
Já quando é feita uma escrita, `hhhhhhhh` é o valor em hexadecimal que será escrito na memória e `bbbbbbbb` é esse mesmo valor em binário. `x` é o endereço da memória onde será escrito o valor.

---

```shell

```

# Resultados obtidos da Simulação 2

Foi realizada uma simulação das instruções presentes no arquivo [instruction.mif](instruction.mif), utilizando o testbench [tb_top](/verif/tb_top.sv) para testar o funcionamento do pipeline. 

Além disso, foi introduzido uma memória de dados de 32 bits. A memória de dados é inicializada com o conteúdo do arquivo [data.mif](data.mif).

O resultado obtido está condizente com o resultado esperado e foi gerado durante a simulação, estando disponível nos arquivos [result.txt](result.txt) e [resultData.txt](resultData.txt).

## Instruções testadas

As seguintes instruções foram testadas durante a simulação:

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

## Registradores após cada instrução

O arquivo gerado é sempre criado/atualizado quando algum registrador é alterado. Ele possui o seguinte formato:

```shell
Register [ x] written with value: [hhhhhhhh] | [dddddddd]
```
Onde `x` é o número do registrador, `hhhhhhhh` é o valor em hexadecimal guardado no registrador e `dddddddd` é esse mesmo valor em decimal.

---


```shell
Register [ 7] written with value: [00000001] | [         1]
Register [ 7] written with value: [00000001] | [         1]
Register [ 2] written with value: [00000004] | [         4]
Register [ 4] written with value: [00000004] | [         4]
Register [ 6] written with value: [ffffff8f] | [4294967183]
Register [ 6] written with value: [00000008] | [         8]
Register [ 7] written with value: [fffffffb] | [4294967291]
Register [ 8] written with value: [ffffaafb] | [4294945531]
Register [ 9] written with value: [0001aafb] | [    109307]
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
Read value: [xxxxxxxx] | [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]
Read value: [xxxxxxxx] | [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]
Read value: [ffffffff] | [11111111111111111111111111111111]
Read value: [ffffffff] | [11111111111111111111111111111111]
Read value: [ffffff8f] | [11111111111111111111111110001111]
Read value: [ffffff8f] | [11111111111111111111111110001111]
Read value: [fffffffb] | [11111111111111111111111111111011]
Read value: [fffffffb] | [11111111111111111111111111111011]
Read value: [ffffaafb] | [11111111111111111010101011111011]
Read value: [ffffaafb] | [11111111111111111010101011111011]
Read value: [0001aafb] | [00000000000000011010101011111011]
```

Note que não são todas as leituras registradas que chegam aos registradores. Este arquivo serve para acompanhar o estado do módulo da memória, não para acompanhar o estado dos registradores.

## Teste das instruções `LBU` e `LHU`
Foi realizada a simulação das instruções contidas no arquivo [instruction2.mif](instruction2.mif), que são, em suma, as mesmas instruções da simulação anterior, porém com as instruções `LBU` e `LHU`, em vez de `LB` e `LH`, respectivamente.

O resultado obtido está condizente com o resultado esperado e foi gerado durante a simulação, estando disponível no arquivo [resultU.txt](resultU.txt).

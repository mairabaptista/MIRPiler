#!/bin/bash

# Compila o código
flex cminus.l
bison -d cminus.y
gcc -c *.c
gcc -o cminus *.o -ly -lfl

# Executa a compilação
./cminus ${PROG_PATH} $2

# Limpa o ambiente após a compilação (Remove arquivos gerados)
rm -rf *.tab.*
rm -rf *.yy.*
rm -rf *.gch
rm -rf *.o
rm cminus


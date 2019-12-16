make
./compiler progs/teste_simples.c
python3 converter.py hd 0 progs/teste_simples.asm
#scp teste_simples.b aluno@172.21.217.21:~/Documentos

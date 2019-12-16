all: tokenizer parser build

tokenizer:
	flex cminus.l

parser:
	bison -d cminus.y

build:
	gcc -c *.c -fno-builtin-exp -Wno-implicit-function-declaration -g
	gcc *.o -ly -lfl -o compiler -fno-builtin-exp

clean:
	rm -f compiler
	rm -f lex.yy.c
	rm -f *.o
	rm -f parser.tab.*

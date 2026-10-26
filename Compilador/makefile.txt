# makefile del compilador de ProAlg (Practica 2). Pensado para Linux.
#   make         construye el compilador
#   make pruebas lo ejecuta con todos los programaX.alg
#   make clean   borra los ficheros generados

CC = gcc
CFLAGS = -Wall

compilador: parser.tab.o lex.yy.o
	$(CC) $(CFLAGS) parser.tab.o lex.yy.o -o compilador

# -d crea parser.tab.h (lo usa el scanner); -v crea parser.output, donde se ven
# los estados del automata y los conflictos
parser.tab.c parser.tab.h: parser.y
	bison -d -v parser.y

lex.yy.c: scanner.l parser.tab.h
	flex scanner.l

parser.tab.o: parser.tab.c
	$(CC) $(CFLAGS) -c parser.tab.c

lex.yy.o: lex.yy.c
	$(CC) -c lex.yy.c

pruebas: compilador
	@for f in programa*.alg; do echo "== $$f"; ./compilador $$f; done

clean:
	rm -f compilador parser.tab.* parser.output lex.yy.c *.o

CC = gcc
CFLAGS =
LIBS = -lfl


all: scanner

scanner: lex.yy.c
	$(CC) $(CFLAGS) lex.yy.c -o scanner $(LIBS)

lex.yy.c: scanner.l
	flex scanner.l

clean:
	rm -f lex.yy.c scanner

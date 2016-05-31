OBJS	= bison.o lex.o main.o

CC		= g++
CFLAGS	= -g -Wall -pedantic

calc: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o calc -ll

lex.o: lex.c
	$(CC) $(CFLAGS) -c lex.c -o lex.o

lex.c: calc.lex
	flex calc.lex
	cp lex.yy.c lex.c

bison.o: bison.c
	$(CC) $(CFLAGS) -c bison.c -o bison.o

bison.c: calc.y
	bison -d -v calc.y
	cp calc.tab.c bison.c
	cmp -s calc.tab.h tok.h || cp calc.tab.h tok.h

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

lex.o yac.o main.o: heading.h
lex.o main.o: tok.h

clean:
	rm -f *.o *~ lex.c lex.yy.c bison.c tok.h calc.tab.c calc.tab.h calc.output calc

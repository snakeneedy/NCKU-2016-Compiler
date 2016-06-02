REMAINS = lex.yy.c lex.yy.o  y.tab.c y.tab.h y.tab.o
TARGET = calc1
build:
	bison -y -d calc1.y
	flex calc1.l
	gcc -c y.tab.c lex.yy.c
	gcc y.tab.o lex.yy.o -o calc1
clean:
	rm ${REMAINS}  ${TARGET}


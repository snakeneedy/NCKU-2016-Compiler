REMAINS = lex.yy.c lex.yy.o  y.tab.c y.tab.h y.tab.o
TARGET = calc2
build:
	bison -y -d calc2.y
	flex calc2.l
	gcc -c y.tab.c lex.yy.c
	gcc y.tab.o lex.yy.o -o calc2
clean:
	rm ${REMAINS}  ${TARGET}


REMAINS = lex.yy.c lex.yy.o  y.tab.c y.tab.h y.tab.o
TARGET = calc3a calc3b calc3g
build:
	bison -y -d calc3.y
	flex calc3.l
	gcc -c y.tab.c lex.yy.c
	gcc y.tab.o lex.yy.o calc3a.c -o calc3a
	gcc y.tab.o lex.yy.o calc3b.c -o calc3b
	gcc y.tab.o lex.yy.o calc3g.c -o calc3g
clean:
	rm ${REMAINS}  ${TARGET}


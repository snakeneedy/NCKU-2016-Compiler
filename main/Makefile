REMAINS = lex.yy.c lex.yy.o  y.tab.c y.tab.h y.tab.o
TARGET = parser
build:
	bison -y -d parser.y
	flex parser.l
	gcc -c y.tab.c lex.yy.c
	gcc -o ${TARGET}  y.tab.o lex.yy.o
clean:
	rm  ${REMAINS}  ${TARGET}


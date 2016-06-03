OBJS = y.tab.o  lex.yy.o
REMAINS = y.tab.c y.tab.h  lex.yy.c
TARGET = parser
CX = g++
CXFLAG = -Wall
build: ${OBJS}
	${CX} -o ${TARGET}  y.tab.o lex.yy.o  ${CXFLAG}

%.o: %.c
	${CX} -c $<

y.tab.c: parser.y
	bison -y -d parser.y

lex.yy.c: parser.l
	flex parser.l

clean:
	rm  ${REMAINS}  ${OBJS}  ${TARGET}


OBJS = y.tab.o lex.yy.o main.o
REMAINS = y.tab.c y.tab.h lex.yy.c
TARGET = parser
CX = g++
CXFLAG = -Wall -lfl
#CXFLAG = -g -Wall -pedantic


build: ${OBJS}
	${CX} -o ${TARGET}  ${OBJS}  ${CXFLAG}

%.o: %.c
	${CX} -c $<  ${CXFLAG}

y.tab.c: parser.y
	bison -y -d parser.y

lex.yy.c: parser.l
	flex parser.l

clean:
	rm  ${REMAINS}  ${OBJS}  ${TARGET}


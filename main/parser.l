%{
	#include "y.tab.h"
    #include "parser.h"
    void yyerror(char *);
%}

%%

[\n]	{yylineno++; return *yytext;}
[^\n]+	{return TOKEN;}

%%

int yywrap(void) {
    return 1;
}

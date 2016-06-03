%{
    #include "parser.h"
    int yylex(void);
    void yyerror(char *);
	extern int yylineno;
%}
%start Program
%token TOKEN

%%
Program:
	| Program Expr '\n'
;

Expr:
	| TOKEN
%%

void yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}

int main(int argc, char **argv)
{
	if (argc == 1)
	{
		fprintf(stderr, "%s: No input file.\n", argv[0]);
		return -1;
	}
	else if (argc > 1 && freopen(argv[1], "r", stdin) == NULL)
	{
		fprintf(stderr, "%s: %s cannot be open.\n", argv[0], argv[1]);
		return -1;
	}
    yyparse();
	printf("%d\n", yylineno);
}

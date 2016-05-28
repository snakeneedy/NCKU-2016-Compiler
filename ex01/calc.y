%{
#include "heading.h"
int yyerror(char *s);
int yylex(void);
%}

%union{
	int		int_val;
	string*	op_val;
}

%start input

%token	<int_val>	INTEGER_LITERAL
%type	<int_val>	exp
%left	PLUS
%left	MULT

%%

input:	/* empty */
		| exp { cout << "Result: " << $1 << endl; }
		;
exp:	INTEGER_LITERAL { $$ = $1; }
		| exp PLUS exp { $$ = $1 + $3; }
		| exp MULT exp { $$ = $1 * $3; }

%%

int yyerror(string s) {
	extern int yylineno;
	extern char **yytext;

	cerr << "ERROR: " << s << " at symbol \"" << yytext;
	cerr << "\" on line " << yylineno << endl;
}

int yyerror(char *s) {
	return yyerror(string(s));
}

int yyerror() {
	return yyerror(string(""));
}

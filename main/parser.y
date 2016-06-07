%{
    #include "parser.h"
    int yylex(void);
    int yyerror();
    int yyerror(char *);
	int yyerror(string s);
%}
%union {
	int     int_val;
	string* str_val;
}
%start Program
%token Id Int Char Read Print Main
%token '<' '>' '(' ')' '{' '}' '[' ']' '+' '-' '*' '=' ',' ';'
%token Geq Leq Eq Neq

%%

Program: {cout << "[Yacc] Program: empty" << "\n";}
	| Int Main '(' ')' '{' StmtList '}' {cout << "[Yacc] Program: Int Main '(' ')' '{' StmtList '}'" << "\n";}
;

StmtList: {cout << "[Yacc] StmtList: empty" << "\n";}
	| StmtList Stmt
;

Stmt: ';' {cout << "[Yacc] Stmt: ';'" << "\n";}
	| Decl {cout << "[Yacc] Stmt: Decl" << "\n";}
;

Decl: Int Id ';' {cout << "[Yacc] Decl: Int Id ';'" << "\n";}
;

%%

int yyerror()
{
	return yyerror(string(""));
}
int yyerror(char *s)
{
	return yyerror(string(s));
}
int yyerror(string s)
{
	extern int yylineno;
	extern char ** yytext;
	cerr << "ERROR: " << s << " at symbol \"" << yytext << "\" on line " << yylineno << "\n";
	return 1;
}

int main(int argc, char **argv)
{
	extern FILE *yyin;
	if (argc == 1)
	{
		cerr << argv[0] << ": No input file.\n";
		return 1;
	}
	else if (argc > 1 && (yyin = fopen(argv[1], "r")) == NULL)
	{
		cerr << argv[0] << ": " << argv[1] << " cannot be open.\n";
		return 1;
	}
    yyparse();
}

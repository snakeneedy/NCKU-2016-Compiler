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
%token Id Int Char Read Print


%%
Program: {cout << "[Yacc] Program: /* empty */" << "\n";}
	| StmtList {cout << "[Yacc] Program: StmtList" << "\n";}
;

StmtList: Stmt StmtList {cout << "[Yacc] StmtList: Stmt StmtList" << "\n";}
	| Stmt {cout << "[Yacc] StmtList: Stmt" << "\n";}
;

Stmt: ';' {cout << "[Yacc] Stmt: ';'" << "\n";}
	| Int Id ';' {cout << "[Yacc] Stmt: Int Id ';'" << "\n";}
	| Read Id ';' {cout << "[Yacc] Stmt: Read Id ';'" << "\n";}
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
	if (argc == 1)
	{
		cerr << argv[0] << ": No input file.\n";
		return 1;
	}
	else if (argc > 1 && freopen(argv[1], "r", stdin) == NULL)
	{
		cerr << argv[0] << ": " << argv[1] << " cannot be open.\n";
		return 1;
	}
    yyparse();
}

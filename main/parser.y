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
	| DeclList {cout << "[Yacc] Program: DeclList" << "\n";}
	| Type Id ';' {cout << "[Yacc] Program: Type Id ';'" << "\n";}
;

DeclList: {cout << "[Yacc] DeclList: /* empty */" << "\n";}
	| DeclList_ DeclList {cout << "[Yacc] DeclList: DeclList_ DeclList" << "\n";}
;

DeclList_: Type Id Decl {cout << "[Yacc] DeclList_: Type Id Decl" << "\n";}
	| Stmt
;

Type: Int {cout << "[Yacc] Type: Int" << "\n";}
	| Char {cout << "[Yacc] Type: Char" << "\n";}
;

Decl: VarDecl {cout << "[Yacc] Decl: VarDecl" << "\n";}
;

VarDecl: ';' {cout << "[Yacc] VarDecl: ';'" << "\n";}
;

Stmt: ';' {cout << "[Yacc] Stmt: ';'" << "\n";}
	| Read Id ';' {cout << "[Yacc] Stmt: read Id ';'" << "\n";}
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


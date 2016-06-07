%{
    #include "parser.h"
    int yylex(void);
    int yyerror();
    int yyerror(char *);
	int yyerror(string s);
	void debug(string);
%}
%union {
	int     int_val;
	string* str_val;
}
%start Program
%token Int Char Read Print Main Return If While Else Break
%token '<' '>' '(' ')' '{' '}' '[' ']' '+' '-' '*' '=' ',' ';'
%token Geq Leq Eq Neq And Or
%token <int_val> Number Id

%%

Program: DeclList {debug("Program: DeclList");}
;
DeclList: {debug("DeclList:");}
	| DeclList_ DeclList {debug("DeclList: DeclList_ DeclList");}
;
DeclList_: Type Id Decl {debug("DeclList_: Type Id Decl");}
;
Decl: VarDecl_ {debug("Decl: VarDecl_");}
	| FunDecl {debug("Decl: FunDecl");}
;
VarDecl: Type Id VarDecl_ {debug("VarDecl: Type Id VarDecl_");}
;
VarDecl_: ';' {debug("VarDecl_: ';'");}
	| '[' Number ']' ';' {debug("VarDecl_: '[' Number ']' ';'");}
;
FunDecl: '(' ParamDeclList ')' Block {debug("FunDecl: '(' ParamDeclList ')' Block");}
;
VarDeclList: {debug("VarDeclList:");}
	| VarDecl VarDeclList {debug("VarDeclList: VarDecl VarDeclList");}
;
ParamDeclList: {debug("ParamDeclList:");}
	| ParamDeclListTail {debug("ParamDeclList: ParamDeclListTail");}
;
ParamDeclListTail: ParamDecl ParamDeclListTail_ {debug("ParamDeclListTail: ParamDecl ParamDeclListTail_");}
;
ParamDeclListTail_: {debug("ParamDeclListTail_:");}
	| ',' ParamDeclListTail {debug("ParamDeclListTail_: ',' ParamDeclListTail");}
;
ParamDecl: Type Id ParamDecl_ {debug("ParamDecl: Type Id ParamDecl_");}
;
ParamDecl_: {debug("ParamDecl_:");}
	| '[' ']' {debug("ParamDecl_: '[' ']'");}
;
Block: '{' VarDeclList StmtList '}' {debug("Block: '{' VarDeclList StmtList '}'");}
;
Type: Int {debug("Type: Int");}
	| Char {debug("Type: Char");}
;
StmtList: Stmt StmtList_ {debug("StmtList: Stmt StmtList_");}
;
StmtList_: {debug("StmtList_:");}
	| StmtList {debug("StmtList_: StmtList");}
;
Stmt: ';' {debug("Stmt: ';'");}
	| Expr ';' {debug("Stmt: Expr ';'");}
	| Return Expr ';' {debug("Stmt: Return Expr ';'");}
	| Break ';' {debug("Stmt: Break ';'");}
	| If '(' Expr ')' Stmt Else Stmt {debug("Stmt: If '(' Expr ')' Stmt Else Stmt");}
	| While '(' Expr ')' Stmt {debug("Stmt: While '(' Expr ')' Stmt");}
	| Block {debug("Stmt: Block");}
	| Print Id ';' {debug("Stmt: Print Id ';'");}
	| Read Id ';' {debug("Stmt: Read Id ';'");}
;
Expr: UnaryOp Expr {debug("Expr: UnaryOp Expr");}
	| Number Expr_ {debug("Expr: Number Expr_");}
	| '(' Expr ')' Expr_ {debug("Expr: '(' Expr ')' Expr_");}
	| Id ExprIdTail {debug("Expr: Id ExprIdTail");}
;
ExprIdTail: Expr_ {debug("ExprIdTail: Expr_");}
	| '(' ExprList ')' Expr_ {debug("ExprIdTail: '(' ExprList ')' Expr_");}
	| '[' Expr ']' ExprArrayTail {debug("ExprIdTail: '[' Expr ']' ExprArrayTail");}
	| '=' Expr {debug("ExprIdTail: '=' Expr");}
;
ExprArrayTail: Expr_ {debug("ExprArrayTail: Expr_");}
	| '=' Expr {debug("ExprArrayTail: '=' Expr");}
;
Expr_: {debug("Expr_:");}
	| BinOp Expr {debug("Expr_: BinOp Expr");}
;
ExprList: {debug("ExprList:");}
	| ExprListTail {debug("ExprList: ExprListTail");}
;
ExprListTail: Expr ExprListTail_ {debug("ExprListTail: Expr ExprListTail_");}
;
ExprListTail_: {debug("ExprListTail_:");}
	| ',' ExprListTail {debug("ExprListTail_: ',' ExprListTail");}
;
UnaryOp: '-' {debug("UnaryOp: '-'");}
	| '!' {debug("UnaryOp: '!'");}
;
BinOp: '+' {debug("BinOp: '+'");}
	| '-' {debug("BinOp: '-'");}
	| '*' {debug("BinOp: '*'");}
	| '/' {debug("BinOp: '/'");}
	| Eq {debug("BinOp: Eq");}
	| Neq {debug("BinOp: Neq");}
	| '<' {debug("BinOp: '<'");}
	| Leq {debug("BinOp: Leq");}
	| '>' {debug("BinOp: '>'");}
	| Geq {debug("BinOp: Geq");}
	| And {debug("BinOp: And");}
	| Or {debug("BinOp: Or");}
;

%%

void debug(string s)
{
	cout << "[Yacc] " << s << "\n";
}
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

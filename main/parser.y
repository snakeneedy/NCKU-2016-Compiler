%{
	#include "parser.h"
	int yylex(void);
	int yyerror();
	int yyerror(char *);
	int yyerror(string s);
	void debug(string prefix, string s);
	extern FILE *yyout;
	Scope scope;
%}
%error-verbose // for more detail of error
%union {
	int     int_val;
	string* str_val;
	vector<string> *vec_str_val;
}
%start Program
%token Int Char Read Print Main Return If While Else Break
%token '<' '>' '(' ')' '{' '}' '[' ']' '+' '-' '*' '=' ',' ';'
%token Geq Leq Eq Neq And Or
%token CommentOneLine CommentMultiLineLeft CommentMultiLineRight
%token <int_val> Number
%token Id
%type  <str_val> Decl FunDecl Block StmtList StmtList_ Stmt

%%

Program: DeclList
	{
		debug("[Yacc]", "Program: DeclList");
	}
;
DeclList:
	{
		debug("[Yacc]", "DeclList:");
	}
	| DeclList_ DeclList
	{
		debug("[Yacc]", "DeclList: DeclList_ DeclList");
	}
;
DeclList_: Type Id Decl
	{
		debug("[Yacc]", "DeclList_: Type Id("+*$<str_val>2+") Decl");
		// TODO: idMain
		string prefix = "    .data\nnewline: .asciiz \"\\n\"\n\n    .text\nread:\n    li   $v0, 5\n    syscall\n    jr   $ra\n\nprint:\n    li   $v0, 1\n    syscall\n    li   $v0, 4\n    la   $a0, newline\n    syscall\n    jr   $ra\n\nexit:\n    li   $v0, 10\n    syscall\n";
		if (*$<str_val>2 == "idMain")
		{
			// prefix
			fprintf(yyout, "%s", prefix.c_str());
			fprintf(yyout, "    .globl main\n");
			//
			fprintf(yyout, "main:\n");
			fprintf(yyout, "%s", (*$<str_val>3).c_str());
		}
		else
		{
			fprintf(yyout, "%s:\n", (*$<str_val>2).c_str());
			fprintf(yyout, "%s", (*$<str_val>3).c_str());
		}
	}
;
Decl: VarDecl_
	{
		debug("[Yacc]", "Decl: VarDecl_");
		$<str_val>$ = new string();
	}
	| FunDecl
	{
		debug("[Yacc]", "Decl: FunDecl");
		$<str_val>$ = new string(*$<str_val>1);
	}
;
VarDecl: Type Id VarDecl_
	{
		debug("[Yacc]", "VarDecl: Type Id("+*$<str_val>2+") VarDecl_");
		$<str_val>$ = new string();
		scope.def_var(*$<str_val>2);
	}
;
VarDecl_: ';'
	{
		debug("[Yacc]", "VarDecl_: ';'");
	}
	| '[' Number ']' ';'
	{
		debug("[Yacc]", "VarDecl_: '[' Number ']' ';'");
	}
;
FunDecl: '(' ParamDeclList ')' Block
	{
		debug("[Yacc]", "FunDecl: '(' ParamDeclList ')' Block");
		$<str_val>$ = new string(*$<str_val>4);
	}
;
VarDeclList:
	{
		debug("[Yacc]", "VarDeclList:");
	}
	| VarDecl VarDeclList
	{
		debug("[Yacc]", "VarDeclList: VarDecl VarDeclList");
	}
;
ParamDeclList:
	{
		debug("[Yacc]", "ParamDeclList:");
	}
	| ParamDeclListTail
	{
		debug("[Yacc]", "ParamDeclList: ParamDeclListTail");
	}
;
ParamDeclListTail: ParamDecl ParamDeclListTail_
	{
		debug("[Yacc]", "ParamDeclListTail: ParamDecl ParamDeclListTail_");
	}
;
ParamDeclListTail_:
	{
		debug("[Yacc]", "ParamDeclListTail_:");
	}
	| ',' ParamDeclListTail
	{
		debug("[Yacc]", "ParamDeclListTail_: ',' ParamDeclListTail");
	}
;
ParamDecl: Type Id ParamDecl_
	{
		debug("[Yacc]", "ParamDecl: Type Id("+*$<str_val>2+") ParamDecl_");
	}
;
ParamDecl_:
	{
		debug("[Yacc]", "ParamDecl_:");
	}
	| '[' ']'
	{
		debug("[Yacc]", "ParamDecl_: '[' ']'");
	}
;
Block: '{' VarDeclList StmtList '}'
	{
		debug("[Yacc]", "Block: '{' VarDeclList StmtList '}'");
		$<str_val>$ = new string(*$<str_val>3);
	}
;
Type: Int
	{
		debug("[Yacc]", "Type: Int");
	}
	| Char
	{
		debug("[Yacc]", "Type: Char");
	}
;
StmtList: Stmt StmtList_
	{
		debug("[Yacc]", "StmtList: Stmt StmtList_");
		$<str_val>$ = new string(*$<str_val>1 + *$<str_val>2);
	}
;
StmtList_:
	{
		debug("[Yacc]", "StmtList_:");
		$<str_val>$ = new string();
	}
	| StmtList
	{
		debug("[Yacc]", "StmtList_: StmtList");
		$<str_val>$ = new string(*$<str_val>1);
	}
;
Stmt: ';'
	{
		debug("[Yacc]", "Stmt: ';'");
	}
	| Expr ';'
	{
		debug("[Yacc]", "Stmt: Expr ';'");
	}
	| Return Expr ';'
	{
		debug("[Yacc]", "Stmt: Return Expr ';'");
		$<str_val>$ = new string();
		*$<str_val>$ += "    jr   $ra";
	}
	| Break ';'
	{
		debug("[Yacc]", "Stmt: Break ';'");
	}
	| If '(' Expr ')' Stmt Else Stmt
	{
		debug("[Yacc]", "Stmt: If '(' Expr ')' Stmt Else Stmt");
	}
	| While '(' Expr ')' Stmt
	{
		debug("[Yacc]", "Stmt: While '(' Expr ')' Stmt");
	}
	| Block
	{
		debug("[Yacc]", "Stmt: Block");
	}
	| Print Id ';'
	{
		debug("[Yacc]", "Stmt: Print Id("+*$<str_val>2+") ';'");
		// TODO: Print
		// fprintf(yyout, "%s", scope.load_var(*$<str_val>2).c_str());
		// fprintf(yyout, "    move $a0, $v0\n");
		// fprintf(yyout, "    jal print\n");
		$<str_val>$ = new string();
		*$<str_val>$ += scope.load_var(*$<str_val>2);
		*$<str_val>$ += "    move $a0, $v0\n";
		*$<str_val>$ += "    jal print\n";
	}
	| Read Id ';'
	{
		debug("[Yacc]", "Stmt: Read Id("+*$<str_val>2+") ';'");
		// TODO: Read
		// fprintf(yyout, "    jal read\n");
		// fprintf(yyout, "    move $a0, $v0\n");
		// fprintf(yyout, "%s", scope.assign_var(*$<str_val>2).c_str());
		$<str_val>$ = new string();
		*$<str_val>$ += "    jal read\n";
		*$<str_val>$ += "    move $a0, $v0\n";
		*$<str_val>$ += scope.assign_var(*$<str_val>2);
	}
;
Expr: UnaryOp Expr
	{
		debug("[Yacc]", "Expr: UnaryOp Expr");
	}
	| Number Expr_
	{
		debug("[Yacc]", "Expr: Number Expr_");
	}
	| '(' Expr ')' Expr_
	{
		debug("[Yacc]", "Expr: '(' Expr ')' Expr_");
	}
	| Id ExprIdTail
	{
		debug("[Yacc]", "Expr: Id("+*$<str_val>1+") ExprIdTail");
	}
;
ExprIdTail: Expr_
	{
		debug("[Yacc]", "ExprIdTail: Expr_");
	}
	| '(' ExprList ')' Expr_
	{
		debug("[Yacc]", "ExprIdTail: '(' ExprList ')' Expr_");
	}
	| '[' Expr ']' ExprArrayTail
	{
		debug("[Yacc]", "ExprIdTail: '[' Expr ']' ExprArrayTail");
	}
	| '=' Expr
	{
		debug("[Yacc]", "ExprIdTail: '=' Expr");
	}
;
ExprArrayTail: Expr_
	{
		debug("[Yacc]", "ExprArrayTail: Expr_");
	}
	| '=' Expr
	{
		debug("[Yacc]", "ExprArrayTail: '=' Expr");
	}
;
Expr_:
	{
		debug("[Yacc]", "Expr_:");
	}
	| BinOp Expr
	{
		debug("[Yacc]", "Expr_: BinOp Expr");
	}
;
ExprList:
	{
		debug("[Yacc]", "ExprList:");
	}
	| ExprListTail
	{
		debug("[Yacc]", "ExprList: ExprListTail");
	}
;
ExprListTail: Expr ExprListTail_
	{
		debug("[Yacc]", "ExprListTail: Expr ExprListTail_");
	}
;
ExprListTail_:
	{
		debug("[Yacc]", "ExprListTail_:");
	}
	| ',' ExprListTail
	{
		debug("[Yacc]", "ExprListTail_: ',' ExprListTail");
	}
;
UnaryOp: '-'
	{
		debug("[Yacc]", "UnaryOp: '-'");
	}
	| '!'
	{
		debug("[Yacc]", "UnaryOp: '!'");
	}
;
BinOp: '+'
	{
		debug("[Yacc]", "BinOp: '+'");
	}
	| '-'
	{
		debug("[Yacc]", "BinOp: '-'");
	}
	| '*'
	{
		debug("[Yacc]", "BinOp: '*'");
	}
	| '/'
	{
		debug("[Yacc]", "BinOp: '/'");
	}
	| Eq
	{
		debug("[Yacc]", "BinOp: Eq");
	}
	| Neq
	{
		debug("[Yacc]", "BinOp: Neq");
	}
	| '<'
	{
		debug("[Yacc]", "BinOp: '<'");
	}
	| Leq
	{
		debug("[Yacc]", "BinOp: Leq");
	}
	| '>'
	{
		debug("[Yacc]", "BinOp: '>'");
	}
	| Geq
	{
		debug("[Yacc]", "BinOp: Geq");
	}
	| And
	{
		debug("[Yacc]", "BinOp: And");
	}
	| Or
	{
		debug("[Yacc]", "BinOp: Or");
	}
;

%%

void debug(string prefix, string s)
{
	//if (prefix == "[Yacc]")
	//	fprintf(yyout, "%s %s\n", prefix.c_str(), s.c_str());
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
	extern char * yytext;
	cerr << "ERROR: " << s << " at symbol \"" << yytext << "\" on line " << yylineno << "\n";
	return 1;
}

# NCKU 2016 Compiler

# Current situation

Run command:

+ `./main/parser <input_path>`
+ `./main/parser <input_path> -o <output_path>`
+ `./main/parser -o <output_path> <input_path>`

```bash
$ cd main
$ make
$ cd ..
$ ./main/parser ex01/test.c
[Lex] int
[Yacc] Type: Int
[Lex] id: idFunction
[Lex] (
[Lex] int
[Yacc] Type: Int
[Lex] id: idValA
[Lex] ,
[Yacc] ParamDecl_:
[Yacc] ParamDecl: Type Id ParamDecl_
[Lex] int
[Yacc] Type: Int
[Lex] id: idValB
[Lex] )
[Yacc] ParamDecl_:
[Yacc] ParamDecl: Type Id ParamDecl_
[Yacc] ParamDeclListTail_:
[Yacc] ParamDeclListTail: ParamDecl ParamDeclListTail_
[Yacc] ParamDeclListTail_: ',' ParamDeclListTail
[Yacc] ParamDeclListTail: ParamDecl ParamDeclListTail_
[Yacc] ParamDeclList: ParamDeclListTail
[Lex] {
[Lex] int
[Yacc] Type: Int
[Lex] id: idSum
[Lex] ;
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id VarDecl_
[Lex] id: idSum
[Yacc] VarDeclList:
[Yacc] VarDeclList: VarDecl VarDeclList
[Lex] =
[Lex] id: idValA
[Lex] +
[Yacc] BinOp: '+'
[Lex] id: idValB
[Lex] ;
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Expr ';'
[Lex] print
[Lex] id: idSum
[Lex] ;
[Yacc] Stmt: Print Id ';'
[Lex] return
[Lex] id: idSum
[Lex] ;
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Return Expr ';'
[Lex] }
[Yacc] StmtList_:
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] Block: '{' VarDeclList StmtList '}'
[Yacc] FunDecl: '(' ParamDeclList ')' Block
[Yacc] Decl: FunDecl
[Yacc] DeclList_: Type Id Decl
[Lex] int
[Yacc] Type: Int
[Lex] id: idMain
[Lex] (
[Lex] )
[Yacc] ParamDeclList:
[Lex] {
[Lex] int
[Yacc] Type: Int
[Lex] id: idA
[Lex] ;
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id VarDecl_
[Lex] int
[Yacc] Type: Int
[Lex] id: idB
[Lex] ;
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id VarDecl_
[Lex] int
[Yacc] Type: Int
[Lex] id: idResult
[Lex] ;
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id VarDecl_
[Lex] int
[Yacc] Type: Int
[Lex] id: idLoop
[Lex] ;
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id VarDecl_
[Lex] int
[Yacc] Type: Int
[Lex] id: idArray
[Lex] [
[Lex] Number(10)
[Lex] ]
[Lex] ;
[Yacc] VarDecl_: '[' Number ']' ';'
[Yacc] VarDecl: Type Id VarDecl_
[Lex] read
[Yacc] VarDeclList:
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] VarDeclList: VarDecl VarDeclList
[Lex] id: idA
[Lex] ;
[Yacc] Stmt: Read Id ';'
[Lex] read
[Lex] id: idB
[Lex] ;
[Yacc] Stmt: Read Id ';'
[Lex] print
[Lex] id: idA
[Lex] ;
[Yacc] Stmt: Print Id ';'
[Lex] print
[Lex] id: idB
[Lex] ;
[Yacc] Stmt: Print Id ';'
[Lex] id: idResult
[Lex] =
[Lex] (
[Lex] id: idA
[Lex] +
[Yacc] BinOp: '+'
[Lex] id: idB
[Lex] )
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Lex] *
[Yacc] BinOp: '*'
[Lex] id: idB
[Lex] ;
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] Expr: '(' Expr ')' Expr_
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Expr ';'
[Lex] print
[Lex] id: idResult
[Lex] ;
[Yacc] Stmt: Print Id ';'
[Lex] id: idResult
[Lex] =
[Lex] id: idA
[Lex] +
[Yacc] BinOp: '+'
[Lex] id: idB
[Lex] -
[Yacc] BinOp: '-'
[Lex] id: idA
[Lex] *
[Yacc] BinOp: '*'
[Lex] id: idB
[Lex] /
[Yacc] BinOp: '/'
[Lex] Number(1)
[Lex] ;
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Expr ';'
[Lex] print
[Lex] id: idResult
[Lex] ;
[Yacc] Stmt: Print Id ';'
[Lex] if
[Lex] (
[Lex] id: idA
[Lex] >
[Yacc] BinOp: '>'
[Lex] id: idB
[Lex] )
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Lex] {
[Lex] id: idResult
[Yacc] VarDeclList:
[Lex] =
[Lex] id: idA
[Lex] -
[Yacc] BinOp: '-'
[Lex] id: idB
[Lex] ;
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Expr ';'
[Lex] print
[Lex] id: idResult
[Lex] ;
[Yacc] Stmt: Print Id ';'
[Lex] }
[Yacc] StmtList_:
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] Block: '{' VarDeclList StmtList '}'
[Yacc] Stmt: Block
[Lex] else
[Lex] {
[Lex] id: idResult
[Yacc] VarDeclList:
[Lex] =
[Lex] id: idB
[Lex] -
[Yacc] BinOp: '-'
[Lex] id: idA
[Lex] ;
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Expr ';'
[Lex] print
[Lex] id: idResult
[Lex] ;
[Yacc] Stmt: Print Id ';'
[Lex] }
[Yacc] StmtList_:
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] Block: '{' VarDeclList StmtList '}'
[Yacc] Stmt: Block
[Yacc] Stmt: If '(' Expr ')' Stmt Else Stmt
[Lex] id: idLoop
[Lex] =
[Lex] Number(10)
[Lex] ;
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Expr ';'
[Lex] while
[Lex] (
[Lex] id: idLoop
[Lex] >
[Yacc] BinOp: '>'
[Lex] Number(0)
[Lex] )
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Lex] {
[Lex] id: idLoop
[Yacc] VarDeclList:
[Lex] =
[Lex] id: idLoop
[Lex] -
[Yacc] BinOp: '-'
[Lex] Number(1)
[Lex] ;
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Expr ';'
[Lex] }
[Yacc] StmtList_:
[Yacc] StmtList: Stmt StmtList_
[Yacc] Block: '{' VarDeclList StmtList '}'
[Yacc] Stmt: Block
[Yacc] Stmt: While '(' Expr ')' Stmt
[Lex] print
[Lex] id: idLoop
[Lex] ;
[Yacc] Stmt: Print Id ';'
[Lex] id: idArray
[Lex] [
[Lex] Number(1)
[Lex] ]
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Lex] =
[Lex] Number(5)
[Lex] ;
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] ExprArrayTail: '=' Expr
[Yacc] ExprIdTail: '[' Expr ']' ExprArrayTail
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Expr ';'
[Lex] id: idArray
[Lex] [
[Lex] Number(6)
[Lex] ]
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Lex] =
[Lex] Number(10)
[Lex] ;
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] ExprArrayTail: '=' Expr
[Yacc] ExprIdTail: '[' Expr ']' ExprArrayTail
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Expr ';'
[Lex] id: idResult
[Lex] =
[Lex] id: idArray
[Lex] [
[Lex] Number(1)
[Lex] ]
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Lex] +
[Yacc] BinOp: '+'
[Lex] id: idArray
[Lex] [
[Lex] Number(6)
[Lex] ]
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Lex] ;
[Yacc] Expr_:
[Yacc] ExprArrayTail: Expr_
[Yacc] ExprIdTail: '[' Expr ']' ExprArrayTail
[Yacc] Expr: Id ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprArrayTail: Expr_
[Yacc] ExprIdTail: '[' Expr ']' ExprArrayTail
[Yacc] Expr: Id ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Expr ';'
[Lex] print
[Lex] id: idArray
[Lex] ;
[Yacc] Stmt: Print Id ';'
[Lex] id: idResult
[Lex] =
[Lex] id: idFunction
[Lex] (
[Lex] id: idA
[Lex] ,
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Lex] id: idB
[Lex] )
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] ExprListTail_:
[Yacc] ExprListTail: Expr ExprListTail_
[Yacc] ExprListTail_: ',' ExprListTail
[Yacc] ExprListTail: Expr ExprListTail_
[Yacc] ExprList: ExprListTail
[Lex] ;
[Yacc] Expr_:
[Yacc] ExprIdTail: '(' ExprList ')' Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Expr ';'
[Lex] print
[Lex] id: idResult
[Lex] ;
[Yacc] Stmt: Print Id ';'
[Lex] return
[Lex] Number(0)
[Lex] ;
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Stmt: Return Expr ';'
[Lex] }
[Yacc] StmtList_:
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] Block: '{' VarDeclList StmtList '}'
[Yacc] FunDecl: '(' ParamDeclList ')' Block
[Yacc] Decl: FunDecl
[Yacc] DeclList_: Type Id Decl
[Yacc] DeclList:
[Yacc] DeclList: DeclList_ DeclList
[Yacc] DeclList: DeclList_ DeclList
[Yacc] Program: DeclList
```


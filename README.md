# NCKU 2016 Compiler

# Current situation

Run command:

+ `./main/parser <input_path>`
+ `./main/parser <input_path> -o <output_path>`
+ `./main/parser -o <output_path> <input_path>`

# Current mission

Convert `test.c` to `test.s`

`test.c`:
```c
int idMain ( ) {
	int idA ;
	read idA ;
	print idA ;
    return 0 ;
}
```

`test.s`:
```asm
	.text
	.global main
main:
	li    $v0, 5
	syscall
	move  $a0, $v0
	li    $v0, 1
	syscall
	li    $v0, 10
	syscall
```

# Log
## Sample 1

```c
int idMain ( ) {
    int idA ;
    read idA ;
    print idA ;
    return 0 ;
}
```

```text
[Yacc] Type: Int
[Yacc] ParamDeclList:
[Yacc] Type: Int
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id VarDecl_
[Yacc] VarDeclList:
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] Stmt: Read Id ';'
[Yacc] Stmt: Print Id ';'
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Stmt: Return Expr ';'
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
[Yacc] DeclList:
[Yacc] DeclList: DeclList_ DeclList
[Yacc] Program: DeclList
```

## Sample 2

```c
int idMain ( ) {
    int idA ;
    int idB ;
    int idResult ;

    read idA ;
    read idB ;

    print idA ;
    print idB ;

    idResult = ( idA + idB ) * idB ;
    print idResult;

    idResult = idA + idB - idA * idB / 1 ;
    print idResult ;

    return 0 ;
}
```

```text
[Yacc] Type: Int
[Yacc] ParamDeclList:
[Yacc] Type: Int
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id VarDecl_
[Yacc] Type: Int
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id VarDecl_
[Yacc] Type: Int
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id VarDecl_
[Yacc] VarDeclList:
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] Stmt: Read Id ';'
[Yacc] Stmt: Read Id ';'
[Yacc] Stmt: Print Id ';'
[Yacc] Stmt: Print Id ';'
[Yacc] BinOp: '+'
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] BinOp: '*'
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] Expr: '(' Expr ')' Expr_
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id ExprIdTail
[Yacc] Stmt: Expr ';'
[Yacc] Stmt: Print Id ';'
[Yacc] BinOp: '+'
[Yacc] BinOp: '-'
[Yacc] BinOp: '*'
[Yacc] BinOp: '/'
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
[Yacc] Stmt: Print Id ';'
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Stmt: Return Expr ';'
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
[Yacc] Block: '{' VarDeclList StmtList '}'
[Yacc] FunDecl: '(' ParamDeclList ')' Block
[Yacc] Decl: FunDecl
[Yacc] DeclList_: Type Id Decl
[Yacc] DeclList:
[Yacc] DeclList: DeclList_ DeclList
[Yacc] Program: DeclList
```

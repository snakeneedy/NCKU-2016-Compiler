# NCKU 2016 Compiler

# Current situation

Run command:

+ `./main/parser <input_path>`
+ `./main/parser <input_path> -o <output_path>`
+ `./main/parser -o <output_path> <input_path>`

# MISP Sample

Exit
```asm
    .text
    .globl main
main:
    b exit
exit:
    li   $v0, 10
    syscall
```

Read
```asm
    .data
idA: .word 1024
    .text
    .globl main
main:
    jal read
    sw   $v0, idA
read:
    li   $v0, 5
    syscall
    jr   $ra
```

Print
```asm
    .data
newline: .asciiz "\n"
idA: .word 1024
    .text
    .globl main
main:
    lw $a0, idA
    jal print
print:
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, newline
    syscall
    jr   $ra
```

Align Value
```asm
    .data
idA: .word 1024
    .text
    .globl main
main:
    li   $t0, 100
    sw   $t0, idA
```

Push and Pop
```asm
    .data
    .text
push:
    add  $sp, $sp, -4
    sw   $a0, 0($sp)
    jr   $ra

pop:
    lw   $v0, 0($sp)
    add  $sp, $sp, 4
    jr   $ra

    .globl main
main:
    li  $a0, 10
    jal push
    jal pop
    move $a0, $v0
    jal print

    b exit
```


## Sample 1

```asm
    .data
newline: .asciiz "\n"
idA: .word 1024
    .text
    .globl main
main:
    la $a0, idA
    jal print
    li $t0, 100
    sw $t0, idA
    lw $a0, idA
    jal print
    b exit

read:
    li   $v0, 5
    syscall
    jr   $ra

print:
    li   $v0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    jr   $ra

exit:
    li $v0, 10
    syscall
```

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

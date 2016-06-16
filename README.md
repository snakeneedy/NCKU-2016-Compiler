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

## Sample 3

```c
int idFunction ( int idValA , int idValB ) {
    int idSum ;
    idSum = idValA + idValB ;
    print idSum ;
    return idSum ;
}

int idMain ( ) {
    int idA ;
    int idB ;
    int idResult ;
    int idLoop;
    int idArray [ 10 ] ;

    read idA ;
    read idB ;

    print idA ;
    print idB ;

    idResult = ( idA + idB ) * idB ;
    print idResult;

    idResult = idA + idB - idA * idB / 1 ;
    print idResult ;

    if ( idA > idB ) {
        idResult = idA - idB ;
        print idResult ;
    }
    else {
        idResult = idB - idA ;
        print idResult ;
    }

    idLoop = 10;
    while ( idLoop > 0) {
        idLoop = idLoop - 1 ;
    }
    print idLoop ;

    idArray [ 1 ] = 5 ;
    idArray [ 6 ] = 10 ;
    idResult = idArray [ 1 ] + idArray [ 6 ];
    print idArray;

    idResult = idFunction ( idA , idB ) ;
    print idResult ;

    return 0 ;
}
```

```text
[Yacc] Type: Int
[Yacc] Type: Int
[Yacc] ParamDecl_:
[Yacc] ParamDecl: Type Id(idValA) ParamDecl_
[Yacc] Type: Int
[Yacc] ParamDecl_:
[Yacc] ParamDecl: Type Id(idValB) ParamDecl_
[Yacc] ParamDeclListTail_:
[Yacc] ParamDeclListTail: ParamDecl ParamDeclListTail_
[Yacc] ParamDeclListTail_: ',' ParamDeclListTail
[Yacc] ParamDeclListTail: ParamDecl ParamDeclListTail_
[Yacc] ParamDeclList: ParamDeclListTail
[Yacc] Type: Int
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id(idSum) VarDecl_
[Yacc] VarDeclList:
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] BinOp: '+'
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idValB) ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idValA) ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id(idSum) ExprIdTail
[Yacc] Stmt: Expr ';'
[Yacc] Stmt: Print Id(idSum) ';'
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idSum) ExprIdTail
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
[Yacc] DeclList_: Type Id(idFunction) Decl
[Yacc] Type: Int
[Yacc] ParamDeclList:
[Yacc] Type: Int
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id(idA) VarDecl_
[Yacc] Type: Int
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id(idB) VarDecl_
[Yacc] Type: Int
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id(idResult) VarDecl_
[Yacc] Type: Int
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id(idLoop) VarDecl_
[Yacc] Type: Int
[Yacc] VarDecl_: '[' Number ']' ';'
[Yacc] VarDecl: Type Id(idArray) VarDecl_
[Yacc] VarDeclList:
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] Stmt: Read Id(idA) ';'
[Yacc] Stmt: Read Id(idB) ';'
[Yacc] Stmt: Print Id(idA) ';'
[Yacc] Stmt: Print Id(idB) ';'
[Yacc] BinOp: '+'
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idB) ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idA) ExprIdTail
[Yacc] BinOp: '*'
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idB) ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] Expr: '(' Expr ')' Expr_
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id(idResult) ExprIdTail
[Yacc] Stmt: Expr ';'
[Yacc] Stmt: Print Id(idResult) ';'
[Yacc] BinOp: '+'
[Yacc] BinOp: '-'
[Yacc] BinOp: '*'
[Yacc] BinOp: '/'
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idB) ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idA) ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idB) ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idA) ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id(idResult) ExprIdTail
[Yacc] Stmt: Expr ';'
[Yacc] Stmt: Print Id(idResult) ';'
[Yacc] BinOp: '>'
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idB) ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idA) ExprIdTail
[Yacc] VarDeclList:
[Yacc] BinOp: '-'
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idB) ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idA) ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id(idResult) ExprIdTail
[Yacc] Stmt: Expr ';'
[Yacc] Stmt: Print Id(idResult) ';'
[Yacc] StmtList_:
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] Block: '{' VarDeclList StmtList '}'
[Yacc] Stmt: Block
[Yacc] VarDeclList:
[Yacc] BinOp: '-'
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idA) ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idB) ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id(idResult) ExprIdTail
[Yacc] Stmt: Expr ';'
[Yacc] Stmt: Print Id(idResult) ';'
[Yacc] StmtList_:
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] Block: '{' VarDeclList StmtList '}'
[Yacc] Stmt: Block
[Yacc] Stmt: If '(' Expr ')' Stmt Else Stmt
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id(idLoop) ExprIdTail
[Yacc] Stmt: Expr ';'
[Yacc] BinOp: '>'
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idLoop) ExprIdTail
[Yacc] VarDeclList:
[Yacc] BinOp: '-'
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Expr_: BinOp Expr
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idLoop) ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id(idLoop) ExprIdTail
[Yacc] Stmt: Expr ';'
[Yacc] StmtList_:
[Yacc] StmtList: Stmt StmtList_
[Yacc] Block: '{' VarDeclList StmtList '}'
[Yacc] Stmt: Block
[Yacc] Stmt: While '(' Expr ')' Stmt
[Yacc] Stmt: Print Id(idLoop) ';'
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] ExprArrayTail: '=' Expr
[Yacc] ExprIdTail: '[' Expr ']' ExprArrayTail
[Yacc] Expr: Id(idArray) ExprIdTail
[Yacc] Stmt: Expr ';'
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] ExprArrayTail: '=' Expr
[Yacc] ExprIdTail: '[' Expr ']' ExprArrayTail
[Yacc] Expr: Id(idArray) ExprIdTail
[Yacc] Stmt: Expr ';'
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] BinOp: '+'
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Expr_:
[Yacc] ExprArrayTail: Expr_
[Yacc] ExprIdTail: '[' Expr ']' ExprArrayTail
[Yacc] Expr: Id(idArray) ExprIdTail
[Yacc] Expr_: BinOp Expr
[Yacc] ExprArrayTail: Expr_
[Yacc] ExprIdTail: '[' Expr ']' ExprArrayTail
[Yacc] Expr: Id(idArray) ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id(idResult) ExprIdTail
[Yacc] Stmt: Expr ';'
[Yacc] Stmt: Print Id(idArray) ';'
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idA) ExprIdTail
[Yacc] Expr_:
[Yacc] ExprIdTail: Expr_
[Yacc] Expr: Id(idB) ExprIdTail
[Yacc] ExprListTail_:
[Yacc] ExprListTail: Expr ExprListTail_
[Yacc] ExprListTail_: ',' ExprListTail
[Yacc] ExprListTail: Expr ExprListTail_
[Yacc] ExprList: ExprListTail
[Yacc] Expr_:
[Yacc] ExprIdTail: '(' ExprList ')' Expr_
[Yacc] Expr: Id(idFunction) ExprIdTail
[Yacc] ExprIdTail: '=' Expr
[Yacc] Expr: Id(idResult) ExprIdTail
[Yacc] Stmt: Expr ';'
[Yacc] Stmt: Print Id(idResult) ';'
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
[Yacc] DeclList_: Type Id(idMain) Decl
[Yacc] DeclList:
[Yacc] DeclList: DeclList_ DeclList
[Yacc] DeclList: DeclList_ DeclList
[Yacc] Program: DeclList
```

## Sample 3

```c
int idMain ( ) {
    int idA ;
    int idB ;
    if ( 3 > 2 )
    {
        print idA ;
    }
    else
    {
        print idB ;
    }
    return 0 ;
}
```

```text
[Yacc] Type: Int
[Yacc] ParamDeclList:
[Yacc] Type: Int
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id(idA) VarDecl_
[Yacc] Type: Int
[Yacc] VarDecl_: ';'
[Yacc] VarDecl: Type Id(idB) VarDecl_
[Yacc] VarDeclList:
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] VarDeclList: VarDecl VarDeclList
[Yacc] BinOp: '>'
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Expr_: BinOp Expr
[Yacc] Expr: Number Expr_
[Yacc] VarDeclList:
[Yacc] Stmt: Print Id(idA) ';'
[Yacc] StmtList_:
[Yacc] StmtList: Stmt StmtList_
[Yacc] Block: '{' VarDeclList StmtList '}'
[Yacc] Stmt: Block
[Yacc] VarDeclList:
[Yacc] Stmt: Print Id(idB) ';'
[Yacc] StmtList_:
[Yacc] StmtList: Stmt StmtList_
[Yacc] Block: '{' VarDeclList StmtList '}'
[Yacc] Stmt: Block
[Yacc] Stmt: If '(' Expr ')' Stmt Else Stmt
[Yacc] Expr_:
[Yacc] Expr: Number Expr_
[Yacc] Stmt: Return Expr ';'
[Yacc] StmtList_:
[Yacc] StmtList: Stmt StmtList_
[Yacc] StmtList_: StmtList
[Yacc] StmtList: Stmt StmtList_
[Yacc] Block: '{' VarDeclList StmtList '}'
[Yacc] FunDecl: '(' ParamDeclList ')' Block
[Yacc] Decl: FunDecl
[Yacc] DeclList_: Type Id(idMain) Decl
[Yacc] DeclList:
[Yacc] DeclList: DeclList_ DeclList
[Yacc] Program: DeclList
```

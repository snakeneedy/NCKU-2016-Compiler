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

/* scope.c */
/* output MIPS asm code */
#ifndef SCOPE
#define SCOPE
#include "scope.h"

Scope::Scope():maxAddr(0)
{
	;
}
Scope::~Scope()
{
	;
}
void Scope::def_var (string varName, int size)
{
	Variable var;
	if (size < 0)
	{
		var.isArray = false;
		var.size = 1;
	}
	else
	{
		var.isArray = true;
		var.size = size;
	}
	var.addr = (4) * var.size + maxAddr;
	varTable[varName] = var;
	maxAddr = var.addr;
}
string Scope::assign_var (string varName, int index)
{
	// store the value of $a0
	/*
		add $sp, $sp, -4
		sw $a0, 0($sp)
		add $sp, $sp, 4
	*/
	string result;
	Variable var = varTable[varName];
	stringstream ss;
	ss << var.addr + index * (4);
	string refAddr = ss.str();
	result += "    add  $sp, $sp, -" + refAddr + "\n";
	result += "    sw   $a0, 0($sp)\n";
	result += "    add  $sp, $sp, " + refAddr + "\n";
	return result;
}
string Scope::load_var (string varName, int index)
{
	// load the value to $v0
	/*
		add $sp, $sp, -4
		lw $v0, 0($sp)
		add $sp, $sp, 4
	*/
	string result;
	Variable var = varTable[varName];
	stringstream ss;
	ss << var.addr + index * (4);
	string refAddr = ss.str();
	result += "    add  $sp, $sp, -" + refAddr + "\n";
	result += "    lw   $v0, 0($sp)\n";
	result += "    add  $sp, $sp, " + refAddr + "\n";
	return result;
}

#endif // SCOPE

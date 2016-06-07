%{
#include "parser.h"
#include "y.tab.h"
int yyerror(char *);
%}

digit	[0-9]
letter	[A-Za-z]
upper	[A-Z]
lower	[a-z]
alfa	[0-9A-Za-z_]
whitesp	[ \t\n]

num		{digit}+
word	{letter}+


%%

int			{cout << "[Lex] int" << "\n"; return Int;}
read		{cout << "[Lex] read" << "\n"; return Read;}
print		{cout << "[Lex] print" << "\n"; return Print;}
return		{cout << "[Lex] return" << "\n"; return Return;}
if			{cout << "[Lex] if" << "\n"; return If;}
else		{cout << "[Lex] else" << "\n"; return Else;}
while		{cout << "[Lex] while" << "\n"; return While;}
break		{cout << "[Lex] break" << "\n"; return Break;}

">="		{cout << "[Lex] '>='" << "\n"; return Geq;}
"<="		{cout << "[Lex] '<='" << "\n"; return Leq;}
"=="		{cout << "[Lex] '=='" << "\n"; return Eq;}
"!="		{cout << "[Lex] '!='" << "\n"; return Neq;}
"&&"		{cout << "[Lex] '&&'" << "\n"; return And;}
"||"		{cout << "[Lex] '||'" << "\n"; return Or;}
[ \t]		{;}
\n			{yylineno++;}
{num}		{cout << "[Lex] Number(" << yytext << ")" << "\n"; yylval.int_val = atoi(yytext); return Number;}

[<>(){}\[\]+\-*/=,;]	{cout << "[Lex] " << *yytext << "\n"; return *yytext;}
id{upper}{letter}*		{cout << "[Lex] id: " << yytext << "\n"; yylval.int_val = 0; return Id;}

[^ \t\n]	{yyerror(yytext);}


%%

int yywrap(void) {
	return 1;
}

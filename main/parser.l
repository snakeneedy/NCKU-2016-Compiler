%{
#include "parser.h"
#include "y.tab.h"
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
idMain		{cout << "[Lex] idMain" << "\n"; return Main;}
[\(\)\{\};]		{cout << "[Lex] " << *yytext << "\n"; return *yytext;}
id{upper}{alfa}*	{cout << "[Lex] id: " << yytext << "\n"; return Id;}
whitesp		;

%%

int yywrap(void) {
	return 1;
}


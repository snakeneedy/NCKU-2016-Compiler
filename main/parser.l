%{
#include "parser.h"
#include "y.tab.h"
int yyerror();
int yyerror(char *);
int yyerror(string s);
void debug(string prefix, string s);
%}
%option yylineno
/* YY_NO_INPUT */
%option noinput
/* for 'void yyunput(int, char*)' defined but not used */
%option nounput

digit	[0-9]
letter	[A-Za-z]
upper	[A-Z]
lower	[a-z]
alfa	[0-9A-Za-z_]
whitesp	[ \t\n]

num		{digit}+
word	{letter}+


%%

int			{debug("[Lex]", "int"); return Int;}
read		{debug("[Lex]", "read"); return Read;}
print		{debug("[Lex]", "print"); return Print;}
return		{debug("[Lex]", "return"); return Return;}
if			{debug("[Lex]", "if"); return If;}
else		{debug("[Lex]", "else"); return Else;}
while		{debug("[Lex]", "while"); return While;}
break		{debug("[Lex]", "break"); return Break;}

">="		{debug("[Lex]", "'>='"); return Geq;}
"<="		{debug("[Lex]", "'<='"); return Leq;}
"=="		{debug("[Lex]", "'=='"); return Eq;}
"!="		{debug("[Lex]", "'!='"); return Neq;}
"&&"		{debug("[Lex]", "'&&'"); return And;}
"||"		{debug("[Lex]", "'||'"); return Or;}
"//"		{debug("[Lex]", "'//'"); return CommentOneLine;}
"/*"		{debug("[Lex]", "'/*'"); return CommentMultiLineLeft;}
"*/"		{debug("[Lex]", "'*/'"); return CommentMultiLineRight;}
[ \t\r]		{;}
\n			{yylineno++;}
-?{num}		{debug("[Lex]", "Number"); yylval.int_val = atoi(yytext); return Number;}

[<>(){}\[\]+\-*/=,;]	{debug("[Lex]", "" + string(yytext)); return *yytext;}
id{upper}{letter}*		{debug("[Lex]", "id: " + string(yytext)); yylval.str_val = new string(yytext); return Id;}

[^ \t\n]	{yyerror(yytext);}


%%

int yywrap(void) {
	return 1;
}

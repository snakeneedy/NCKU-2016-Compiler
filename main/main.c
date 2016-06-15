#include "parser.h"
vector<string> vVarStmt;
vector<string> vFuncStmt;
vector<string> vMainStmt;

void init ();
int yyparse();

int main(int argc, char **argv)
{
	extern FILE *yyin, *yyout;


	if (argc == 1)
	{
		cerr << argv[0] << ": No input file.\n";
		return 1;
	}
	else if (argc == 2 && string(argv[1]) != "-o")
	{
		if ((yyin = fopen(argv[1], "r")) == NULL)
		{
			cerr << argv[0] << ": " << argv[1] << " cannot be open.\n";
			return 1;
		}
		string output = string(argv[1]);
		yyout = fopen((output+".s").c_str(), "w");
	}
	else if (argc > 1)
	{
		for (int i = 1; i < argc; ++i)
		{
			if (string(argv[i]) == "-o")
			{
				if (i + 1 == argc)
				{
					cerr << argv[0] << ": No output file.\n";
					return 1;
				}
				else if ((yyout = fopen(argv[i + 1], "w")) == NULL)
				{
					cerr << argv[0] << ": " << argv[i + 1] << " cannot be written.\n";
					return 1;
				}
				i++;
			}
			else if ((yyin = fopen(argv[i], "r")) == NULL)
			{
				cerr << argv[0] << ": " << argv[1] << " cannot be open.\n";
				return 1;
			}
		}
	}
	;
	init();
	yyparse();
}
void init ()
{
	vVarStmt.push_back("newline: .asciiz \"\\n\"");

	vFuncStmt.push_back("exit:");
	vFuncStmt.push_back("    li $v0, 10");
	vFuncStmt.push_back("    syscall");
	vFuncStmt.push_back("");
	vFuncStmt.push_back("read:");
	vFuncStmt.push_back("    li   $v0, 5");
	vFuncStmt.push_back("    syscall");
	vFuncStmt.push_back("    jr   $ra");
	vFuncStmt.push_back("");
	vFuncStmt.push_back("print:");
	vFuncStmt.push_back("    li   $v0, 1");
	vFuncStmt.push_back("    syscall");
	vFuncStmt.push_back("    li   $v0, 4");
	vFuncStmt.push_back("    la   $a0, newline");
	vFuncStmt.push_back("    syscall");
	vFuncStmt.push_back("    jr   $ra");
}

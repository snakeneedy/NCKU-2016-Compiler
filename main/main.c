#include "parser.h"

int yyparse();

int main(int argc, char **argv)
{
	extern FILE *yyin, *yyout;
	if (argc == 1)
	{
		cerr << argv[0] << ": No input file.\n";
		return 1;
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
	yyparse();
}

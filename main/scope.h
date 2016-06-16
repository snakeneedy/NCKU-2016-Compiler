/* scope.h */
#include <string>
#include <sstream>
#include <map>
using namespace std;
typedef int MyType;

struct Variable
{
	int addr;
	bool isArray;
	int size;
};

class Scope
{
public:
	Scope();
	~Scope();
	void def_var (string varName, int size = -1);
	string assign_var (string varName, int index = 0);
	string load_var (string varName, int index = 0);
private:
	map<string, Variable> varTable;
	int maxAddr;
};

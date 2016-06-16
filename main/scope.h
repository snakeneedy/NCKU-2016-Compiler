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
	void def_var (MyType type, string varName, int size);
	string assign_var (string varName, MyType value, int index);
	string load_var (string varName, int index);
private:
	map<string, Variable> varTable;
	int maxAddr;
};

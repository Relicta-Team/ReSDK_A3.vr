

// for fields decl(returntype)
//for function decl(returntype(param_type1;param_type2...))
/*examples:

	decl(int) testNumber = 3;
	decl(string[]) testArr = ["a","b","c"];
	decl(void()) testFuncNoReturn = {};
	decl(float(float;float)) testFuncAplusB = {params ["_a","_b"]; _a + _b};

	for template use <>:
	decl(map<string;int>) testMap = createhashmap [["a",1],["b",2]];
	decl(set<int>) testSet = hashMap_createList([1 arg 2 arg 3]);

	native types:
	simple:
		int,float,bool,string,
	special:
		void,any,code,thread_handle,namespace,text,config
	containers:
		array,map,set,ref,tuple
	visual objects:
		mesh,actor
	virtual types:
		object,struct
	ui:
		display,widget

	//for class and struct fields:
	class(ABS)
		decl(int) var(a,3);
	endclass

	struct(test)
		decl(string) def(str) "";
	endstruct
*/
#define decl(data)

//for macro enums
/*example:
	enum(AccessMode,ACCESS_MODE_)
	#define ACCESS_MODE_USER 1
	#define ACCESS_MODE_MODERATOR 2
	#define ACCESS_MODE_ADMIN 3

*/
#define enum(name,prefix)

//top-level namespace name prefix for functions
/*example: 
	namespace(noengine,noengine_)
	
	noengine_function1 = {};
	noengine_function2 = {};
	noengine_var1 = 1;
	noengine_var2 = false;

	* prefix will be added in rules:
	namespace(testNamespace,test_;test)

	test_fnc = {}; //in testNamespace because test_ prefix catch
	testFnc = {}; //in testNamespace because second test prefix catch
*/
#define namespace(ns_name,prefix)

//inline macrocode to real value
/* example:
	inline_macro
	#define GLOBAL_MACRO 1

	inline_macro
	#define TEST_CONST_STRING "hello"
*/
#define inline_macro

//specifier for constant variables
/* example:
	const decl(int) testvar = 123;
*/
#define const

//emplace macro value to constant in root module scope
/*	example:

	macro_const(noe_test_macro)
	#define TEST_MACRO 1
	->>>
	noe_test_macro = 1;

*/
#define macro_const(full_func_name)

//pragma for ignore file
#define ignore_this_file
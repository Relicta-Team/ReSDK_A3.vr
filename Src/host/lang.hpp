

// for fields decl(returntype)
//for function decl(returntype(param_type1;param_type2...))
/*examples:

	decl(int) testNumber = 3;
	decl(string[]) testArr = ["a","b","c"];
	decl(void()) testFuncNoReturn = {};
	decl(float(float;float)) testFuncAplusB = {params ["_a","_b"]; _a + _b};

	native types:
	simple:
		int,float,bool,string,
	special:
		void,any,code,thread_handle,namespace,text,config
	containers:
		array,map,set,ref
	visual objects:
		mesh,actor
	virtual types:
		object,struct
	ui:
		display,widget

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
*/
#define namespace(ns_name,prefix)

//pragma for ignore file
#define ignore_this_file
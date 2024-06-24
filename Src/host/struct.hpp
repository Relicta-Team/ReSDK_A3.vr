// structures management (hashmap objects)
// version 1.0
/*
	Structures are dynamic faster objects with automatically disposed them

	struct(TestStructure)
		def(variable) 3;
		def(method) {
			_v = self sget(variable);
			log(str _v);
		}
		? special methods
		def(copy) {}
		def(constructor) {}
		def(destructor) {}
	endstruct

	_o = struct_new(TestStructure);
	_o scall(method);
	_o oget(variable)
	_o oset(variable,3);

	flags
		"#create": Code - this is the hashmap object's constructor
		"#clone": Code - this is code happening when cloning is done on this hashmap object
		"#delete": Code - this is the hashmap object's destructor. It will always be executed inside missionNamespace.
		"#str": Code - code that is used to evaluate what is displayed when the str function is called on the object - must return String
		"#flags": Array of Strings - case-insensitive flags regarding this hashmap object
			"noCopy": forbids copying, +_hashMapObject will throw an error
			"sealed": prevents from adding and removing any keys - key values can still be edited
			"unscheduled": all methods (including #clone and #create) will be executed in unscheduled environment
		"#base": Array or HashMap - declaration of base class for inheritance
		"#type": Any - can be used to give a object a "type name", on inheritance types will be merged into an Array

*/
#define STRUCT_MEM_TYPE "#type"
#define STRUCT_MEM_BASE "#base"
#define STRUCT_MEM_TOSTRING "#str"
#define STRUCT_MEM_FLAGS "#flags"
#define STRUCT_MEM_CONSTRUCTOR "#create"
#define STRUCT_MEM_DESTRUCTOR "#delete"
#define STRUCT_MEM_COPY "#clone"

#define struct(name) _sdecl__ = [[STRUCT_MEM_TYPE, #name ], [STRUCT_MEM_FLAGS, ["unscheduled"], ["__dflg__",false] ] ];
#define base(basename) _sdecl__ pushBack [STRUCT_MEM_BASE, #basename ];
#define endstruct ;spi_lst pushBack _sdecl__;

#define isinstance(_inst_o,type_n) (type_n in (_inst_o get STRUCT_MEM_TYPE))

//define new field or method
//!all values located for objects of type in one address (reference equals)
#define def(varname) ;_soffst__ = _sdecl__ pushBack [#varname]; _sdecl__ select _soffst__ pushBack 

//method managemet
#define self _self
#define call(methodname) call [#methodname]
#define callp(methodname,params) call [#methodname,[params]]

//variables management
#define get(memname) GET #memname
#define set(memname,val__) SET [#memname,val__]

#define typename(o) (o GET STRUCT_MEM_TYPE select 0)

//instansing
#define new(name) (createHashMapObject [pts_##name])
#define newParams(name,arglist) (createHashMapObject [pts_##name,[arglist]])

//forced delete structure
#define delete(o) (o SET ["__dflg__",true];{if !(_y isequaltype {})then{o deleteAT _x};}FOREACH o)
#define isdeleted(o) (o get "__dflg__")

//native calling and helpers
#define nativeCall Call
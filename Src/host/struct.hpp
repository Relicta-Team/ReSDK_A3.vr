// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define STRUCT_API_VERSION 1.0
// enable fileinfo for structs. do not enable in release build
//#define STRUCT_USE_ALLOC_INFO

/*
	Structures are dynamic faster than locations objects with automatically memory management

	struct(Struct1) base(StructBase)
		def(testvar) 1;
		def(testvar2) false;
		def(testfunc)
		{
			_a = 1 + 2;
			_a //return
		}
	endstruct

	_o = struct_new(TestStructure);
	_o callv(method);
	_o callp(method,1 arg 2);
	_o getv(mem)
	_o setv(mem,1)


	* ==== Example of usage ====
	struct(TestStructure)
		def(variable) 3;
		def(method) {}
		? special methods
		def(copy) {} //copy constructor
		def(init) {} //constructor
		def(del) {} //destructor
		def(str) {} //string representation
	endstruct

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

	! Внимание !
	При создании структур с переменными все их значения располагаются по одному адресу в памяти.
	Это актуально как для ссылочных типов,так и для типов значений.
	Т.е. мы можем использовать константы как значения, получаемые без накладных расходов на доп вызов кода

	! Внимание 2 !
	? Вероятнее всего (нужно проверить) хэшобъекты не могут возвращать значение в переменную с помощью exitWith
	def(test) {params["_d"]; if(true) exitWith {123}}

	_o = ...
	private _var = _o call ["test",["hello"]];
	assert(!isNullVar(_var)) //!выбросит исключение...

*/

#ifndef EDITOR
	#undef STRUCT_USE_ALLOC_INFO
#endif

#define STRUCT_MEM_TYPE "#type"
#define STRUCT_MEM_BASE "#base"
#define STRUCT_MEM_TOSTRING "#str"
#define STRUCT_MEM_FLAGS "#flags"
#define STRUCT_MEM_CONSTRUCTOR "#create"
#define STRUCT_MEM_DESTRUCTOR "#delete"
#define STRUCT_MEM_COPY "#clone"

#define struct(name) _sdecl__ = [ [STRUCT_MEM_TYPE, #name ], [STRUCT_MEM_FLAGS, struct_default_flag], ["__dflg__",false] ];
#define base(basename) _sdecl__ pushBack [STRUCT_MEM_BASE, #basename ];
#define endstruct ;spi_lst pushBack _sdecl__;

#define isinstance(_inst_o,type_n) (#type_n in (_inst_o get STRUCT_MEM_TYPE))

//define new field or method
//!all values located for objects of type in one address (reference equals)
#define def(varname) ;_soffst__ = _sdecl__ pushBack [#varname]; _sdecl__ select _soffst__ pushBack 

//method managemet
#define self _self
//call function without parameters
#define callv(methodname) call [#methodname]
//call functions with parameters
#define callp(methodname,params) call [#methodname,[params]]
//call base version of any method
#define callbase(methodname) _this call(missionnamespace getvariable ("pts_"+(self GET STRUCT_MEM_TYPE select 1)) GET #methodname)

//variables management
#define getv(memname) get #memname
#define setv(memname,val__) set [#memname,val__]

#define struct_typename(o) ((o) GET STRUCT_MEM_TYPE select 0)

//instansing
#ifdef STRUCT_USE_ALLOC_INFO
	#define struct_new(name) (call{_sbj___ = [ pts_##name ] call struct_iallc; _sbj___ set ["__fileinfo__",__FILE__+ '+__LINE__']; _sbj___})
	#define struct_newp(name,arglist) (call{_sbj___ = [ pts_##name ,[arglist]] call struct_iallc; _sbj___ set ["__fileinfo__",__FILE__+ '+__LINE__']; _sbj___})
#else
	#define struct_new(name) ([ pts_##name ] call struct_iallc)
	#define struct_newp(name,arglist) ([ pts_##name ,[arglist]] call struct_iallc)
#endif

//forced delete structure
#define struct_free(o) o SET ["__dflg__",true];{if !(_y isequaltype {})then{o deleteAt _x};}foreach o
#define struct_erase(o) o SET ["__dflg__",true]; {o deleteAt _x}foreach o
#define struct_isdeleted(o) (o get "__dflg__")
//copy of object
#define struct_copy(rval) (+(rval))
//calling base method
#define struct_base_call(method) call (missionnamespace getvariable ("pts_"+ (self GET STRUCT_MEM_TYPE select 1) ) )

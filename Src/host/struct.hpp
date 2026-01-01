// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define STRUCT_API_VERSION 2.0
// enable fileinfo for structs. do not enable in release build
//#define STRUCT_USE_ALLOC_INFO

/*
	Structures are dynamic faster than locations objects with automatically memory management

	====================================
	====================================
	====================================

	How to use:

	1. Include this header in preloaded code. Before them include STRUCT_INIT_FUNCTIONS for generate functions
		#define STRUCT_INIT_FUNCTIONS
		#include "......\struct.hpp"
	2. Load or include your struct delcarations
		Optional you can use structlib for utility structures
		Load or inlcude StructLib.sqf
	3. After connection all structure declarations you must call initializator
		call struct_initialize

	If you need override base class for all structures define macro STRUCT_ROOT_TYPE on initialize functions:
		#define STRUCT_INIT_FUNCTIONS
		#define STRUCT_ROOT_TYPE StructTypeName
		#include "......\struct.hpp"
	For example this can be used for allocators

	====================================
	====================================
	====================================
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

	//macro for specific member names (rvengine-side)
	#define STRUCT_MEM_TYPE "#type"
	#define STRUCT_MEM_BASE "#base"
	#define STRUCT_MEM_TOSTRING "#str"
	#define STRUCT_MEM_FLAGS "#flags"
	#define STRUCT_MEM_CONSTRUCTOR "#create"
	#define STRUCT_MEM_DESTRUCTOR "#delete"
	#define STRUCT_MEM_COPY "#clone"

// ======================================================
// ======================================================
// ======================================================

// * * * * * * * * * * * * Declaration base * * * * * * * * * * * * 

#define struct(name) _t_vtable = spi_lst; _t_annot_ = []; _sdecl__ = [ [STRUCT_MEM_TYPE, #name ], [STRUCT_MEM_FLAGS, struct_default_flag], ["__dflg__",false] ];
#define base(basename) _sdecl__ pushBack [STRUCT_MEM_BASE, #basename ];
#define endstruct ;_t_vtable pushBack _sdecl__; if (count _t_annot_ > 0) then {_sdecl__ pushBack ["#type_annot_list",_t_annot_]};

/*
	private _obj = inline_struct(TestStruct)
		def(var)3;
		def(test_func) {
			_x = self getv(var);
			print(_x);
		}
	inline_endstruct;

	private _number = _obj getv(var);

	logformat("inline struct: %1", inline_struct(Obj) def(someValue) 123 inline_endstruct);
*/
#define inline_struct(name) call{ _sdecl__ = [ [STRUCT_MEM_TYPE, #name ], [STRUCT_MEM_BASE, vtable_s get "InlineStructBase__"], [STRUCT_MEM_FLAGS, struct_default_flag], ["__dflg__",false] ];

#define inline_endstruct ; private _sobj = createHashMapObject [_sdecl__,nil]; _sobj}



// * * * * * * * * * * * * Member declaration * * * * * * * * * * * *

//define new field or method
//!all values located for objects of type in one address (reference equals)
#define def(varname) ;_soffst__ = _sdecl__ pushBack [#varname]; _sdecl__ select _soffst__ pushBack 

//define new method for cast to type. Signature: $_ToType
/*
	def(value) 321;
	cast_def(int) { self getv(value) }
	...
	_i = struct_cast(o,int); //_i == 321
*/

#define def_null(varname) def(varname) null;

/*
	type annotation for fix bug #428
	def_ret(functest) 
	{
		if (true) exitWith {"can be with ret_def(), not def()"};
		"no returns..."
	}
*/
#define def_ret(varname) ;_t_annot_ pushBack ( #varname ); def(varname)

#define __STRUCT_CAST_PREFIX___ "$_"
#define cast_def(typeto) ;_soffst__ = _sdecl__ pushBack [__STRUCT_CAST_PREFIX___ + (#varname)]; _sdecl__ select _soffst__ pushBack 
#define static_def(t) setLastError("Static declarations are not supported in current version");


// * * * * * * * * * * * * Member access and call * * * * * * * * * * * *

//method managemet
#define self _self
//call function without parameters
#define callv(methodname) call [#methodname]
//call functions with parameters
#define callp(methodname,params) call [#methodname,[params]]
//call base version of any method
#define callbase(methodname) call{__STRUCT_CALLBASE__;'methodname'}
#define __STRUCT_CALLBASE_TOKEN__ "__STRUCT_CALLBASE__;"
#define __STRUCT_CALLBASE_REGEX__ "call\{__STRUCT_CALLBASE__;'(\w+)'\}"
#define __STRUCT_CALLBASE_REGEX_REPLACE_FORMAT__ "call\{__STRUCT_CALLBASE__;'%1'\}"

//variables management
#define getv(memname) get #memname
#define setv(memname,val__) set [#memname,val__]

#define modv(memname,val__) call { _this set [#memname, (_this get #memname) val__ ] }
#define incv(memname) modv(memname, + 1)
#define decv(memname) modv(memname, - 1)


// * * * * * * * * * * * * Type checking * * * * * * * * * * * *

#define isinstance(_inst_o,type_n) (#type_n in (_inst_o get STRUCT_MEM_TYPE))
#define isinstance_str(_inst_o,type_n) ((type_n) in (_inst_o get STRUCT_MEM_TYPE))

#define struct_typename(o) ((o) GET STRUCT_MEM_TYPE select 0)

#define struct_existType(o) (#o in vtable_s)
#define struct_existType_str(o) ((o) in vtable_s)

#define struct_isstruct(o) (STRUCT_MEM_TYPE in (o))

// * * * * * * * * * * * * Object management * * * * * * * * * * * *

//instansing
#ifdef STRUCT_USE_ALLOC_INFO
	#define struct_new(name) (call{_sbj___ = createHashMapObject[ pts_##name ,nil]; _sbj___ set ["__fileinfo__",__FILE__+ '+__LINE__']; _sbj___})
	#define struct_newp(name,arglist) (call{_sbj___ = createHashMapObject[ pts_##name ,[arglist]]; _sbj___ set ["__fileinfo__",__FILE__+ '+__LINE__']; _sbj___})
#else
	#define struct_new(name) (createHashMapObject[ pts_##name ,nil ])
	#define struct_newp(name,arglist) (createHashMapObject[ pts_##name ,[arglist]])
#endif

//forced delete structure
#define struct_free(o) o SET ["__dflg__",true];{if !(_y isequaltype {})then{o deleteAt _x};}foreach o
#define struct_erase(o) o SET ["__dflg__",true]; {o deleteAt _x}foreach o
#define struct_isdeleted(o) (!isnil{o get "__dflg__"})
//copy of object
#define struct_copy(rval) (+(rval))


// * * * * * * * * * * * * Type casting * * * * * * * * * * * *
/*
	For cast struct for special type

	struct(Vec3)
		def(_x) 0; def(_y) 0; def(_z) 0;
		cast_def(Array)
		{
			[self getv(_x),self getv(_y),self getv(_z)]
		}
		cast_def(int)
		{
			floor (self getv(_x) + self getv(_y) + self getv(_z))
		}
	endstruct
*/
#define struct_cast(o,typeto) o call [__STRUCT_CAST_PREFIX___ + #typeto]

//TODO implement
// //#define struct_callstat(Typename,static_func)


// * * * * * * * * * * * * Internal * * * * * * * * * * * *
/*
	! Not implemented in current version
	special operator overloading
	def(num) 0;
	operator_def(=)
	{
		params ["_rval"];
		_rval setv(num,_rval getv(num) + 1);
		_rval;
	}
	operator_def(+)
	{
		params ["_rval"];
		self setv(num,self getv(num) + _rval);
	}

	op_call(_struct, 	=  ,3); // _struct = _struct callp(operator_=,3);

	opcall(_s,	+	,5); // _s callp(operator_+,5);
*/


#define ___struct_root_instr(v) #v

#ifdef STRUCT_ROOT_TYPE
	#define __STRUCT_CHECK_ROOT	\
		private _structRootName = ___struct_root_instr(STRUCT_ROOT_TYPE); \
		if !(_structRootName in _bmap) exitWith { \
			private _eMessage = format["Structure type %1 not found; Disable flag STRUCT_ROOT_TYPE or declare that struct",_structRootName]; \
			setLastError(_eMessage); \
		};

	//if base not root type - change base type
	#define __STRUCT_REDEFINE_BASE \
		if not_equals(_x,_structRootName) exitWith {_structRootName};


#else
	#define __STRUCT_CHECK_ROOT
	#define __STRUCT_REDEFINE_BASE
#endif



#ifdef STRUCT_INIT_FUNCTIONS

	spi_lst = []; //preinit structures list
	vtable_s = createHashMap;
	vt_cast = createHashMap; //cast table
	struct_default_flag = ["unscheduled"];
	strt_inh = createHashMap; //struct inheritance table
	strt_inhChld = createHashMap; //struct inheritance table of all childrens
	struct_initialize = {
		assert(regex_replace);

		private _t = null;
		private _decl = null;
		//first pass - creating vtable and setup into vtable map
		private _bmap = createHashMap;
		private _undefFields = null;
		private _weakDecl = null;
		private _weakDeclMap = createHashMap;
		{
			//fill all fields with null values
			_undefFields = _x select {count _x==1};
			{
				_x append [nil];
				;false
			} count _undefFields;

			_decl = createHashMapFromArray _x;
			_t = _decl deleteAt "init";
			if !isNullVar(_t) then {
				_decl set [STRUCT_MEM_CONSTRUCTOR,_t];
			};
			
			_t = _decl deleteAt "del";
			if !isNullVar(_t) then {
				_decl set [STRUCT_MEM_DESTRUCTOR,_t];
			};

			_t = _decl deleteat "copy";
			if !isNullVar(_t) then {
				_decl set [STRUCT_MEM_COPY,_t];
			};

			_t = _decl deleteat "str";
			if !isNullVar(_t) then {
				_decl set [STRUCT_MEM_TOSTRING,_t];
			};

			_t = _decl deleteat "#type_annot_list";
			if !isNullVar(_t) then {
				
				private _cde_ = null;
				//get unique
				_t = _t arrayIntersect _t;

				//recompile
				{
					_cde_ = _decl get _x;
					if (_cde_ isequaltype {}) then {
						//update code
						_cde_ = compile (["call{", toString _cde_, "}"] joinString " ");
						//save
						_decl set [_x,_cde_];
					};
				} foreach _t;
			};

			//["Load struct %1",_decl get STRUCT_MEM_TYPE] call logInfo;
			//virtual check
			{
				if isNullVar(_y) then {continue};

				if (equalTypes(_y,{})) then {

					private _code__ = toString _y;
					if !(__STRUCT_CALLBASE_TOKEN__ in _code__) exitWith {};

					//match
					private _signatures = [_code__,__STRUCT_CALLBASE_REGEX__] call regex_getMatches;
					private _mname = null;
					_mother = _decl get STRUCT_MEM_BASE;
					//replace tokens
					{
						_mname = [_x,"'(\w+)'",1] call regex_getFirstMatch;
						_code__ = [_code__,
							format[__STRUCT_CALLBASE_REGEX_REPLACE_FORMAT__,_mname],
							format["(_this call (pts_%1 get '%2'))",_mother,_mname]
						] call regex_replace
					} foreach _signatures;

					//update code
					_decl set [_x,compile _code__];
				}
			} foreach _decl;
			
			missionnamespace setvariable ["pts_"+(_decl get STRUCT_MEM_TYPE),_decl];
			vtable_s set [_decl get STRUCT_MEM_TYPE,_decl];
			_bmap set [_decl get STRUCT_MEM_TYPE,_decl];
			
			//creating type only with type and base fields
			_weakDecl = createHashMapFromArray [
				[STRUCT_MEM_TYPE,_decl get STRUCT_MEM_TYPE]
			];
			
			if (STRUCT_MEM_BASE in _decl) then {
				_weakDecl set [STRUCT_MEM_BASE,_decl get STRUCT_MEM_BASE];
			};
			
			_weakDeclMap set [_weakDecl get STRUCT_MEM_TYPE,_weakDecl];
			strt_inhChld set [_weakDecl get STRUCT_MEM_TYPE,[]]; //generate empty child list
		} foreach spi_lst;

		//check base
		__STRUCT_CHECK_ROOT

		//second pass - inheritance
		{
			_declFrom = _y;
			_tnTo = _declFrom get STRUCT_MEM_BASE;
			if isNullVar(_tnTo) then {
				__STRUCT_REDEFINE_BASE
				continue
			};
			
			_declTo = _bmap get _tnTo;
			if !isNullVar(_declTo) then {
				_declFrom set [STRUCT_MEM_BASE,_declTo];
				//
				_weakDeclMap get _x set [STRUCT_MEM_BASE,_weakDeclMap get _tnTo];
			};
		} foreach _bmap;

		//third pass - register mother types
		private _tList = null;
		private _baseName = null;
		{
			_baseName = _x;
			_tList = (createHashMapObject[_y]) get STRUCT_MEM_TYPE;
			{
				(strt_inhChld get _x) pushBack _baseName;
			} foreach (_tList select [1]);
			strt_inh set [_x,_tList];
		} foreach _weakDeclMap;
	};


	#define STRUCT_INIT_ENABLE_REINITIALIZE_LOGGING
	//!ОБНОВЛЕННЫЕ ТИПЫ ЗАРАБОТАЮТ ТОЛЬКО ДЛЯ НОВЫХ ИНСТАНСОВ
	struct_reinitialize = {
		params ["_path"];
		spi_lst = [];
		call compile preprocessFileLineNumbers _path;
		{
			private _undefFields = _x select {count _x==1};
			{
				_x append [nil];
				;false
			} count _undefFields;

			private _decl = createHashMapFromArray _x;
			private _class = _decl get STRUCT_MEM_TYPE;
			private _baseClass = _decl get STRUCT_MEM_BASE;
			private _vtableCur = vtable_s get _class;
			private _currentMethods = createhashmap;

			#ifdef STRUCT_INIT_ENABLE_REINITIALIZE_LOGGING
				["Reinitialize struct %1",_class] call cprint;
			#endif

			{
				if equalTypes(_y,{}) then {
					#ifdef STRUCT_INIT_ENABLE_REINITIALIZE_LOGGING
						["  found method %1",_x] call cprint;
					#endif
					_currentMethods set [_x,_y];
				};
			} foreach _vtableCur;

			//rename system methods
			private _t = _decl deleteAt "init";
			if !isNullVar(_t) then {
				_decl set [STRUCT_MEM_CONSTRUCTOR,_t];
			};
			_t = _decl deleteAt "del";
			if !isNullVar(_t) then {
				_decl set [STRUCT_MEM_DESTRUCTOR,_t];
			};
			_t = _decl deleteat "copy";
			if !isNullVar(_t) then {
				_decl set [STRUCT_MEM_COPY,_t];
			};
			_t = _decl deleteat "str";
			if !isNullVar(_t) then {
				_decl set [STRUCT_MEM_TOSTRING,_t];
			};

			//path methods
			{
				[_x,_y] params ["_memname","_code"];
				if equalTypes(_code,{}) then {
					_currentMethods deleteAt _memname;
					
					private _code__ = toString _code;
					if !(__STRUCT_CALLBASE_TOKEN__ in _code__) exitWith {
						#ifdef STRUCT_INIT_ENABLE_REINITIALIZE_LOGGING
							["  valid method %1",_memname] call cprint;
						#endif
						_vtableCur set [_memname,_code];
					};

					//match
					private _signatures = [_code__,__STRUCT_CALLBASE_REGEX__] call regex_getMatches;
					private _mname = null;
					//replace tokens
					{
						_mname = [_x,"'(\w+)'",1] call regex_getFirstMatch;
						_code__ = [_code__,
							format[__STRUCT_CALLBASE_REGEX_REPLACE_FORMAT__,_mname],
							format["(_this call (pts_%1 get '%2'))",_baseClass,_mname]
						] call regex_replace
					} foreach _signatures;

					//update code
					_vtableCur set [_memname,compile _code__];
					#ifdef STRUCT_INIT_ENABLE_REINITIALIZE_LOGGING
						["  path method %1",_memname] call cprint;
					#endif
				};
						
			} foreach _decl;

			if (count _currentMethods > 0) then {
				{
					#ifdef STRUCT_INIT_ENABLE_REINITIALIZE_LOGGING
						["  delete method %1",_x] call cprint;
					#endif
					_vtableCur deleteAt _x;
				} foreach _currentMethods;
			};
		} foreach spi_lst;
	};

	struct_alloc = {
		params ["_s","_params"];
		
		#ifdef STRUCT_USE_ALLOC_INFO
		private _s = 
		#endif

		if isNullVar(_params) then {
			createHashMapObject[vtable_s get _s];
		} else {
			createHashMapObject[vtable_s get _s,_params];
		};
		
		#ifdef STRUCT_USE_ALLOC_INFO
			_s set ["__fileinfo__",'stack:'+(str diag_stacktrace)];
			_s
		#endif
	};

	struct_eraseFull = {
		params ["_o"];
		struct_erase(_o)
	};

	struct_reflect_getTypeValue = {
		params ["_typename","_varname"];
		if not_equalTypes(_typename,"") then {
			_typename = struct_typename(_typename);
		};
		private _type = missionNamespace getvariable ("pts_"+_typename);
		if isNullVar(_type) exitWith {null};
		private _val = _type get _varname;
		if isNullVar(_val) then {
			while {isNullVar(_val)} do {
				_type = _type get STRUCT_MEM_BASE;
				_val = _type get _varname;
			};
			_val
		} else {
			_val
		};
	};

	struct_getAllTypesOf = {
		params ["_typename"];
		array_copy(strt_inhChld get _typename)
	};

	struct_getBaseTypesOf = {
		params ["_typename"];
		array_copy(strt_inh get _typename)
	};

#endif
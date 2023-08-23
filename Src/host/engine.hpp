// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\SETTINGS.h>
//generated version macros
#include <..\version.hpp>

//platform specific
//! dont use on client, because compiled client (CONTENT-file) used vm-compiler. Only server and editor allowed
#define PLATFORM_VERSION '__GAME_VER__'
#define PLATFORM_VERSION_MAJ __GAME_VER_MAJ__
#define PLATFORM_VERSION_MIN __GAME_VER_MIN__
#define PLATFORM_VERSION_BUILD __GAME_BUILD__


//external override
#ifdef RELEASE
	#undef __TRACE__ENABLED
#endif


#define ENABLE_LINE_IN_FILES

#ifdef ENABLE_LINE_IN_FILES
	#define __pragma_preprocess preprocessFileLineNumbers
#else
	#define __pragma_preprocess preprocessFile
#endif

#define __pragma_prep_cli preprocessFile

//simple implementation of regions
#define region(name)
#define endregion

// logger
#define arg ,

//args struct
#define args1(a) a
#define args2(a,b) a,b
#define args3(a,b,c) a,b,c
#define args4(a,b,c,d) a,b,c,d
#define args5(a,b,c,d,e) a,b,c,d,e
#define args6(a,b,c,d,e,f) a,b,c,d,e,f

#define conDllCall "debug_console" callExtension

#define log(message) [message] call cprint
#define logformat(provider,formatText) [provider,formatText] call cprint

/*#define warning(message) "debug_console" callExtension ("WARN: " + message + "#1101"); [message] call discWarning
#define error(message) "debug_console" callExtension ("ERROR: " + message + "#1001"); [message] call discError

#define warningformat(message,fmt) "debug_console" callExtension (format ["WARN: " + message + "#1101",fmt]); [format[message,fmt]] call discWarning
#define errorformat(message,fmt) "debug_console" callExtension (format ["ERROR: " + message  + "#1001",fmt]); [format[message,fmt]] call discError*/
/// -------------------------------------- FUNCTIONAL PRINTS ---------------------------------------
#define warning(message) [message] call cprintWarn
#define error(message) [message] call cprintErr

#define warningformat(message,fmt) [message,fmt] call cprintWarn
#define errorformat(message,fmt) [message,fmt] call cprintErr

/// ------------------------------------ FUNCTIONAL PRINTS -----------------------------------------

#ifdef __TRACE__ENABLED
	#define trace(message) "debug_console" callExtension ("TRACE: " + message + "#1011");
	#define traceformat(message,fmt) "debug_console" callExtension (format ["TRACE: " + message + "#1011",fmt]);

	//breakpoints
	#define breakpoint_setfile(x) __bp__file__ = x;
	#define breakpoint(data) "__REDIRECT_KEYWORD_THIS_REQUIRED__" call{private __bp_l = __LINE__;private __bp_f = "<anon>"; if !isNullVar(__bp__file__)then{__bp_f=__bp__file__};\
	traceformat("L%1 [%2]	%3",__bp_l arg __bp_f arg data)\
	};
#else
	#define trace(message)
	#define traceformat(message,fmt)

	#define breakpoint_setfile(x)
	#define breakpoint(data)
#endif




#define OBSOLETE(funcname) private _dt = format ["[OBSOLETE] => %1(): This function will be removed in the future and should not be used." + "#1101", #funcname]; "debug_console" callExtension _dt; [_dt] call discWarning;

#define NOTIMPLEMENTED(funcname) private _dt = format ["[NOT_IMPLEMENTED] => %1(): This function not implemented." + "#1101", #funcname]; "debug_console" callExtension _dt; [_dt] call discWarning;

//закрытие потока программы
#define ___appexitstr(value) #value
#define appExit(exitCode) logformat("Application exited. Reason: %1 (%2)",exitCode arg __appexit_listreasons select exitCode); if (!isMultiplayer) then {client_isLocked = true; server_isLocked = true; endMission "END1";} else {if (isServer) then {server_isLocked = true} else {client_isLocked = true}}
	#define __appexit_listreasons (["EXIT" \
	,"CRITICAL" \
	,"DOUBLEDEF" \
	,"UNDEFINEDMODULE" \
	,"COMPILATIOEXCEPTION" \
	,"RUNTIMEERROR" \
	,"ASSERTION_FAIL" \
	,"EXTENSION_ERROR" \
	])apply{"APPEXIT_REASON_"+_x}

	#define APPEXIT_REASON_EXIT 0
	#define APPEXIT_REASON_CRITICAL 1
	#define APPEXIT_REASON_DOUBLEDEF 2
	#define APPEXIT_REASON_UNDEFINEDMODULE 3
	#define APPEXIT_REASON_COMPILATIOEXCEPTION 4
	#define APPEXIT_REASON_RUNTIMEERROR 5
	#define APPEXIT_REASON_ASSERTION_FAIL 6
	#define APPEXIT_REASON_EXTENSION_ERROR 7


// fread subsystem

//this is really need?
#ifdef _SQFVM
	#define DISABLE_REGEX_ON_FILE
#endif

//__THIS_FILE_REPLACE__
//__THIS_MODULE_REPLACE__
#ifdef DISABLE_REGEX_ON_FILE
	#define loadFile(path) if (server_isLocked) exitWith {error("Compile process aborted - server.isLocked == true")}; logformat("Start loading file %1",path); ["Load file - '%1'",path] call logInfo;  call compile __pragma_preprocess (path)

	#define importClient(path) if (isNil {allClientContents}) then {allClientContents = [];}; if (client_isLocked) exitWith {error("Compile process aborted - client.isLocked == true")}; \
	private _ctx = compile __pragma_prep_cli (path); if (_canCallClientCode) then {call _ctx}; allClientContents pushback _ctx;

	#define importCommon(path) if (isNil {allClientContents}) then {allClientContents = [];}; \
	private _ctx = compile __pragma_prep_cli ("src\host\CommonComponents\" + path); \
	if (_canCallClientCode) then {call _ctx}; allClientContents pushback _ctx;
#else
	#define loadFile(path) if (server_isLocked) exitWith {error("Compile process aborted - server.isLocked == true")}; logformat("Start loading file %1",path); ["Load file - '%1'",path] call logInfo; call compile __pragma_preprocess (path)

	#define importClient(path) if (isNil {allClientContents}) then {allClientContents = [];}; if (client_isLocked) exitWith {error("Compile process aborted - client.isLocked == true")}; \
	_macro_module = path regexFind ["\w+(?=\.)",0] select 0 select 0 select 0; \
	private _ctx = compile ((__pragma_prep_cli (path))regexReplace ["__THIS_MODULE_REPLACE__",""""+ _macro_module+""""]); if (_canCallClientCode) then {call _ctx}; allClientContents pushback _ctx;

	#define importCommon(path) if (isNil {allClientContents}) then {allClientContents = [];}; \
	_macro_file = """shared" +"\" + path + """"; _macro_module = path regexFind ["\w+(?=\.)",0] select 0 select 0 select 0; \
	__prep = ((__pragma_prep_cli ("src\host\CommonComponents\" + path)) regexReplace ["__THIS_FILE_REPLACE__",(_macro_file regexReplace ["\\","\\\\"])]) regexReplace ["__THIS_MODULE_REPLACE__",""""+ _macro_module+""""]; \
	private _ctx = compile __prep; \
	if (_canCallClientCode) then {call _ctx}; allClientContents pushback _ctx;
#endif

#ifdef __VM_VALIDATE
	#define __vm_log(text) "debug_console" callExtension ((text)+"#1110")

	#define loadFile(path) \
	__vm_log("Load file: " + path); \
	call compile preprocessFile (path);

	#define __vm_warning(data) diag_log format["[VM_WARN]: %1",data];


	#define locationnull 0
	#define is3DEN true

	#define addMissionEventHandler ["addMissionEventHandler"] pushBack 

	#define toString str
	#define linearConversion ["linearConversion"] pushBack 
	#define parseSimpleArray ["parseSimpleArray"] pushBack 
	#define endMission ["endMission"] pushBack 
	//for randInt
	#define FLOOR 
	
	#define NO_VM_EXECUTE if (true) exitwith {};
#else
	#define __vm_log(text)
	#define __vm_warning(data)
	
	#define NO_VM_EXECUTE
#endif

#ifdef __GH_ACTION
	#define __vm_log(text) diag_log (text)
#endif
#ifdef __VM_BUILD
	#define __vm_log(text) "debug_console" callExtension ((text)+"#1110")
#endif

//check if file exists
#define fileExists(file) fileexists (file)

#define SHORT_PATH call {private _arr = __FILE__ splitString "\"; private _ret = ""; if (!isMultiplayer) then \
{ {if (_foreachindex >= 8) then {_ret = _ret + "\" + _x}} forEach _arr } else { \
_ret = __FILE__; \
}; _ret select [1,count _ret - 1]} \

//TODO fix path
#define SHORT_PATH_CUSTOM(d__) (d__) call {private _arr = _this splitString "\"; private _ret = ""; if (!isMultiplayer) then \
{ if ("relicta.vr" in _arr) then {_ret = (_arr select [(_arr find "relicta.vr")+1,count _arr]) joinString "\"} else {_ret = _this}; } else { \
_ret = _this; \
}; _ret} \



//common macro
#define null nil

#define isNull(val) (isnil{val})
#define isNullReference(obj) (isNULL (obj))
#define isNullVar(var) (isnil 'var')

//Определяет значение переменной
#define defIsNull(_v,_defval) if isNullVar(_v) then {_defval} else {_v}
//Распаковывает ссылку на переменную из верхнего уровня если существует
#define outRef(var,def) var = if isNullVar(var) then {def} else {var}

//prob correct??? (rewrite)
#define isNullPtr(obj) (obj isequaltypeany [locationnull,controlnull,objnull,displaynull])

#define isReference(obj) (obj isequaltypeany [locationnull,controlnull,objnull,displaynull])

/* NON-USABLE MACROS
#define isRefType(val) (val isEqualTypeAny [locationnull,controlnull,objnull,displaynull])
#define isValType(val) !isRefType(val)
*/

//string help
#define stringEmpty ""

//mem check
// Осуществляет проверку значения в стиле C++. Любые nullable значения вернут false
#define isValid(ptr) ([ptr] call rv_cppcheck)
//псевдоним if (valid(modlue_somevariable))
#define valid(ptr) ([ptr] call rv_cppcheck)
// alias to valid
#define bool(val) valid(val)

//
#define __gptr_os (selectrandom table_hex)
#define generatePtr (__gptr_os + __gptr_os + __gptr_os + __gptr_os + __gptr_os)

//math
/*
bool TestRange (int numberToCheck, int bottom, int top)
{
  return (numberToCheck >= bottom && numberToCheck <= top);
}
*/
//Проверка диапазона
#define inRange(numberToCheck,bottom,top) ((numberToCheck) >= bottom && (numberToCheck) <= top)

#define boolToInt(bval) ([0,1]select (bval))

//получить процент от числа
#define precentage(checked,precval) ((checked)*(precval)/100)

// формат в игровое время мин и сек (часы вряд-ли где-то юзаются)
#define formatTime(secs) (secs call{format["%1 мин. %2 сек.",floor(_this / 60),_this % 60]})

//форматирование времени: каст секунды в минуты
#define t_asMin(s) ((s)*60)
#define t_asHrs(s) ((s)*3600)

#define INFINITY 1e39

#define INC(var) var = var+1
#define DEC(var) var = var-1

//Возможно тут проблема при конкатенации строк с присутствием в них запятых
#define MOD(var,val) var = var val
#define modvar(var) var = var

//array helpers
#define MODARR(var,index,modif) var set[index,(var select(index)) modif]
#define SETARR(arr,index,val) arr set[index,val]
#define GETARR(arr,index) arr select(index)

#define array_exists(arr,var) ((var)in arr)
//рандомный сорт массива
#define array_shuffle(array) (array call BIS_fnc_arrayShuffle)
//копирование массива
#define array_copy(array) (+(array))
//poplast
#define array_remlast(arr) (arr call {_this deleteAt (count _this - 1)})
//select last item
#define array_selectlast(arr) (arr call {_this select (count _this - 1)})
// check if array empty
#define array_isempty(arr) (count(arr)==0)
//check array elements count
#define array_count(arr) (count (arr))

#define array_remove(array,el) ([array,el] call {params["_a","_e"]; _a deleteAt(_a find _e)})

#define vec1(x) [x]
#define vec2(x,y) [x,y]
#define vec3(x,y,z) [x,y,z]
#define vec4(x,y,w,h) [x,y,w,h]


//reference packer
#define refcreate(value) [value]
#define refget(val) (val select 0)
#define refset(ref,newvalue) ref set[0,newvalue]
#define refunpack(ref) ref = (ref select 0)

//Engine Common Pointers
/*
	_val = ptr_alloc("test string");
	_copy = _val;
	ptr_set(_val,"3");
	_copy == _val //true
	ptr_get(_val) //"3"
	ptr_free(_val)
	_copy == nullptr //true

	//new fnc
	_v = ptr_alloc(123);
	//setval
	ptr(_v) 3;
	//check ptr
	if isptr(_v) then {1} else {0} //1
*/
#define __ptr_struct_internal__(address,value) vec2(address,value)
#define nullptr ptr_cnl
#define ptr_alloc(initial) ((initial)call ptr_create)
#define ptr_free(refval) ((refval)call ptr_destroy)
	//internal ptr helpers
	#define PTR_STRUCT_ADDRESS 0
	#define PTR_STRUCT_VALUE 1
	//simple commands
	#define ptr_address(p) ((p)call ptr_cts)
	#define ptr_read(p) ((p)select PTR_STRUCT_VALUE)
	#define ptr_write(p,v) (p)set[PTR_STRUCT_VALUE,v]
	//functionality
	#define ptr_modvar(p) _poldvm_g_=0;(p call ptr_remval)pushBack _poldvm_g_
	#define ptr_inc(p) _poldvs_g_=(p)select PTR_STRUCT_VALUE;p set[PTR_STRUCT_VALUE,_poldvs_g_+1];
	#define ptr_dec(p) _poldvs_g_=(p)select PTR_STRUCT_VALUE;p set[PTR_STRUCT_VALUE,_poldvs_g_-1];
	//fast set value
	#define ptr(p) _poldvm_g_=0;(p call ptr_remval)pushBack
	//check is ptr
	#define isptr(p) ((p)call ptr_check)

//hash set
#define hashSet_createEmpty() createHashMap
#define hashSet_create(keys) ((keys)createHashMapFromArray [])
#define hashSet_createList(vals) ([vals]createHashMapFromArray [])
#define hashSet_add(hash,item) (hash)set [item,nil]
#define hashSet_toArray(hash) (keys(hash))
#define hashSet_rem(hash,item) (hash)deleteAt (item)
#define hashSet_exists(hash,item) ((item)in(hash))
#define hashSet_count(hash) (count(hash))
#define hashSet_clear(hash) (hash)call{{_this deleteat _x}foreach +_this}
#define hashSet_copyFrom(hash,merged) (hash)merge (merged)

//hashmap
#define hashMapNew createHashMap
#define hashMapNewArgs createHashMapFromArray

// assign logics
/*
	prop(testvar) = "";

	asigncounter = 0;
	onpropset(testvar) = {
		INC(asigncounter);
		testvar = _this;
	};

	onpropget(testvar) = {
		testvar
	};

	propset(testvar,"message 1");
	propset(testvar,propget(testvar) + " and ");
	propset(testvar,"clear");
	logformat("asigncounter equals 3 = %1; testvar equals clear = %2",asigncounter == 3 arg propget(testvar) == "clear")
*/
#define prop(varname) varname
#define onpropset(varname) varname##_set
#define onpropget(varname) varname##_get
#define propset(varname,val) val call onpropset(varname)
#define propget(varname) call onpropget(varname)

// scripted events
/*
	registerEventHandler(onSystemPrint);

	systemPrint = {
		private _message = "Hello world!!";
		log(_message);
		callEventHandler(onSystemPrint,_message);
	};

	addEventHandler(onSystemPrint,{warning("First")});
	addEventHandler(onSystemPrint,{warning("second. Message was: " + eventHandlerArgs)});

	call systemPrint;
*/

// preprocessing protect to native function eventhandler
#define objectAddEventHandler ADDEVENTHANDLER

#define __eventHandlerName__(varname) varname##_evh
#define eventHandlerArgs _evhargs__
#define registerEventHandler(varname) __eventHandlerName__(varname) = []
#define addEventHandler(varname,val) __eventHandlerName__(varname) pushBack (val)
#define removeEventHandler(varname,val) __eventHandlerName__(varname) deleteat (__eventHandlerName__(varname) find (val))
#define callEventHandler(varname,evhargs) private eventHandlerArgs = evhargs; {call _x;true} count __eventHandlerName__(varname)

// simple object creator
/*
	ps_##name = [["typeName",#name
		],[#varname,1],[#varname,2
	]];

	structCreate(tempStruct)
		structVar(a) 1
		structVar(b) 2
	structEnd

	_s = structNew(tempStruct);


*/
#define structCreate(name) ps_##name = [["typeName",#name
#define structEnd ]];

#define structVar(varname) ],[#varname,

#define structNew(name) (createHashMapFromArray ps_##name)
//accessing struct
#define structSet(obj,varname,varval) obj set [#varname,varval]
#define structGet(obj,varname) (obj get #varname)

//comparsion

#define equals(obja,objb) ((obja)isequalto(objb))
#define not_equals(obja,objb) ((obja)isnotequalto(objb))


#define equalTypes(obja,objb) ((obja)isequaltype(objb))
#define not_equalTypes(obja,objb) (!equalTypes(obja,objb))

//random helpers
#define pick selectRandom
//выбор рандомного числа включительно Bis_fnc_randomNum
#define rand(_beg,_end) (linearConversion [0,1,random 1,_beg,_end])
//BIS_fnc_randomInt
#define randInt(_beg,_end) (FLOOR linearConversion [0,1,random 1,(_beg)min(_end),(_end)max(_beg)+1])

#define prob(val) (random[0,50,100]<(val))

//math helpers
#define pow(a,b) ((a) ^ (b))

//Ограничение числа
#define clamp(val,__min,__max) ((val)max(__min)min(__max))

#define clampangle(x,a,b) (((((x) % 360 + 360) % 360) max (a)) min (b))

#define parseNumberSafe(v) ((parseNumber (v)) call {if(finite _this) then {_this} else {0}})

//delay subsystem

#define netTickTime CBA_missionTime
#define tickTime diag_tickTime
#define deltaTime diag_deltaTime

#define startUpdate(func,delay) [func,delay] call CBA_fnc_addPerFrameHandler
#define startUpdateParams(func,delay,params) [func,delay,params] call CBA_fnc_addPerFrameHandler

#define stopUpdate(handle) handle call CBA_fnc_removePerFrameHandler

#define thisUpdate (_this select 1)

#define stopThisUpdate() stopUpdate(_this select 1)

#define changeUpdateTime(handle,newTime) (call {if (handle < 0 || newTime < 0) exitWith {false}; \
cba_common_perFrameHandlerArray select (handle) set [1,newTime]; true})

#define changeThisUpdateTime(newTime) changeUpdateTime(thisUpdate,newTime)

#define getThisCodeInTimeEvent(varname) varname = _x select 1

#define nextFrame(code) [code] call CBA_fnc_execNextFrame
#define nextFrameParams(code,args) [code,args] call CBA_fnc_execNextFrame

#define invokeAfterDelay(code,delay) [code,[],delay] call CBA_fnc_waitAndExecute
#define invokeAfterDelayParams(code,delay,params) [code,params,delay] call CBA_fnc_waitAndExecute

	/*

		deferred
		{

		}
		doInvoke(3)

	*/
	#define deferred __cframe__=
	#define doInvoke(delay) ;invokeAfterDelay(__cframe__,delay)
	#define doInvokeParams(delay,_prms) ;invokeAfterDelayParams(__cframe__,delay,_prms)

#define asyncInvoke(c_condit,c_state,args,timeout,c_tim) [c_condit, c_state, args,timeout,c_tim] call CBA_fnc_waitUntilAndExecute

#define startAsyncInvoke [
#define endAsyncInvoke ] call CBA_fnc_waitUntilAndExecute;


//lang helpers

#define ifcheck(val,_trueval,_falseval) (if(val)then{_trueval}else{_falseval})

#define FHEADER scopename "main"

#define RETURN(val) (val) breakout "main"

#define IF(val) if (val) then

#define IF_EXIT(val) if (val) exitwith

#define IF_RET(val,ret) if (val) then {RETURN(ret)}

#define FOR(init,start,end) for #init from start to end do

#define WHILE(cond) while {cond} do

#define SWITCH(cond) switch(cond) do

#define CASE(cond) case (cond) :

// extended language helpers
#define fswitch(val) (val) call
#define fcase(val) if equals(_this,val) exitWith
#define fcasein(values) if (_this in (values)) exitWith


//sound engine

#define soundDataDef(path) [path]
#define soundData(path,pithmin,pithmax) [path,pithmin,pithmax]

//Получает рандомный питч от 0.5 до 2
#define getRandomPitch (linearConversion [0, 1, random 1, 0.5, 2])

#define getRandomPitchInRange(low,up) (linearConversion [0, 1, random 1,low, up])

//small protect

//#define DISABLE_POINTER_CRIPT

#ifdef DEBUG
#define DISABLE_POINTER_CRIPT
#endif

//pointer cript
#ifdef DISABLE_POINTER_CRIPT
	#define criptPtr_index 0
	#define criptPtr(val) (val)
#else
	#define criptPtr_index 32
	#define criptPtr(val) (toString (toarray (val) apply {_x + criptPtr_index}))
#endif

//versioning arma
#define getArmaVersion() (format ["%1.%2",(productVersion select 2)/100 toFixed 2,(productVersion select 3)])


//data managment
#ifdef DATA_MANAGER_ENABLED

	//определяем имя модуля
	#define defineModule(name) _thisModule = 'name';

	#define global_var(var) [#var,__FILE__,__LINE__,_thisModule] call gv_rv; var
	#define global_func(var) [#var,__FILE__,__LINE__,_thisModule] call gv_rf; var
	/*
		global_var(lobby_isReady) = true;
		global_func(cm_isLoaded) {

		};

		//decl

		global_var(lobby::isReady) true;
		global_func(g::testfunc(a,b,c)) { } // compilation change args

	*/
	//critical safe data
		//register for type-safety variable
	#define __iglob_provider(var,type) [#var,type] call gv_rts
	#define global_num(var) __iglob_provider(var,0)
	#define global_str(var) __iglob_provider(var,"")
	#define global_arr(var) __iglob_provider(var,[])
	#define global_obj(var) __iglob_provider(var,objnull)
	#define global_ptr(var) __iglob_provider(var,locationnull)
#endif

#define __aps_on_assert_exit appExit(APPEXIT_REASON_ASSERTION_FAIL)
#ifndef ENABLE_EXIT_ON_ASSERT
	#define __aps_on_assert_exit 
#endif

//assertion

//При билдинге/валидации может быть задействовано сервером. 
//В режиме игры на клиенте и сервере срабатывает только при компиляции модулей скриптов

#define __ASSERT_WEBHOOK_PREFIX__ "<@&1137382730074697728> "

#define __assert_value_tostring__(val) 'val'

#define __assert_runtime_file__ __FILE__

#define __EVAL_PATH_VM__(filepath) (filepath) call { \
private _arr = (tolower _this) splitString "\/"; private _ret = ""; if ("src" in _arr) then {_ret = (_arr select [(_arr find "src"),count _arr]) joinString "\" \
} else {_ret = _this};\
_ret} \

#ifdef __VM_BUILD
	#define __assert_runtime_file__ __EVAL(call compile '_ref = toArray __FILE__;{if (_x <= 0)then{_ref set [_foreachindex,32]}} foreach _ref; __EVAL_PATH_VM__(TOString _ref)')
	#define __assert_value_tostring__(val) 'val'
#endif
#ifdef __VM_VALIDATE
	#define __assert_runtime_file__ __EVAL(call compile '_ref = toArray __FILE__;{if (_x <= 0)then{_ref set [_foreachindex,32]}} foreach _ref; __EVAL_PATH_VM__(TOString _ref)')
	#define __assert_value_tostring__(val) 'val'
#endif

#define __assert_static_runtime_expr1(expr) if !([expr] call sys_int_evalassert) exitWith {[__assert_value_tostring__(expr),__assert_runtime_file__,__LINE__] call sys_static_assert_}
#define __assert_static_runtime_expr2(expr,message) if !([expr] call sys_int_evalassert) exitWith {[__assert_value_tostring__(expr),__assert_runtime_file__,__LINE__,message] call sys_static_assert_}
#define __assert_static_compile_expr1(expr) __EVAL(__assert_static_runtime_expr1(expr))
#define __assert_static_compile_expr2(expr,message) __EVAL(__assert_static_runtime_expr2(expr,message))
#define __assert_runtime_expr1(expr) if !([expr] call sys_int_evalassert)exitWith {['(expr)',__assert_runtime_file__,__LINE__] call sys_assert_}

//called at compile/build; Only simple expressions without macros
#define static_assert(expr) __assert_static_runtime_expr1(expr)
//see static_assert; Only simple expressions without macros
#define static_assert_str(expr,message) __assert_static_runtime_expr2(expr,message)

//called at runtime; Only simple expressions without macros
#define assert(expr) __assert_runtime_expr1(expr)

#ifdef __VM_BUILD
	//called at compile/build; Only simple expressions without macros
	#define static_assert(expr) __assert_static_compile_expr1(expr)
	//see static_assert; Only simple expressions without macros
	#define static_assert_str(expr,message) __assert_static_compile_expr2(expr,message)
#endif
#ifdef __VM_VALIDATE
	//called at compile/build; Only simple expressions without macros
	#define static_assert(expr) __assert_static_compile_expr1(expr)
	//see static_assert; Only simple expressions without macros
	#define static_assert_str(expr,message) __assert_static_compile_expr2(expr,message)
#endif

#define __THIS_FILE_REPLACE__ SHORT_PATH

//Преобразование внутри файла не будет выполнено. Нужно заменить всё на всё
#ifdef DISABLE_REGEX_ON_FILE
	#define __THIS_MODULE_REPLACE__ "<RUNTIME_MODULE>"
#endif

#ifdef DISABLE_ASSERT
	#define assert(a)
	#define static_assert(a)
	#define static_assert_str(a,b)
	#define __THIS_FILE_REPLACE__
#endif

//Вне дебага все ассерты выключаются
#ifndef DEBUG
	#define assert(a)
	#define static_assert(a)
	#define static_assert_str(a,b)
	
	#define __THIS_FILE_REPLACE__
#endif

//debuging
/*#define CALLSTACK(function) {private ['_ret']; \
if (ACRE_IS_ERRORED) then { ['AUTO','AUTO'] call ACRE_DUMPSTACK_FNC; ACRE_IS_ERRORED = false; }; \
ACRE_IS_ERRORED = true; ACRE_STACK_TRACE set [ACRE_STACK_DEPTH, [diag_tickTime, __FILE__, __LINE__, ACRE_CURRENT_FUNCTION, 'ANON', _this]]; \
ACRE_STACK_DEPTH = ACRE_STACK_DEPTH + 1; ACRE_CURRENT_FUNCTION = 'ANON'; \
_ret = _this call ##function; ACRE_STACK_DEPTH = ACRE_STACK_DEPTH - 1; \
ACRE_IS_ERRORED = false; _ret;}*/

#ifdef EDITOR
	#define setLastError(data__) ([data__] call relicta_debug_setlasterror); halt
#else
	#define setLastError(data__)
#endif


#define exitScope(cond) if (true) exitWith {cond};
//TODO: опционально возвращаем только первые несколько функций стека вызова
#define getCallStack() diag_stacktrace
//#define CALLSTACK_NAMED(function, functionName) {private ['_ret']; if (ACRE_IS_ERRORED) then { ['AUTO','AUTO'] call ACRE_DUMPSTACK_FNC; ACRE_IS_ERRORED = false; }; ACRE_IS_ERRORED = true; ACRE_STACK_TRACE set [ACRE_STACK_DEPTH, [diag_tickTime, __FILE__, __LINE__, ACRE_CURRENT_FUNCTION, functionName, _this]]; ACRE_STACK_DEPTH = ACRE_STACK_DEPTH + 1; ACRE_CURRENT_FUNCTION = functionName; _ret = _this call ##function; ACRE_STACK_DEPTH = ACRE_STACK_DEPTH - 1; ACRE_IS_ERRORED = false; _ret;}
//#define DUMPSTACK ([__FILE__, __LINE__] call acre_main_fnc_dumpCallStack


//common macro
#define BASIC_MOB_TYPE "B_Survivor_F"


// bypass compiler unknown commands
// Данные макросы используются для проброса функций из новой версии в обход компилятора клиента
// Пример: VM_COMPILER_ADDFUNC_UNARY(freeExtension_impl,freeExtension) -> для вызова используем: call freeExtension_impl
#define VM_COMPILER_ADDFUNC_BINARY(name,cmd) name = compile '(_this select 0) cmd (_this select 1)'
#define VM_COMPILER_ADDFUNC_UNARY(name,cmd) name = compile 'cmd _this'
#define VM_COMPILER_ADDFUNC_NULAR(name,cmd) name = compile 'cmd'


#ifdef EDITOR
	#define editor_only(any) any
	#define editor_conditional(ed__,noted__) ed__
#else
	#define editor_only(any) 
	#define editor_conditional(ed__,noted__) noted__
#endif
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\SETTINGS.h>
//generated version macros
#include <..\version.hpp>

#include <lang.hpp>

//platform specific
//! dont use on client, because compiled client (CONTENT-file) used vm-compiler. Only server and editor allowed
#define PLATFORM_VERSION '__GAME_VER__'
#define PLATFORM_VERSION_MAJ __GAME_VER_MAJ__
#define PLATFORM_VERSION_MIN __GAME_VER_MIN__
#define PLATFORM_VERSION_BUILD __GAME_BUILD__

#ifdef EDITOR
	#define ISDEVBUILD (0 call{ \
		private _file = ".git\head"; \
		private _pattern = "refs/heads/development"; \
		if (is3DEN) then { \
			if ([_file] call file_exists) then { \
				_pattern in ([_file] call file_read) \
			} else { \
				false \
			};\
		} else { \
			if (FILEEXISTS _file) then { \
				_pattern in (LOADFILE _file) \
			} else { \
				false \
			}; \
		}; \
	})
#else
	#define ISDEVBUILD false
#endif

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

/// -------------------------------------- FUNCTIONAL PRINTS ---------------------------------------
#define warning(message) [message] call cprintWarn
#define error(message) [message] call cprintErr

#define warningformat(message,fmt) [message,fmt] call cprintWarn
#define errorformat(message,fmt) [message,fmt] call cprintErr

#ifdef RBUILDER
	#define __post_message_RB(m) if (RBuilder_serverStarted) then {["RBuilder","c_send",["print",m]] call rescript_callCommandVoid};
	#define __RB_FATAL_EXIT call RBuilder_onServerLockedLoading;
#else
	#define __post_message_RB(m) 
	#define __RB_FATAL_EXIT 
#endif

/// ------------------------------------ FUNCTIONAL PRINTS -----------------------------------------

#ifdef __TRACE__ENABLED
	#define trace(message) "debug_console" callExtension ("TRACE: " + message + "#1011"); __post_message_RB("TRACE: " + (message))
	#define traceformat(message,fmt) "debug_console" callExtension (format ["TRACE: " + message + "#1011",fmt]); __post_message_RB(format["TRACE: " + (message) arg fmt])
	
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




#define OBSOLETE(funcname) private _dt = format ["[OBSOLETE] => %1(): This function will be removed in the future and should not be used." + "#1101", #funcname]; warning(_dt); [_dt] call discWarning;

#define NOTIMPLEMENTED(funcname) private _dt = format ["[NOT_IMPLEMENTED] => %1(): This function not implemented." + "#1101", #funcname]; warning(_dt); [_dt] call discWarning;

//закрытие потока программы
#define ___appexitstr(value) #value
#define appExit(exitCode) logformat("Application exited. Reason: %1 (%2)",exitCode arg __appexit_listreasons select exitCode); if (!isMultiplayer) then {client_isLocked = true; server_isLocked = true; endMission "END1";} else {if (isServer) then {server_isLocked = true; __RB_FATAL_EXIT} else {client_isLocked = true}}
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


//__THIS_FILE_REPLACE__
//__THIS_MODULE_REPLACE__
#ifdef DISABLE_REGEX_ON_FILE
	#define loadFile(path) if (server_isLocked) exitWith {error("Compile process aborted - server.isLocked == true")}; logformat("Start loading file %1",path); ["Load file - '%1'",path] call logInfo;  call compile __pragma_preprocess (path)
	
	#define importClient(path) if (isNil {allClientContents}) then {allClientContents = []; allClientModulePathes = [];}; if (client_isLocked) exitWith {error("Compile process aborted - client.isLocked == true")}; \
	private _ctx = compile __pragma_prep_cli (path); if (_canCallClientCode) then {call _ctx}; allClientContents pushback _ctx;

	#define importCommon(path) if (isNil {allClientContents}) then {allClientContents = []; allClientModulePathes = [];}; \
	private _ctx = compile __pragma_prep_cli ("src\host\CommonComponents\" + path); \
	if (_canCallClientCode) then {call _ctx}; allClientContents pushback _ctx;
#else
	#define loadFile(path) if (server_isLocked) exitWith {error("Compile process aborted - server.isLocked == true")}; logformat("Start loading file %1",path); ["Load file - '%1'",path] call logInfo; call compile __pragma_preprocess (path)

	#define importClient(path) if (isNil {allClientContents}) then {allClientContents = []; allClientModulePathes = [];}; if (client_isLocked) exitWith {error("Compile process aborted - client.isLocked == true")}; \
	_macro_module = path regexFind ["\w+(?=\.)",0] select 0 select 0 select 0; \
	private _ctx = compile ((__pragma_prep_cli (path))regexReplace ["__THIS_MODULE_REPLACE__",""""+ _macro_module+""""]); if (_canCallClientCode) then {call _ctx}; allClientContents pushback _ctx;  allClientModulePathes pushBack (path);

	#define importCommon(path) if (isNil {allClientContents}) then {allClientContents = []; allClientModulePathes = [];}; \
	_macro_file = """shared" +"\" + path + """"; _macro_module = path regexFind ["\w+(?=\.)",0] select 0 select 0 select 0; \
	__prep = ((__pragma_prep_cli ("src\host\CommonComponents\" + path)) regexReplace ["__THIS_FILE_REPLACE__",(_macro_file regexReplace ["\\","\\\\"])]) regexReplace ["__THIS_MODULE_REPLACE__",""""+ _macro_module+""""]; \
	private _ctx = compile __prep; \
	if (_canCallClientCode) then {call _ctx}; allClientContents pushback _ctx; allClientModulePathes pushBack (path);
#endif

//check if file exists
#define fileExists(file) fileexists (file)

#define SHORT_PATH call {private _arr = __FILE__ splitString "\"; private _ret = ""; if (!isMultiplayer) then \
{ {if (_foreachindex >= 8) then {_ret = _ret + "\" + _x}} forEach _arr } else { \
_ret = __FILE__; \
}; _ret select [1,count _ret - 1]} \

#define getMissionName (missionname+".vr")
#define SHORT_PATH_CUSTOM(d__) (d__) call {private _arr = _this splitString "\"; private _ret = ""; if (!isMultiplayer) then \
{ if (getMissionName in _arr) then {_ret = (_arr select [(_arr find getMissionName)+1,count _arr]) joinString "\"} else {_ret = _this}; } else { \
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

// privates(_a _b _c _d)
#define privates(v) private (v splitString "."); 

//prob correct??? (rewrite)
#define isNullPtr(obj) (obj isequaltypeany [locationnull,controlnull,objnull,displaynull])

#define isReference(obj) (obj isequaltypeany [locationnull,controlnull,objnull,displaynull])

/* NON-USABLE MACROS
#define isRefType(val) (val isEqualTypeAny [locationnull,controlnull,objnull,displaynull])
#define isValType(val) !isRefType(val)
*/

#ifdef RBUILDER
	#define __rb_mesh_common_path__ "core\default\default.p3d"
	#define createMesh(ctx) ctx call { params ["_p","_ps","_loc"]; \
		createSimpleObject [ ifcheck(isServer,__rb_mesh_common_path__,_p), _ps,_loc ]; \
	}
#else
	#define createMesh(ctx) createSimpleObject (ctx)
#endif

//custom memobj
#define mem_alloc() (createLocation ["cba_namespacedummy",[20,20,20],0,0])
#define mem_set(ptr) (ptr)setvariable 
#define mem_unset(ptr,val) (ptr)setvariable[val,null]
#define mem_get(ptr,val) ((ptr)getvariable(val))
#define mem_free(ptr) (deleteLocation (ptr))


//string help
#define stringEmpty ""

//mem check
// Осуществляет проверку значения в стиле C++. Любые nullable значения вернут false
#define isValid(ptr) ([ptr] call rv_cppcheck)
//псевдоним if (valid(modlue_somevariable))
#define valid(ptr) ([ptr] call rv_cppcheck)
// alias to valid
#define toBoolean(val) valid(val)

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

//Проверка типов
#define isInt(num) ((num) call {floor _this == _this})

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

#define array_exists(arr,var) ((var)in(arr))
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

//local variables swap
#define __sw_combine(o1,o2) o1##o2
#define swap_lvars(a,b) private __sw_combine(__t_swp_,b) = a; a = b; b = __sw_combine(__t_swp_,b)

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
#define toMap hashMapNewArgs
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

//comparison

#define equals(obja,objb) ((obja)isequalto(objb))
#define not_equals(obja,objb) ((obja)isnotequalto(objb))


#define equalTypes(obja,objb) ((obja)isequaltype(objb))
#define not_equalTypes(obja,objb) (!equalTypes(obja,objb))

//algorithm
#define all_of(values) ([values] call allOf)
#define any_of(values) ([values] call anyOf)
#define none_of(values) ([values] call noneOf)

#define generate_list(begin,end,fn_) ([begin,end,fn_] call generateList)

//Возвращает индекс (с нуля) первого элемента массива A, который также существует в массиве B. Если общих элементов нет, возвращается -1. 
#define find_any(_searchin,_tofind) ((_searchin)findAny(_tofind))

//random helpers
#define pick selectRandom
//выбор рандомного числа включительно Bis_fnc_randomNum
#define rand(_beg,_end) (linearConversion [0,1,random 1,_beg,_end])

// Обновлённая функция выбора случайного целого числа из диапазона. 1.000001 было добавлено для решения проблемы когда рандом выпадает в 0.999999989
#define randInt(_beg,_end) (FLOOR linearConversion [0,1.000001,random 1,(_beg)min(_end),(_end)max(_beg)+1])

#define prob(val) (random[0,50,100]<(val))

#define prob_new(val) (random 100<(val))

//math helpers
#define pow(a,b) ((a) ^ (b))

//Ограничение числа
#define clamp(val,__min,__max) ((val)max(__min)min(__max))

#define clampangle(x,a,b) (((((x) % 360 + 360) % 360) max (a)) min (b))

#define parseNumberSafe(v) ((parseNumber (v)) call {if(finite _this) then {_this} else {0}})

#define getdiff(a,b) ([a,b] call {params["_a","_b"]; if equals(_a,_b)exitWith{0}; ifcheck(_a>_b,-_a+_b,_b-_a) })

//delay subsystem

#define netTickTime CBA_missionTime
#define tickTime diag_tickTime
#define deltaTime diag_deltaTime

#ifdef EDITOR_OR_SP_MODE
	#define __alloc_thread_loc__ (cba_common_perFrameHandlerArray select -1) set [6,format["%1 at line %2",[__FILE__,getMissionPath "",""] call stringReplace,__LINE__]]; \
		(cba_common_perFrameHandlerArray select -1) set [7,diag_stacktrace]
	#define startUpdate(func,delay) call{private _h = [func,delay] call CBA_fnc_addPerFrameHandler; __alloc_thread_loc__; _h}
	#define startUpdateParams(func,delay,params) call{private _h = [func,delay,params] call CBA_fnc_addPerFrameHandler; __alloc_thread_loc__; _h}
#else
	#define startUpdate(func,delay) [func,delay] call CBA_fnc_addPerFrameHandler
	#define startUpdateParams(func,delay,params) [func,delay,params] call CBA_fnc_addPerFrameHandler
#endif

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

/*
	susspend supported fast thread
	example:

	sftBegin //[{
		sftWait(tickTime>5); //},[...],{
		log("after 5 sec");

		sftSleep(10); //},[...],{
		log("after 10 sec");
	sftEnd // }]
*/

#define sftBegin [sft_processQueue__,{},[{

#define sftEnd },0,tickTime]] call sft_createThread__;

#define sftWait(condition_) },{_canJump = condition_},{

#define sftSleep(await_) },{_canJump = tickTime >= ((await_)+_tstrt)},{

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
#define soundPathPrep(v) ((v)splitString "/" joinString "\")
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


#define __assert_static_runtime_expr1(expr) if !([expr] call sys_int_evalassert) exitWith {[__assert_value_tostring__(expr),__assert_runtime_file__,__LINE__] call sys_static_assert_}
#define __assert_static_runtime_expr2(expr,message) if !([expr] call sys_int_evalassert) exitWith {[__assert_value_tostring__(expr),__assert_runtime_file__,__LINE__,message] call sys_static_assert_}
#define __assert_static_compile_expr1(expr) __EVAL(__assert_static_runtime_expr1(expr))
#define __assert_static_compile_expr2(expr,message) __EVAL(__assert_static_runtime_expr2(expr,message))
#define __assert_runtime_expr1(expr) if !([expr] call sys_int_evalassert)exitWith {[toString {expr},__assert_runtime_file__,__LINE__] call sys_assert_}
#define __assert_runtime_expr2(expr,message) if !([expr] call sys_int_evalassert)exitWith {[toString {expr},__assert_runtime_file__,__LINE__,message] call sys_assert_}

//called at compile/build; Only simple expressions without macros
#define static_assert(expr) __assert_static_runtime_expr1(expr)
//see static_assert; Only simple expressions without macros
#define static_assert_str(expr,message) __assert_static_runtime_expr2(expr,message)

//called at runtime; Only simple expressions without macros
#define assert(expr) __assert_runtime_expr1(expr)
#define assert_str(expr,message) __assert_runtime_expr2(expr,message)

#define __THIS_FILE_REPLACE__ SHORT_PATH

//Преобразование внутри файла не будет выполнено. Нужно заменить всё на всё
#ifdef DISABLE_REGEX_ON_FILE
	#define __THIS_MODULE_REPLACE__ "<RUNTIME_MODULE>"
#endif

#ifdef DISABLE_ASSERT
	#define assert(a)
	#define assert_str(a,b)
	#define static_assert(a)
	#define static_assert_str(a,b)
	#define __THIS_FILE_REPLACE__
#endif

//Вне дебага все ассерты выключаются
#ifndef DEBUG
	#define assert(a)
	#define assert_str(a,b)
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

#ifdef EDITOR_OR_RBUILDER
	#define setLastError(data__) ([data__] call relicta_debug_setlasterror); halt
#else
	#define setLastError(data__)
#endif

#ifdef SP_MODE
	#define setLastError(data__) error(data__)
#endif


#define exitScope(cond) if (true) exitWith {cond};
//TODO: опционально возвращаем только первые несколько функций стека вызова
#define getCallStack() diag_stacktrace
//#define CALLSTACK_NAMED(function, functionName) {private ['_ret']; if (ACRE_IS_ERRORED) then { ['AUTO','AUTO'] call ACRE_DUMPSTACK_FNC; ACRE_IS_ERRORED = false; }; ACRE_IS_ERRORED = true; ACRE_STACK_TRACE set [ACRE_STACK_DEPTH, [diag_tickTime, __FILE__, __LINE__, ACRE_CURRENT_FUNCTION, functionName, _this]]; ACRE_STACK_DEPTH = ACRE_STACK_DEPTH + 1; ACRE_CURRENT_FUNCTION = functionName; _ret = _this call ##function; ACRE_STACK_DEPTH = ACRE_STACK_DEPTH - 1; ACRE_IS_ERRORED = false; _ret;}
//#define DUMPSTACK ([__FILE__, __LINE__] call acre_main_fnc_dumpCallStack

//special spmode macros
#ifdef SP_MODE
	#define sp_checkInput(varname,params) if ([varname,params] call sp_gc_handlePlayerInput) exitWith {};
	#define sp_checkWSim(varname) [varname,_this] call sp_internal_wsimHandleAction; if (!(varname call sp_wsimIsActive)) exitWith {};
#else
	#define sp_checkInput(varname,params)
	#define sp_checkWSim(varname)
#endif


//common macro
#define BASIC_MOB_TYPE "B_Survivor_F"


#ifdef EDITOR
	#define editor_only(any) any
	#define editor_conditional(ed__,noted__) ed__
#else
	#define editor_only(any) 
	#define editor_conditional(ed__,noted__) noted__
#endif

//--------------node scripting macros--------------
//указывает путь узлов для регистрации функций. Должен быть указан в заголовке инициализатора модуля

//макрос проверки разрешения инициализации модуля (для генератора биндингов)
#define IS_INIT_MODULE isNullVar(__FUNCITONS_LOAD_ONLY__)

//регистрация поля класса в библиотеке
/*
	опции:
	name - имя переменной
	desc - описание переменной
	return - явное указание типа переменной. если не указано - будет вычислено на этапе компиляции библиотеки
	!override - можно ли переопределить переменную
	prop - тип свойства (дефолт all, доступные: all,get,set)
	classprop - видимость свойства в инспекторе класса (дефолт-0)
*/
#define node_var call nodegen_addClassField;

//регистрация метода класса в библиотеке
/*
	опции:
	name - имя метода
	namelib - имя, видимое в дереве. если не указано - используется значение из name
	desc - описание метода
	type - тип метода (дефолт method, доступные: method,event,get,const)
		const - добавляет новый элемент в classprop
	return - возвращаемое значение и описание (опционально)
		return:int:Результат вызова:описание
		return:int:Результат вызова
	classprop - автоматическое свойств для констант или методов геттеров (требует возвращаемый тип)
	defcode - код помещаемый при компиляции (дефайне класса). дефолт (вычисляемый) func(@thisName) {objParams();}
		доступные замены в коде
		@thisName - имя этого метода,поля
		@thisParams - структура параметров. По умолчанию генерирует переменные для всех параметров. Используйте @thisParams.2-4 для указания диапазона портов

		дефкоды помещаются в переменные (геттеры) и допустимые методы
	lockoverride - флаг указывает что переопределение заблокировано (не может быть выполнено)
	code - вызываемый код
		!обратите внимание, что для методов типа event помещается определение
	exec - дефолтные входы и выходы (дефолт - all, доступные: all,in,out,none|pure)
		exec:all
	defval - значение по умолчанию для инспектора
	in - номер параметра для input-ов
		in:type:name(:desc)
		opt (указывается на следующей строке):
			mul - мультивход/выход (дефолт 0)
			dname - показывать имя порта (дефолт 1,выключается если есть опция)
			allowtypes - список доступных входов. (дефолт этот тип)
			custom - добавить кастомную настройку (дефолт 1, вычисляется от типа входа. Если тип неизвестне то ничего не добавится)
			pathes - доступные пути с разделителем | (опция allowed_pathes)
			
			typeget - специальный модификатор для разрешения типов при включенных автопорах
			require - требует ли порт обязательного подключения
			gen_param - будет ли сгенерирован параметр для порта. По умолчанию 1
			def - значение по умолчанию. реальное json значение для подстановки в параметры

			custom_type - кастомный тип для автопортов (работает вместе с use_custom)

			typeset_out - указывает имя порта для автозамены типа
		in:int:Вход 1:Описание входного значения
		opt:custom=1:mul=1:dname=1:allowtypes=int|bool|float
*/
#define node_met call nodegen_addClassMethod;

//регистрация класса в библиотеке
/*
	path - Путь для членов класса, path:Объекты.Логика
	Путь наследуется для членов но может быть переопределен
*/
#define node_class call nodegen_addClass;

// регистрация статической функции по имени
/*
	"name:test function" node_func(test_function) = {};

	возможные опциональные дланные opt:

	для установки параметров функции в автоматическом режиме используйте @cfParams

*/
#define node_func(name) + endl+ 'node:name' call nodegen_addFunction; name

//Регистрация системного узла
#define node_system call nodegen_addSystemNode;

//Регистрация перечисления
/*
В перечислении надо указать токен eval. Порядок токенов соответствует расположению на узле:
	eval:Первое число:3
	eval:Второе число:4
	eval:Третье число:5
	При регистрации перечисление пишет член enum_vToK_NAME - который содержит имена (карту), где NAME системное имя перечисления. 
		В этих перечислениях ключи - числа в строке (значения нумератора), значения - строки (названия элементов нумератора) 
	При регистрации перечисления пишет член enum_values_NAME - который содержит массив чисел
	Все ключи в строках, так как этот член - словарь, который не может нормально работать с циферками

	Для указания кастомных типов перечисления укажите enumtype:
		enumtype:float
		enumtype:bool
		enumtype:string

	Фактическое добавление делается так:
	["TestEnum",["Первое число:3:тест описание"]] node_enum
	Доступ из системы получается по имени enum.TestEnum
*/
//! Этот макрос нельзя вырезать из компиляции. Он генерирует статические члены
#define node_enum call nodegen_addEnumerator;

//Регистратор структуры
/*
	Структуры как и перечисления должны компилировать имена членов и сопоставлялки типов
	используйте eval для регистрации членов структуры (они упорядочены)
		eval:string:Строка:"empty":Описание параметра
		eval:int:Число:0
		eval:bool:Логическое:false
	Каждая зарегистрированная структура делает 2 узла: breakStruct, makeStruct

	! Пока неизвестно какие глобальные члены должна писать структура.
	TODO Нужно придумать и реализовать
*/
#define node_struct call nodegen_addStruct;

/*

	В дополнении к обработчикам метода
	node: указывает классовое имя узла
	runtimeports - указывает могут ли быть рантайм порты в этом узле
	autocoloricon - при включенных runtimeports указывает может ли узел менять цвет (включается при runtimeports). По умолчанию 0
	rendertype - тип рендеринга (по умолчанию Default (полный))
	option - пользовательский словарь опции
	libvisible - видимость в библиотеке (по умолчанию истина)
	icon - указанная картинка

	в портах можно указывать вместо типа thisClassname для указания автотипа текущего графа
	thisName - для указания имени текущего графа
*/
#define node_system_group(gname) __nsys_grp = gname;

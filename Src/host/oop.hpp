// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "engine.hpp"
//group: macro common

#define PROTOTYPE_VAR_NAME "proto"
#define TYPE_SUPER_BASE "<superbase>"

#define createObj (createLocation ["cba_namespacedummy",[100,100,100],0,0])
#define createNetObj (createSimpleObject ["CBA_NamespaceDummy", [100, 100, 100]])
#define deleteObj deleteLocation

#define nullPtr locationnull

#ifdef EDITOR_OR_SP_MODE
	#define __testSyntaxClass __classcandef = isnil{_class}; if (!__classcandef) exitWith {errorformat("Syntax error - keyword 'endclass' not found in (%1)",_class); setLastError(format vec2("Syntax error - keyword 'endclass' not found in (%1)",_class));};
#else
	#define __testSyntaxClass
#endif

#define interfaceHeader __interface_header_flag__ = true;

//определение класса
#define class(name) __class_beginDefine__(__className_toString__(name))

//создание типа по строке. Нужно для генерации классов
#define class_runtime(name) __class_beginDefine__(name)

#define __className_toString__(name) #name

//common class begin define
#define __class_beginDefine__(name) _decl_info___ = [__FILE__,__LINE__ + 1]; \
	__testSyntaxClass \
	private ["_class","_mother","_mem_name","_lastIndex","_lastIndexF","_fields","_methods"]; \
	_class = name; _mother = "object"; \
	[_class] call pc_oop_regClassTable; \
	_fields = []; _methods = []; _attributes = []; _autoref = []; \
	_editor_attrs_cls = []; \
	call pc_oop_declareClassAttr; \
	_editor_next_attr = []; _editor_attrs_f = []; _editor_attrs_m = []; \
	_classmet_declinfo = createHashMap; \
	_last_node_info_ = null; \
	__interface_header_flag__ = null; \
	private _pt_obj = [_class] call pc_oop_newTypeObj;


//
#define endclass [__FILE__,__LINE__] call pc_oop_declareEOC;
#define extends(child) _mother = #child;
#define extends_runtime(child) _mother = child;

//attributes system

#define attribute(name) _attributes pushBack ['name',[]];

#define attributeParams(name,params) _attributes pushBack ['name',[params]];

//доступно только в режиме редактора
#ifdef EDITOR_OR_SP_MODE
	//Тут задекларен атрибут для членов класса. Все атрибуты наследуются в дочернии классы. Пример использования:
	// editor_attribute("atrname")
	#define editor_attribute(key_s) _editor_next_attr pushBack [key_s];
	
#else
	#define editor_attribute(key_s)
#endif

//use this macro for automatic reference cleanup: autoref var(someobject,nullPtr);
#define autoref _isAutoRefUse = true;

//CONST DISABLED
//const modif. Create const inside type: const var(PI,3.14);
//!do not enable after lang spec
//#define const _isConstant = true; assert(false);
	#define __set_const_value(var,val) _pt_obj setvariable ['cst_##var',val]

#define __internal_flag_processor(flagname,act) if (!isnil 'flagname') then {act; flagname = nil}

//Регистратор переменной
#define var(name,value) \
	_mem_name = #name ; \
	_lastIndexF = _fields pushback [_mem_name,'value']; \
	call pc_oop_handleAttrF;

/*
	create hashmap in class field. Delimeter nextLine,Tab or ;
	varpair(test,
		pair("a",1);
		pair("x",3);
	);
*/
#define pair(key,val) [key,val]
#define varpair(name,value) \
	_mem_name = #name ; \
	_lastIndexF = _fields pushback [_mem_name,"createHashMapFromArray [" + ('value' splitString (";"+toString[9,13,10]) joinString ",") + "]"]; \
	call pc_oop_handleAttrF;

//Регистратор переменной со строковым именем
#define var_runtime(name,value) \
	_mem_name = name ; \
	_lastIndexF = _fields pushback [_mem_name,'value']; \
	call pc_oop_handleAttrF;

//Вычисляет значения поля на этапе компиляции
//! Внимание ! - при изменении этого макроса выполнить правки в pc_oop_regvar
#define var_exprval(name,value) \
	_mem_name = #name ; \
	__iv_r = value; if equalTypes(__iv_r,"") then {__iv_r = str __iv_r}; \
	_lastIndexF = _fields pushback [_mem_name,format["%1",__iv_r]]; \
	call pc_oop_handleAttrF;

#define net_use _netuse = true;

#define var_num(name) var(name,0)
#define var_str(name) var(name,"")
#define var_bool(name) var(name,false)
#define var_array(name) var(name,[])
#define var_obj(name) var(name,objnull)
#define var_vobj(name) var(name,locationnull)
#define var_hashmap(name) var(name,createHashMap)
#define var_handle(name) var(name,-1)

//#define var_multi(defaultvalue)

#define __check_method_duplicate 

#define func(name) _mem_name = #name; _classmet_declinfo set [_mem_name,__FILE__ + "?" + (str __LINE__)]; \
	_propOverride = _methods findIf {(_x select 0) == _mem_name}; \
	if (_propOverride != -1) then {__check_method_duplicate (_methods select _propOverride) deleteAt 1; _lastIndex = _propOverride} else { \
		_lastIndex = _methods pushback [_mem_name]; \
	}; \
	call pc_oop_handleAttrM; \
	(_methods select _lastIndex) pushback

#define func_runtime(name) _mem_name = name; _classmet_declinfo set [_mem_name,__FILE__ + "?" + (str __LINE__)]; \
	_lastIndex = _methods pushback [_mem_name]; \
	call pc_oop_handleAttrM; \
	(_methods select _lastIndex) pushback

// verbList()
#define verbList(strlist,motherObj) _nCode = 'objParams(); _outArr append ' + (strlist call verbs_parse_strToListOfNum) + '; callSuper(motherObj,getVerbs)'; func(getVerbs) (compile _nCode)

#define verbListOverride(strlist) _nCode = 'objParams(); _outArr append ' + (strlist call verbs_parse_strToListOfNum) + ';'; func(getVerbs) (compile _nCode)


#define getter_func(name,do) func(name) {objParams(); do }

//нет траты памяти на параметризацию. Нужно для константных значений (массивов и строк)
#define getterconst_func(name,do) func(name) { do }

#define getset_func(name,getcode,setcode) _getcode = getcode; _setcode = setcode; func_runtime('get' + 'name') _getcode; func_runtime('set' + 'name') _setcode

#define simpleGet(getcode) {objParams(); getcode }
#define simpleSet(setcode) {objParams_1(_value); setcode }
#define value _value

//do not use now
//TODO поменять местами абстракт и прото
#define abstract_func(name) func(name) {}; private _reqImpl = format['[OOP]:    <%1::%2> Method requires implementation (%3)',_class,#name,SHORT_PATH]; warning(_reqImpl);
#define proto_func(name) func(name) {}

//instansing and deleting
#define new(type) (call (pt_##type getvariable "__instance"))
#define newParams(type,Params) ((Params) call (pt_##type getvariable "__instance"))
#define delete(ref) (ref) call oop_deleteObject
#define isdeleted(ref) (!isNIL{ref getvariable "__del_flag__"})
#define instantiate(strType) (call ((missionNamespace getVariable ("pt_" + (strType))) getvariable '__instance'))
#define instantiateParams(strType,Params) ((Params) call ((missionNamespace getVariable ("pt_" + (strType))) getvariable '__instance'))

// Внутренние параметры, переданные через new
#define ctxParams _internalParams

#define sizeOf(obj) obj call oop_getobjsize

//Получает наследников данного типа
#define getObjectsTypeOf(type) ([#type,false] call oop_getinhlist)
//Получает ВСЕХ наследников от этого типа (глубокое наследование)
#define getAllObjectsTypeOf(type) ([#type,true] call oop_getinhlist)
	//строковый эквивалент
	#define getObjectsTypeOfStr(type) ([type,false] call oop_getinhlist)
	#define getAllObjectsTypeOfStr(type) ([type,true] call oop_getinhlist)

//вызывает базовый класс по пользовательскому пути
//При переопределении изменить и в крафтовых классах
#define callSuper(superclass,metname) call ( pt_##superclass getVariable #metname )

#define super() (__BASECALLFLAG__)

// Parameters
#define this _thisobj

#define updateParams() private this = (_this select 0)

//частота вызова каждого объектного апдейта (не менять)
#define STD_UPDATE_DELAY 1

#define startSelfUpdate(method) startUpdateParams(getSelfFunc(method),STD_UPDATE_DELAY,this)
#define startObjUpdate(obj,method) startUpdateParams(getFunc(obj,method),STD_UPDATE_DELAY,obj)

#define startSelfUpdateWithDelay(method,del) startUpdateParams(getSelfFunc(method),del,this)
#define startObjUpdateWithDelay(obj,method,del) startUpdateParams(getFunc(obj,method),del,obj)

#define setParam(idx,val) _this set [idx,val]

#define objParams() private this = _this

#define objParams_1(a) params ['this', #a ]
	#define objParams_1_nostr(a) params ['this', a ]
#define objParams_2(a,b) params ['this', #a , #b]
	#define objParams_2_nostr(a,b) params ['this', a , b]

#define objParams_3(a,b,c) params ['this', #a , #b , #c]
#define objParams_4(a,b,c,d) params ['this', #a , #b , #c , #d]
#define objParams_5(a,b,c,d,e) params ['this', #a , #b , #c , #d , #e]
#define objParams_6(a,b,c,d,e,f) params ['this', #a , #b , #c , #d , #e , #f]


//accessing

// 0.9 oop update. NOT IMPLEMENTED NOW
/*#define getself(name) (this getvariable #name)
#define setself(name,val) this setvariable [#name,val]
#define modself(name,val) setSelf(name,getSelf(name) val)

#define callself(func) (this call (this getvariable PROTOTYPE_VAR_NAME getvariable #func))
#define callselfparams(func,parms) ([this,parms] call (this getvariable PROTOTYPE_VAR_NAME getvariable #func))

#define getselfprop(func) (this call (this getvariable PROTOTYPE_VAR_NAME getvariable 'get##func'))
#define setselfprop(func,val) [this,val] call (this getvariable PROTOTYPE_VAR_NAME getvariable 'set##func')

//external access
#define callfunc(obj,func) ((obj) call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (#func)))
#define callfuncparams(obj,func,parms) ([obj, parms] call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (#func)))

#define getfunc(obj,func) ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (#func))
#define getfuncreflect(obj,func) ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (func))

#define getvar(obj,name) ((obj) getvariable (#name))
#define setvar(obj,name,value) (obj) setvariable [#name,value]
#define modvar(obj,name,val) setvar(obj,name,getvar(obj,name) val)

#define getprop(obj,func) ((obj) call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable ('get##func')))
#define setprop(obj,func,val)  ([obj,val] call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable ('set##func')))*/
// legacy oop

//calling private methods
#define privateCall(func) (call (this getvariable PROTOTYPE_VAR_NAME getvariable #func))

#define getSelf(name) (this getvariable #name)
#define setSelf(name,val) this setvariable [#name,val]
#define modSelf(name,val) setSelf(name,getSelf(name) val)
#define initSelf(name,_initial) (if ISNIL{getSelf(name)}then{setSelf(name,_initial);_initial}else{getSelf(name)})

	#define getSelfReflect(name) (this getvariable name)
	#define setSelfReflect(name,val) this setvariable [name,val]
	#define modSelfReflect(name,val) setSelfReflect(name,getSelfReflect(name) val)

#define callSelf(func) (this call (this getvariable PROTOTYPE_VAR_NAME getvariable #func))
#define callSelfAfter(func,time) [this getVariable PROTOTYPE_VAR_NAME getVariable #func,this,time] call CBA_fnc_waitAndExecute
#define callSelfAfterParams(func,time,parms) [this getVariable PROTOTYPE_VAR_NAME getVariable #func,[this,parms],time] call CBA_fnc_waitAndExecute
#define callSelfParams(func,parms) ([this,parms] call (this getvariable PROTOTYPE_VAR_NAME getvariable #func))
#define callSelfParamsInline(func,parms) (([this]+(parms)) call (this getvariable PROTOTYPE_VAR_NAME getvariable #func))

	#define callSelfReflect(func) (this call (this getvariable PROTOTYPE_VAR_NAME getvariable func))
	#define callSelfReflectParams(func,parms) ([this,parms] call (this getvariable PROTOTYPE_VAR_NAME getvariable func))
	//Встраивает параметры в системный вызов метода
	#define callSelfReflectParamsInline(func,parms) (([this]+(parms)) call (this getvariable PROTOTYPE_VAR_NAME getvariable func))

#define getSelfFunc(func) (this getvariable PROTOTYPE_VAR_NAME getvariable (#func))
#define getSelfFuncReflect(func) (this getvariable PROTOTYPE_VAR_NAME getvariable (func))

#define getSelfProp(func) (this call (this getvariable PROTOTYPE_VAR_NAME getvariable 'get##func'))
#define setSelfProp(func,val) [this,val] call (this getvariable PROTOTYPE_VAR_NAME getvariable 'set##func')

//external access
#define callFunc(obj,func) ((obj) call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (#func)))
#define callFuncAfter(obj,func,time) [(obj) getVariable PROTOTYPE_VAR_NAME getVariable #func,obj,time] call CBA_fnc_waitAndExecute
#define callFuncAfterParams(obj,func,time,parms) [(obj) getVariable PROTOTYPE_VAR_NAME getVariable #func,[obj,parms],time] call CBA_fnc_waitAndExecute
#define callFuncParams(obj,func,parms) ([obj, parms] call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (#func)))
#define callFuncParamsInline(obj,func,parms) (([obj]+(parms)) call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (#func)))

	#define callFuncReflect(obj,func) ((obj) call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (func)))
	#define callFuncReflectParams(obj,func,parms) ([obj, parms] call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (func)))
	//Встраивает параметры в системный вызов метода
	#define callFuncReflectParamsInline(obj,func,parms) (([obj]+(parms)) call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (func)))

#define getFunc(obj,func) ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (#func))
#define getFuncReflect(obj,func) ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (func))

#define getVar(obj,name) ((obj) getvariable (#name))
#define setVar(obj,name,value) (obj) setvariable [#name,value]
#define modVar(obj,name,val) setVar(obj,name,getVar(obj,name) val)
#define initVar(obj,name,_initial) (if ISNIL{getVar(obj,name)}then{setVar(obj,name,_initial);_initial}else{getVar(obj,name)})

	#define getVarReflect(obj,name) ((obj) getvariable (name))
	#define setVarReflect(obj,name,value) (obj) setvariable [name,value]
	#define modVarReflect(obj,name,val) setVarReflect(obj,name,getVarReflect(obj,name) val)

#define getProp(obj,func) ((obj) call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable ('get##func')))
#define setProp(obj,func,val)  ([obj,val] call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable ('set##func')))

//constant helpers
#define getConst(obj,constvar) callFunc(obj,constvar)
#define getSelfConst(constvar) callSelf(constvar)

//type accessing (extended reflection) 
//!OBSOLETE use object.getType class for accessing type
#define typeGet(typ) (missionNamespace getvariable ['pt_'+ 'typ',nullPtr])
#define typeGetFromObject(obj) (obj getVariable PROTOTYPE_VAR_NAME)
#define typeGetFromString(strvar) (missionNamespace getvariable ['pt_'+ (strvar),nullPtr])
#define typeGetVar(obj,var) (obj getVariable 'var')
#define typeHasVar(obj,var) (!isnil {typeGetVar(obj,var)})
#define typeSetVar(obj,var,val) obj setvariable ['var',val]

#define typeGetDefaultFieldValueSerialized(tp,var) (tp getVariable "__allfields_map" get 'var')
#define typeGetDefaultFieldValue(tp,var) (compile typeGetDefaultFieldValueSerialized(tp,var))

//checkers

#define isExistsObject(ref) (!isnil {(ref getvariable 'proto')})
//Проверка является ли тип наследником isTypeOf(_mob,Mob); //true
#define isTypeOf(obj,type) ((tolower #type) in ((obj) getvariable PROTOTYPE_VAR_NAME getvariable ("__inhlist_map")))
#define isTypeStringOf(obj,type) ((tolower (type)) in ((obj) getvariable PROTOTYPE_VAR_NAME getvariable ("__inhlist_map")))
#define isTypeNameOf(obj,type) ((tolower #type) in (typeGetFromString(obj) getvariable ("__inhlist_map")))
//TODO remove this macro
#define isTypeNameStringOf(obj,type) ((tolower (type)) in (typeGetFromString(obj) getvariable ("__inhlist_map")))
//проверка существования класса
#define isImplementClass(strname) (!isNullReference(typeGetFromString(strname)))
//проверка наличия членов
#define isImplementFunc(objref,met) (!isnil{getFunc(objref,met)})
#define isImplementVar(objref,var) ((tolower #var) in getFunc(objref,__allfields_map))
	#define isImplementFuncStr(objref,met) (!isnil{getFuncReflect(objref,met)})
	#define isImplementVarStr(objref,var) ((tolower (var)) in getFunc(objref,__allfields_map))
//Прямое получение дефолтных значений по подстроке через рефлексию
#define getFieldBaseValue(strt,varx) ([strt,varx,true] call oop_getFieldBaseValue)
#define getFieldBaseValueWithMethod(strt,varx,prp) ([strt,varx,true,prp] call oop_getFieldBaseValue)
// NON USABLE #define isTypeStringOf(obj,type) ((tolower type) in ((obj) getVariable PROTOTYPE_VAR_NAME getVariable "__inhlist_map"))

//!deprecated
#define isNullObject(obj) ((obj) isequalto nullPtr)



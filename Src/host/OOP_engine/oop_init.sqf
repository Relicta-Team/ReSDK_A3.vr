// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\oop.hpp"
#include "..\engine.hpp"

//class names system

//inheritance
#define NULLCLASS "<NAN_CLASS>"
#define EXIT_IF_ERROR(mes) if (_iserror || server_isLocked) exitWith {error(mes); [mes] call logCritical}
#define shell_init(__name__system,__value__system) format["_thisobj setvariable ['%1',%2]; ",__name__system,__value__system]
#define logoop(mes) ["[OOP]:    " ,(mes) ,"#0111"] call stdoutPrint; ["(OOP_init)	%1",mes] call logInfo

logoop("Starting class compilation");

_iserror = false;
_oop_initTime = diag_ticktime;

_attr_ex_init_list = [];
{
	_pObj = missionnamespace getvariable ['pt_' + _x,NULLCLASS];
	_className_str = _x;
	if (_pObj isequalto NULLCLASS) exitWith {
		["Cant find class - %1",_x] call logCritical;
		errorformat("Cant find class - %1",_x);
		_iserror = true;
	};
	_fieldsBaseValues = [];
	_exist_fields = [];
	_exists_methods = [];
	_ctor_objects = [];
	_dtor_objects = [];

	_motherType = _pObj getvariable ['__motherClass',"nulldata"];

	if (_pObj getVariable ['__isPrepToComp',false]) exitWith {
		_iserror = true;
		["Duplicate classname - '%1'",_className_str] call logCritical;
		errorformat("Duplicate classname - '%1'",_className_str);
	};
	_pObj setVariable ['__isPrepToComp',true];

	if (_motherType != TYPE_SUPER_BASE && {(missionnamespace getvariable ['pt_' + _motherType,nullPtr]) isEqualTo nullPtr}) exitWith {
		_iserror = true;
		["Can't find mother type '%2' in class '%1'",_className_str arg _motherType] call logCritical;
		errorformat("Can't find mother type '%2' in class '%1'",_className_str arg _motherType);
	};

	#define allocName this setName "%2"

	_shell_data = if (_motherType == "NetObject") then {
		setLastError("Network objects obsoleted and not supported");
		format['private ctxParams = _this; private this = createNetObj; private _pt = pt_%2; allocName; this setvariable ["%1",_pt]; ',PROTOTYPE_VAR_NAME,_x];
	} else {
		format['private ctxParams = _this; private this = createObj; private _pt = pt_%2; allocName; this setvariable ["%1",_pt]; ',PROTOTYPE_VAR_NAME,_x];
	};

	//attributes and autoref init
	private _attrs = [];
	private _autoref = [];


	//inheritance process
	_mot = _pObj;
	_inheritance_list = [_x];
	_counter = 0;

	while {!((_mot) isequalto NULLCLASS)} do {

		if (_counter >= 9999) exitWith {
			["Maximum inheritance amount on class '" + _x + "'"] call logCritical;
			errorformat("Maximum inheritance amount on class '%1'",_x);
			_iserror = true;
		};
		INC(_counter);

		//reg fields
		{
			_x params ["_name","_value"];
			_name = toLower _name;

			if (!(_name in _exist_fields)) then {
				_exist_fields pushBack _name;
				_fieldsBaseValues pushBack [_name,_value];

				//reg new field
				_shell_data = _shell_data + shell_init(_name,_value);
			};
		} foreach (_mot getvariable '__fields');

		//reg methods
		{
			_x params ["_name","_value"];
			_name = toLower _name;

			if (_name isEqualTo "constructor") then {_ctor_objects pushBack (_mot)};
			if (_name isEqualTo "destructor") then {_dtor_objects pushBack (_mot)};

			if (!(_name in _exists_methods)) then {
				_exists_methods pushBack _name;

				//reg new method

				_pObj setvariable [_name,_value];
			};
		} foreach (_mot getvariable '__methods');

		//collect attributes
		_attrs append (_mot getVariable '__attributes');
		//collect autoref variables
		_autoref append (_mot getVariable '__autoref');

		//getting this child
		_thisChild = _mot getVariable "classname";

		//go to next mother
		_mot = _mot getvariable ['__motherClass',"nulldata"];
		_motTypeName = _mot;

		if (_mot == TYPE_SUPER_BASE) exitWith {};
		_inheritance_list pushback (_mot);

		_mot = missionnamespace getvariable ['pt_' + _mot,NULLCLASS];
		if equals(_mot,NULLCLASS) exitWith {
			errorformat("Compilation runtime error. Cant find mother class %1",_motTypeName);
			_iserror = true;
		};
		(_mot getVariable '__childList') pushBackUnique (tolower _thisChild);
	};

	if (_iserror) exitWith {
		["Abort init classes after inheritance process '" + _x + "'"] call logError;
		errorformat("Abort init classes after inheritance process '%1'",_x);
	};

	//calling ctors
	_shell_data = _shell_data + '{this call (_x getvariable "constructor")} foreach (this getvariable "proto" getvariable "__ctors"); this';

	_pObj setvariable ['__instance',compile _shell_data];
	_pObj setvariable ["__inhlistCase",_inheritance_list];
	_inheritance_list = _inheritance_list apply {tolower _x};
	_pObj setvariable ["__inhlist",_inheritance_list];

	//make hashset for isTypeOf faster algorithm
	_pObj setVariable ["__inhlist_map",hashSet_create(_inheritance_list)];

	//reversing ctors. base to childs...
	reverse _ctor_objects;

	_pObj setvariable ['__ctors',_ctor_objects];
	_pObj setvariable ['__dtors',_dtor_objects];

	//added mother object
	if !((_pObj getVariable ['__motherClass',TYPE_SUPER_BASE]) isEqualTo TYPE_SUPER_BASE) then {
		_pObj setvariable ['__motherObject',
			missionNamespace getVariable [
				'pt_' +
				(_pObj getVariable ['__motherClass',TYPE_SUPER_BASE])
			,TYPE_SUPER_BASE]
		];
	};

	//adding reflect info: field and method names
	_pObj setVariable ["__allfields",_exist_fields];
	_pObj setVariable ["__allmethods",_exists_methods];

	//hashing faster than arrays
	_pObj setVariable ["__allfields_map",createHashMapFromArray _fieldsBaseValues];

	//init all attributes
	if not_equals(_attrs,[]) then {
		_attr_ex_init_list pushBack [_pObj,_attrs];

		//initialize all attributes after all classes done
	};

	//init autoref method
	if not_equals(_autoref,[]) then {
		_pObj setVariable ["__autoref_list",_autoref];
	};

	if (server_isLocked) exitWith {};
	//log("shell object <" + _x + "> is > " + _shell_data);
	//logoop("Class loaded - " + _x);

} forEach p_table_allclassnames;

private _errorAttr = {
	["Cant find attribute <%1> in class <%2>",_name arg _pObj getVariable ["classname" arg "UNKNOWN_CLASS"]] call logError;
	errorformat("Cant find attribute <%1> in class <%2>",_name arg _pObj getVariable ["classname" arg "UNKNOWN_CLASS"]);
};


{
	_x params ["_pObj","_attrs"];
	
	{
		_x params ["_name","_params"];

		[_pObj,_params] call (missionNamespace getVariable ["oop_attr_"+_name,_errorAttr]);

	} foreach _attrs;
} foreach _attr_ex_init_list;

EXIT_IF_ERROR("Class compilation was terminated");

logoop("--------------------------------------------------");
logoop("All classes loaded in " + str (diag_ticktime - _oop_initTime) + " sec");

// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


function(goasm_builder_build)
{
	params ["_onSuccessDelegate","_onErrorDelegate"];
	goasm_builder_postInit_delegate = _onSuccessDelegate;
	goasm_builder_onError_delegate = _onErrorDelegate;
	
	call goasm_builder_buildImplMain;
}

function(goasm_builder_postbuildCode)
{
	params ["_reason"];

	if (_reason == "postbuild") then {
		[format["Classes collection builded at %1 sec (%2 classes)",goasm_build_lastTime,count p_table_allclassnames],5] call showInfo;
		goasm_builder_isBuildedClasses = true;
		call goasm_builder_postInit_delegate;

		goasm_builder_postInit_customSetup = false; //resert to default
	} else {
		goasm_builder_isBuildedClasses = null;
		["Build error. See console",10] call showWarning;
		call goasm_builder_onError_delegate;
	};
}

function(goasm_builder_rebuildClasses)
{
	if (!goasm_builder_postInit_customSetup) then {
		goasm_builder_postInit_delegate = {
			call golib_vis_loadObjList;
		}; 
	};

	goasm_builder_onError_delegate = {
		[ 
			"Сборка классов завершилась с ошибкой. Нажмите ""Повторить"" для повторной попытки компиляции классов", 
			"Сборка", 
			[ 
				"Повторить", 
				{ 
					nextFrame(goasm_builder_rebuildClasses)
				} 
			], 
			[ 
				"Отмена", 
				{ } 
			], 
				"\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa", 
				findDisplay 313 
		] call createMessageBox;
	};
	nextFrame(goasm_builder_buildImplMain);
}

function(goasm_builder_setPostBuildCode)
{
	goasm_builder_postInit_delegate = _this;
	goasm_builder_postInit_customSetup = true;
}

function(goasm_builder_buildImplMain)
{
	//disable fws update
	call fileWatcher_guardSafeRebuild;

	//restore nodegen library
	call nodegen_cleanupClassData;

	goasm_isbuilded = false;
	call goasm_builder_cleanup;

	private _statusReturn = call goasm_builder_makeClassTable;
	if isNullVar(_statusReturn) exitWith {
		["%1 - error on compilation classes",__FUNC__] call printError;
		["error"] call goasm_builder_postbuildCode;
	};
	if (_statusReturn != 1) exitWith {
		["%1 - error on compilation classes. Status code: %2",__FUNC__,_statusReturn] call printError;
		["error"] call goasm_builder_postbuildCode;
	};

	#define NULLCLASS "<NAN_CLASS>"
	#define EXIT_IF_ERROR(mes) if (_iserror || server_isLocked) exitWith {[mes] call printError; ["error"] call goasm_builder_postbuildCode;}
	#define shell_init(__name__system,__value__system) format["_thisobj setvariable ['%1',%2]; ",__name__system,__value__system]

	_iserror = false;
	_oop_initTime = diag_ticktime;

	_attr_ex_init_list = [];
	{
		_pObj = missionnamespace getvariable ['pt_' + _x,NULLCLASS];
		_className_str = _x;
		if (_pObj isequalto NULLCLASS) exitWith {
			["Cant find class - %1",_x] call printError;
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
			["Duplicate classname - '%1'",_className_str] call printError;
		};
		_pObj setVariable ['__isPrepToComp',true];

		if (_motherType != TYPE_SUPER_BASE && {(missionnamespace getvariable ['pt_' + _motherType,nullPtr]) isEqualTo nullPtr}) exitWith {
			_iserror = true;
			["Can't find mother type '%2' in class '%1'",_className_str arg _motherType] call printError;
		};

		#define allocName this setName "%2"

		//_shell_data WAS DISABLED FOR MEMORY OPTIMIZATION
		/*_shell_data = if (_motherType == "NetObject") then {
			format['private ctxParams = _this; private this = createNetObj; private _pt = pt_%2; allocName; this setvariable ["%1",_pt]; ',PROTOTYPE_VAR_NAME,_x];
		} else {
			format['private ctxParams = _this; private this = createObj; private _pt = pt_%2; allocName; this setvariable ["%1",_pt]; ',PROTOTYPE_VAR_NAME,_x];
		};*/

		//attributes and autoref init
		private _attrs = [];
		private _autoref = [];

		private _attr_fields = createHashMap;
		private _attr_methods = createHashMap;
		private _attr_class = createHashMap;
		_pObj setVariable ["_redit_attribFields",_attr_fields];
		_pObj setVariable ["_redit_attribMethods",_attr_methods];
		_pObj setVariable ["_redit_attribClass",_attr_class];

		//Общий метод обработки атрибутов членов класса
		private __handleMemberAttributes = {
			params ["_memberNameStr","_refArr","_flag"];
			private _isInherAtr = not_equals(_mot,_pObj);
			{
				_x params ["_mem_name","_atrlist"];
				_mem_name = tolower _mem_name; //fix fields inspector attributes
				
				//Член не имеет атрибутов. проводим регистрацию
				if !(_mem_name in _refArr) then {
					private _list = [];

					{
						if ([_x select 0,_mot,_flag,_x select [1,(count _x) - 1],_isInherAtr] call goasm_attributes_canAddAttribute) then {
							_list pushBack _x;
						};
					} foreach _atrlist;

					if (count _list > 0) then {
						_refArr set [_mem_name,_list];
					};
				} else {
					//Получаем список атрибутов
					_curAtList = _refArr get _mem_name;
					//Если атрибут есть в списке наследования - пропускаем
					{
						_atName = _x select 0;
						if ([_atName,_mot,_flag,_x select [1,(count _x) - 1],_isInherAtr] call goasm_attributes_canAddAttribute) then {
							if ((_curAtList findif {(_x select 0) == _atName}) == -1) then {
								_curAtList pushBack _x;
							};
						};

					} foreach _atrlist;
				};
			} forEach (_mot getVariable [_memberNameStr,[]]);
		};

		private __handleClassAttributes = {
			params ["_memberNameStr","_refArr","_flag"];
			private _isInherAtr = not_equals(_mot,_pObj);
			{
				//если атрибут не в классе
				_atName = _x select 0;
				if !(_atName in _refArr) then {
					private _atdata = _x select [1,(count _x) - 1];
					if ([_atName,_mot,_flag,_atdata,_isInherAtr] call goasm_attributes_canAddAttribute) then {
						_refArr set [_atName,_atdata];
					};
				} else {
					private _atdata = _x select [1,(count _x) - 1];
					if ([_atName,_mot,_flag,_atdata,_isInherAtr] call goasm_attributes_canAddAttribute) then {
						//fix upper inheritance attributes. Editor 1.4
						//Так как наследование идёт сверху вниз нам не нужно переопределять дочерними свойствами значения атрибута при наличии
						if (_atName in _refArr) exitwith {};
						_refArr set [_atName,_atdata];
					};
				};
			} foreach (_mot getVariable [_memberNameStr,[]]);
		};

		//inheritance process
		_mot = _pObj;
		_inheritance_list = [_x];
		_counter = 0;

		while {!((_mot) isequalto NULLCLASS)} do {

			if (_counter >= 9999) exitWith {
				["Maximum inheritance amount on class '%1'",_x] call printError;
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
					//_shell_data = _shell_data + shell_init(_name,_value);
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

			//handle members attributes
			["__ed_attr_fields",_attr_fields,"field"] call __handleMemberAttributes;
			["__ed_attr_methods",_attr_methods,"method"] call __handleMemberAttributes;

			["__ed_attr_class",_attr_class,"class"] call __handleClassAttributes;

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
				["Compilation runtime error. Cant find mother class %1",_motTypeName] call printError;
				_iserror = true;
			};
			(_mot getVariable '__childList') pushBackUnique (tolower _thisChild);
		};

		if (_iserror) exitWith {
			["Abort init classes after inheritance process '%1'",_x] call printError;
		};

		//calling ctors
		//_shell_data = _shell_data + '{this call (_x getvariable "constructor")} foreach (this getvariable "proto" getvariable "__ctors"); this';

		//_pObj setvariable ['__instance',compile _shell_data];
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

		[_className_str,(_pObj getvariable "__allfields_map") get "model"] call golib_massoc_generate;

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
		["Cant find attribute <%1> in class <%2>",_name arg _pObj getVariable ["classname" arg "UNKNOWN_CLASS"]] call printError;
	};

	{
		_x params ["_pObj","_attrs"];
		_pObj setVariable ["__ed_attr_class",_attrs];
	} foreach _attr_ex_init_list;

	EXIT_IF_ERROR("compilation error");

	#undef NULLCLASS
	#undef EXIT_IF_ERROR
	#undef shell_init

	goasm_build_lastTime = diag_ticktime - _oop_initTime;
	["%2 - BUILD DONE! All classes loaded in %1 sec",goasm_build_lastTime,__FUNC__] call printLog;
	goasm_isbuilded = true;
	["postbuild"] call goasm_builder_postbuildCode;
}


//вызывается только внутри goasm_builder_build
function(goasm_builder_cleanup)
{
	golib_massoc_map_modelToClass = createHashMap;

	//cleanup gameobjects
	if (!isnil {p_table_allclassnames}) then {
		{
			missionnamespace setvariable ["pt_" + _x,nil];
		} foreach p_table_allclassnames;

		//removing all vObj
		{
			deleteLocation _x;
		} foreach (nearestLocations [[100,100,100],["CBA_NamespaceDummy"],10])
	};

	//initialize typelists
	p_table_inheritance = [];
	p_table_allclassnames = [];
}


function(goasm_builder_makeClassTable)
{
	//for backward compatibility
	server_isLocked = false;
	client_isLocked = false;

	//Инициализация временного хранилища для атрибутов
	private _editor_next_attr = [];

	#define loadFile(path) if (server_isLocked) exitWith {["Compile process aborted - server.isLocked == true"] call printError; -5}; ["Start loading file %1",path] call printLog; call compile preprocessFileLineNumbers (path)
	
	#include <..\..\host\GameObjects\GameConstants.hpp>
	//load base object
	#include "..\..\host\OOP_engine\oop_object.sqf"
	
	//test object
	if (golib_vis_debug_createTestClass) then {
		editor_attribute("ColorClass" arg "ff0000")
		class(ATest_BaseObject) extends(GameObject)
			editor_attribute("alias" arg "тест1")
			editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:8") editor_attribute("Tooltip" arg "Описание через атрибут") var(testName,null);
			editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:8") var(testCODEString,call somefunuction_callname);
			editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:20") var(testStringNotEmpt,"");
			editor_attribute("EditorVisible" arg "type:float" arg "range:-5:5") editor_attribute("Tooltip" arg "Test float;") var(testFloat,3.6);
			editor_attribute("EditorVisible" arg "type:int" arg "range:-5:5") editor_attribute("Tooltip" arg "Test int") var(testInt,90);
			editor_attribute("EditorVisible" arg "type:int" arg "range:0:300") editor_attribute("Tooltip" arg "Runtime integer") var(testIntRuntime,call {"some instructions";123});
			editor_attribute("EditorVisible" arg "type:bool") editor_attribute("Tooltip" arg "Test bool") var(testBool,false);
			editor_attribute("EditorVisible" arg "type:bool") editor_attribute("Tooltip" arg "Test bool inversed") var(testBoolInversed,true);
			editor_attribute("EditorVisible" arg "custom_provider:model") var(model,"a3\structures_f_epa\items\food\canteen_f.p3d");
			editor_attribute("alias" arg "Размер")
			editor_attribute("EditorVisible" arg "custom_provider:size") editor_attribute("Tooltip" arg "Размер предмета") var(size,ITEM_SIZE_TINY);
		endclass
	};

	
	
	// для оптимизации пока отключил загрузчик всех классов в игру
	//#include "GOAsm_test_objects.sqf"

	call compile preprocessFileLineNumbers "src\Editor\GameObjectsAssembly\__GOAsm_loader.sqf";

	//загружаем нодовые классы
	call nodegen_loadClasses;

	1
}

// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
	
	private _result = [] call oop_loadTypes;
	if (_result) then {
		["%2 - BUILD DONE! All classes loaded in %1 sec",goasm_build_lastTime,__FUNC__] call printLog;
		goasm_isbuilded = true;
		["postbuild"] call goasm_builder_postbuildCode;
	};
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

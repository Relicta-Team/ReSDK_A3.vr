// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



function(goasm_iapi_effect_convertConfig)
{
	params ["_cls","_cfg"];
	private _aobj = ([_cls,"class","EffectClass"] call goasm_attributes_getValues);

	private _type = (([_aobj,"type",true] call goasm_attributes_getPropertyValue) select 0);
	if (
		isNullVar(_type) || 
		not_equalTypes(_type,"")
	) exitWith {
		["%3: Atribute structure error; See %1[%2]",_cls,_aobj,__FUNC__] call printError;
		"--errormodel--"
	};
	
	if (_type == "particle") exitWith {
		"Land_VR_Block_02_F"
	};
	if (_type == "spawnpoint") exitWith {_cfg};
	if (_type == "teleport") exitwith {_cfg};
	if (_type == "zone") exitwith {_cfg};

	["%1: Unknown type - %2 at class %3",__FUNC__,_aobj,_cls] call printError;
}

function(goasm_iapi_effect_preparModel)
{
	params ["_obj","_class"];

	if (_class == "SpawnPoint" || _class == "CollectionSpawnPoint") exitWith {
		if !("Spawn points" call layer_isExists) then {
			["Spawn points"] call layer_create;
		};

		//add object to layer
		[_obj,"Spawn points"] call layer_addObject;
	};
	if (_class == "TeleportBase" || _class == "TeleportExit") exitWith {
		if !("Teleports" call layer_isExists) then {
			["Teleports"] call layer_create;
		};

		//add object to layer
		[_obj,"Teleports"] call layer_addObject;
	};
	if ([_class,"ZoneBase"] call oop_isTypeOf) exitwith {
		if !("Zones" call layer_isExists) then {
			["Zones"] call layer_create;
		};

		//add object to layer
		[_obj,"Zones"] call layer_addObject;
	};

	_obj set3DENAttribute ["ObjectTextureCustom0",""];
	_obj set3DENAttribute ["ObjectTextureCustom1","#(argb,8,8,3)color(1.0,0.0,0.4,1.0,co)"];
	_obj set3DENAttribute ["ObjectMaterialCustom0",""];
	_obj set3DENAttribute ["ObjectMaterialCustom1",""];

	if !("Effects" call layer_isExists) then {
		["Effects"] call layer_create;
	};

	//add object to layer
	[_obj,"Effects"] call layer_addObject;
}
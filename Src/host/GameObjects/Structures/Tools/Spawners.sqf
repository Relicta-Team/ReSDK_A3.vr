// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//При входе клиента в зону спавна удаляет его
editor_attribute("HiddenClass")
class(ISpawnerStruct) extends(IStruct)
	var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
	getter_func(onSpawn,null);
	getter_func(disposeAfterUserEnterLocation,true);
	
	func(onEnterArea)
	{
		objParams_1(_usr);
		callSelf(onSpawn);
		delete(this);
	};
	
	
endclass

//список всех спавнпойнтов
spawnPos_internal_list_all = [];
//список спавнпойтов по тегу
spawnPos_internal_map_equalCollections = createHashMap;

spawnPos_internal_list_rnd = [];

isExistsSpawn = { private _name = _this; (spawnPos_internal_list_all findif {getVar(_x,spawnPointName) == _name}) != -1 };
isExistsRandomSpawn = { private _name = _this; equalTypes(vec2(_name,"NOT_FOUND") call getRandomSpawnDirByName,0) };

getSpawnPosByName = {
	params ["_name",["_def",[0,0,0]]];
	private _ind = spawnPos_internal_list_all findif {getVar(_x,spawnPointName) == _name};
	if (_ind == -1) exitWith {
		errorformat("getSpawnPosByName() - cant find spawnpos '%1'",_name);
		_def
	};
	getPosAtl getVar(spawnPos_internal_list_all select _ind,loc)
};

getSpawnDirByName = {
	params ["_name",["_def",random 360]];
	private _ind = spawnPos_internal_list_all findif {getVar(_x,spawnPointName) == _name};
	if (_ind == -1) exitWith {
		errorformat("getSpawnPosByName() - cant find spawnpos '%1'",_name);
		_def
	};
	getDir getVar(spawnPos_internal_list_all select _ind,loc)
};

getRandomSpawnPosByName = {
	params ["_pos",["_defpos",0]];

	private _wobj = [_pos,_defpos] call getRandomSpawnByNameProvider;
	if isNullReference(_wobj) exitWith {_defpos};
	getPosAtl _wobj

};
getRandomSpawnDirByName = {
	params ["_pos",["_dir",0]];

	private _wobj = [_pos,_dir] call getRandomSpawnByNameProvider;
	if isNullReference(_wobj) exitWith {_dir};
	getDir _wobj
};

getRandomSpawnByNameProvider = {
	params ["_name","_def"];

	if (count spawnPos_internal_map_equalCollections == 0) then {
		//generate collection of spawnmaps
		{
			private _key = getVar(_x,spawnPointName);
		
			if equals(_key,"") exitWith {
				errorformat("%1.ctor: some spawn point have empty name",callSelf(getClassName));
			};

			if !array_exists(spawnPos_internal_map_equalCollections,_key) then {
				private _newList = [_x];
				spawnPos_internal_map_equalCollections set [_key,_newList];
			} else {
				(spawnPos_internal_map_equalCollections get _key) pushBack _x;
			};
		} foreach spawnPos_internal_list_rnd;
	};

	private _posList = spawnPos_internal_map_equalCollections get _name;
	if isNullVar(_posList) exitWith {
		errorformat("getRandomSpawnPosByName() - cant find spawnpos '%1'",_name);
		objnull
	};
	getVar(pick _posList,loc)
};

editor_attribute("EffectClass" arg "type:spawnpoint")
class(SpawnPoint) extends(IStructNonReplicated)

	editor_attribute("InternalImpl")
	;if (!is3DEN) then {
		var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
	}  else {
		var(model,"VR_3DSelector_01_default_F");
	};
	
	editor_attribute("InternalImpl")
	var(name,null);
	editor_attribute("InternalImpl")
	var(desc,null);
	editor_attribute("InternalImpl")
	var(weight,null);

	editor_attribute("alias" arg "pointName")
	editor_attribute("Tooltip" arg "Название точки спавна.\nДля получения позиции используйте функцию getSpawnPosByName()")
	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:64")
	
	var(spawnPointName,"");

	func(constructor)
	{
		objParams();
		
		spawnPos_internal_list_all pushBackUnique this;
	};

endclass

//Отличие от обычного SpawnPoint-а: случайный выбор позиции из коллекции по единому тегу
class(CollectionSpawnPoint) extends(SpawnPoint)

	func(constructor)
	{
		objParams();
		spawnPos_internal_list_rnd pushBackUnique this;
	};

endclass
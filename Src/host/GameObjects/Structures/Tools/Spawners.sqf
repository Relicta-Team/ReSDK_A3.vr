// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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

getSpawnObjectByName = {
	params ["_name"];
	private _ind = spawnPos_internal_list_all findif {getVar(_x,spawnPointName) == _name};
	if (_ind == -1) exitWith {nullPtr};
	spawnPos_internal_list_all select _ind
};

getSpawnPosByName = {
	params ["_name",["_def",[0,0,0]]];
	private _obj = [_name] call getSpawnObjectByName;
	if isNullReference(_obj) exitWith {
		errorformat("getSpawnPosByName() - cant find spawnpos '%1'",_name);
		_def
	};
	
	getPosAtl getVar(_obj,loc)
};

getSpawnDirByName = {
	params ["_name",["_def",random 360]];
	private _obj = [_name] call getSpawnObjectByName;
	if isNullReference(_obj) exitWith {
		errorformat("getSpawnPosByName() - cant find spawnpos '%1'",_name);
		_def
	};

	getDir getVar(_obj,loc)
};

getRandomSpawnPosByName = {
	params ["_pos",["_defpos",0]];

	private _wobj = [_pos] call getRandomSpawnObjectByName;
	if isNullReference(_wobj) exitWith {_defpos};

	getPosAtl getVar(_wobj,loc)

};
getRandomSpawnDirByName = {
	params ["_pos",["_dir",0]];

	private _wobj = [_pos] call getRandomSpawnObjectByName;
	if isNullReference(_wobj) exitWith {_dir};

	getDir getVar(_wobj,loc)
};

getRandomSpawnObjectByName = {
	params ["_name",["_returnList",false]];

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
		errorformat("getRandomSpawnObjectByName() - cant find spawnpos '%1'",_name);
		
		if (_returnList) exitWith {[]};
		nullPtr
	};
	
	if (_returnList) exitWith {array_copy(_posList)};
	pick _posList
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

class(EntitySpawner) extends(IStructNonReplicated)
	var(name,"Спавнер АИ-сущности");

	editor_attribute("InternalImpl")
	;if (!is3DEN) then {
		var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
	}  else {
		var(model,"vr_3dselector_01_exit_f");
	};

	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:64")
	editor_attribute("alias" arg "Entity type")
	var(entityType,"");

	editor_attribute("EditorVisible" arg "type:int" arg "range:1:100")
	editor_attribute("alias" arg "stat Strength")
	var(st,10);

	editor_attribute("EditorVisible" arg "type:int" arg "range:1:100")
	editor_attribute("alias" arg "stat Intelligence")
	var(iq,10);

	editor_attribute("EditorVisible" arg "type:int" arg "range:1:100")
	editor_attribute("alias" arg "stat Dexterity")
	var(dx,10);

	editor_attribute("EditorVisible" arg "type:int" arg "range:1:100")
	editor_attribute("alias" arg "stat Health")
	var(ht,10);

	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:64")
	editor_attribute("alias" arg "Behaviour type")
	var(behaviourName,"");

	func(initModel)
	{
		objParams_3(_pos,_dir,_vec);
		super();
		private _cls = getSelf(entityType);
		// if !isImplementClass(_cls) exitWith {
		// 	errorformat("EntitySpawner.ctor: cant find entity class '%1'",_cls);
		// 	setLastError("Cant find entity class '" + _cls + "'");
		// };
		private _behaviour = getSelf(behaviourName);
		//todo use behaviour

		//todo use builder type
		private _args = [_pos,null];//[_pos,[getSelf(st) arg getSelf(iq) arg getSelf(dx) arg getSelf(ht)]];
		#ifdef EDITOR
			startAsyncInvoke
			{
				params ["_args"];
				private _ppos = _args select 0;
				_ready = true;
				{
					if !([[[_ppos,_x] call noe_posToChunk,_x] call noe_client_getPosChunkToData] call noe_client_isObjectsLoadingDone) exitWith {
						_ready = false;
					};
				} foreach noe_client_allChunkTypes;
				
				_ready
			},
			{
				params ["_args"];
				_args call ai_createMob;
			},
			[_args]
			endAsyncInvoke
		#else
			_args call ai_createMob;
		#endif
	};

endclass
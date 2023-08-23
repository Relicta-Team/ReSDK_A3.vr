// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\..\client\Inventory\inventory.hpp>

// Создание предмета в 3д пространстве
createItemInWorld = {
	params ['_name_str',"_pos",["_dir",random 360],["_emulDrop",true],["_vec",[0,0,1]],["_probStackSize",1]];

	private _type = missionnamespace getVariable ["pt_" + _name_str,"NAN"];
	if (_type isEqualTo "NAN") exitWith {
		errorformat("Cant instantiate object with class %1 (not found)",_name_str);
		nullPtr
	};
	//std validate type
	if (!(call (_type getVariable "isItem"))) exitWith {
		errorformat("Cant instantiate object %1 as item",_name_str);
		nullPtr
	};

	// вместо нуля можно передавать параметры
	private this = 0 call (_type getvariable '__instance');

	private _vec = [0,0,1];

	if (_emulDrop) then {

		private _posI = [0,0,0];
		private _posI = (ATLToASL _pos) vectorAdd [0,0,0.1];

		private _dirPos = random 360;

		private _itsc = lineIntersectsSurfaces [_posI,_posI vectorDiff [0,0,1000],objNull,objNull,true,1,"VIEW","FIRE"];

		if ((count _itsc) == 0) then {
			//[ASLToATL _posI,_goDir,_vec];
			_pos = ASLToATL _posI;
			//_dir = _goDir;
		} else {
			(_itsc select 0) params ["_posIn","_vecup","_targ"];
			//[ASLToATL _pos,_goDir,_vecup];
			_pos = ASLToATL _posIn;
			//_dir = _goDir;
			_vec = _vecUp
		};
	};

	private _visObj = callSelfParams(InitModel,_pos arg _dir arg _vec);

	[[_pos,CHUNK_TYPE_ITEM] call noe_posToChunk,CHUNK_TYPE_ITEM,_visObj] call noe_registerObject;

	this
};

// Создание предмета в контейнере
createItemInContainer = {
	params ["_name_str","_container",["_probStackSize",1],["_ignoreMode",""]]; 
	//ignoremode = all,maxsize,countslots,none
	//specifiers:resize,insert(by default)
	//sample: "maxsize;insert;expand;"
	/*
		ignoremode:
		- all for size and count slots
		- maxsize for maximum size 
		- countslots for count slots
		- none or empty string - do nothing
		specs:
		- expand for update size
		- insert only emplace item inside container
	*/
	//full sample: ["GameObject",_ref,null,"maxsize;countslots;resize;addslots"] call createItemInContainer
	// ["GameObject",_ref,null,"all;expand"] call createItemInContainer

	private _type = missionnamespace getVariable ["pt_" + _name_str,"NAN"];
	if (_type isEqualTo "NAN") exitWith {
		errorformat("Cant instantiate object with class %1 (not found)",_name_str);
	};

	if (!callFunc(_container,isContainer)) exitWith {
		errorformat("Object %1 is not a container",callFunc(_container,getClassName));
		nullPtr
	};

	private _item = call (_type getvariable '__instance');
	private _contLoc = getVar(_container,loc);

	_ignoreMode = tolower _ignoreMode;
	private _FLAG_msFlag__ = "maxsize" in _ignoreMode;
	private _FLAG_csFlag__ = "countslots" in _ignoreMode;
	if ("all" in _ignoreMode) then {
		_FLAG_msFlag__ = true; 
		_FLAG_csFlag__ = true;
	};
	//specifiers
	private _FLAG_spResize__ = "expand" in _ignoreMode;

	private _rez = callFuncParams(_container,addItem,_item);

	//Если контейнер на мобе
	if (equalTypes(_contLoc,nullPtr) && {isTypeOf(_contLoc,Mob)}) then {
		//добавляем в вес
		_contLoc call gurps_recalcuateEncumbrance;
	};

	if !(_rez isEqualTo true) exitWith {
		errorformat("Cant create %2 in %1. Result is %3",callFunc(_container,getClassName) arg callFunc(_item,getClassName) arg _rez);
		delete(_item);
		//перерасчитываем в вес
		_contLoc call gurps_recalcuateEncumbrance;
		nullPtr;
	};

	_item
};

// Создание предмета в инвентаре
createItemInInventory = {
	params ["_name_str","_mob","_slot",["_probStackSize",1]];

	if (_mob isEqualType objnull) then {
		_mob = _mob getvariable 'link';
	};

	private _type = missionnamespace getVariable ["pt_" + _name_str,"NAN"];
	if (_type isEqualTo "NAN") exitWith {
		errorformat("Cant instantiate object with class %1 (not found)",_name_str);
	};

	if isNullVar(_slot) then {_slot = getVar(_mob,activeHand)};

	private _altSlot = if array_exists(INV_LIST_HANDS,_slot) then {
		ifcheck(_slot==INV_HAND_L,INV_HAND_R,INV_HAND_L)
	} else {
		_slot
	};
	
	private _item = call (_type getvariable '__instance');

	private _cantSetMain = !callFuncParams(_mob,canSetItemOnSlot,_item arg _slot);
	private _cantSetAlt = !callFuncParams(_mob,canSetItemOnSlot,_item arg _altSlot);

	if (_cantSetMain && _cantSetAlt) exitWith {
		private _idata = [_name_str,getVar(_item,pointer)];
		warningformat("createItemInInventory() - canSetitemOnSlot check fall. Item spawned on world: %1",_idata);
		delete(_item);
		private _pos = getPosATL getVar(_mob,owner);
		if (_pos distance [0,0,0] <= 5) then {
			_pos = callFunc(_mob,getInitialPos);
		};
		//Создаём на земле под мобом
		[_name_str,_pos] call createItemInWorld;
	};
	if (_cantSetMain && !_cantSetAlt) then {_slot = _altSlot};

	callFuncParams(_mob,setItemOnSlot,_item arg _slot);

	_item
};

// Создание структуры в мире
createStructure = {
	params ['_name_str',"_pos",["_dir",random 360],["_emulDrop",true],["_vec",[0,0,1]]];

	private _type = missionnamespace getVariable ["pt_" + _name_str,"NAN"];
	if (_type isEqualTo "NAN") exitWith {
		errorformat("Cant instantiate object with class %1 (not found)",_name_str);
	};
	//std validate type
	if (!(call (_type getVariable "isStruct"))) exitWith {
		errorformat("Cant instantiate object %1 as structure",_name_str);
		nullPtr
	};
	private this = call (_type getvariable '__instance');

	//private _vec = [0,0,1];

	if (_emulDrop) then {

		private _posI = [0,0,0];
		private _posI = (ATLToASL _pos) vectorAdd [0,0,0.1];

		private _dirPos = random 360;

		private _itsc = lineIntersectsSurfaces [_posI,_posI vectorDiff [0,0,1000],objNull,objNull,true,1,"VIEW","FIRE"];

		if ((count _itsc) == 0) then {
			_pos = ASLToATL _posI;
		} else {
			(_itsc select 0) params ["_posIn","_vecup","_targ"];
			_pos = ASLToATL _posIn;
			_vec = _vecUp
		};
	};

	private _visObj = callSelfParams(InitModel,_pos arg _dir arg _vec);

	[[_pos,CHUNK_TYPE_STRUCTURE] call noe_posToChunk,CHUNK_TYPE_STRUCTURE,_visObj] call noe_registerObject;

	this
};

// Создание декорации в мире
createDecoration = {
	params ['_name_str',"_pos",["_dir",random 360],["_emulDrop",true],["_vec",[0,0,1]]];

	private _type = missionnamespace getVariable ["pt_" + _name_str,"NAN"];
	if (_type isEqualTo "NAN") exitWith {
		errorformat("Cant instantiate object with class %1 (not found)",_name_str);
	};
	//std validate type
	if (!(call (_type getVariable "isDecor"))) exitWith {
		errorformat("Cant instantiate object %1 as decoration",_name_str);
		nullPtr
	};
	private this = call (_type getvariable '__instance');

	//private _vec = [0,0,1];

	if (_emulDrop) then {

		private _posI = [0,0,0];
		private _posI = (ATLToASL _pos) vectorAdd [0,0,0.1];

		private _dirPos = random 360;

		private _itsc = lineIntersectsSurfaces [_posI,_posI vectorDiff [0,0,1000],objNull,objNull,true,1,"VIEW","FIRE"];

		if ((count _itsc) == 0) then {
			_pos = ASLToATL _posI;
		} else {
			(_itsc select 0) params ["_posIn","_vecup","_targ"];
			_pos = ASLToATL _posIn;
			_vec = _vecUp
		};
	};

	private _visObj = callSelfParams(InitModel,_pos arg _dir arg _vec);

	[[_pos,CHUNK_TYPE_DECOR] call noe_posToChunk,CHUNK_TYPE_DECOR,_visObj] call noe_registerObject;

	this
};


// Удаление декора
deleteDecor = {
	params ["_dec"];
	FHEADER;
	if equalTypes(_dec,"") then {
		private _vObj = pointer_get(_dec);
		if !pointer_isValidResult(_vObj) exitWith {errorformat("Decor not found - %1",_dec); RETURN(false)};
		_dec = _vObj;
	};

	[_dec,CHUNK_TYPE_DECOR] call noe_unloadVisualObject; //removing visual object

	delete(_dec);
};

// Удаление структуры
deleteStructure = {
	params ["_struct"];
	FHEADER;
	if equalTypes(_struct,"") then {
		private _vObj = pointer_get(_struct);
		if !pointer_isValidResult(_vObj) exitWith {errorformat("Structure not found - %1",_struct); RETURN(false)};
		_struct = _vObj;
	};

	[_struct,CHUNK_TYPE_STRUCTURE] call noe_unloadVisualObject; //removing visual object

	delete(_struct);
};

// Удаление предмета
deleteItem = {
	params ["_item"];
	FHEADER;

	if equalTypes(_item,"") then {
		private _vObj = pointer_get(_item);
		if !pointer_isValidResult(_vObj) exitWith {errorformat("Item not found - %1",_item); RETURN(false)};
		_item = _vObj;
	};

	if callFunc(_item,isInWorld) then {
		[_item,CHUNK_TYPE_ITEM] call noe_unloadVisualObject; //removing visual object
		delete(_item);
	} else {
		private _loc = getVar(_item,loc);
		if callFunc(_loc,isMob) exitWith {
			callFuncParams(_loc,removeItem,_item);
			delete(_item);
		};
		if callFunc(_loc,isContainer) exitWith {
			callFuncParams(_loc,removeItem,_item arg nullPtr);
			delete(_item);
		};
	};

	RETURN(true);
};

//Получить игровой объект по позиции. Параметр _retAsList позволяет вернуть несколько объектов в этой позиции
//_retChild - опциональный параметр для возврата всех дочерних типов
getGameObjectOnPosition = {
	params ["_type","_vecPos",["_dist",3],["_retAsList",false],["_retChild",false]];
	FHEADER;
	_dist = clamp(_dist,0.001,10000);

	private _list = _vecPos nearObjects _dist;
	private _objRet = ifcheck(_retAsList,[],nullPtr);
	private _prob = nullPtr;
	private _algGet = ifcheck(_retChild,{isTypeStringOf(_prob,_type)},{callFunc(_prob,getClassName) == _type});
	if (_retAsList) then {
		{
			if (_x call noe_server_isNGO) then {continue};

			_prob = _x getVariable "link";
			#ifdef EDITOR
			if isNullVar(_prob) then {continue};
			#endif
			if (call _algGet) then {
				_objRet pushBack _prob;
			};
		} foreach _list;
	} else {
		{
			if (_x call noe_server_isNGO) then {continue};

			_prob = _x getVariable "link";
			#ifdef EDITOR
			if isNullVar(_prob) then {continue};
			#endif
			if (call _algGet) exitWith {
				_objRet = _prob;
			};
		} foreach _list;
	};


	_objRet;
};

//возвращает все объекты в мире. очень затратно по ресурсам
getAllObjectsInWorldTypeOf = {
	params ["_type",["_retChild",true]];
	private _mid = worldSize/2;
	[_type,[_mid,_mid,0],10000,true,_retChild] call getGameObjectOnPosition;
};

//Возвращает все итемы определенного типа
getAllItemsTypeOf = {
	params ["_type",["_retChild",true]];
	private _mid = worldSize/2;
	[_type,[_mid,_mid,0],10000,_retChild] call getAllItemsOnPosition;
};

//Получает все итемы в инвентаре сущности
getAllItemsInInventory = {
	params ["_mob","_type",["_retChild",true]];
	private _objRet = [];
	private _algGet = ifcheck(_retChild,{isTypeStringOf(_this,_type)},{callFunc(_this,getClassName) == _type});
	private _itmSlot = nullPtr;
	{

		_itmSlot = callFuncParams(_mob,getItemInSlot,_x);
		if isNullReference(_itmSlot) then {
			continue;
		};

		if (_itmSlot call _algGet) then {
			_objRet pushBack _itmSlot;
		};

		if callFunc(_itmSlot,isContainer) then {
			{
				if (_x call _algGet) then {
					_objRet pushBack _x;
				};
			} foreach getVar(_itmSlot,content);
		};

	} forEach INV_LIST_ALL;
	_objRet
};

//Собирает все игровые объекты на позиции возвращая их в листе. Включает предметы на мобах и в контейнерах
getAllItemsOnPosition = {
	params ["_type","_vecPos",["_dist",3],["_retChild",false]];
	FHEADER;
	if !isTypeNameOf(_type,Item) exitWith {
		warningformat("getAllItemsOnPosition() - Type %1 not inherit item",_type);
		[]
	};
	_dist = clamp(_dist,0.001,10000);

	private _list = _vecPos nearObjects _dist;
	private _objRet = [];
	private _prob = nullPtr;
	private _algGet = ifcheck(_retChild,{isTypeStringOf(_this,_type)},{callFunc(_this,getClassName) == _type});
	
	{
		if (_x call noe_server_isNGO) then {continue};
		
		_prob = _x getVariable "link";
		#ifdef EDITOR
		if isNullVar(_prob) then {continue};
		#endif
		if (_prob call _algGet) then {
			_objRet pushBack _prob;
		} else {
			if callFunc(_prob,isMob) exitWith {
				private _itmSlot = nullPtr;
				private _mob = _prob;
				{
		
					_itmSlot = callFuncParams(_mob,getItemInSlot,_x);
					if isNullReference(_itmSlot) then {
						continue;
					};
		
					if (_itmSlot call _algGet) then {
						_objRet pushBack _itmSlot;
					};
		
					if callFunc(_itmSlot,isContainer) then {
						{
							if (_x call _algGet) then {
								_objRet pushBack _x;
							};
						} foreach getVar(_itmSlot,content);
					};
		
				} forEach INV_LIST_ALL;
			};
			if callFunc(_prob,isContainer) exitWith {
				{
					if (_x call _algGet) then {
						_objRet pushBack _x;
					};
				} foreach getVar(_prob,content);
			};
		};
	} foreach _list;


	_objRet;
};

//Возвращает всех мобов в радиусе _dist на позиции _vecPos
getMobsOnPosition = {
	params ["_type","_vecPos",["_dist",3],["_retAsList",false],["_retChild",false]];
	FHEADER;
	_dist = clamp(_dist,0.001,10000);
	private _objRet = ifcheck(_retAsList,[],nullPtr);
	private _list = _vecPos nearObjects _dist;
	private _algGet = ifcheck(_retChild,{isTypeStringOf(_this,_type)},{callFunc(_this,getClassName) == _type});
	{
		_x = _x getVariable "link";
		if (_x call _algGet) then {
			if (_retAsList) then {
				_objRet pushBack _x;
			} else {
				RETURN(_objRet);
			}
		};
	} foreach _list;
	_objRet;
};

//Возвращает список всех мобов в мире
getAllMobsInWorld = {
	params ["_type",["_retChild",false]];
	private _list = cm_allInGameMobs apply {_x getvariable "LINK"};
	private _algGet = ifcheck(_retChild,{isTypeStringOf(_this,_type)},{callFunc(_this,getClassName) == _type});
	private _retList = [];
	{
		if (_x call _algGet) then {
			_retList pushback _x;
		};
	} foreach _list;
	_retList
};

//Получает игровой объект по ссылке
getObjectByRef = {
	params [["_name",""],["_def",nullPtr]];
	go_editor_globalRefs getOrDefault [_name,_def];
};

//получить зону по имени
getZoneByName = {
	zoneLocations_map_all getOrDefault [_this,nullPtr];
};

//TODO implement
noe_transform_position = {
	params ["_ptr","_newpos",["_transformAsWPos",false]];
	//TODO...
};
//TODO implement
noe_transform_direction = {

};
//TODO implement
noe_transform_vector = {

};
//TODO implement
noe_transform_all = {

};

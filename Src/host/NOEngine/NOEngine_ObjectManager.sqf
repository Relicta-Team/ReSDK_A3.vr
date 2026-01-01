// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\..\client\Inventory\inventory.hpp>

//common function for creating items,structures, decorations in gameworld
"
	name:Создать объект
	namelib:Создать объект GameObject (спавн объекта)
	desc:Создает новый игровой объект типа GameObject в мире на указанной позиции.
	in:classname:Тип объекта
		opt:def=IDestructible:typeset_out=Объект
	in:vector3:Позиция:Позиция объекта в мире
	in:auto:Направление:Направление создаваемого объекта. Если не указано, то направление будет случайным, т.е. объект будет направлен в случайную сторону.
		opt:require=0:allowtypes=int|float|vector3
	in:bool:На поверхности:При включении этого параметра создаваемый объект будет установлен на ближайшую поверхность, так как если бы он упал с воздуха если позиция находится над землёй, но без получения повреждений объекту.
		opt:require=0:def=true
	in:vector3:Вектор:Вектор направления создаваемого объекта. По умолчанию направлен вверх (0,0,1). [community.bistudio.com/wiki/vectorUp Подробнее по ссылке]
		opt:def=[0,0,1]:require=0
	out:IDestructible:Объект:Созданный объект
"
node_func(createGameObjectInWorld) = {
	params ["_name_str","_pos",["_dir",random 360],["_emulDrop",false],["_vec",[0,0,1]]];
	private _type = missionnamespace getVariable ["pt_" + _name_str,"NAN"];
	
	assert_str(equalTypes(_type,nullPtr),"Unknown object type " + _name_str);

	if (_type isEqualTo "NAN") exitWith {
		errorformat("Cant instantiate object with class %1 (not found)",_name_str);
		nullPtr
	};

	assert_str(!isTypeNameOf(_name_str,BasicMob),"BasicMob not supported in createGameObjectInWorld");

	//alloc type
	private _chT = call (_type getVariable "getChunkType");

	//default checks
	assert_str(!isNullVar(_name_str),"Null name for creating object");
	assert_str(!isNullVar(_chT),"Unknown chunk type for object " + _name_str);

	private this = call (_type getvariable '__instance');

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

	[[_pos,_chT] call noe_posToChunk,_chT,_visObj] call noe_registerObject;
	
	[this] call createGameObjectScriptInternal;

	this
};

"
	name:Создать скрипт
	desc:Создает и назачает скрипт на указанном игровом объекте. Возвращает @[bool ИСТИНУ], если скрипт успешно создан и назначен игровому объекту. "+
	"Если скрипт уже существует на игровом объекте - просто возвращает @[bool ЛОЖЬ].\n\n"+
	"Обратите внимание, что у скриптов игровых объектов существует ограничения на допустимые типы объектов. Если ваш скрипт не может быть назначен игровому объекту из-за ограничений, то создания скрипта не произойдёт.
	in:classname:Тип:Тип создаваемого скрипта.
		opt:def=ScriptedGameObject
	in:IDestructible:Объект:Игровой объект, для которого создается скрипт.
	out:bool:Результат:Результат создания и назначения скрипта. При успешном выполнеии возвращает @[bool ИСТИНУ].
"
node_func(createGameObjectScript) = {
	params ["_name_str","_gobj","_scriptParamsArgs"];
	if isNullReference(_gobj) exitWith {false};
	if !isNullReference(getVar(_gobj,__script)) exitWith {false};

	//create script instance
	private _script = instantiate(_name_str);

	assert_str(!isNullVar(_script),"Internal script creating error for type " + _name_str);
	if !isTypeOf(_script,ScriptedGameObject) exitWith {
		setLastError("Created object is not ScriptedGameObject: " + callFunc(_script,getClassName));
		false
	};

	if !isNullVar(_scriptParamsArgs) then {
		setVar(_script,_parameters,_scriptParamsArgs);	
	};

	callFuncParams(_script,assignScript,_gobj);

	//apply script to all exists objects
	if callFunc(_script,addScriptToAllObjects) then {
		private _tobj = typeGetFromObject(_script);
		if !typeHasVar(_tobj,__internalInitAllScript__) then {
			assert_str(equalTypes(pointerList,hashMapNull),"Internal script creating error; Pointer list is not a hashmap");

			typeSetVar(_tobj,__internalInitAllScript__,true);

			private _objPtr = null;
			private _allowedClassesList = (0 call typeGetVar(_tobj,getRestrictions));
			private _scrRef = null;
			{
				_objPtr = _x;
				_scrRef = getVar(_objPtr,__script);
				if isNullVar(_scrRef) then {continue};
				if !isNullReference(_scrRef) then {continue};

				if ((_allowedClassesList findif {isTypeStringOf(_objPtr,_x)})!=-1) then {
					_scrRef = instantiate(_name_str);
					callFuncParams(_scrRef,assignScript,_objPtr);

					//update logic for all next objects of this type
					private _tgobj = typeGetFromObject(_gobj);
					if !typeHasVar(_tgobj,__internal_scriptInstancer__) then {
						typeSetVar(_tgobj,__internal_scriptInstancer__,_name_str);
					};
				};
			} foreach (values pointerList);
		};
	};
	true
};

createGameObjectScriptInternal = {
	params ["_obj"];
	//initialize script instance if defined
	private _scriptName = typeGetVar(typeGetFromObject(_obj),__internal_scriptInstancer__);
	if !isNullVar(_scriptName) then {
		callFuncParams(instantiate(_scriptName),assignScript,_obj)
	};
};

"
	name:Удалить объект
	desc:Удаляет указанный объект из мира. После удаления все ссылки на этот объект станут невалидными.
	in:IDestructible:Объект
	out:bool:Удалён:Было ли успешно удаление объекта.
"
node_func(deleteGameObject) = {
	params ["_obj"];
	FHEADER;

	if equalTypes(_obj,"") then {
		private _vObj = pointer_get(_obj);
		if !pointer_isValidResult(_vObj) exitWith {errorformat("Game object not found - %1",_obj); RETURN(false)};
		_obj = _vObj;
	};
	private _chT = callFunc(_obj,getChunkType);
	if (_chT == CHUNK_TYPE_ITEM) exitwith {[_obj] call deleteItem};
	if (_chT == CHUNK_TYPE_STRUCTURE) exitwith {[_obj] call deleteStructure};
	if (_chT == CHUNK_TYPE_DECOR) exitwith {[_obj] call deleteDecor};
	
	assert_str(false,"Unknown chunk type for object " + str _obj);
	
	false
};

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

	//private _vec = [0,0,1];

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

	[this] call createGameObjectScriptInternal;

	this
};

//error counter for debugging cannot add items in container information
ciic_internal_errorCheckCanAdd = 0;
ciic_internal_successedCreation = 0;

// Создание предмета в контейнере
"
	name:Создать предмет в контейнере
	desc:Создает новый игровый предмет в указанном контейнере. Если предмет слишком большой или в контейнере нет места - предмет не будет создан.
	in:classname:Тип предмета
		opt:def=Item:typeset_out=Предмет
	in:IDestructible:Контейнер:Контейнер, в котором будет создан предмет.
	out:Item:Предмет:Созданный предмет в контейнере. Может вернуть null-значение, если создание невозможно по причине нехватки места или сликом большого размера предмета.
"
node_func(createItemInContainer) = {
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
		nullPtr
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
		INC(ciic_internal_errorCheckCanAdd);
		errorformat("Cant create %2 in %1. Result is %3",callFunc(_container,getClassName) arg callFunc(_item,getClassName) arg _rez);
		delete(_item);
		//перерасчитываем вес
		_contLoc call gurps_recalcuateEncumbrance;
		nullPtr;
	};

	INC(ciic_internal_successedCreation);

	[_item] call createGameObjectScriptInternal;

	_item
};

// Создание предмета в инвентаре
"
	name:Создать предмет в инвентаре
	desc:Создает новый игровой предмет в инвентаре персонажа. Если предмет не получилось создать в слоте персонажа - он будет создан под ним.
	in:classname:Тип предмета
		opt:def=Item:typeset_out=Предмет
	in:Mob:Персонаж:Персонаж, которому будет выдан предмет
	in:enum.InventorySlot:Слот:Слот, в котором будет создан предмет
	out:Item:Предмет:Созданный предмет
"
node_func(createItemInInventory) = {
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

	[_item] call createGameObjectScriptInternal;

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

	[this] call createGameObjectScriptInternal;

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

	[this] call createGameObjectScriptInternal;

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
		delete(_item);
	};

	RETURN(true);
};

//Получить игровой объект по позиции. Параметр _retAsList позволяет вернуть несколько объектов в этой позиции
//_retChild - опциональный параметр для возврата всех дочерних типов
"
	name:Получить объекты в позиции
	desc:Получает массив игровых объектов в заданной позиции
	in:classname:Тип объекта:Тип искомых объектов
		opt:def=GameObject:typeset_out=Массив|array[{typename}]
	in:vector3:Позиция:Точка в которой будет производиться поиск
	in:float:Радиус:Радиус поиска в метрах от позиции поиска
		opt:def=3
	in:bool:Глубокий поиск:При включении этого параметра будет производиться глубокий поиск при котором искомыми объектами будут являться дочерние типы, найденные в указанной позиции.
		opt:def=false
	out:array[GameObject]:Массив:Массив найденных игровых объектов указанного типа
"
node_func(getGameObjectOnPosition_Node) = {
	params ["_t","_v","_d","_rch"];
	[_t,_v,_d,true,_rch] call getGameObjectOnPosition;
};

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
			#ifdef EDITOR_OR_SP_MODE
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
			#ifdef EDITOR_OR_SP_MODE
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
"
	name:Все объекты в мире
	desc:Возвращает все объекты в мире указанного типа. Данная операция требует много ресурсов и может занять время при большом количестве объектов в мире.
	in:classname:Тип объекта:Тип искомых объектов
		opt:def=GameObject:typeset_out=Массив|array[{typename}]
	in:bool:Глубокий поиск:При включении этого параметра будет производиться глубокий поиск при котором искомыми объектами будут являться дочерние типы, найденные в мире. 
		opt:def=false
	out:array[GameObject]:Массив:Массив всех игровых объектов указанного типа
"
node_func(getAllObjectsInWorldTypeOf) = {
	params ["_type",["_retChild",true]];
	private _mid = worldSize/2;
	[_type,[_mid,_mid,0],10000,true,_retChild] call getGameObjectOnPosition;
};

//Возвращает все итемы определенного типа
"
	name:Все предметы в мире
	desc:Возвращает массив всех предметов определенного типа, найденные в мире, инвентарях персонажей и контейнерах. Данная операция требует много ресурсов и может занять время при большом количестве объектов в мире.
	in:classname:Тип предмета:Тип искомых предметов
		opt:def=Item:typeset_out=Массив|array[{typename}]
	in:bool:Глубокий поиск:При включении этого параметра будет производиться глубокий поиск при котором искомыми объектами будут являться дочерние типы, найденные в мире. 
		opt:def=false
	out:array[Item]:Массив:Массив всех найденных предметов указанного типа в мире, инвентарях и контейнерах.
"
node_func(getAllItemsTypeOf) = {
	params ["_type",["_retChild",true]];
	private _mid = worldSize/2;
	[_type,[_mid,_mid,0],10000,_retChild] call getAllItemsOnPosition;
};

//Получает все итемы в инвентаре сущности
"
	name:Все предметы в инвентаре
	desc:Возвращает все итемы в инвентаре сущности.
	in:Mob:Сущность:Моб, у которого будет выполнен поиск и получение предметов
	in:classname:Тип предмета:Тип искомых предметов
		opt:def=Item:typeset_out=Массив|array[{typename}]
	in:bool:Глубокий поиск:При включении этого параметра будет производиться глубокий поиск при котором искомыми объектами будут являться дочерние типы, найденные в мире. 
		opt:def=false
	out:array[Item]:Массив:Массив всех итемов в инвентаре сущности указанного типа.
"
node_func(getAllItemsInInventory) = {
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
"
	name:Все предметы в позиции
	desc:Возвращает все предметы в мире, инвентарях и контейнерах в указанном радиусе от указанной позиции.
	in:classname:Тип предмета:Тип искомых предметов
		opt:def=Item:typeset_out=Массив|array[{typename}]
	in:vector3:Позиция:Точка поиска предметов.
	in:float:Радиус:Радиус поиска
		opt:def=3
	in:bool:Глубокий поиск:При включении этого параметра будет производиться глубокий поиск при котором искомыми объектами будут являться дочерние типы, найденные в мире. 
		opt:def=false
	out:array[Item]:Массив:Массив всех найденных предметов в мире, инвентарях и контейнерах в указанной точке и радиусе от этой точки.
"
node_func(getAllItemsOnPosition) = {
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
"
	name:Все мобы в позиции
	desc:Возвращает все мобы в мире в указанном радиусе от указанной позиции.
	in:classname:Тип моба:Тип искомых мобов
		opt:def=BasicMob:typeset_out=Массив|array[{typename}]
	in:vector3:Позиция:Точка поиска мобов.
	in:float:Радиус:Радиус поиска
		opt:def=3
	in:bool:Глубокий поиск:При включении этого параметра будет производиться глубокий поиск при котором искомыми объектами будут являться дочерние типы, найденные в мире. 
		opt:def=false
	out:array[BasicMob]:Массив:Массив всех искомых мобов в мире в указанной точке и радиусе от этой точки.
"
node_func(getMobsOnPosition_Node) = {
	params ["_type","_vecPos","_dist",["_retChild",false]];
	[_type,_vecPos,_dist,null,_retChild] call getMobsOnPosition;
};

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
"
	name:Все мобы в мире
	desc:Возвращает список всех мобов в мире.
	in:classname:Тип моба:Тип искомых мобов
		opt:def=BasicMob:typeset_out=Массив|array[{typename}]
	in:bool:Глубокий поиск:При включении этого параметра будет производиться глубокий поиск при котором искомыми объектами будут являться дочерние типы, найденные в мире. 
		opt:def=false
	out:array[BasicMob]:Массив:Массив всех искомых мобов в мире.
"
node_func(getAllMobsInWorld) = {
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
"
	name:Объект по ссылке
	desc:Получает игровой объект по глобальной ссылке, указанной в редакторе.
	in:string:Ссылка:Глобальная ссылка на объект.
	out:IDestructible:Объект:Объект по ссылке. Может возвращать null, если объекта с такой ссылкой не существует.
"
node_func(getObjectByRef) = {
	params [["_name",""],["_def",nullPtr]];
	go_editor_globalRefs getOrDefault [_name,_def];
};

//получить зону по имени
//TODO implement
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

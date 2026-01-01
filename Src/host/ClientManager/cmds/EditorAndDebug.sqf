// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\Gender\Gender.hpp>

#ifdef DEBUG
	
	addCommand("container_errinfo",PUBLIC_COMMAND)
	{
		checkIfMobExists();
		private _msg = "Internal error: Variables not found";
		if !isNull(ciic_internal_errorCheckCanAdd) then {
			_msg = format["Success created: %1; Errors: %2",ciic_internal_successedCreation,ciic_internal_errorCheckCanAdd];
		};
		callSelfParams(localSay,_msg arg "system");
	};

	addCommand("showthreads",PUBLIC_COMMAND)
	{
		_t = format["Active %1 threads: ",count cba_common_perFrameHandlerArray];
		{
			_delay = _x select 1;
			_startedAt = _x select 3;
			_threadLocation = _x select 6;
			// _threadStacktrace = +(_x select 7);
			// reverse _threadStacktrace;
			// _ist = _threadStacktrace findif {_x select 0 != ""};
			// if (_ist == -1) then {
			// 	_threadStacktrace = endl + "Unknown stacktrace region";
			// } else {
			// 	_tlist = (_threadStacktrace select [0,_ist+1]) apply {"		"+(_x call scriptError_internal_handleStack_short)};
			// 	_tlist = _tlist - [""];
			// 	_threadStacktrace = endl + ((_tlist) joinString endl);
			// };
			// _threadStacktrace = endl + ((_threadStacktrace apply {"	" + (_x call scriptError_internal_handleStack_short)}) joinString endl);
			_threadStacktrace = ""; // not implemented now...

			_code = (toString (_x select 0)) splitString ";";
			
			_threadStacktrace = [_threadStacktrace,endl,sbr] call stringReplace;

			if (count _code > 0 && {[_code select 0,"private ___fn___ = ",false] call stringStartWith}) then {
				_code = _code select 0;
				_code = _code select [count "private ___fn___ = ",count _code];

				modvar(_t) + sbr + (format["<t color='#00ff00'>%1</t> (per %2s, started %3s ago): %4%5",_code,_delay,tickTime - _startedAt,_threadLocation,_threadStacktrace]);
			} else {
				modvar(_t) + sbr + (format["<t color='#00ff00'>Unk thread %1</t> (per %4s, started %5s ago): %2%3",_x select 5,_threadLocation,_threadStacktrace,_delay,tickTime - _startedAt]);
			};
		} foreach cba_common_perFrameHandlerArray;

		callFuncParams(thisClient,ShowMessageBox,"Text" arg _t);
	};

	addCommand("jumpclass",PUBLIC_COMMAND)
	{
		private _item = ["target",""] call oop_getdata select 0;
		if isNullReference(_item) exitWith {
			callSelfParams(localSay,"Нет объекта" arg "log");
		};
		typeGetVar(typeGetFromObject(_item),__decl_info__) params ["_file","_line"];
		["WorkspaceHelper","gotoclass",[_file,_line],true] call rescript_callCommand;
	};

	addCommandWithDescription("spawncamp",ACCESS_PLAYER,"Спавнит костёр под персонажем") {
		checkIfMobExists();

		_posAtl = callSelf(getPos);
		["Campfire",_posAtl,null,false] call createStructure;
	};

	addCommand("alltome",ACCESS_ADMIN) {
		checkIfMobExists();
		_posAtl = callSelf(getPos);
		{
			_x setPosAtl _posAtl;
		} foreach cm_allInGameMobs;
	};

	addCommandWithDescription("fixpos",PUBLIC_COMMAND,"Возвращает персонажа в точку последнего подключения")
	{
		checkIfMobExists();

		callSelfParams(setPos,callSelf(getInitialPos));
	};

	addCommandWithDescription("giveup",PUBLIC_COMMAND,"Поднимает из бессознанки")
	{
		checkIfMobExists();
		setSelf(unconscious,1);
	};

	addCommandWithDescription("tptoadmin",PUBLIC_COMMAND,"Попытаться телепортироваться к администратору в сети") {
		checkIfMobExists();

		_cli = (["ACCESS_OWNERS"] call cm_accessTypeToNum) call cm_findClientByAccess;
		if equals(_cli,nullPtr) exitWith {
			rpcSendToClient(caller,"chatPrint",["Нет админа. Тп не будет((((" arg "error"]);
		};
		_act = getposatl getVar(_cli,actor);

		callSelfParams(setPos,_act);
	};

	addCommandWithDescription("givemelight",PUBLIC_COMMAND,"Создаёт факел под персонажем") {
		checkIfMobExists();
		_posAtl = callSelf(getPos);

		["Torch",_posAtl,null,false] call createItemInWorld;
	};

	addCommand("killme",PUBLIC_COMMAND)
	{
		checkIfMobExists();
		callSelfParams(die,"test");
	};

	addCommand("unctest",PUBLIC_COMMAND)
	{
		checkIfMobExists();
		callSelfParams(setUnconscious,10);
	};

	addCommandWithDescription("stamina",PUBLIC_COMMAND,"Восстанавливает запас выносливости")
	{
		checkIfMobExists();
		callSelfParams(addStaminaRegen,1000);
	};
	
	addCommandWithDescription("lobbyreturn",PUBLIC_COMMAND,"Возврат в лобби")
	{
		checkIfMobExists();
		
		[this,"Lobby"] call cm_switchToMob;
	};

	addCommandWithDescription("checkserverlight",PUBLIC_COMMAND,"Проверка освещенности")
	{
		checkIfMobExists();
		private _struct = "<t align='center'> Проверка освещения в радиусе 20 метров:</t>";
		
		modvar(_struct) + sbr + (format["srv_lt_value:: native: %1; api: %2",getLightingAt (getSelf(owner)), callSelf(getLighting)]);
		modvar(_struct) + sbr + (format["act_lt_logic: %1",getSelf(__lightSlots)]);
		
		_posAtl = callSelf(getPos);

		modvar(_struct) + sbr + "Items:";
		private _list = ["ILightible",_posAtl,20,true,true] call getAllItemsOnPosition;
		if array_isempty(_list) then {
			modvar(_struct) + sbr + "empty";
		} else {
			{
				modvar(_struct) + sbr + (format["%1*%2: logic: %3; light: %4",
					callFunc(_x,getName),
					getVar(_x,pointer),
					getVar(_x,lightIsEnabled),
					getVar(_x,loc) getvariable "srv_slt_obj"
				]);
			} foreach _list;
		};

		modvar(_struct) + sbr + "Structs:";
		_list = ["ILightibleStruct",_posAtl,20,true,true] call getGameObjectOnPosition;
		if array_isempty(_list) then {
			modvar(_struct) + sbr + "empty";
		} else {
			{
				if isTypeOf(_x,ILightibleStruct) then {
					modvar(_struct) + sbr + (format["%1*%2: logic: %3; light: %4",
						callFunc(_x,getName),
						getVar(_x,pointer),
						getVar(_x,lightIsEnabled),
						getVar(_x,loc) getvariable "srv_slt_obj"
					]);
				};

			} foreach _list;
		};

		callSelfParams(ShowMessageBox,"Text" arg _struct);
	};

	addCommandWithDescription("craftlist",PUBLIC_COMMAND,"Открывает список рецептов. параметры default|system|interact")
	{
		checkIfMobExists();
		
		private _mode = args;
		private _list = [];
		{
			private _recipeType = _y get "c_type";
			private _kval = str _y;
			if (_mode in ["default","building"] && _recipeType in ["default","building"]) then {
				_list pushBack _kval;
			};
			if (_mode == "system" && _recipeType == _mode) then {
				_list pushBack (_kval+(_y get "systemSpecific"));
			};
			if (_mode == "interact" && _recipeType == "interact") then {
				_list pushBack _kval;
			};
		} foreach csys_map_allCraftRefs;

		private _dat = ["Выберите рецепт для спавна ингредиентов:"];
		private _handler = {
			callSelfParams(localSay,format["Ingredient selected %1" arg _value]);
			private _recipeId = parseNumber(_value splitString ":" select 1);
			callSelf(CloseMessageBox);
			if (_recipeID == 0) exitWith {
				callSelfParams(localSay,"Parse recipe id error" arg "system");
			};

			private _recipe = csys_map_allCraftRefs get _recipeID;
			private _components = _recipe get "components";
			if ((_recipe get "c_type") == "interact") then {
				_components = [
					_recipe get "hand_item",
					_recipe get "target"
				];
			};
			callSelf(generateLastInteractOnServer);
			private _endPos = callSelf(getLastInteractEndPos);
			{
				private _class = _x get "class";
				if (_x get "isMultiSelector") then {
					_class = _class select 0;
				};
				private _count = _x get "count";
				for "_i" from 1 to _count do {
					[_class,_endPos] call createGameObjectInWorld;
				};
			} foreach _components;
		};
		{
			private _istr = [_x,"|","/"] call stringReplace;
			_dat pushback (format["%1",_istr]);
		} foreach _list;
		
		if (count _dat == 1) exitWith {
			callFuncParams(thisClient,localSay,"Нет доступных ингредиентов" arg "error");
		};

		callFuncParams(thisClient,ShowMessageBox,"Listbox" arg _dat arg _handler);
	};

#endif
// DEBUG

#ifdef EDITOR

addCommand("nvg",ACCESS_OWNERS)
{
	checkIfMobExists();
	if (parsenumber args > 0) then {
		callSelfParams(localEffectUpdate,"GhostNightVision")
	} else {
		callSelfParams(localEffectRemove,"GhostNightVision")
	};
};

addCommandWithDescription("newmob",ACCESS_OWNERS,"Опциональные аргументы: role=RHead type=Mob; role - роль с которой будет выдана экипировка. type - тип создаваемой сущности. Пример: newmob role=RCaretaker")
{
	checkIfMobExists();
	if (isMultiplayer) exitwith {};

	private _pos = (call interact_getIntersectData) select 1;
	if equals(_pos,vec3(0,0,0)) exitwith {};
	
	private _instance = "Mob";
	private _role = "";

	private _argv = args splitString "=;, ";
	for "_i" from 0 to (count _argv) - 1 step 2 do {
		_curit = _argv select _i;
		if (_i + 1 > ((count _argv) -1)) exitwith {};
		_curval = _argv select (_i + 1);
		if (_curit == "role") then {
			if isImplementClass(_curval) then {
				if isTypeNameOf(_curval,BasicRole) then {
					_role = _curval;
				};
			};
		};
		if (_curit == "type") then {
			if isImplementClass(_curval) then {
				if isTypeNameOf(_curval,BasicMob) then {
					_instance = _curval;
				};
			};
		};
	};

	private _gMob = _pos call gm_createMob;
	private _mob = instantiate(_instance);
	callFuncParams(_mob,initAsActor,_gMob);
	[_mob,8,10,8,12] call gurps_initSkills;
	setVar(_mob,name,"Существо");
	([GENDER_MALE] call naming_getRandomName) params ["_f_","_s_"];
	[_mob,_f_,_s_] call naming_generateName;

	smd_allInGameMobs pushBackUnique _gMob;
	callFuncParams(_mob,setMobFace,pick faces_list_man);
	setVar(_mob,curTargZone,TARGET_ZONE_RANDOM);

	//fix initpos for new entity
	callFuncParams(_mob,setInitialPos,_pos);
	
	//setup previous entity initpos
	callFuncParams(this,setInitialPos,callFunc(this,getPos));

	if (_role != "") then {
		private _robj = _role call gm_getRoleObject;
		if !isNullReference(_robj) then {
			callFuncParams(_robj,getEquipment,_mob);
		};
	};
};

addCommandWithDescription("playtarget",ACCESS_OWNERS,"Перейти за другую сущность на которую вы нацелены")
{
	checkIfMobExists();
	private _data = (["target",""] call oop_getData) select 0;
	if !isReference(_data) exitwith {};
	if !isTypeOf(_data,BasicMob) exitwith {};

	[this,_data] call cm_switchToMob;
};


#endif

#ifdef EDITOR
addCommandWithDescription("rcsphere",PUBLIC_COMMAND,"Скрыть или показать желтую сферу при интеракциях")
{
	if (parseNumber args == 0) then {
		si_internal_rayObject hideObject true;
		["Курсор выключен","system"] call chatPrint;
	} else {
		si_internal_rayObject hideObject false;
		["Курсор включен","system"] call chatPrint;
	};
};
#endif
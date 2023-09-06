// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#ifdef DEBUG
	
	addCommand("showthreads",PUBLIC_COMMAND)
	{
		_t = "Active threads: ";
		{
			_delay = _x select 1;
			_startedAt = _x select 3;
			_code = (toString (_x select 0)) splitString ";";
			if (count _code > 0 && {[_code select 0,"private ___fn___ = ",false] call stringStartWith}) then {
				_code = _code select 0;
				_code = _code select [count "private ___fn___ = ",count _code];

				modvar(_t) + sbr + (format["%1 (per %2s, started %3s ago)",_code,_delay,tickTime - _startedAt]);
			} else {
				modvar(_t) + sbr + (format["Unk thread %1",_x select 5]);
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

	cmd_internal_debug_protomaker_versionrequired = "0.7.687";
	cmd_internal_debug_protomaker_listmodels = hashSet_createEmpty();
	/*
		Object categories:	
		WallBase
		BedBase
		FloorBase
		CharStructBase
		TableBase
		FurnitureBase

	*/
	addCommand("initprotomaker",PUBLIC_COMMAND)
	{
		checkIfMobExists();
		_requiredVersion = cmd_internal_debug_protomaker_versionrequired;
		if (project_version!=_requiredVersion) exitwith {
			callSelfParams(localSay,"Функционал доступен только на версии "+_requiredVersion arg "log");
		};

		if !isNull(getSelf(__protomaker_markerCreated)) exitwith {
			callSelfParams(localSay,"Уже запущено на этом персонаже" arg "log");
		};

		setSelf(__protomaker_markerCreated,true);
		_handler = {
			//items bypass
			if isTypeOf(_targ,Item) exitwith {false};

			if (callFunc(_targ,isDoor) && {getVar(_targ,isLocked)}) then {
				setVar(_targ,isLocked,false);
				callSelfParams(localSay,"Дверь разблокирована");
				true
			};
			if (callFunc(_targ,getClassname) != "IStruct" && callFunc(_targ,getClassname) != "Decor") exitWith {
				callSelfParams(localSay,"Это готовый объект");
				true
			};

			setSelf(__marker_lastModel,toLower ((getModelInfo getVar(_targ,loc)) select 1));
			if (getSelf(__marker_lastModel) in cmd_internal_debug_protomaker_listmodels) then {
				callSelfParams(localSay,"ВНИМАНИЕ! Модель уже была проверена - " + str getSelf(__marker_lastModel) arg "error");
			};
			
			_hndl = {
				//_value is typename
				/*
					1. open window: set structure name,
					2. open window: set description name (opt)
					3. open window: set classname (upper CamelCase)
					4. open window: print result
				*/
			};

			_dat = ["Выбрать тип объекта"];
			{
				_type = _x;
				_dat pushback (format["%1|%2",
					getFieldBaseValue(_type,"name"),
					_type
				]);
				
			} foreach getObjectsTypeOf(StructureBasicCategory);
			if (count _dat == 1) exitWith {
				callSelfParams(localSay,"Пустой список" arg "error");
			};
			callSelfParams(ShowMessageBox,"Listbox" arg _dat arg _hndl);

			true
		};

		callSelfParams(addEventClick,"initprotomaker___debug" arg _handler);
		callSelfParams(localSay,"Теперь нажатие ЛКМ по заблокированным дверям разблокирует их. В остальных случаях откроется окно сохранения данных");
	};

region(deprecated functionality for sound processor)
	cmd_internal_debug_tobjmarker_versionrequired = "0.7.655";

	addCommand("playgame",PUBLIC_COMMAND)
	{
		_requiredVersion = cmd_internal_debug_tobjmarker_versionrequired;
		if (project_version!=_requiredVersion) exitwith {
			callSelfParams(localSay,"Функционал доступен только на версии "+_requiredVersion arg "log");
		};

		if (call gm_isRoundPreload) then {
			["GMExtended"] call gm_initGameMode;
		} else {
			callFuncParams(thisClient,localSay,"Режим можно установить только до начала раунда" arg "log");
		};
		callFuncParams(thisClient,localSay,"Режим будет автоматически запущен через 10 секунд");
		_postrun = {
			gm_lobbyTimeLeft = 1;
			gm_supressStartCondition = true;
		};
		invokeAfterDelay(_postrun,10);
	};

	addCommandWithDescription("initmarkertobj",PUBLIC_COMMAND,"Отладочная функция")
	{
		checkIfMobExists();

		_requiredVersion = cmd_internal_debug_tobjmarker_versionrequired;
		if (project_version!=_requiredVersion) exitwith {
			callSelfParams(localSay,"Функционал доступен только на версии "+_requiredVersion arg "log");
		};

		if !isNull(getSelf(__markerCreated)) exitwith {
			callSelfParams(localSay,"Уже запущено на этом персонаже" arg "log");
		};

		setSelf(__markerCreated,true);
		setSelf(__marker_uniqueModels,[]);
		/*
			addtobj(path,sound_pen_prob,bullet_pen_prob)
		*/

		_handler = {
			//items bypass
			if isTypeOf(_targ,Item) exitwith {false};

			if (callFunc(_targ,isDoor) && {getVar(_targ,isLocked)}) then {
				setVar(_targ,isLocked,false);
				callSelfParams(localSay,"Дверь разблокирована");
				true
			};

			//make probs single input
			_h = {
				_vec2 = _value splitString " ";
				if (count _vec2 != 2) exitwith {
					callSelfParams(localSay,"Ошибка. Нужно 2 числа" arg "error");
					callSelf(CloseMessageBox);
				};
				_vec2 params ["_soundPrec","_bulletPrec"];
				_soundPrec = round parseNumber _soundPrec;
				if !inRange(_soundPrec,1,100) exitwith {
					callSelfParams(localSay,"Ошибка. Звук от 1 до 100; Указано " + str _soundPrec arg "error");
				};
				_bulletPrec = round parseNumber _bulletPrec;
				if !inRange(_bulletPrec,1,100) exitwith {
					callSelfParams(localSay,"Ошибка. Проход снарядов от 1 до 100; Указано " + str _bulletPrec arg "error");
				};

				setSelf(__marker_lastData,vec3(getSelf(__marker_lastModel),_soundPrec,_bulletPrec));

				callSelf(CloseMessageBox);
				callSelfParams(localSay,"Подождите пару секунд до открытия следующего окна...");

				_m = "Скопируйте текст из поля ввода и передайте разработчику";
				_dat = format["addtobj(""%1"",%2,%3);",getSelf(__marker_lastModel),_soundPrec,_bulletPrec];
				
				getSelf(__marker_uniqueModels) pushBackUnique getSelf(__marker_lastModel);

				_h = {
					callSelf(CloseMessageBox);
					callSelfParams(localSay,"ГОТОВО");
				};
				callSelfAfterParams(ShowMessageBox,2,"Input" arg [_m arg _dat arg "Сохранил"] arg _h);

			};

			setSelf(__marker_lastModel,(getModelInfo getVar(_targ,loc)) select 1);

			if (getSelf(__marker_lastModel) in getSelf(__marker_uniqueModels)) then {
				callSelfParams(localSay,"ВНИМАНИЕ! Модель уже была проверена - " + str getSelf(__marker_lastModel) arg "error");
			};
			
			_prefix = format["[Объект %1(%2)]",callFunc(_targ,getName),callFunc(_targ,getClassName)];

			_m = _prefix+" Установите целочисленные значения (от 1 до 100), разделяемые пробелом, где первое число - процент прохождения звука сквозь объект, второе число - вероятность прохождения пули сквозь объект";
			callFuncParams(this,ShowMessageBox,"Input" arg [_m arg "100 100" arg "Проверка"] arg _h);

			true
		};

		callSelfParams(addEventClick,"initmarkertobj___debug" arg _handler);
		callSelfParams(localSay,"Теперь нажатие ЛКМ по заблокированным дверям разблокирует их. В остальных случаях откроется окно сохранения данных");
	};

region(______________________________end deprecated)

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

#endif
// DEBUG


//Команды, введенные для отладки в релизной сборке
addCommandWithDescription("cancook",PUBLIC_COMMAND,"Проверка работы сковородок в радиусе 10 метров")
{
	checkIfMobExists();

	private _timer = getSelf(__internal_debug_command_cancook_timer);
	if (!isNullVar(_timer) && {tickTime > _timer}) exitWith {
		callSelfParams(localSay,"Вами уже создан отчет о крафтах. Следующий можно создать через " + str (_timer - tickTime) + " сек" arg "system");
	};

	private _posAtl = callSelf(getPos);
	private _list = ["FryingPan",_posAtl,10,true] call getAllItemsOnPosition;
	if array_isempty(_list) exitwith {
		callSelfParams(localSay,"Сковородок не найдено" arg "system");
	};
	
	private _notConnected = 0;
	private _dump = false;
	{
		if (!callFunc(_x,isConnectedToSource)) then {
			INC(_notConnected);
			callSelfParams(localSay,"!!! НАЙДЕНА НЕ ПОДКЛЮЧЕННАЯ СКОВОРОДА !!!" arg "system");
			_dump = true;
		};
	} foreach _list;

	private _m = format["<t size='1.5'>Не подключено шт: %1; Всего %2. %3</t>",_notConnected,array_count(_list),ifcheck(_dump,"Будет создан отчет в логах","Отчет не будет создан")];
	callSelfParams(localSay,_m arg "system");
	if (_dump) then {
		private _dat = "DUMP_CANCOOK:";
		
		{
			private _allowedCateg = callFunc(_x,getAllowedCraftCategories);
			if (count _allowedCateg == 0) then {
				modvar(_dat) + "NO ALLOWED CATEGORIES FOR OBJECT:"+str getVar(_x,pointer);
			} else {
				_dat = _dat + str ([_allowedCateg select 0,_x] call craft_data_getRecipes);
			};
		} foreach _list;
		[_dat] call logWarn;
		setSelf(__internal_debug_command_cancook_timer,tickTime + 60 * 3);
	};
};

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
	([0] call naming_getRandomName) params ["_f_","_s_"];
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
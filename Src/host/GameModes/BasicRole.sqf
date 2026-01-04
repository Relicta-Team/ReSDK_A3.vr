// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <GameMode.h>

editor_attribute("ColorClass" arg "05F014")
class(BasicRole) extends(object) attribute(Role)
	var(roleIdx,-1); //указатель на роль для клиента (оптимизация сетевого трафика)
	var(name,""); //role name
	var(desc,""); //role description
	var(descInGame,null); //shown after client start in role. if null - copy from desc, empty string - no shown

	//Классы объектов персонажей выдаваемых при спавне
	var(classMan,"Mob");
	var(classWoman,"MobWoman");
	
	getter_func(isMainRole,false); //ключевые роли управляют условием начала старта. Так же они заносятся в 

	//после смерти сразу возвращает в лобби. должно быть выключено
	var(returnInLobbyAfterDead,false);
	
	// Данная функция возвращает значение bool. Если true то при входе за персонажа
	//будут сохранены имя и лицо для последующей валидации при заходе за следующую роль
	//т.е. будет выскакивать сообщение "поменяйте лицо/имя" перед заходом в раунд
	//на момент добавления (0.7.459) используется у гостов чтобы измененное имя призрака не перебивало имя умершего персонажа
	getter_func(canStoreNameAndFaceForValidate,true);
	
	//Показывает описание роли после старта
	func(showInGameDesc)
	{
		objParams_1(_mob);
		OBSOLETE(BasicRole::showInGameDesc);
		private _desc = getSelf(descInGame);

		if (isNullVar(_desc) || {_desc == ""}) exitWith {
			_desc = getSelf(desc);
			callFuncParams(_mob,localSay,format vec3("Вы - %1! %2",getSelf(name),_desc) arg "info");
		};
		if (_desc != "") exitWith {
			callFuncParams(_mob,localSay,format vec3("Вы - %1! %2",getSelf(name),_desc) arg "info");
		};
	};

	var(count,1); //сколько персонажей может залететь за эту роль
	getter_func(canAddAfterStart,true);// может ли быть добавлена роль после старта из лобби ролей в нелобби

	//навыки персонажа: "_st","_iq","_dx","_ht". Может быть массивом или строкой
	/*
		строка имеет разделитель между навыками:	;
		между именем навыка и значением:	=-: и пробел
			Пример определения двух навыков
			"st:3;dx:5"
			"st=3;dx:5"
			"ST:3-5; Dx=5"
			"st=3-5; DX = 5-6"

		Стандартизированный вид:
			разделитель навыков:	;
			разделитель названия навыка и значения:	=
			разделитель минимального и максимального значения навыка:	-
	*/
	getter_func(getSkills,vec4(10,10,10,10));

	//настройки дополнительных навыков определяются так же как и в getSkills при использовании через строку
	//список всех навыков в skills_internal_list_otherSkillsSystemNames
	getter_func(getOtherSkills,[]); //array in form vec2(string,[number, vec2(min,max)]) or string of settings

	//Вызывается после старта раунда
	//Срабатывает только для лобби ролей
	//? не используется в данный момент
	func(onStarted)
	{
		objParams();
		//! не используется нигде в коде
	};

	//Будет ли видна роль в списке после старта
	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		true
	};

	//Можно ли взять роль в лобби. Второй параметр означает будет ли выводиться сообщение в вызываемом контексте
	func(canTakeInLobby)
	{
		objParams_2(_cliObj,_canPrintErrors);
		true
	};

	getter_func(needDiscordRoles,[]); //нужные роли дискорда. Пустой список - доступно всем

	//стандартный метод проверки доступности роли
	func(isAllowedRoleToClient)
	{
		objParams_2(_cliObj,_banRef);
		if isNullVar(_banRef) then {
			_banRef = callFunc(_cliObj,getBannedRoles);
		};
		private _thisClass = callSelf(getClassName);
		if ((_banRef findif {_thisClass==_x})!=-1) exitwith {false};
		
		//проверка репутацией
		if !callFuncParams(_cliObj,isAllowedRoleByReputation,this) exitwith {false};

		// private _loadedRep = getVar(_cliObj,testResult)!=""; //Не задействовано
		
		//проверка ролей дискорда
		private _discRoles = callFunc(_cliObj,getDiscordRoles);
		private _needRoles = callSelf(needDiscordRoles);

		//при выключенной системе обходим логику
		private _enabledDSMAccounts = call dsm_accounts_canUse;
		if (!_enabledDSMAccounts) then {_needRoles = []};
		if (!dsm_accounts_enableRoleAccessCheck) then {
			_needRoles = [];
		};

		//нет доступных ролей
		if (count _needRoles > 0 && {count (_discRoles arrayIntersect _needRoles) == 0}) exitwith {false};

		private _racc = callSelf(roleAccess);
		if (count _racc == 0) exitWith {true};
		private _myAccess = getVar(_cliObj,access);
		
		//По правилам, определенным в BasicRole::roleAccess
		(getVar(_cliObj,access) findif {
			if (_x < 0) then {
				_myAccess == abs(_x)
			} else {
				_myAccess >= _x
			};
		}) != -1
	};

	//массив уровней доступа чтобы взять эту роль. Пустой массив означает что роль доступна всем
	//если указаный доступ ACCESS_PLAYER то доступ может быть для для этой роли и всех дочерних (тоесть кто выше или равен этому уровню),
	//	Например: ACCESS_ADMIN - позволит взять эту роль админам и всем кто выше по статусу 
	//отрицательные значения (прим -ACCESS_PLAYER) означают что правило относится ТОЛЬКО для этой роли
	getter_func(roleAccess,[]);

	//Может ли быть роль полноценным антагом
	func(canBeFullAntag)
	{
		objParams_1(_client);
		true
	};

	//Может быть роль скрытым антагом
	func(canBeHiddenAntag)
	{
		objParams_1(_client);
		true
	};

	// сущности хранятся в массиведаже после смерти
	var_array(basicMobs); //базовый список мобов, которые зашли за эту роль
	var_array(mobs); //Список мобов которым выдавалась эта роль. Массив обновляемый

	// геттеры для базовых и назначенных мобов
	getter_func(getBasicMobs,getSelf(basicMobs));
	getter_func(getMobs,getSelf(mobs));

	//кто распределился на эту роль
	var_array(contenders_1);
	var_array(contenders_2);
	var_array(contenders_3);


	getterconst_func(isEmbarkRole,false); //эмбарковые роли будут давать спавн "высадками"
	getterconst_func(getEmbarkCountRange,vec2(1,1)); //минимум и максимум для старта эмбарка
	var_array(embark); //лист с клиентами эмбарка

	//Можно ли сделать высадку
	func(canEmbark)
	{
		objParams();
		true
	};

	func(onEmbarkSpawned)
	{
		objParams();
	};

	//!!!Устаревший способ позиционирования персонажа!!!
	// Не рекомендуется к использованию.
	// возвращает позицию на которой будет создана роль
	func(getInitialPos)
	{
		objParams();
		null
	};

	// Возвращает направление, на котором будет созадна роль
	func(getInitialDir)
	{
		objParams();
		null
	};

	//Стартовая точка спавна. 
	/*
		Может быть:
		- точкой спавна (pos:spawnpointname)
		- рандомной точкой спавна (rpos:randomspawnpointname)

		если не указан тип, он будет вычислен автоматически.
		Но если есть тип рандомной точки и обычной с одинаковым выбранным названием то будет по умолчанию применен префикс pos
	*/
	func(spawnLocation)
	{
		objParams();
		null
	};

	// Работает в связке с spawnLocation. 
	// false - берет направление от стартовой точки
	// true - задает случайное направление
	getter_func(useRandomDirOnSpawn,false);

	//Точка привязки (кровать или стул)
	/*
		Может быть:
			- глобальной ссылкой на объект: ref:objectglobalreference (for getObjectByRef)
			- именем типа: type:IChair
		
		!!! Указать только connectedTo без spawnLocation невозможно, так как при вставании со стула/кровати
		система должна знать куда поместить персонажа.
	*/
	getter_func(connectedTo,null);

	// Внутренняя инициализация позиции
	func(initLocation)
	{
		objParams_1(_mob);

		//deprecated values
		private _spawnPos = callSelf(getInitialPos);
		private _spawnDir = callSelf(getInitialDir);

		private _spawnLoc = callSelf(spawnLocation);
		private _connectedTo = callSelf(connectedTo);
		private _canPostConnectTo = !isNullVar(_connectedTo);
		
		if (!isNullVar(_spawnLoc)) then {
			// автоматическое определение типа точки
			if ((["pos:","rpos:"] findif {(_x select [0,4]) in _spawnLoc})==-1) then {
				private _isSpawnP = _spawnLoc call isExistsSpawn;
				private _isRandSpawnP = _spawnLoc call isExistsRandomSpawn;
				if (_isSpawnP && _isRandSpawnP) then {
					_spawnLoc = "pos:" + _spawnLoc;
				} else {
					_spawnLoc = ifcheck(_isSpawnP,"pos:","rpos:") + _spawnLoc;
				};
			};
			
			(_spawnLoc splitString ":")params ["_mode","_spawnName"];
			
			if !(_mode in ["pos","rpos"]) exitwith {};

			private _funcGetPos = ifcheck(_mode=="pos",getSpawnPosByName,getRandomSpawnPosByName);
			
			private _pos = [_spawnName,-1] call _funcGetPos;
			if equals(_pos,-1) exitwith {};
			_spawnPos = _pos;
			
			private _funcGetDir = ifcheck(callSelf(useRandomDirOnSpawn),{random 360},ifcheck(_mode=="pos",getSpawnDirByName,getRandomSpawnDirByName));
			private _dir = [_spawnName,""] call _funcGetDir;
			if not_equals(_dir,"") then {
				_spawnDir = _dir;
			};
		};

		#ifdef EDITOR
		if ("spawnposFromCache" call sdk_hasSystemFlag && gm_roundduration <= 1) then {
			private _cache = call editorDebug_getPlayerSettings;
			if ("pos" in _cache) then {_spawnPos = _cache get "pos"};
			if ("dir" in _cache) then {_spawnDir = _cache get "dir"};
			assert(not_equals(_spawnPos,vec3(0,0,0)));
			_canPostConnectTo = false; //drop postconnect
		};

		if (isNullVar(_spawnPos) || isNullVar(_spawnDir)) then {
			["Определите spawnLocation для роли %1",callSelf(getClassName)] call messageBox;
			_spawnPos = [0,0,0];
			_spawnDir = 0;
		};

		#endif

		callFuncParams(_mob,setInitialPos,_spawnPos);
		callFuncParams(_mob,setDir,_spawnDir);

		if (_canPostConnectTo) then {
			if ((["type:","ref:"] findif {(_x select [0,4]) in _connectedTo})==-1) then {
				private _isRef = !isNullReference(_connectedTo call getObjectByRef);
				private _isTyped = isImplementClass(_connectedTo) && {typeHasVar(typeGetFromString(_connectedTo),seatConnect)};
				
				if (_isRef) exitwith {_connectedTo = "ref:" + _connectedTo};
				if (_isTyped) exitwith {_connectedTo = "type:" + _connectedTo};
				#ifdef EDITOR
				["Определите метку ссылки или типа в connectedTo для роли %1",callSelf(getClassName)] call messageBox;
				#endif
			};
			(_connectedTo splitString ":") params ["_typeConnect","_nameConnect","_optConnection"];
			private _objRef = nullPtr;
			if (_typeConnect == "ref") then {
				_objRef = _nameConnect call getObjectByRef;
			};
			if (_typeConnect == "type") then {
				private _objRefTest = [_nameConnect,_spawnPos,3,false,true] call getGameObjectOnPosition;
				if !isNullReference(_objRefTest) then {_objRef = _objRefTest};
			};
			if (!isNullReference(_objRef)) then {
				if !isNullVar(_optConnection) then {
					if equals(_optConnection,-1) then {_optConnection = null};
					if not_equalTypes(_optConnection,0) then {_optConnection = null};
				};

				private _args = [_objRef,_mob,_optConnection,[_spawnPos,_spawnDir]];
				private _postcode = {
					params ["_objRef","_mob","_optConnection","_vec2resetpos"];

					private __GLOBAL_INITIALIZER_POS__ = _vec2resetpos;

					if (isNullReference(_objRef) || isNullReference(_mob)) exitwith {};
					callFuncParams(_objRef,seatConnect,_mob arg _optConnection);
				}; invokeAfterDelayParams(_postcode,0.001,_args);
			};	
		};
	};

	/*
		Строковый список ролей, которых будет знать персонаж.

		Синтаксически выглядит следующим образом:
			[! | @][! | @]<string>

	 		- Префикс ! перед ролью означает, что будут известны персонажи зашедшие только со старта раунда
			- Префикс @ перед ролью означает что используется ТОЛЬКО эта роль без наследования.

		Информация для префиксов выше: по-умолчанию указанная роль используется с системой наследования.

		Пример:
			getter_func(knownRoles,"@IRStationRole !RoleBum Role")
	*/
	getter_func(knownRoles,"");

	

	func(initWelcome)
	{
		objParams_1(_mob);
		private _ft = format["<t size='1.4'>Вы - %1 по имени %4.%3Вам %5.%3%2</t>",getSelf(name),getSelf(desc),sbr,callFuncParams(_mob,getNameEx,"кто"),[getVar(_mob,age),["год","года","лет"],true] call toNumeralString];
		callFuncParams(_mob,addFirstJoinMessage,_ft);
	};

	//процедура спавна снаряжения
	func(getEquipment)
	{
		objParams_1(_mob);
	};
	
	//проверка было ли это назначение в лейте. false означает что человек зашёл со стартом раунда
	getter_func(isLateAssigned,gm_handleMainLoop != -1);
	
	//событие, вызываемое когда клиент зашёл за роль
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
	};

	//Вызывается при смерти текущей роли
	func(onDead)
	{
		objParams_2(_mob,_usr);
	};

	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
	};

	//вызывается при конце игры за текущую роль (если человек выжил за нее)
	//В большинстве случаев используется onEndgameBasic
	//! Внимание ! При модификации очков клиента второй параметр _onlyOnGame должен быть ТОЛЬКО false ServerCleint::addPoints()
	//! Так как данные методы вызываются когда стейт игры уже изменился на GAME_STATE_END
	func(onEndgame)
	{
		objParams_2(_mob,_usr);
	};

	func(onEndgameBasic)
	{
		objParams_2(_mob,_usr);
	};

	//внутренний метод модификации очков
	func(addPoints)
	{
		objParams_3(_mob,_usr,_pts);
		_pts = floor _pts;
		if (_pts == 0) exitwith {};
		if getVar(_mob,isDead) exitwith {};
		if (_pts > 0) then {
			callFuncParams(_usr,addPoints,_pts);
		} else {
			callFuncParams(_usr,removePoints,abs _pts);
		};
	};

	var(reputationNeed,rolerep(0,0,0)); //репутационное требование
	func(getReputationRequirement)
	{
		objParams();
		getSelf(reputationNeed) params ["_location","_harm","_responsibility"];
		(10 * _location) + _harm + _responsibility
	};

endclass


class(GhostRole) extends(BasicRole)
	var(name,"Призрак");
	var(desc,"Покинутая душа");
	var(count,999999);
	var(lastSpawnpos,vec3(0,0,0));//перезаписываемая переменная
	getter_func(getInitialPos,getSelf(lastSpawnpos));
	getter_func(getInitialDir,random 360);
	getter_func(canStoreNameAndFaceForValidate,false);
	
	var(classMan,"MobGhost");
	var(classWoman,"MobGhost");
endclass

class(AdminObserverRole) extends(BasicRole)
	var(name,"Наблюдатель");
	var(desc,"");
	var(count,999999);
	var(spawnPosition,vec3(0,0,0));//перезаписываемая переменная
	getter_func(getInitialPos,getSelf(spawnPosition));
	getter_func(getInitialDir,random 360);
	getter_func(canStoreNameAndFaceForValidate,false);
	
	var(classMan,"MobObserver");
	var(classWoman,"MobObserver");
endclass


class(TOMMonsterRole) extends(BasicRole)
	var(name,"Томный монстр");
	var(desc,"Вы доживаете свой последний момент в этом мире. Делайте то" pcomma " что вы любите больше всего.")
endclass

class(BlessedPiligrimRole) extends(BasicRole)
	var(name,"Блаженный пилигрим");
	var(desc,"Вы осознали тяжесть своих поступков и решили их искупить" pcomma " придя в это место.");
endclass

class(TheEssenseRole) extends(BasicRole)
	var(name,"Сущность");
	var(desc,"Вы - воплощение Сути. Вас не интересует судьба этих людей" pcomma " а только их зрелищность. Томные не должны тревожить эту историю. Если" pcomma " конечно" pcomma " присутствие томных не делает ее зрелищной...");
endclass

//! Do not use this role in usercode
#ifdef EDITOR
class(BasicRole_SimulationReSDK) extends(BasicRole)
	
	var(name,"Приключенец");
	var(desc,"Он здесь чтобы повеселиться.");

	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,true);
	getter_func(canStoreNameAndFaceForValidate,false);

	var(count,100);
	
	var(returnInLobbyAfterDead,true);

	getter_func(spawnLocation,null);

	getter_func(getSkills,"st=10; dx=10; iq=10; ht=10");

	func(getOtherSkills) {[]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _sdkProp = ["currentRoleEquip",""] call sdk_getPropertyValue;
		if (_sdkProp == "") exitwith {};

		private _roleType = typeGetFromString(_sdkProp);
		
		assert(!isNullReference(_roleType));
		private _hasMethodGetEquipment = typeHasVar(_roleType,getEquipment);
		assert(_hasMethodGetEquipment);

		private _method = typeGetVar(_roleType,getEquipment);
		[this,_mob] call _method;
	};

	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
	};
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
	};
	
endclass
#endif
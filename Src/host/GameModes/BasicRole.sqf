// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
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

		if isNullVar(_desc) exitWith {
			_desc = getSelf(desc);
			callFuncParams(_mob,localSay,format vec3("Вы - %1! %2",getSelf(name),_desc) arg "info");
		};
		if (_desc != "") exitWith {
			callFuncParams(_mob,localSay,format vec3("Вы - %1! %2",getSelf(name),_desc) arg "info");
		};
	};

	var(count,1); //сколько персонажей может залететь за эту роль
	getter_func(canAddAfterStart,true);// может ли быть добавлена роль после старта из лобби ролей в нелобби

	//навыки персонажа: "_st","_iq","_dx","_ht"
	getter_func(getSkills,vec4(10,10,10,10));

	getter_func(getOtherSkills,[]); //array in form vec2(string,[number, vec2(min,max)])

	//Вызывается после старта раунда
	//Срабатывает только для лобби ролей
	func(onStarted)
	{
		objParams();
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
		if (!call dsm_accounts_canUse) then {_needRoles = []};

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

	var_array(basicMobs); //базовый список мобов, которые зашли за эту роль
	var_array(mobs); //Список мобов которым выдавалась эта роль. Массив обновляемый

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


	//возвращает позицию на которой будет создана роль
	func(getInitialPos)
	{
		objParams();
	};

	func(getInitialDir)
	{
		objParams();
	};

	//инициализация позиции
	func(initLocation)
	{
		objParams_1(_mob);
		
		#ifdef EDITOR
		if ("spawnposFromCache" call sdk_hasSystemFlag && gm_roundduration <= 1) exitwith {
			private _cache = call editorDebug_getPlayerSettings;
			private _pos = _cache getOrDefault ["pos",callSelf(getInitialPos)];
			private _dir = _cache getOrDefault ["dir",callSelf(getInitialDir)];
			
			callFuncParams(_mob,setInitialPos,_pos);
			callFuncParams(_mob,setDir,_dir);
		};
		#endif

		callFuncParams(_mob,setInitialPos,callSelf(getInitialPos));
		callFuncParams(_mob,setDir,callSelf(getInitialDir));
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
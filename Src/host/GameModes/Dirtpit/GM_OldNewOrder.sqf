// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

editor_attribute("CodeOnyGamemode")
class(GMOldNewOrder) extends(GMExtended)
	getterconst_func(isPlayableGamemode,true);
	var(name,"Старый Новый Порядок");
	var(desc,"Агенты Новой Армии пытаются исполнить свои планы.");
	var(descExtended,"В поселение тайно проникли агенты Новой Армии! Их цели неизвестны" + comma + " но средства их достижения пугают: ведь цель оправдывает все.");

	//ссылки на объект антагов. Первый в списке самый главный
	//это не мобы а ООП объекты
	var(antags,[]);

	var(duration,60 * (60*2)); //2 часа

	//Одна или несколько, но не больше трёх
	var(objectivesCountMin,1);
	var(objectivesCountMax,3);
	var_array(objectives);

	var(generator,nullPtr); //дистацния взрыва 15 метров
	var(leftBombParts,[]);
	var_array(bombs); //ссылки на игровые объекты бомб
	var_bool(isBlownUp);

	//vec3: type, min val, max val
	var(reqItemsListAll,[
			vec3("BattleAxe",1,1) arg
			vec3("RadioBaikal",1,3) arg
			vec3("Flashlight",1,3) arg
			vec3("LampKerosene",1,2)
		]);
	var(reqItemCounts,vec2(1,2)); //набор предметов для стила

	var_array(reqItemsOutsideStation); //list of structs vec2(typeName,count)
	var(textNeedItems,"");
	var(slotsData,vec2(ITEM_SIZE_TINY,0));
	var(containerOutsideStation,nullPtr); //контейнер снаружи станции. В нём должны быть reqItemsOutsideStation
	var(hasAllItems,false); //все предметы в контейнере?

	var(hostage,nullPtr); //ссылка на заложника
	var(hostageNeedPos,vec3(0,0,0));
	var(hostageLocationDistance,10); //он должен находиться не дальше 4 метров от точки

	var(needRole,nullPtr); //объект роли для задачи с занятием должности

	var(well,nullPtr); //ссылка на колодец
	
	func(getLeadingRolesInfo)
	{
		objParams();
		"<t align='left' color='#AF2CF5' font='PuristaMedium'>В роли агентов Новой Армии были:" + sbr +
		((getSelf(antags) apply { callSelfParams(getCreditsInfo,_x) }) joinString sbr) + 
		"</t>"
	};
	
	func(handleAntagRoleHidden)
	{
		objParams_3(_client,_mob,_index);
		/*
			В первом проходе определим оптимальное количество антагов:
			все игроки * процент от числа / 100
			Все округления значений вверх
		*/
		_bRole = callFunc(getVar(_mob,basicRole),getClassName);
		//примерный список тех ролей, которые не могут быть антагами в этом виде
		if (_bRole in ["RHead","RWifeHead","RHeadSon","RCaretaker","RVeteran"]) exitwith {}; 
		
		#ifdef EDITOR
		if (getVar(_client,name)=="Septima") exitwith {
			getSelf(antags) set [0,_mob];
		};
		#endif
		if (_index <= ((round(_countInGame * 17 / 100))max 1)) exitWith {
			logformat("[HANDLE ANTAG]: Client %1 (%2) is antag!",getVar(_client,name) arg getVar(_client,id));
			getSelf(antags) pushBack _mob;
		};
		
	};

	//Основная логика выбора задач для антагов
	func(generateNAObjectives)
	{
		objParams();
		//list struct: class, name, desc, code check on frame, initialization
		//initialization runs only after antags role assigned
		private _list = [];

		_list pushBack ["bomb","Заминировать генератор","Установить бомбу рядом с генератором. Бомба должна находиться не дальше 15 метров от него.",{
			//bomb has been planted on generator
			getVar(gm_currentMode,isBlownUp)
		},{
			//get generator
			_gen = ["ConvertorForGenerator",false] call getAllObjectsInWorldTypeOf;
			if (count _gen < 1) exitwith {
				error("!!!!! GENERATOR COUNT ERROR");
				[1] call gm_endRound;
			};
			_gen = _gen select 0;
			setSelf(generator,_gen);

			//create bomb parts
			private _lbombs = [];
			setSelf(leftBombParts,_lbombs);
			for "_i" from 0 to (count getSelf(antags)) step 2 do {
				_lbombs append ["Item_OldNewOrder_BombPart1","Item_OldNewOrder_BombPart2"];
			};
			_handleBombPart = {
				if _hasItemInHand exitwith {false};
				if (
					isTypeOf(_targ,BlockBrick) ||
					isTypeOf(_targ,BlockDirt) ||
					isTypeOf(_targ,BlockStone)
				) exitwith {
					private _parts = getVar(gm_currentMode,leftBombParts);
					callSelfParams(mindSay,"Мне удалось раскопать часть взрывчатки");
					[_parts deleteAt 0,this] call createItemInInventory;
					if (count _parts == 0) then {
						{
							callFuncParams(_x,removeEventClick,"GM_OldNewOrder_getBombPartEvent");
						} foreach getVar(gm_currentMode,antags);
					};

					true
				};

				false
			};


			private _eventCheck = {
				params ['_task','_mob'];
				getVar(gm_currentMode,isBlownUp)
			};

			private _t = new(TaskCustom);
			setVar(_t,checkCompleteOnEnd,true);
			setVar(_t,isTaskSingleCheck,true);
			setVar(_t,name,"Взорвать генератор");
			setVar(_t,desc,"Взорвать генератор.");
			setVar(_t,descRoleplay,"Нужно подорвать генератор взрывчаткой"+comma+" которую мы запрятали в земле и между камнями.");
			setVar(_t,_customCondition,_eventCheck);
			//setVar(_t,eventOnSuccess,_onSuccess);
			callFuncParams(_t,setTag,"GMOldNewOrder_task");

			{
				callFuncParams(_x,addFirstJoinMessage,"Части бомбы мы запрятали в земле"+comma+" серых каменных стенах и зелёном кирпиче..." + sbr +"После добычи и сборки бомб их нужно активировать кусачками.");
				callFuncParams(_x,addEventClick,"GM_OldNewOrder_getBombPartEvent" arg _handleBombPart);

				callFuncParams(_x,addTask,_t);
			} foreach getSelf(antags);
		}];

		/*
		_list pushBack ["steal","Выкрасть предметы",{
			getSelf(textNeedItems)
		},{
			!isNullReference(getSelf(containerOutsideStation)) && {getSelf(hasAllItems)}
		},{
			_allItems = +getSelf(reqItemsListAll);
			getSelf(reqItemCounts) params ["_minval","_maxval"];
			_countAll = randInt(_minval,_maxval);
			_items = [];
			_maxSize = ITEM_SIZE_TINY;
			_countSlots = 0;
			for "_i" from 1 to _countAll do {
				_type = _allItems deleteAt randInt(0,(count _allItems) - 1);
				_name = [_type select 0,"name",true,"getName"] call oop_getFieldBaseValue;
				_needCount = randInt(_type select 1,_type select 2);
				_sizePerItem = [_type select 0,"size",true,"getSize"] call oop_getFieldBaseValue;
				_maxSize = _maxSize max _sizePerItem;
				_countSlots = _countSlots + (_needCount * BASE_STORAGE_COST(_sizePerItem));
				_items pushBack [_name,_type select 0,_needCount,_needCount];
			};

			setSelf(slotsData,vec2(_maxSize,_countSlots));

			setSelf(reqItemsOutsideStation,_items);

			private _needSteal = "Вынести предметы за пределы города: ";
			private _numeralTokens = ["штука","штуки","штук"];
			{
				_x params ["_itemName","_typeName","_count","_leftCount"];
				if (_forEachIndex > 0) then {
					_needSteal = _needSteal + ", ";
				};

				_needSteal = _needSteal + format["%1 (%2 %3)",_itemName,_count,[_count,_numeralTokens] call toNumeralString];
			} foreach getSelf(reqItemsOutsideStation);

			_needSteal = _needSteal + ". Предметы должны лежать в ящике, который можно раскопать в земле за городом с помощью лопаты.";
			setSelf(textNeedItems,_needSteal);

			//reflect dirt change method
			_methodnew = {
				objParams_2(_with,_usr);
				if isTypeOf(_with,Shovel) then {
					private _gm = "GMOldNewOrder" call gm_getGameModeObject;
					if (!array_exists(getVar(_gm,antags),_usr)) exitWith {}; //откапывать могут только антаги
					if isNullReference(getVar(_gm,containerOutsideStation)) then {
						callFuncParams(_usr,meSay,"откапывает здоровый секретный ящик!");
						_cont = ["ContainerGreen3",getPosATL callFunc(_usr,getBasicLoc)] call createStructure;
						setVar(_cont,name,"Ящик Новой Армии");
						setVar(_gm,containerOutsideStation,_cont);
						getVar(_gm,slotsData) params ["_maxSize","_countSlots"];
						//countSlots - слотов под size * count * items
						//maxsize - самый большой предмет
						setVar(_cont,countSlots,_countSlots);
						setVar(_cont,maxSize,_maxSize);

						//reflect change
						_onAddItemInContainer = {
							objParams_1(_item);
							private _gm = "GMOldNewOrder" call gm_getGameModeObject;
							private _typeItem = callFunc(_item,getClassName);
							private _idx = getVar(_gm,reqItemsOutsideStation) findif {(_x select 1) == _typeItem};
							if (_idx == -1) exitWith {};

							private _buf = getVar(_gm,reqItemsOutsideStation) select _idx;
							_buf set [3,(_buf select 3) - 1];

							//check if all exists
							private _isSuccess = true;
							{
								_x params ["_nm","_t","_cn","_cl"];
								if (_cl > 0) exitWith {_isSuccess = false};
							} foreach getVar(_gm,reqItemsOutsideStation);
							setVar(_gm,hasAllItems,_isSuccess);
						};

						_onRemoveItemFromContainer = {
							objParams_1(_item);
							private _gm = "GMOldNewOrder" call gm_getGameModeObject;
							private _typeItem = callFunc(_item,getClassName);
							private _idx = getVar(_gm,reqItemsOutsideStation) findif {(_x select 1) == _typeItem};
							if (_idx == -1) exitWith {};

							private _buf = getVar(_gm,reqItemsOutsideStation) select _idx;
							_buf set [3,(_buf select 3) + 1];

							//check if all exists
							private _isSuccess = true;
							{
								_x params ["_nm","_t","_cn","_cl"];
								if (_cl > 0) exitWith {_isSuccess = false};
							} foreach getVar(_gm,reqItemsOutsideStation);
							setVar(_gm,hasAllItems,_isSuccess);
						};

						private _contType = typeGetFromObject(_cont);
						_contType setVariable ["onAddItemInContainer",_onAddItemInContainer];
						_contType setVariable ["onRemoveItemFromContainer",_onRemoveItemFromContainer];
					};
				};
			};

			typeGet(BlockDirt) setVariable ["onInteractWith",_methodnew];
		}];
		*/



		_list pushBack ["hostage","Выкрасть заложника",{
			format["Похитьте %1. Цель должна выведена из города в ближайшие пещеры.",callFuncParams(getSelf(hostage),getNameEx,"кого")]
		},{
			__host = getSelf(hostage);
			//локация заложника не станция и связан
			/*&& callFunc(__host,isHandcuffed)*/
			!getVar(__host,isDead) && {callFunc(__host,getBasicLoc) distance getSelf(hostageNeedPos) <= getSelf(hostageLocationDistance)}
		},{
			//выбираем заложника из станционников минус антаги
			private _stationers = (call gm_getStationRoleList) - getSelf(antags);

			//!Позиции СТАРЫЕ
			private _poses = [
				[3786.29,3820.18,28.1076],
				[3824.77,3889.32,24.2702],
				[3815.28,3829.42,24.4165]
			];
			
			#ifdef EDITOR
			_stationers = [getSelf(antags) select 0];
			#endif

			setSelf(hostageNeedPos,["kochevniki"] call getSpawnPosByName);
			setSelf(hostage,pick _stationers);

			private _eventCheck = {
				__host = getVar(gm_currentMode,hostage);
				(!getVar(__host,isDead) 
				//&& {!getVar(getSelf(mob),isDead)} 
				&& {callFunc(__host,getBasicLoc) distance getVar(gm_currentMode,hostageNeedPos) <= getVar(gm_currentMode,hostageLocationDistance)})
			};

			private _t = new(TaskCustom);
			setVar(_t,checkCompleteOnEnd,true);
			setVar(_t,isTaskSingleCheck,true);
			setVar(_t,name,"Похищение");
			setVar(_t,desc,"Выкрасть человека из города.");
			setVar(_t,descRoleplay,format["Нужно похитить %1. Цель должна выведена из города в ближайшие пещеры." arg callFuncParams(getSelf(hostage),getNameEx,"вин")]);
			setVar(_t,_customCondition,_eventCheck);
			callFuncParams(_t,setTag,"GMOldNewOrder_task");
			{
				callFuncParams(_x,addTask,_t);
			} foreach getSelf(antags);

		}];

		_list pushBack ["setrole","Помогите своему лидеру занять одну из ключевых фигур города",{
			"Он должен получить должность " + (getSelf(needRole) call {
				if isTypeOf(_this,RHead) exitWith {"головы"};
				if isTypeOf(_this,RAbbat) exitWith {"аббата"};
				if isTypeOf(_this,RKnut) exitWith {"кнута"};
				if isTypeOf(_this,RMerchant) exitWith {"торгаша"};
				if isTypeOf(_this,RCaretaker) exitWith {"смотрителя"};
				"непонятно кого..."
			})
		},{
			private _need = getSelf(needRole);
			//роль одного из антагов указана текущей
			equals(getVar(getVar(gm_currentMode,antags) select 0,role),_need)
		},{
			//выбираем нужную роль: Голова, Аббат, Кнут, Торговец, Нач.СБС
			private _listRolesStr = ["RHead","RAbbat","RKnut","RMerchant","RCaretaker"];

			//убираем все роли которых нет
			{
				if (count getVar(_x call gm_getRoleObject,basicMobs) == 0) then {_listRolesStr set [_forEachIndex,objnull]};
				//антаги нет
				if (count (getVar(_x call gm_getRoleObject,basicMobs) arrayIntersect getSelf(antags)) > 0) then {_listRolesStr set [_forEachIndex,objnull]};
			} foreach _listRolesStr;
			_listRolesStr = _listRolesStr - [objnull];

			#ifdef EDITOR
			_listRolesStr = ["RAbbat","RKnut","RCaretaker"]; //tests
			#endif

			private _listRoles = [];
			{
				_pickedRole = _x call gm_getRoleObject;
				if isNullReference(_pickedRole) then {
					errorformat("GM_OldNewOrder - unknown role class <%1> - null reference",_x);
				} else {
					_listRoles pushBack _pickedRole;
				};
			} foreach _listRolesStr;

			setSelf(needRole,pick _listRoles);
			
			private _eventCheck = {
				private _need = getVar(gm_currentMode,needRole);
				//роль одного из антагов указана текущей
				equals(getVar(getVar(gm_currentMode,antags) select 0,role),_need)
			};

			private _rDesc = "Возьмите на себя роль " + (getSelf(needRole) call {
				if isTypeOf(_this,RHead) exitWith {"головы"};
				if isTypeOf(_this,RAbbat) exitWith {"аббата"};
				if isTypeOf(_this,RKnut) exitWith {"кнута"};
				if isTypeOf(_this,RMerchant) exitWith {"торгаша"};
				if isTypeOf(_this,RCaretaker) exitWith {"смотрителя"};
				"непонятно кого..."
			});
			
			private _t = new(TaskCustom);
			//setVar(_t,checkCompleteOnEnd,true);
			setVar(_t,isTaskSingleCheck,false); //любой может быть занявшим роль
			setVar(_t,name,"Занять роль");
			setVar(_t,desc,"Нужно вступить в новую должность.");
			setVar(_t,descRoleplay,_rDesc);
			setVar(_t,_customCondition,_eventCheck);
			callFuncParams(_t,setTag,"GMOldNewOrder_task");
			
			{
				callFuncParams(_x,addTask,_t);

			} foreach [getSelf(antags) select 0];

		}];


		_list pushBack ["leave","Покинуть Грязноямск",{
			"Не менее одного человека должно покинуть город и добраться до Бомжграда"
		},{
			private _antags = getVar(gm_currentMode,antags);
			//----------- fix 0.7.677 -----------
			//покинуть город может хотя бы один из антагов
			private _aliveCount = 1;//{!getVar(_x,isDead)} count _antags;
			private _kochPos = ["kochevniki"] call getSpawnPosByName;
			({
				callFunc(_x,getPos) distance (_kochPos) <= 40 && !getVar(_x,isDead)
			} count _antags) >= _aliveCount;
			
		},{

			private _eventCheck = {
				params ['this',"_mob"];
				private _kochPos = ["kochevniki"] call getSpawnPosByName;
				!getVar(_mob,isDead) && {
					callFunc(_mob,getPos) distance (_kochPos) <= 40
				}
			};

			private _t = new(TaskCustom);
			setVar(_t,checkCompleteOnEnd,true);
			setVar(_t,isTaskSingleCheck,false);
			setVar(_t,name,"Побег");
			setVar(_t,desc,"Покинуть город через пещеры.");
			setVar(_t,descRoleplay,"Нужно сбежать из Грязноямска. Точка сбора - пещеры на выходе из Бомжграда");
			setVar(_t,_customCondition,_eventCheck);
			setVar(_t,tag,"GMOldNewOrder_task");

			{
				callFuncParams(_x,addTask,_t);

			} foreach getSelf(antags);

		}];

	if (false) then {
		/*_list pushBack ["poisonwell","Отравите воду в колодце","Подлейте яд в систему водоснабжения города",{
			//колодец отравлен (есть реагент)
			true
		},{
			//находим колодец по типу
			_well = ["BigPipePump",[3798.78,3761.31,23.2586],5] call getGameObjectOnPosition;
			setSelf(well,_well);
		}];*/
	};
		

		#ifdef EDITOR
		warning("===================   RESIZED OBJECTIVES STACK IN GM_OldNewOrder   ===================");
		_list = [_list select 0];
		#endif

		//максимум задач слишком много. Верхний предел ограничиваем
		if (getSelf(objectivesCountMax) > count _list) then {
			setSelf(objectivesCountMax,count _list);
		};

		// ----------------------------------------------------------------
		//				GENERATE OBJECTIVES
		private _objsCount = randInt(getSelf(objectivesCountMin),getSelf(objectivesCountMax));
		private _pickedObjectives = [];

		//random order
		_list = array_shuffle(_list);

		for "_i" from 1 to _objsCount do {
			_pickedObjectives pushBack (_list deleteAt 0);
		};

		setSelf(objectives,_pickedObjectives);

		// ---------------------- INITIAL CALLING -------------------
		{
			call (_x select 4);
		} foreach _pickedObjectives;
	};

	func(postSetup)
	{
		objParams();
		super();
		modSelf(duration, + tickTime);

		//generate objectives
		callSelf(generateNAObjectives);

		private _tasks = "Вы - Агент Новой Армии, пробравшийся в поселение под прикрытием. Ваши задачи:";
		{
			_x params ["_cls","_name","_desc"];
			_tasks = _tasks + sbr + format["    %1. %2: %3",_forEachIndex + 1,_name,ifcheck(equalTypes(_desc,{}),call _desc,_desc)];
		} foreach getSelf(objectives);

		private _myFriends = null;
		private _mft = "";

		{
			callFuncParams(_x,addFirstJoinMessage,_tasks);
			callFuncParams(_x,addMemory,_tasks);
			_myFriends = array_copy(getSelf(antags))-[_x];
			if (count _myFriends > 0) then {

				//TODO role info add
				//чтобы антаги друг друга знали рассылаем им ники своих
				//Ваш подельник - имя (роль)
				private _names = (_myFriends apply {callFuncParams(_x,getNameEx,"кто")}) joinString ", ";
				_mft = "Мои подельники: " + _names + ".";
				callFuncParams(_x,addFirstJoinMessage,_mft);
				callFuncParams(_x,addMemory,_mft);
			};

			if (_forEachIndex > 0) then {
				private _t = "Мой командир: " + callFuncParams(getSelf(antags) select 0,getNameEx,"кто") + format[" (%1)",getVar(getVar(getSelf(antags) select 0,role),name)];
				callFuncParams(_x,addFirstJoinMessage,_t);
				callFuncParams(_x,addMemory,_t);
			} else {
				if (count getSelf(antags) > 1) then {
					private _t = "Я командир своего отряда.";
					callFuncParams(_x,addFirstJoinMessage,_t);
					callFuncParams(_x,addMemory,_t);
				};
			};

		} foreach getSelf(antags);

	};

	func(checkFinish)
	{
		objParams();

		// Победа СТАНЦИИ

		//Все мертвы
		_antgs = getSelf(antags);
		#ifndef EDITOR
		if ({getVar(_x,isDead)}count(_antgs) == count _antgs) exitWith {1};
		#endif
		if (tickTime > getSelf(duration)) exitWith {
			//антаги находятся вне станции в конце раунда
			//TODO check condition location
			//3;
			//конец по времени
			2
		};
		private _ref = ("escaper_location" call getObjectByRef);
		if isNullReference(_ref) exitwith {0};
		private _cntMob = ["Mob",getposatl getVar(_ref,loc),5,true,true] call getMobsOnPosition;
		if ({callFunc(_x,isActive)} count _cntMob >= 
			#ifdef EDITOR
			1
			#else
			1
			#endif
		) exitwith {
			callSelf(escapeRoundResult);
		};

		// Победа НА
		//Все цели выполнены
		_countSuccess = 0;
		{
			if (call (_x select 3)) then {
				INC(_countSuccess);
			};
		} foreach getSelf(objectives);
		if (count getSelf(objectives) == _countSuccess) exitWith {5};

		0
	};

	func(getTaskTextSuccessInfo)
	{
		objParams();
		private _tasks = "<t align='left' color='#FAB475' font='PuristaMedium'>Задачи агентов:";
		private _isDone = false;
		{
			_x params ["_cls","_name","","_isSuccessCode"];
			_isDone = call _isSuccessCode;
			_tasks = _tasks + sbr + format["    %1. %2 - <t color='#%4'>%3</t>",_forEachIndex + 1,_name,ifcheck(_isDone,"Выполнено","Не выполнено"),ifcheck(_isDone,"417339","7E3E4F")];
		} foreach getSelf(objectives);

		_tasks + "</t>";
	};

	getterconst_func(escapeRoundResult,4);
	func(getResultTextOnFinish)
	{
		objParams();
		private _fr = getSelf(finishResult);
		if(_fr == 1) exitWith {"Все Агенты Новой Армии погибли." + sbr + callSelf(getTaskTextSuccessInfo)};
		if(_fr == 2) exitWith {"Агенты Новой Армии не успели выполнить свои цели." + sbr + callSelf(getTaskTextSuccessInfo)};
		if(_fr == 3) exitWith {"Агенты Новой Армии скрылись." + sbr + callSelf(getTaskTextSuccessInfo)};
		if (_fr == callSelf(escapeRoundResult)) exitwith {
			private _ref = ("escaper_location" call getObjectByRef);
			if isNullReference(_ref) exitwith {"Врата были открыты"};
			private _cntMob = ["Mob",getposatl getVar(_ref,loc),15,true,true] call getMobsOnPosition;
			private _t = "Грязноямск был покинут раньше, чем агенты успели выполнить свои задачи. Смогли выбраться:";
			{
				_t = _t + sbr + callSelfParams(getCreditsInfo,_x);
			} foreach _cntMob;
			_t + sbr + callSelf(getTaskTextSuccessInfo)
		};
		"Агентам Новой Армии удалось выполнить свои цели." + sbr + callSelf(getTaskTextSuccessInfo)
	};

	func(getEndSong)
	{
		objParams_1(_usr);
		private _fr = getSelf(finishResult);
		private _rez = super();
		if (_fr == 5) exitwith {"round\end_newarmy"};
		if (_rez!="") exitWith {_rez};
		""
	};

	func(onFinish)
	{
		objParams();
		super();

		private _allTasks = count getSelf(objectives);
		{
			private _mob = _x;
			private _successedTasks = {
				getVar(_x,tag) == "GMOldNewOrder_task" &&
				getVar(_x,isDone)
			} count getVar(_mob,tasks);
			
			callFuncParams(getVar(_mob,client),addPoints,_successedTasks);
		} foreach getSelf(antags);
	};

endclass

class(Item_OldNewOrder_distanceCheckCaptive) extends(Paper)

	var(name,"Странная бумага");
	var(desc,"Тут какие-то непонятные символы. Только знающий человек поймёт что тут написано.");

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
	};
	
	getter_func(getMainActionName,"Посмотреть направление");
	func(onMainAction)
	{
		objParams_1(_usr);
		private _gm = "GMOldNewOrder" call gm_getGameModeObject;
		if array_exists(getVar(_gm,antags),_usr) then {
			private _dist = getVar(_gm,hostageNeedPos) distance (getPosATL callFunc(_usr,getBasicLoc));
			if (_dist <= getVar(_gm,hostageLocationDistance)) then {
				private _m = pick["Тут нужно оставить заложника","Это точка встречи для передачи заложника","По этим указаниям заложник будет передан в этой точке"];
				callFuncParams(_usr,mindSay,_m);
			} else {
				private _dir = callFunc(_usr,getBasicLoc) getRelDir getVar(_gm,hostageNeedPos);
				private _textMove = "прямо";
				call {
					if (_dir > 315 || _dir <= 45) exitWith {_textMove = pick["вперёд","прямо"]};
					if (_dir > 45 && _dir <= 135) exitWith {_textMove = "правее"};
					if (_dir > 135 && _dir <= 225) exitWith {_textMove = "назад"};
					if (_dir > 225 && _dir <= 315) exitWith {_textMove = "левее"};
				};
				private _mes = format[
					"%1 %2 %3 %4",
					pick["Двигаемся","Идём","Нужно пройти","Позиция заложника"],
					_textMove,
					round _dist,
					[round _dist,["метр","метра","метров"]] call toNumeralString
				];
				callFuncParams(_usr,mindSay,_mes);
			};
		} else {
			private _mes = pick["Что-то на новоармейском...","Непонятные символы...","Тут какие-то цифры.","Не понимаю как это прочесть..."];
			callFuncParams(_usr,mindSay,_mes);
		};
	};
endclass

class(Item_OldNewOrder_BombPart1) extends(Item)
	var(name,"Взрывчатка");
	var(model,"a3\props_f_enoch\military\equipment\portablesolarpanel_01_folded_f.p3d");
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,3.5);

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,Item_OldNewOrder_BombPart2) exitWith {
			delete(_with);
			private _bobj = callSelfParams(replaceWith,"Item_OldNewOrder_Bomb");
			callFunc(_bobj,onCreateBomb);
		};
	};
endclass

class(Item_OldNewOrder_BombPart2) extends(Item)
	var(name,"Элемент питания бомбы");
	var(model,"a3\props_f_enoch\military\equipment\batterypack_01_battery_f.p3d");

	var(size,ITEM_SIZE_SMALL);
	var(weight,1.5);

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,Item_OldNewOrder_BombPart1) exitWith {
			delete(_with);
			private _bobj = callSelfParams(replaceWith,"Item_OldNewOrder_Bomb");
			callFunc(_bobj,onCreateBomb);
		};
	};
endclass

class(Item_OldNewOrder_Bomb) extends(Item)
	var(name,"Бомба");
	var(desc,"Взрывное устройство с дистанцией поражения в 15 метров. Активируется кусачками");
	var(model,"a3\weapons_f\explosives\satchel.p3d");
	var(size,ITEM_SIZE_LARGE);
	var(weight,5);

	var_bool(isEnabled); //запущен детонатор
	var(detonateAfter,60*3);//взрыв через 3 минуты
	var_bool(isActivated);

	autoref var(handleupd,-1);

	func(onCreateBomb)
	{
		objParams();
		private _gm = "GMOldNewOrder" call gm_getGameModeObject;
		getVar(_gm,bombs) pushBack this;
	};

	func(onTimeLeft)
	{
		objParams();

		//fatal damage
		{
			private _mob = _x;
			private _allParts = BP_INDEX_ALL - [BP_INDEX_TORSO];
			_allParts = array_shuffle(_allParts);
			private _rndListParts = [];
			for "_i" from 1 to randInt(2,4) do {
				_rndListParts pushBackUnique (_allParts deleteAt 0)
			};

			{
				callFuncReflectParams(_mob,pick["destroyLimb" arg "lossLimb"],_x);
			} foreach _rndListParts;
			if prob(60) then {
				invokeAfterDelayParams({callFuncParams(_this,Die,null)},0.1,_mob);
			};
		} foreach callSelfParams(getNearMobs,25 arg false);

		callSelfParams(worldSay,setstyle("БАБАХ!",style_redbig) arg null arg 40 arg false);
		callSelfParams(playSound,"atmos\Explosion" + str randInt(1,6) arg rand(0.8,1.3) arg 150 arg null arg null arg false);

		//rem to this list
		private _gm = gm_currentMode;
		getVar(_gm,bombs) deleteAt (getVar(_gm,bombs) find this);

		if (callFuncParams(getVar(_gm,generator),getDistanceTo,this) <= 15) then {
			setVar(_gm,isBlownUp,true);
			delete(getVar(_gm,generator));
		};

		//delete this
		delete(this);
	};

	func(setEnable)
	{
		objParams_1(_mode);
		if equals(getSelf(isEnabled),_mode) exitWith {false};
		if getSelf(isActivated) exitWith {false};

		if (_mode) then {
			callSelfParams(startUpdateMethod,"onUpdate" arg "handleupd");
		} else {
			callSelfParams(stopUpdateMethod,"handleupd");
		};
		#ifdef EDITOR
		if (_mode) then {setSelf(detonateAfter,10)};
		#endif
		setSelf(isEnabled,_mode);
		true
	};

	func(onUpdate)
	{
		updateParams();
		modSelf(detonateAfter, - 1);
		if (getSelf(detonateAfter) <= 0) exitWith {
			callSelfParams(stopUpdateMethod,"handleupd");
			setSelf(isActivated,true);
			callSelf(onTimeLeft);
		};
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,WireCutters) then {
			private _newMode = !getSelf(isEnabled);
			if callSelfParams(setEnable,_newMode) then {
				callFuncParams(_usr,meSay,ifcheck(_newMode,"подключает провода к бомбе","обрезает провода бомбы"));
			};
		};
	};

	func(getName)
	{
		objParams();
		ifcheck(getSelf(isEnabled),"Активированная " + toLower getSelf(name),getSelf(name))
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		private _timeLeft = getSelf(detonateAfter);
		private _isEnabled = getSelf(isEnabled);

		callSuper(Item,getDescFor) + (if (_isEnabled) then {
			if getSelf(isActivated) then {
				sbr + "Слишком поздно чтобы что-то изменить..."
			} else {
				sbr +
				format["На маленьком циферблате показывает %1 %2",_timeLeft,[_timeLeft,["секунда","секунды","секунд"]] call toNumeralString]
			};
		} else {""})
	};
endclass

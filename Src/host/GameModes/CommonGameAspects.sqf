// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <GameMode.h>

server_gameAspects_list_nopicked = [];
#define DEFAULT_WEIGHT 1
#define proto_class(name) server_gameAspects_list_nopicked pushBack #name; class(name)

proto_class(DirtpitGameAspect) extends(BaseGameAspect)
	var(allowedMaps,["Minimap"]);
	var(weight,DEFAULT_WEIGHT);
endclass

//множественный аспект
proto_class(MultiGameAspect) extends(BaseGameAspect)
	var(internalAspects,[]); //список объектов аспекта
	var(aspectsCount,1); //количество выбранных аспектов

	func(onActivate)
	{
		objParams();
		[this] call gm_pickMultiAspects;
	};

	func(getAspectText)
	{
		objParams();
		//TODO переопределить
		private _aspText = ifcheck(getSelf(isHidden),pick ["Неизвестно, страшно, загадочно" arg "Неизвестно и загадочно" arg "Неизвестно и страшно" arg "Страшно и загадочно"],getSelf(descRoleplay));
		format["<t font='Ringbear' align='center' color='#269669'><t size='1.4'>Влияние Реликты</t>%1%2</t>",sbr,_aspText];
	};
	
	func(printAspectInfo)
	{
		objParams();
		//TODO переопределить
		private _postHide = false;
		if getSelf(isHidden) then {
			_postHide = true;
			setSelf(isHidden,false);
		};
		private _text = callSelf(getAspectText);
		{
			callFuncParams(_x,localSay,_text arg "");
		} foreach (cm_allClients);
		
		if (_postHide) then {
			setSelf(isHidden,true);
		};
	};
	
	func(onRoundBegin)
	{
		objParams();
		//TODO переопределить
	};
	
	func(onRoundEnd)
	{
		objParams();
		//TODO переопределить
		if getSelf(isHidden) then {
			_text = format["<t font='RobotoCondensed' size='1.3' color='#269669'>Влияние Реликты - ""%1"": %2</t>",getSelf(name),getSelf(descRoleplay)];
			{
				callFuncParams(_x,localSay,_text arg "");
			} foreach (cm_allClients);
			
		};
	};
	
	func(onMob)
	{
		objParams_1(_mob);
		//TODO переопределить
	};
endclass

//Это тихая смена
class(EmptyGameAspect) extends(BaseGameAspect)
	var(name,"Тихий промежуток");
	var(desc,"Без аспекта");
	var(descRoleplay,"Сегодня выдался тихий промежуток.");
	var(weight,DEFAULT_WEIGHT);
	var(isHidden,true);
endclass

//никто не умеет драться
class(CannotCloseCombatAspect) extends(DirtpitGameAspect)
	var(name,"Беспомощный Грязноямск");
	var(desc,"У всех скилл ближнего боя очень низок");
	var(descRoleplay,"Никто в Грязноямске не умеет драться.");
	
	func(onMob)
	{
		objParams_1(_mob);
		super();
		if !isTypeOf(getVar(_mob,basicRole),IRStationRole) exitwith {};

		//Временный фикс на попадание
		callFuncParams(_mob,initDX,(callFunc(_mob,getBaseDX) - randInt(4,6)) max 1);

		{
			callFuncParams(_mob,updateSkillLevel,_x arg 0 arg true);
		} foreach ["fight","shield","fencing","axe","baton","spear","sword","knife","whip",
			"pistol","rifle","shotgun","crossbow"
		];
		
	};
endclass

//никто не умеет драться кроме детей
class(CannotCloseCombatWithoutChildrensAspect) extends(DirtpitGameAspect)
	var(name,"Беспомощный Грязноямск?");
	var(desc,"Все кроме детей не умеют драться");
	var(descRoleplay,"Только подрастающее поколение Грязноямска сможет всех защитить.");
	
	func(onMob)
	{
		objParams_1(_mob);
		super();

		if !isTypeOf(getVar(_mob,basicRole),IRStationRole) exitwith {};

		{
			if callFunc(_mob,isChild) then {
				callFuncParams(_mob,updateSkillLevel,_x arg randInt(2,5));
			} else {
				//Временный фикс на попадание
				callFuncParams(_mob,initDX,(callFunc(_mob,getBaseDX) - randInt(4,6)) max 1);

				callFuncParams(_mob,updateSkillLevel,_x arg 0 arg true);
			};
		} foreach ["fight","shield","fencing","axe","baton","spear","sword","knife","whip",
			"pistol","rifle","shotgun","crossbow"
		];
		
	};
endclass

//дети потеряли интеллект, но получили доп силу
class(StrongAndDumbChildrensAspect) extends(BaseGameAspect)
	var(name,"Сильные дети");
	var(desc,"Дети тупее но сильнее");
	var(descRoleplay,"Дети рождались более сильными"pcomma " но были гораздо тупее.");
	var(isHidden,true);
	func(onMob)
	{
		objParams_1(_mob);
		super();
		if (!callFunc(_mob,isChild)) exitwith {};

		callFuncParams(_mob,initIQ,randInt(2,4));
		callFuncParams(_mob,initST,callFunc(_mob,getBaseST) + randInt(3,6));
	};
endclass

//Ты можешь идти, куда захочешь (никакие двери не залочены и ключи их не локают)
class(OpenedDoorsAspect) extends(BaseGameAspect)
	var(name,"Открытые двери");
	var(desc,"Двери не локаются");
	var(descRoleplay,"Что-то случилось с замками... Больше не нужно запирать двери и каждый может идти"pcomma " куда захочет.");
	
	func(onRoundBegin)
	{
		objParams();

		{
			//только не электронные двери
			if !isTypeOf(_x,ElectronicDeviceDoor) then {
				if getVar(_x,isLocked) then {
					private _list = getVar(_x,keyTypes);
					_list resize 0;
					setVar(_x,keyTypes,_list);

					callFuncParams(_x,setDoorLock,false arg true);
				};
			};
		} foreach (
			(["DoorStatic",true] call getAllObjectsInWorldTypeOf) + 
			(["DoorDynamic",true] call getAllObjectsInWorldTypeOf)
		);
	};
endclass

//голова был безупречным правителем. казна полна
class(MoreMoneyInBankAspect) extends(DirtpitGameAspect)
	var(name,"Полная казна");
	var(desc,"В казне больше средств");
	var(descRoleplay,"Наш Голова был отличным правителем и сумел пополнить казну города.");
	
	func(onRoundBegin)
	{
		objParams();

	};
endclass

//мельтешата пожрали 50% еды
//Ты можешь идти, куда захочешь (никакие двери не залочены и ключи их не локают)
//!WARNING used obsolete function getInitialiPos
class(RatsEatFoodAspect) extends(BaseGameAspect)
	var(name,"Меньше еды");
	var(desc,"Половина еды съедена мельтешатами");
	var(descRoleplay,"Дикие мельтешата пожрали половину наших припасов.");
	
	func(onRoundBegin)
	{
		objParams();

		private _basepos = callFunc("RCook" call gm_getRoleObject,getInitialPos);

		{
			if prob(50) then {delete(_x)};			
		} foreach (
			//(["IFoodItem",true] call getAllItemsTypeOf)
			(["IFoodItem",_basepos,300,true] call getAllItemsOnPosition) +
			(["Muka",_basepos,300,true] call getAllItemsOnPosition)
		);
	};
endclass

//голова знает что на станции агенты новой армии
class(HeadKnownAntagInOldNewOrder) extends(DirtpitGameAspect)
	var(name,"Мудрый Голова");
	var(desc,"Голова знает что в городе предатели");
	var(descRoleplay,"Голова прознал" pcomma " что в город пробрались агенты Новой Армии.");
	
	var(allowedMaps,["GMOldNewOrder"]);
	var(weight,DEFAULT_WEIGHT + 0.4);
	var(isHidden,true);

	func(onMob)
	{
		objParams_1(_mob);
		super();

		if (callFunc(getVar(_mob,basicRole),getClassName)!="RHead") exitwith {};
		private _m = setstyle("<t size='1.8'>Ты знаешь, что среди жителей города есть новоармейцы под прикрытием. Они явно задумали что-то плохое против тебя...</t>",style_redbig);
		callFuncParams(_mob,addFirstJoinMessage,_m);
		
	};
endclass

//грязноямск не отличается умом
class(DumbDirtpitAspect) extends(DirtpitGameAspect)
	var(name,"Слабоумный Грязноямск");
	var(desc,"В Грязноямске все тупые");
	var(descRoleplay,"Грамотеями быть запрещено. Именно поэтому жителя Грязноямска не отличаются сообразительностью.");
	
	func(onMob)
	{
		objParams_1(_mob);
		super();
		if !isTypeOf(getVar(_mob,basicRole),IRStationRole) exitwith {};

		callFuncParams(_mob,initIQ,(callFunc(_mob,getBaseIQ) - randInt(5,6)) max 1);
	};
endclass

//Все женщины безумно сильные
class(StrongWomansAspect) extends(BaseGameAspect)
	var(name,"Сильные цацы");
	var(desc,"Женщины безумно сильные");
	var(descRoleplay,"Цацы значительно сильнее мужчин.");
	var(isHidden,true);

	func(onMob)
	{
		objParams_1(_mob);
		super();
		if (!callFunc(_mob,isFemale)) exitwith {};

		callFuncParams(_mob,initST,callFunc(_mob,getBaseST) + randInt(5,8));
	};
endclass

//голова празднует сегодня своё 16 летие
class(HeadChildDirtpitAspect) extends(DirtpitGameAspect)
	var(name,"Власть детям");
	var(desc,"Голова 16ти летний ребенок");
	var(descRoleplay,"Голова сегодня празднует своё 16ти летие.");

	func(onMob)
	{
		objParams_1(_mob);
		super();

		if (callFunc(getVar(_mob,basicRole),getClassName)!="RHead") exitwith {};
		
		setVar(_mob,age,16);		
	};
endclass

//изгнание из грязноямска самое худшее что может быть (бан роли на месяц)
class(ExileBanDirtpitAspect) extends(DirtpitGameAspect)
	var(name,"Фатальное изгнание");
	var(desc,"Бан роли на месяц за изгнание из города");
	var(descRoleplay,"Изгнание из Грязноямска - самое худшее" pcomma " что может быть сегодня.");
	var(isHidden,true);
	var(weight,0.1);

	var(exiled,[]); //клиенты кикнутые

	func(addExiledMob)
	{
		objParams_1(_mob);

		//Добавление работает только во время игры
		if (!call gm_isRoundPlaying) exitWith {};

		if (callFunc(_mob,isPlayer) && {!isNullReference(getVar(_mob,client))}) then {
			getSelf(exiled) pushBack [getVar(getVar(_mob,client),name),callFunc(getVar(_mob,role),getClassName)]
		} else {
			//playerClients
			private _clients = getVar(_mob,playerClients);
			if (count _clients == 0) exitwith {};
			getSelf(exiled) pushBack [getVar(array_selectlast(_clients),name),callFunc(getVar(_mob,role),getClassName)]
		};
	};

	func(onRoundEnd)
	{
		objParams();
		super();

		{
			_x params ["_name","_roleClass"];

			#ifdef EDITOR 
			private __br = 
			#endif

			[
				null,
				_name,
				_roleClass,
				"Автоматический бан за аспект " + getSelf(name),
				[["months","+1"]]
			] call db_banJobByName;

			#ifdef EDITOR
			[format["BANASPECT(%2): %1",__br,_x],"system"] call chatPrint;
			#endif
		} foreach getSelf(exiled);
	};

endclass

//нынче Бомжики сейчас очень опасны
class(StrongBumsAspect) extends(DirtpitGameAspect)
	var(name,"Бомжи ломятся");
	var(desc,"Бомжи очень сильные");
	var(descRoleplay,"Нынче бомжи очень сильны и опасны.");

	func(onMob)
	{
		objParams_1(_mob);
		super();
		if !isTypeOf(getVar(_mob,basicRole),RBum) exitwith {};

		callFuncParams(_mob,initST,callFunc(_mob,getBaseST) + randInt(4,6));
	};
endclass


//смерть сегодня имеет самый ужасный исход (потеря 5 хвостиков)
class(NoDeathPointsAspect) extends(DirtpitGameAspect)
	var(name,"Жажда жизни");
	var(desc,"За смерть в роли человека потеря 5х хвостиков");
	var(descRoleplay,"Сегодня никому не хочется умирать...");
	var(weight,0.1);

	func(onRoundBegin)
	{
		objParams();
		super();
		

		{
			//Аккуратно инжектим код
			[_x,"onDeadBasic",{
				//жрунам не даем штраф
				if (
					getSelf(classMan) != "GMPreyMobEater" 
					&& {getSelf(classWoman) != "GMPreyMobEater"}
				) then {
					callFuncParams(_usr,removePoints,5)
				};
			},"end",false] call oop_injectToMethod;
		} foreach (callFunc(gm_currentMode,getLobbyRoles) + callFunc(gm_currentMode,getLateRoles))

	};
endclass

//только казни спасли грязноямск. всем кроме штрихов пистолеты
class(ArmedMilitarsDirtpitAspect) extends(DirtpitGameAspect)
	var(name,"Смертоносное ополчение");
	var(desc,"У смотрителя и бывалых есть заряженные пистолеты боевыми патронами");
	var(descRoleplay,"Только жесткий подход ополчения в своё время помог сохранить Грязноямск. Ополченцы вооружены и готовы без промедления казнить любого кто нарушит порядок или ослушается Голову.");
	var(weight,0.6);
	
	func(onMob)
	{
		objParams_1(_mob);
		super();
		private _class = callFunc(getVar(_mob,basicRole),getClassName);
		if (!(_class in ["RCaretaker","RVeteran"])) exitwith {};

		//Временный фикс на попадание
		callFuncParams(_mob,initDX,(callFunc(_mob,getBaseDX) - randInt(4,6)) max 1);

		{
			callFuncParams(_mob,updateSkillLevel,_x arg 2);
			private _beltItm = callFuncParams(_mob,getItemInSlot,INV_BELT);
			if !isNullReference(_beltItm) then {
				delete(_beltItm);
			};

			_beltItm = ["PistolPBM",_mob,INV_BELT] call createItemInInventory;
			callFuncParams(_beltItm,createMagazine,"MagazinePBMLoaded");
			setVar(_beltItm,name,"""Казнитель""");
			private _cloth = callFuncParams(_mob,getItemInSlot,INV_CLOTH);
			if !isNullReference(_cloth) then {
				["MagazinePBMLoaded",_cloth] call createItemInContainer;
			};
		} foreach ["pistol"];
		
	};
endclass

//Обывалы черезвычайно сильны
class(StrongCitizensAspect) extends(DirtpitGameAspect)
	var(name,"Безделье - сила!");
	var(desc,"Сильные обывалы и бродяги");
	var(descRoleplay,"Бездельники и хвосты грязноямска вместо нормальной работы решили подкачаться.");
	var(isHidden,true);

	func(onMob)
	{
		objParams_1(_mob);
		super();
		if (!isTypeOf(getVar(_mob,basicRole),RCitizen)) exitwith {};

		callFuncParams(_mob,initST,callFunc(_mob,getBaseST) + randInt(5,7));
	};
endclass

//Все стальные двери украдены и переплавлены
class(StealedDoorsAspect) extends(BaseGameAspect)
	var(name,"Без стальных дверей");
	var(desc,"Двери уничтожаются");
	var(descRoleplay,"Некоторые стальные двери бессовестно украли.");
	
	func(onRoundBegin)
	{
		objParams();

		{
			//только не электронные двери
			if !isTypeOf(_x,ElectronicDeviceDoor) then {
				if prob(40) then {
					delete(_x);
				};
			};
		} foreach (
			(["SteelGridDoor",true] call getAllObjectsInWorldTypeOf) + 
			(["SteelDoorThinSmall",true] call getAllObjectsInWorldTypeOf)
		);
	};
endclass

//Грязноямск: Сын Головы убежал в пещеры
//!WARNING used obsolete function getInitialiPos
class(HeadSonEscapedAspect) extends(DirtpitGameAspect)
	var(name,"Блудный сын");
	var(desc,"Сын головы появляется за городом");
	var(descRoleplay,"Сын Головы убежал в пещеры.");
	
	func(onRoundBegin)
	{
		objParams();

		["RHeadSon","getInitialPos",{
			objParams();
			(["kochevniki"] call getSpawnPosByName)vectorAdd vec3(rand(-0.1,0.1),rand(-0.1,0.1),0)
		},"replace",false] call oop_injectToMethod;
	};

	func(onMob)
	{
		objParams_1(_mob);
		super();
		if (!isTypeOf(getVar(_mob,basicRole),RHeadSon)) exitwith {};

		["Candle",_mob] call createItemInInventory;
	};
endclass

//Торгаш наторговал в прошлой смене кучу звяков
class(MerchantMoreMoneyAspect) extends(DirtpitGameAspect)
	var(name,"Богатый торгаш");
	var(desc,"Больше средств в торговой консоли со старта.");
	var(descRoleplay,"Торгаш наторговал в прошлой смене кучу звяков.");
	
	func(onRoundBegin)
	{
		objParams();

		{
			modVar(_x,money, + randInt(500,700));
		} foreach (["MerchantConsole",true] call getAllObjectsInWorldTypeOf);
	};
endclass

//А что такое деньги? - Все звяки из казны грязноямска пропали
class(NoMoneyInBankAspect) extends(DirtpitGameAspect)
	var(name,"А что такое деньги?");
	var(desc,"В казне нет звяков");
	var(descRoleplay,"Кто-то украл все звяки из казны Грязноямска.");
	var(isHidden,true);

	func(onRoundBegin)
	{
		objParams();

	};
endclass

//Грязноямск: жена головы немыслимо сильна
class(StrongHeadWifeAspect) extends(DirtpitGameAspect)
	var(name,"Королева Грязноямска");
	var(desc,"Жена Головы очень сильна");
	var(descRoleplay,"Ходят слухи" pcomma " что жена Головы - сильнейшая цаца среди всех жителей Грязноямска. Быть может скоро именно она займет место правителя.");

	var(wifeHeads,[]);

	func(onMob)
	{
		objParams_1(_mob);
		super();
		if (!isTypeOf(getVar(_mob,basicRole),RWifeHead)) exitwith {};

		callFuncParams(_mob,initST,callFunc(_mob,getBaseST) + randInt(9,12));

		callFuncParams(_mob,addFirstJoinMessage,setstyle("Только я знаю что нужно этому городу. Я должна стать Головой!",style_redbig));
		getSelf(wifeHeads) pushBack _mob;
	};

	func(onRoundEnd)
	{
		objParams();

		{
			_mob = _x;
			if getVar(_mob,isDead) then {continue};

			if (callFunc(_mob,isPlayer) && {!isNullReference(getVar(_mob,client))}) then {
				callFuncParams(getVar(_mob,client),addPoints,2);
			} else {
				private _clients = getVar(_mob,playerClients);
				if (count _clients == 0) exitwith {};
				callFuncParams(array_selectlast(_clients),addPoints,2);
			};
		} foreach getSelf(wifeHeads);
	};

endclass

//Грязноямск оправдывает своё название. Все очень грязны
class(DirtpitIsRealAspect) extends(DirtpitGameAspect)
	var(name,"Грязный ямск");
	var(desc,"Все жители Грязноямска полностью в грязи");
	var(descRoleplay,"Грязноямск оправдывает своё название. Все его жители очень грязны.");
	
	func(onMob)
	{
		objParams_1(_mob);
		super();
		if !isTypeOf(getVar(_mob,basicRole),IRStationRole) exitwith {};
		
		{
			callFuncParams(_x,setGerms,GERM_COUNT_MAX);
		} foreach (values getVar(_mob,bodyParts));
	};

endclass

//Голова со смотрителем возвращаются из недельного путешествия по пещерам (голодны и снаряжены)
//!Призракам нужно в половину меньше времени до упокоения
//!Грязноямск кишит серыми
//!Умершие воскрешают даже в грязноямске (нужно воскрешение трупов)
//!Thanks to our brave warriors, there will be no ambushes in the caves today
//!Кочевники бедны, раздеты и унижены
//!праздник Татора Дуды - надо выпить за это
//!Грязноямск: That diet was a great choice. Fresh male milk is exremely nutritious
//!весь грязноямск страдает одним и тем же пороком
//!в переговорной грязноямска назначена встреча


// Весы режимов (от 0 до 2)
// Основная идея в том чтобы появление аспектов от режима  делало их более вероятными
// Поэтому мы назначаем общим аспектам числа от 0 до 1, а режимным от 1 до 2.

// Общие
_GAExtendedKeysWeight = 0.8;        // Мягкие ключи
_GADeathSprintWeight = 0.2; 		// Поступь мертвеца 
_GACombatChairsWeight = 0.5;		// Опасные стулья
_GADangerousWeaponWeight = 0.3;	    // Опасные пафели
_GAPainfullPainkillerWeight = 0.3;  // Больное обезболивающее
_GAStartRolesShuffle = 0.2;		    // Смешивание ролей при старте игры

// Злачник
_GASaloonWhereWeaponsWeight = 1;    // Где наши пушки?
_GASaloonNoAmmoWeight = 1;				// Мы всё простреляли


class(GAExtendedKeys) extends(BaseGameAspect)
	var(name,"Мягкие ключи");
	var(desc,"У каждого ключа расширяется список доступных дверей");
	var(descRoleplay,"Так завелось"pcomma " что ключи в этом месте открывают больше"pcomma " чем должны.");
	var(weight,_GAExtendedKeysWeight);

	var(_allKeyTypes,[]);

	func(_onKey)
	{
		objParams_1(_key);
		private _keyTypes = getSelf(_allKeyTypes);
		private _keys = getVar(_key,keyOwner);
		private _uniqueList = _keyTypes - _keys;
		for "_i" from 2 to randInt(2,4) do {
			if (count _uniqueList == 0)exitWith {};
			_rndItem = pick _uniqueList;
			_keys pushBack (_rndItem);
			_uniqueList = _uniqueList - [_rndItem];
		};
		setVar(_key,desc,"С этим ключом что-то не так...");
		//setVar(_key,name,getSelf(name) + "?!");
	};

	func(onMob)
	{
		objParams_1(_mob);
		super();
		{
			callSelfParams(_onKey,_x);
		} foreach ([_mob,"Key"] call getAllItemsInInventory);
	};

	func(onActivate)
	{
		objParams();

		//Собираем все двери
		private _allDoors = (["DoorDynamic"] call getAllObjectsInWorldTypeOf)+(["DoorStatic"]call getAllObjectsInWorldTypeOf);
		//собираем все типы замков
		private _keyTypes = [];
		{
			{_keyTypes pushBackUnique _x;true} foreach getVar(_x,keyTypes);
		} foreach _allDoors;
		setSelf(_allKeyTypes,_keyTypes);

		private _keys = [];
		{
			callSelfParams(_onKey,_x);
		} foreach (["Key"] call getAllItemsTypeOf);
	};

endclass

class(GADeathSprint) extends(BaseGameAspect)
	var(name,"Поступь мертвеца");
	var(desc,"Спринт может привести к фатальным последствиям");
	var(descRoleplay,"Наши подошвы сделаны из гнилой плоти. Лучше ходить аккуратненько...");
	var(weight,_GADeathSprintWeight);

	func(onActivate)
	{
		objParams();
		private _type = nullPtr;
		private _inject = '
			if isNull(getSelf(__gadeathsprint_lastcheck)) then {setSelf(__gadeathsprint_lastcheck,tickTime + randInt(1,10))};
			if callSelf(isSprinting) then {
				if (tickTime >= getSelf(__gadeathsprint_lastcheck)) then {
					setSelf(__gadeathsprint_lastcheck,tickTime + randInt(1,10));
					_it = pick (callSelfParams(getNearStructs,10)+callSelfParams(getNearDecors,10));
					if isNullReference(_it) exitWith {};
					callFuncParams(_it,onCrushingContact,this arg true);
					callSelfParams(meSay,"подскальзывается на ровном месте.");
				};
			};
		';
		private _baseCode = "";
		{
			_type = typeGetFromString(_x);
			_baseCode = toString typeGetVar(_type,handle_stamina);
			typeSetVar(_type,handle_stamina,compile(_baseCode + _inject));
		} foreach ["Mob","MobWoman"];
	};

endclass
/*
class(GAStartRolesShuffle) extends(BaseGameAspect)
	var(name,"Неразбериха");
	var(desc,"Все персонажи с начала смены меняются местами");
	var(descRoleplay,"Все просыпаются совсем не теми"pcomma "кем засыпали вчера...");
	var(weight,_GAStartRolesShuffle);
	func(onActivate)
	{
		objParams();
		private _cliList = cm_allClients select {getVar(_x,isReady)};
		// просто ставим всем без роли чтобы работала перемешка персонажей
		{
			callFunc(_x,resetAllRoles);
		} foreach _cliList;
		
		//TODO астрал предлагает сделать рандом на основе только занятых ролей.
	};

endclass
*/

class(GACombatChairs) extends(BaseGameAspect)
	var(name,"Опасные стулья");
	var(desc,"Стулья становятся гиперубийственными штуками, при этом их можно обезвредить кусачками");
	var(descRoleplay,"Кто-то позабивал гвозди в ножки всех стульев вокруг.");
	var(weight,_GACombatChairsWeight);

	func(onActivate)
	{
		objParams();

		{
			_wm = getVar(_x,attachedWeap);
			_wm = callFunc(_wm,copyIfCommon);
			_bonList = getVar(_wm,dmgBonus);
			setVar(_wm,copyOfDmgBonus,array_copy(_bonList));
			{
				_bonList set [_x,7];
			} foreach _bonList;
			setVar(_x,attachedWeap,_wm);
		} foreach (["IChairAsItem"] call getAllItemsTypeOf);

		//замена конструктора для новых стульев
		private _type = typeGet(IChairAsItem);
		private _inject = '
			_wm = getVar(this,attachedWeap);
			_wm = callFunc(_wm,copyIfCommon);
			_bonList = getVar(_wm,dmgBonus);
			setVar(_wm,copyOfDmgBonus,array_copy(_bonList));
			{
				_bonList set [_x,7];
			} foreach _bonList;
			setVar(this,attachedWeap,_wm);
		';

		_baseCode = toString typeGetVar(_type,constructor);
		typeSetVar(_type,constructor,compile(_baseCode + _inject));

		//WireCutters
		["IChairAsItem","onInteractWith",{
			objParams_2(_with,_usr);

			if isTypeOf(_with,WireCutters) then {
				_wm = getVar(this,attachedWeap);
				_oldBon = getVar(_wm,copyOfDmgBonus);
				if isNullVar(_oldBon) exitWith {
					callFuncParams(_usr,localSay,"Этот стул выглядит безобидно" arg "error");
				};
				setVar(_wm,dmgBonus,_oldBon);
				setVar(_wm,copyOfDmgBonus,null);
				callFuncParams(_usr,meSay,"срезает все гвоздики со стула");
			};
		},"begin",true] call oop_injectToMethod;
	};

endclass

// TODO: Тут на самом деле это должна быть характеристика патронов, и патронов именно которые изначально есть на локации
class(GADangerousWeapon) extends(BaseGameAspect)
	var(isHidden,true);
	var(name,"Опасные пафели");
	var(desc,"Оружие с каким-то шансом может взорваться в руках и оторвать руку. Оружие уничтожается");
	var(descRoleplay,"В последней партии патронов переборщили с грибным порохом.");
	var(weight,_GADangerousWeaponWeight);

	func(onActivate)
	{
		objParams();
		["IRangedWeapon","onPostShoot",{
			if isNull(getSelf(__gadangerousweapon_counter)) then {setSelf(__gadangerousweapon_counter,randInt(3,30))};
			modSelf(__gadangerousweapon_counter, - 1);
			if (getSelf(__gadangerousweapon_counter) <= 0) then {
				callSelfParams(worldSay,setstyle("Оружие взрывается!",style_redbig) arg "");
				private _d = 2 call gurps_throwdices;
				if (!_supressMessage) then {
					callFuncParams(_usr,meSay,format ["со всей мощи впечатался в %1." arg callSelfParams(getNameFor,_usr)]);
				};
				_zones = pick[TARGET_ZONE_ARM_L,TARGET_ZONE_ARM_R];
				_zones = callFuncParams(_usr,redirectZoneInExistingParts,_zones);
				_d = 4 call gurps_throwdices;
				callFuncParams(_usr,applyDamage,_d arg DAMAGE_TYPE_PIERCING_NO arg _zones arg DIR_FRONT arg di_partDamage);
				delete(this);
			};
		},"end",true] call oop_injectToMethod;
	};
endclass

class(GAPainfullPainkiller) extends(BaseGameAspect)
	var(isHidden,true);
	var(name,"Больное обезболивающее");
	var(desc,"Обезбол вызывает ЛЮТУЮ боль");
	var(descRoleplay,"Оказывается, на заводе перепутали обезболивающее с болюющим.");
	var(weight,_GAPainfullPainkillerWeight);

	func(onActivate)
	{
		objParams();
		private _space = ms_map_allMatters get "Tamidin";

		//Милая копипаста...
		_space set ["onAssimIngest",{
			{
				//Нет части тела
				if isNullReference(_y) then {continue};
				callSelfParams(addPainLevel,_x arg 1);
			} foreach getSelf(bodyParts);
		}];
		_space set ["onAssimBlood",{
			{
				//Нет части тела
				if isNullReference(_y) then {continue};
				callSelfParams(addPainLevel,_x arg 2);
			} foreach getSelf(bodyParts);
		}];
	};
endclass

class(GASaloonWhereWeapons) extends(BaseGameAspect)
	var(isHidden,true);
	var(name,"Где наши пушки?");
	var(desc,"Пушки из бара спавнятся у других людей. Этот аспект показывается всем кто в баре и тем кто украл пушки");
	var(descRoleplay,"Да уж... Из бара украли все оружие.");
	var(allowedModes, ["GMSaloon" arg "GMSaloonV2"]);
	var(weight,_GASaloonWhereWeaponsWeight);

	var(listStolenWeapons,[]);

	func(onActivate)
	{
		objParams();
		//Собираем стволы с бара
		{
			getVar(_x,loc) setPosAtl [100,100,10];
			getSelf(listStolenWeapons) pushBack _x;
			callFunc(_x,replicateObject);
		} foreach (["IRangedWeapon",[3464.57,3603.77,18.0835],50,true] call getAllItemsOnPosition);
	};

	func(onMob)
	{
		objParams_1(_mob);
		super();
		_brole = getVar(_mob,basicRole);
		if (callFunc(_brole,getClassName) in ["RCookSaloon" arg "RBarmenSaloon" arg "RGromilaSaloon"]) then {
			callFuncParams(_mob,addFirstJoinMessage,"<t size='1.7'>"+getSelf(descRoleplay)+"</t>");
		} else {
			if (count getSelf(listStolenWeapons) > 0) then {
				if prob(60) then {
					_item = getSelf(listStolenWeapons) deleteAt 0;
					getVar(_item,loc) setPosAtl callFunc(_mob,getInitialPos);
					callFunc(_item,replicateObject);
					callFuncParams(_mob,addFirstJoinMessage,"<t size='1.7' color='#C9BF02'>Мне удалось каким-то образом украсть оружие из бара. Оно прямо у меня под ногами!</t>");
				};
			};
		};
	};

endclass

class(GASaloonNoAmmo) extends(BaseGameAspect)
	var(isHidden,true);
	var(name,"Мы всё простреляли");
	var(desc,"Бандиты потратили все патроны на предыдущем деле.");
	var(descRoleplay,"Бандиты потратили все патроны на предыдущем деле.");
	var(allowedModes, ["GMSaloon" arg "GMSaloonV2"]);
	var(weight,_GASaloonNoAmmoWeight);

	func(onRoundBegin)
	{
		objParams();
		private _pos = [3366.23,3705.17,21.0051];
		if isTypeOf(gm_currentMode,GMSaloonV2) then {
			_pos = [3366.31,3743.75,29.3002];
		};
		{
			_mag = _x;
			{delete(_x)} foreach array_copy(getVar(_mag,content));
		} foreach (["IMagazineBase",_pos,10,true] call getAllItemsOnPosition);
	};

	func(onMob)
	{
		objParams_1(_mob);
		super();

		if !(callFunc(getVar(_mob,basicRole),getClassName) in ["RBanditMainSaloon" arg "RBanditMiniSaloon"]) exitWith {};

		{
			delete(_x);
		} foreach ([_mob,"IAmmoBase",true] call getAllItemsInInventory);
		{
			_mag = _x;
			{delete(_x)} foreach array_copy(getVar(_mag,content));
		} foreach ([_mob,"IMagazineBase",true] call getAllItemsInInventory);
		{
			if callFunc(_x,hasMagazine) then {
				_mag = getVar(_x,magazine);
				{delete(_x)} foreach array_copy(getVar(_mag,content));
			};
		} foreach ([_mob,"IRangedWeapon",true] call getAllItemsInInventory);
	};

endclass

/*class(GASaloonSwap) extends(BaseGameAspect)
	var(name,"Махнёмся?");
	var(desc,"Руки и персонал бара поменялись местами.");
	var(descRoleplay,"Бандиты преуспели в захвате бара. Теперь они разносят бибки и брагу. Но где же бывший владелец?");
	var(allowedModes, ["GMSaloon"]);

	func(onActivate)
	{
		objParams();

	};

	func(onMob)
	{
		objParams_1(_mob);
	};

endclass*/

// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

editor_attribute("CodeOnyGamemode")
class(GMHunt) extends(GMBase)
	var(name,"Охота");
	var(desc,"Бомжи пытаются не попасться в лапы истязателей");
	var(descExtended,"Бомжи пытаются не попасться в лапы истязателей.");
	
	var(deadThreshold,20);//порог смертности для завершения раунда
	
	var(aliveHumans,0); //живых людей осталось
	var(ingameBums,0); //бомжей в игре
	var(ingameEaters,0);
	var(ingameNA,0);
	getter_func(isExistsEater,getSelf(ingameEaters) > 0); //событие: жруны
	getter_func(isExistsNA,getSelf(ingameNA) > 0); //событие: карательный отряд

	var(duration,60* 30); //30 мин
	getter_func(isVoteSystemEnabled,false);
	
	getterconst_func(getProbability,70);
	getterconst_func(getReqPlayersMin,2);
	getterconst_func(getReqPlayersMax,10);

		//данные режима
	//имя загружаемой карты
	getterconst_func(getMapName,"Okopovo");
	//имя лобби звука
	getterconst_func(getLobbySoundName,"lobby\First_Steps.ogg");
	//дефолтный бэкграунд
	getterconst_func(getLobbyBackground,PATH_PICTURE("lobby\lobby.paa"));

	//Список ролей для этого режима. Массив строк. Инициализируется во время пикинга режима
	func(getLobbyRoles)
	{
		[
			"RHuntHunter",
			"RHuntBum"
		]
	};
	//Список лейт ролей. Массив строк. Инициализируется во время пикинга режима
	func(getLateRoles)
	{
		[
			"RHuntHunterLate",
			"RHunterEater",
			"RHuntNACleaner"
		]
	};

	//события режима

	//Условие старта раунда
	func(conditionToStart)
	{
		objParams();

		/*#ifdef EDITOR
		if (true) exitWith {true};
		#endif*/

		count getVar(("RHuntHunter") call gm_getRoleObject,contenders_1) > 0 &&
		count getVar(("RHuntBum") call gm_getRoleObject,contenders_1) > 0
	};

	//Возвращает строку почему не вышло
	func(onFailReasonToStart)
	{
		objParams();
		"Нужен хотя-бы 1 охотник и 1 бомжик"
	};

	func(getUnsleepGameInfo)
	{
		objParams();
		super()
	};

	func(preSetup)
	{
		objParams();

	};

	var(door,nullPtr);
	func(postSetup)
	{
		objParams();
		private _door = { 
		if (getVar(_x,name) == "Предвестник ужаса") exitWith { 
			_x; 
		}; 
		} foreach (["IStruct",[3971.71,3969.43,9.78205],5,true,true] call getGameObjectOnPosition);
		if isNullVar(_door) exitWith {
			gm_roundDuration = getSelf(duration);
		};

		setSelf(door,_door);
	};
	
#ifdef EDITOR
gmhunt_debug_canend = false;
#endif

	func(checkFinish)
	{
		objParams();
		
		//door check
		if !isNullReference(getSelf(door)) then {
			private _countHunt = 0;
			{
				if isTypeOf(getVar(_x,basicRole),RHuntHunter) then {
					INC(_countHunt);
				};
			} foreach (["Mob",[3971.71,3969.43,9.78205],5,true,true] call getGameObjectOnPosition);

			if (_countHunt > 0) then {
				callFuncParams(getSelf(door),worldSay,"<t size='1.3' color='#ff0000'>Дверь разрушается под гнетом страха.</t>" arg "info" arg 8);
				delete(getSelf(door));
			};
		};

		#ifdef EDITOR
		if (true && isNullVar(__FLAG__)) exitWith {
			ifcheck(gmhunt_debug_canend,1,0);
		};
		#endif

		if (gm_roundDuration >= getSelf(duration)) exitWith {1};
		if callSelf(isExistsNA) exitWith {
			if (!callSelf(isExistsEater) && (getSelf(aliveHumans) - getSelf(ingameNA)) <= 0) exitWith {
				3
			};
			0
		};
		
		if (callSelf(isExistsEater) && getSelf(aliveHumans) <= 0) exitWith {2};		
		
		if ((getSelf(aliveHumans)) <= 0) exitWith {5};
		if (getSelf(ingameBums) <= 0) exitWith {4};
		0
	};
	
	func(getResultTextOnFinish)
	{
		objParams();
		if(getSelf(finishResult) == 1)exitWith{
			"Началась полная неразбериха. Уцелевшим удалось скрыться из развалин..."
		};
		if (getSelf(finishResult) == 2) exitWith {
			"Жруны сегодня будут сыты!"
		};
		if (getSelf(finishResult) == 3) exitWith {
			"Карательный отряд зачистил развалины."
		};
		if (getSelf(finishResult) == 4) exitWith {
			"Бомжи погибли."
		};
		if (getSelf(finishResult) == 5) exitWith {
			"Все умерли."
		};
		
		"Смена окончена."
	};
	
	func(onFinish)
	{
		objParams();
		super();
	};
	
endclass
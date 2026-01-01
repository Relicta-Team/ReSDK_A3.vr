// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

editor_attribute("CodeOnyGamemode")
class(GMExtended) extends(GMStationBase)
	getterconst_func(isPlayableGamemode,true);
	var(name,"Тихий день");
	var(desc,"Свободный режим. Развлекайтесь");
	var(descExtended,"Ещё один относительно спокойный день.");
	
	var(deadThreshold,20);//порог смертности для завершения раунда
	
	var(duration,60* (60*2)); //2 часа 
	
	getterconst_func(getProbability,30);
	getterconst_func(getReqPlayersMin,6);
	getterconst_func(getReqPlayersMax,30);

	//var(canAddAspect,false); //выключена система аспектов

	func(getUnsleepGameInfo)
	{
		objParams();
		super() + [
			"Ах, этот чистый маленький пещерный городок Грязноямск! Второй по величине город Свободных Поселений, он уступает только столице — Канаве. Все блага умирающей цивилизации представлены здесь в изобилии: электричество, тепло, знаменитый бар ""Кабак"" и система гермозатворов, надёжно охраняющих город от набегов из пещер. Жить здесь куда лучше, чем умирать за пределами города."+sbr+sbr+"Впрочем, как только вы ловите себя на этой мысли — вы понимаете, что сон отходит."+sbr+sbr+"Пришло время просыпаться."
		]
	};

	func(preSetup)
	{
		objParams();

		// init map
		call cave_dirtpitLoad;

		// Items spawned with code 
		["SurgicalExpander",[3789.67,3752.17,25.3659],292.955,false] call createItemInWorld;
		["SurgeryScalpel",[3790.04,3752.22,25.3969],321.039,false] call createItemInWorld;
		["SurgicalSaw",[3789.82,3750.61,25.3659],33.0043,false] call createItemInWorld;
		["Forceps",[3789.82,3751.22,25.3659],null,false] call createItemInWorld;
	};
	
	getterconst_func(escapeRoundResult,3);

	func(checkFinish)
	{
		objParams();
		
		if (getSelf(countDead) >= getSelf(deadThreshold)) exitWith {2};
		if (gm_roundDuration >= getSelf(duration)) exitWith {1};
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
		0
	};

	var(__commonEndResult,str randInt(1,2));

	func(getEndSong)
	{
		objParams_1(_usr);
		private _fr = getSelf(finishResult);
		private _rez = super();
		if (_rez!="") exitWith {_rez};
		"round\endround" + getSelf(__commonEndResult);
	};
	
	func(getResultTextOnFinish)
	{
		objParams();
		if(getSelf(finishResult) == 1)exitWith{
			"Сегодня в Грязноямске ничего не произошло. Может это и к лучшему...."
		};
		if (getSelf(finishResult) == callSelf(escapeRoundResult)) exitwith {
			private _ref = ("escaper_location" call getObjectByRef);
			if isNullReference(_ref) exitwith {"Врата были открыты"};
			private _cntMob = ["Mob",getposatl getVar(_ref,loc),15,true,true] call getMobsOnPosition;
			private _t = "Грязноямск был покинут. Смогли выбраться:";
			{
				_t = _t + sbr + callSelfParams(getCreditsInfo,_x);
			} foreach _cntMob;
			_t
		};
		"За сегодня погибло слишком много... Во истину кровавый день в истории Грязноямска."
	};
	
	func(onFinish)
	{
		objParams();
		super();
	};
	
endclass
#include <..\GameMode.h>

editor_attribute("HiddenClass")
class(GMStationBase) extends(GMBase)
	getterconst_func(isPlayableGamemode,false);
	var(headSecondNames,vec2("","")); //фамилия головы для мужского и женского варианта

	func(preSetup)
	{
		objParams();
	};

	func(postSetup)
	{
		objParams();
	};

	//стандартизированное событие начала раунда
	//!!! Не рекомендуется к использованию
	func(onRoundBegin)
	{
		objParams();
		//init bank money
		private _bank = ["SteelGreenCabinet",[3753.97,3772.06,29.788],4,false] call getGameObjectOnPosition;
		if !isNullReference(_bank) then {

			private _pap = ["Paper",_bank] call createItemInContainer;
			setVar(_pap,name,"Напоминание");


			private _count = randInt(300,1200);

			if ("MoreMoneyInBankAspect" call gm_isAspectSetup) then {
				_count = 3000;
			};

			if ("NoMoneyInBankAspect" call gm_isAspectSetup) exitwith {
				setVar(_pap,name,"Смятая записка");
				setVar(_pap,content,"Тебя развели дуда! Спасибо за эту кучу звяков. Мы богачи а ты - сюсявый бибовед.");
			};

			private _mCnttxt = format["В казне на сегодня %1",[_count,["звяк","звяка","звяков"],true] call toNumeralString];
			setVar(_pap,content,"Для размена бряков на звяки обращаться к торгашу." +sbr+_mCnttxt);

			callFuncParams(_bank,initMoney,_count arg true);
		};

		//start generator
		private _gen = ["PowerGenerator",[3827.37,3728.61,17.0241],4,false] call getGameObjectOnPosition;
		if !isNullReference(_gen) then {
			callFunc(_gen,beginUpdateGenerator);
		};

		if (count cm_allClients >= 30) then {	
			setSelf(duration,60* (60*3));
			setSelf(deadThreshold,35);
		};

		_ladders = ["LadderBase"] call getAllObjectsInWorldTypeOf;
		_sewercover = ["SewercoverBase"] call getAllObjectsInWorldTypeOf;
		if (count _ladders == count _sewercover) then {
			_sewercover = array_shuffle(_sewercover);
			{
				private _curlad = _ladders select _forEachIndex;
				private _cursew = _x;
				
				setVar(_curlad,pointTo,_cursew);
				setVar(_cursew,pointTo,_curlad);
			} foreach _sewercover;
		} else {
			errorformat("Collectors initialize error; Count ladders %1; sewercover %2",count _ladders arg count _sewercover);
		};


		//initialize ideology
		callSelf(processInitIdeology);
	};
	
	var(possibleIdeologies,[]);
	getterconst_func(ideologySelectionTimeout,t_asMin(5));
	func(processInitIdeology)
	{
		objParams();
		private _ideologies = getAllObjectsTypeOf(GMStationIdeology);
		setSelf(possibleIdeologies,_ideologies);
		callSelfAfter(_onIdeologyTimeout,callSelf(ideologySelectionTimeout));
		["BasicMob","setSleep",{
			objParams_1(_mode);
			private _hasIdeology = callFunc(gm_currentMode,isPickedIdeology);
			if (!_mode && !_hasIdeology) exitwith {
				callSelfParams(localSay,"<t size='1.7'>Время ещё не пришло. Наш правитель ещё не определился</t>" arg "error");
			};
			
		},"begin",true] call oop_injectToMethod;
	};

	getter_func(isPickedIdeology,!isNullReference(ideology));

	func(_onIdeologyTimeout)
	{
		objParams();
		
		if callSelf(isPickedIdeology) exitwith {};

		private _headRole = "RHead" call gm_getRoleObject;
		{
			callFuncParams(_x,localSay,"Время вышло. Идеология будет выбрана автоматически." arg "system");
		} foreach callFunc(_headRole,getBasicMobs);

		callSelfParams(pickIdeology,"");
	};

	var(ideology,nullPtr);

	func(pickIdeology)
	{
		objParams_1(_selected);
		private _idObject = nullPtr;
		{
			if (_x == _selected) exitwith {
				_idObject = instantiate(_selected);
			};
		} foreach getSelf(possibleIdeologies);

		if isNullReference(_idObject) then {
			_idObject = instantiate(pick getSelf(possibleIdeologies));
		};

		setSelf(ideology,_idObject);

		[format["%1",getVar(_idObject,name)],"event"] call cm_sendOOSMessage;

		callFunc(_idObject,onStarted);
		{
			callFuncParams(_idObject,onApplyToMob,_x);
		} foreach (["BasicMob"] call getAllMobsInWorld);
	};

	func(printRoundStatistic)
	{
		objParams();
		super();
		private _ideology = getSelf(ideology);
		if isNullReference(_ideology) exitwith {};
		private _t = format["Идеология: %1%2%3",getVar(_ideology,name),sbr,getVar(_ideology,desc)];
		[_t,"system"] call cm_sendOOSMessage;
	};

endclass


class(GMStationIdeology) extends(IGamemodeSpecificClass)
	var(name,"Режим правления");
	var(desc,"");

	//событие идеологии применяется к стартовавшим с начала
	func(onApplyToMob)
	{
		objParams_1(_mob);
	};

	//Событие идеологии применяется к стартовавшим в прогрессе
	func(onLateApplyToMob)
	{
		objParams_1(_mob);
	};

	//событие, вызываемое при старте идеологии
	func(onStarted)
	{
		objParams();
	};

	func(onEndgame)
	{
		objParams();
	};

endclass
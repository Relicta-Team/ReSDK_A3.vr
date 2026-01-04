// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



region(Memories)

	//Получаем задачи и воспоминания
	func(getMemories)
	{
		objParams();

		if !callSelf(hasBrain) exitWith {};

		private _mem = getVar(callSelf(getBrain),memories);
		if !getVar(_mem,canKnownSelf) exitWith {
			callSelfParams(mindSay, "Я не помню ничего о себе.");
		};

		private _txt = "";
		//_txt = _txt + format["Меня зовут: %1.",callSelfParams(getNameEx,"кто")] + sbr;
		_txt = _txt + format["Я - %1 по имени %2.",
			getVar(getSelf(role),name),
			callSelfParams(getNameEx,"кто")
		] + sbr;
		_txt = _txt + format["Мне %1 %2.",getSelf(age),[getSelf(age),["год","года","лет"]] call toNumeralString];
		

		if (count getSelf(tasks) > 0) then {
			_txt = _txt + sbr + "<t size='1.4'>Мои задачи:";
			private _tpref = "";
			{
				_tpref = "";
				if getVar(_x,isDone) then {
					if (getVar(_x,result) > 0) then {
						_tpref = "<t color='#00ff00'>[выполнено] </t>";
					} else {
						_tpref = "<t color='#ff0000'>[не выполнено] </t>";
					};
				};
				if getVar(_x,customTaskInfo) then {
					private _tdescEx = callFuncParams(_x,getTaskDescription,this);
					if (_tdescEx != "") then {
						modvar(_txt) + sbr + format["    %2%1",_tdescEx,_tpref];
					};
				} else {
					modvar(_txt) + sbr + format["    %3%1: %2",getVar(_x,name),callFuncParams(_x,getTaskDescription,this),_tpref];
				};
			} foreach getSelf(tasks);
			
			modvar(_txt) +"</t>";
		};

		private _mobDesc = callSelf(getDesc);
		if (!isNullVar(_mobDesc) && {_mobDesc!=""}) then {
			modvar(_txt) + sbr + _mobDesc;
		};

		private _mpool = [];
		{
			_mpool pushBack _x;
		} foreach getVar(_mem,messages);

		if (count _mpool > 0) then {
			modvar(_txt) + sbr + "<t color='#5A71A3'>" + (_mpool joinString sbr) + "</t>";
		};

		{
			modvar(_txt) + sbr + _x;
		} foreach getSelf(__firstLoginMesPool);

		if isNullVar(__FLAG_UNSLEEP_INIT__) then {
			callSelfParams(ShowMessageBox,"Text" arg _txt);
		} else {
			private _evcls = {
				setSelf(__isFirstUnsleep,false);
				callSelfParams(setSleep,false);
			};
			callSelfParams(ShowMessageBox,"Text" arg _txt arg null arg null arg _evcls);
		};
		
	};

	func(getMemoriesUNSLEEP)
	{
		objParams();
		//
		private __FLAG_UNSLEEP_INIT__ = true;
		callSelf(getMemories);
	};

	func(getSkillsInfoText)
	{
		objParams();
		if !callSelf(hasBrain) exitWith {};

		private _mem = getVar(callSelf(getBrain),memories);
		if !getVar(_mem,canKnownSelf) exitWith {
			callSelfParams(mindSay, "Я не помню ничего о себе.");
		};

		private _txt = setstyle(callSelf(getLearnedSkillsInfo),style_learnedskills);

		//adding perks info
		private _perksText = callSelfParams(getPerksTextInfo,null);
		if (_perksText != "") then {
			modvar(_txt) + sbr + sbr + format["<t size='0.9'>Мои навыки:%2%1</t>",_perksText,sbr];
		};

		callSelfParams(ShowMessageBox,"Text" arg _txt);
	};

	"
		name:Добавить воспоминание
		desc:Добавляет мобу сообщение, отображаемое в его воспоминаниях. Если у персонажа нет головы или мозга - воспоминание не будет добавлено.
		type:method
		lockoverride:1
		in:string:Воспоминание:Текст воспоминания
		return:int:Индекс добавленного сообщения для возможности последующего удаления.
	" node_met
	func(addMemory)
	{
		objParams_1(_txt);

		if !callSelf(hasBrain) exitWith {-1};
		private _mem = getVar(callSelf(getBrain),memories);
		callFuncParams(_mem,addMemory,_txt);
	};

	"
		name:Удалить воспоминание
		desc:Удаляет воспоминание моба. Если у персонажа нет головы или мозга - воспоминание не будет удалено.
		type:method
		lockoverride:1
		in:int:Индекс:Индекс воспоминания для удаления
		return:bool:Удалено ли воспоминание. Если у персонажа нет мозга или индекс принимает недопустимое значение - возвращает @[bool ЛОЖЬ]
	" node_met
	func(removeMemory)
	{
		objParams_1(_h);
		if !callSelf(hasBrain) exitWith {false};
		private _mem = getVar(callSelf(getBrain),memories);
		callFuncParams(_mem,removeMemory,_h);
	};

endregion


region(Status effects)

	var_array(__allStatusEffects);

	func(handle_statuseffects)
	{
		{
			callFunc(_x,onUpdate);
		} count getSelf(__allStatusEffects);
	};

	func(addStatusEffect)
	{
		objParams_2(_name,_initialData);

		if isNullVar(_initialData) then {_initialData = 0};
		private _typeObj = typeGetFromString(_name);
		if isNullReference(_typeObj) exitWith {
			errorformat("Cant create status effect %1 on %2",_name arg getSelf(pointer));
			false
		};

		if !isTypeNameOf(_name,SEBase) exitWith {
			errorformat("Cant create non-status effect %1 on %2",_name arg getSelf(pointer));
			false
		};

		private _isOneTime = call typeGetVar(_typeObj,isOnetimeStatus);
		//создание не нужно
		if (_isOneTime && callSelfParams(hasStatusEffect,_name)) then {
			private _effect = callSelfParams(getStatusEffect,_name);
			callFuncParams(_effect,onRecreate,_initialData);
		} else {
			private _effect = instantiate(_name);
			setVar(_effect,startTime,tickTime);
			setVar(_effect,loc,this);
			getSelf(__allStatusEffects) pushBack _effect;
			callFuncParams(_effect,onCreate,_initialData);
		};
		true
	};

	func(hasStatusEffect)
	{
		objParams_2(_name,_optCond);
		!isNullReference(callSelfParams(getStatusEffect,_name arg _optCond))
	};

	func(getStatusEffect)
	{
		objParams_2(_name,_optCond);
		private _ref = getSelf(__allStatusEffects);
		private _list = [];
		private _b = false;
		{
			_b = callFunc(_x,getClassName)==_name;
			if (_b)then{_list pushBack _x};
			_b
		} count _ref;
		private _count = count _list;
		if (_count == 0) then {nullPtr} else {

			if isNullVar(_optCond) then {
				_list select 0;
			} else {
				private _idx = _list findif _optCond;
				if (_idx == -1) exitWith {nullPtr};
				_list select _idx;
			};
		};
	};

	func(removeStatusEffect)
	{
		objParams_1(_name);
		private _ref = getSelf(__allStatusEffects);
		private _idx = _ref findif {callFunc(_x,getClassName)==_name};
		if (_idx==-1) exitWith {false};
		private _obj = _ref select _idx;
		delete(_obj);
		true
	};

region(gameinfo)
	var(__gameinfo,[]);
	func(__generateGameInfo)
	{
		objParams();
		private _list = callFunc(gm_currentMode,getUnsleepGameInfo);
		
		if equalTypes(_list,"") then {_list = [_list]};

		if (isNullVar(_list) || {count _list == 0}) exitwith {};
		_list = array_shuffle(_list);
		setSelf(__gameinfo,_list select vec2(0,callFunc(gm_currentMode,getUnsleepMessagesCount)));
	};
	func(__hasGameInfoMessages)
	{
		objParams();
		count getSelf(__gameinfo) > 0
	};
	func(__showGameInfo)
	{
		objParams();
		if !callSelf(__hasGameInfoMessages) exitWith {};
		private _t = getSelf(__gameinfo) deleteat 0;
		private _evcls = {
			if callSelf(__hasGameInfoMessages) then {
				callSelf(__showGameInfo);
			} else {
				callSelfParams(setSleep,false);
			};
		};
		_t = "<t size='1.4' color='#3479E0'>"+_t+"</t>";
		callSelfParams(ShowMessageBox,"Text" arg _t arg null arg null arg _evcls);
	};

	//рантайм добавление подсказок
	func(addUnsleepInfo)
	{
		objParams_1(_text);
		getSelf(__gameinfo) pushBack _text;
	};
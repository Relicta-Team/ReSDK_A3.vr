// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


class(DirtpitEnegryLowEvent) extends(InfluenceEventDirtpit)
	var(name,"Сбой энергии");
	var(desc,"В городе заканчивается энергия");
	var(descRoleplay,"Наблюдаются перебои с электроэнергией.");
	getter_func(isMultiplay,true);
	var(disconnectedData,[]); //vec2(_from,_listOfNodes);

	func(onActivate)
	{
		objParams();
		private _list = null;
		private _precentage = 0;
		private _refData = getSelf(disconnectedData);
		{
			{
				if getVar(_x,edIsNode) then {
					private _sourceNode = _x;
					_list = getVar(_sourceNode,edConnected);
					_list = array_shuffle(_list);
					_precentage = round precentage(count _list - 1,50);
					if (_precentage <= 0) then {continue};

					_list = _list select [0,_precentage];
					private _items = [];
					private _struct = [_sourceNode,_items];
					{
						_items pushBack _x;
						callFuncParams(_x,disconnectFrom,_sourceNode);
					} foreach _list;
					_refData pushback _struct;
				};
				
			} foreach array_copy(getVar(_x,edConnected));

		} foreach (["PowerGenerator",true] call getAllObjectsInWorldTypeOf);

		private _restoreTime = randInt(60 * 10,60 * 30);
		#ifdef EDITOR
		_restoreTime = 30;
		#endif
		callSelfAfter(restoreConnections,_restoreTime);
	};

	func(restoreConnections)
	{
		objParams();
		{
			_x params ["_sourceNode","_items"];
			{
				callFuncParams(_x,connectTo,_sourceNode);
			} foreach _items;
		} foreach getSelf(disconnectedData);
	};


endclass

class(EscapeDirtpitEvent) extends(InfluenceEventDirtpit)
	var(name,"Сбой протокола Расход");
	var(desc,"Автоматически запускает протокол расход если не запущен");
	var(descRoleplay,"Сбой протокола ""Расход"". Запущена аварийная процедура автоматической разблокировки.");
	getter_func(isMultiplay,true);
	func(canPlay)
	{
		objParams();
		private _controls = ["HeadControlPanel",true] call getAllObjectsInWorldTypeOf;
		if (count _controls == 0) exitwith {false};
		({
			!getVar(_x,escapeIsDone) && !getVar(_x,statusEscape)
		} count _controls) > 0
	};
	func(onActivate)
	{
		objParams();
		private _controls = ["HeadControlPanel",true] call getAllObjectsInWorldTypeOf;
		if (count _controls == 0) exitwith {};
		{
			if (!getVar(_x,escapeIsDone) && !getVar(_x,statusEscape)) then {
				callFunc(_x,changeEscapeMode);
				callFuncParams(_x,updateActivity,randInt(60 * 1,60 * 2));
			};	
		} foreach _controls;
	};
endclass

class(GateUnlockEvent) extends(InfluenceEventDirtpit)
	var(name,"Сбой врат");
	var(desc,"Закрытые врата на карте открываются");
	getter_func(isMultiplay,true);
	var(gateList,null);
	func(constructor)
	{
		objParams();
		_gates = ["GateCity",true] call getAllObjectsInWorldTypeOf;
		_gates = _gates - ["gate_escape" call getObjectByRef];
		setSelf(gateList,_gates);

		{
			if (!getVar(_x,isOpen)) then {
				callFunc(_x,onActivate);
			};
		} foreach _gates;
	};

endclass

class(GateBreakEvent) extends(GateUnlockEvent)
	var(name,"Повреждение системы врат");
	var(desc,"Врата открываются и не могут закрыться");
	getter_func(isMultiplay,false);

	func(constructor)
	{
		objParams();
		private _sourceNode = nullPtr;
		{
			_sourceNode = getVar(_x,edOwner);
			callFuncParams(_sourceNode,removeConnection,_x);
		} foreach getSelf(gateList);
	};
endclass

class(MerchantConsoleMoneyLoseEvent) extends(InfluenceEventDirtpit)
	var(name,"Пропажа средств торговца");
	var(desc,"В торговской консоли пропали все средства");
	func(onActivate)
	{
		objParams();
		{
			setVar(_x,money,0);
		} foreach (["MerchantConsole",false] call getAllObjectsInWorldTypeOf)
	};

endclass

class(MoneyInTrashEvent) extends(InfluenceEventDirtpit)
	var(name,"Деньги в мусорках");
	var(desc,"В мусорках можно найти немного звяков");
	func(onActivate)
	{
		objParams();
		{
			if prob(70) then {
				callFuncParams(_x,initMoney,randInt(1,13));
			};
		} foreach (["SmallTrashCan",true] call getAllObjectsInWorldTypeOf);
	};
endclass

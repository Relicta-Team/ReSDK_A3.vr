// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


addCommand("oopinfo",ACCESS_ADMIN) {
	_data = format["GC INFO: Created objects %1; Active objects %2; Thread update %3",oop_cco,oop_cao,oop_upd];
	rpcSendToClient(caller,"chatPrint",vec2(_data,"log"));
};

addCommandWithDescription("spawnitem",ACCESS_ADMIN,"Допустимые аргументы: count; name; stackCount: spawnitem item count 3") {
	checkIfMobExists();
	args = args splitString " ";
	if (count args == 1) exitWith {
		_item = args select 0;
		_posAtl = callSelf(getPos);
		[_item,_posAtl,null,false] call createItemInWorld;
	};
	_item = args deleteAt 0;
	if ((count args %2) != 0) exitWith {
		errorformat("Wrong arguments count: %1",args);
	};

	_posAtl = callSelf(getPos);
	_itm = [_item,_posAtl,null,false] call createItemInWorld;

	#define isvar(x) if (_varName == #x) exitWith
	#define printerr(cause) errorformat("[Command::spawnitem]: " + cause + " - (%1 = %2)",_varName arg _varValue)

	for "_i" from 0 to count args - 1 step 2 do {
		_varName = args select _i;
		_varValue = args select (_i+1);

		call {
			isvar(count) {
				_amount = parseNumber _varValue;
				if (_amount < 1 || _amount > 50) exitWith {
					printerr("Wrong amount");
				};
				for "_ct" from 1 to _amount-1 do {
					[_item,_posAtl,null,false] call createItemInWorld;
				};
			};
			isvar(name) {setVar(_itm,name,_varValue)};
			isvar(stackCount) {
				if callFunc(_itm,isStack) then {
					_amount = parseNumber _varValue;
					if (_amount > getVar(_itm,stackMaxAmount) || _amount < 1) exitWith {
						printerr("Wrong amount");
					};
					setVar(_itm,stackCount,_amount);
					callFunc(_itm,recalculateStackWeight);
				} else {
					printerr("Item is not a stack");
				};
			};

			printerr("Cant find property");
			continue;
		};
	};
};

#ifdef EDITOR
	//Ниже жесткие копии с setpact, getpact
	addCommandWithDescription("setptarg",ACCESS_OWNERS)
	{
		checkIfMobExists();
		callSelf(generateLastInteractOnServer);
		private _item = callSelf(getLastInteractTarget);
		if isNullReference(_item) exitWith {
			callSelfParams(localSay,"Нет объекта" arg "log");
		};
		callSelfParams(localSay,"Start setting values to pointer " + getVar(_item,pointer) arg "log");
		{
			_v = (_x splitString "=");
			if (count _v != 2) then {
				callSelfParams(localSay,"Error on set var. PARSING ERROR: " + _x);
				continue;
			};
			
			_reflectName = (_v select 0)regexReplace [" ",""];
			setVarReflect(_item,_reflectName,call compile(_v select 1));
			_ft = format[" with new value: %1",getVarReflect(_item,_reflectName)];
			callSelfParams(localSay,"Setted var " + _reflectName + _ft arg "log");
			
		} foreach (args splitString ";")
	};
	
	addCommand("getptarg",ACCESS_OWNERS)
	{
		checkIfMobExists();
		callSelf(generateLastInteractOnServer);
		private _item = callSelf(getLastInteractTarget);
		if isNullReference(_item) exitWith {
			callSelfParams(localSay,"Нет объекта" arg "log");
		};
		callSelfParams(localSay,"Start getting values to pointer " + getVar(_item,pointer) arg "log");
		{			
			_reflectName = (_x)regexReplace [" ",""];
			_ft = format[" = %1",getVarReflect(_item,_reflectName)];
			callSelfParams(localSay,"	" + _reflectName + _ft arg "log");
		} foreach (args splitString ";")
	};
	
	addCommand("dumptarg",ACCESS_OWNERS)
	{
		checkIfMobExists();
		callSelf(generateLastInteractOnServer);
		private _item = callSelf(getLastInteractTarget);
		if isNullReference(_item) exitWith {
			callSelfParams(localSay,"Нет объекта" arg "log");
		};
		callSelfParams(localSay,"PTR DUMP INFO:" + getVar(_item,pointer) + "-------------------------------------" arg "log");
		{
			_ft = format[" = %1",getVarReflect(_item,_x)];
			callSelfParams(localSay,"	" + _x + sanitizeHTML(_ft) arg "log");
		} foreach (allVariables _item);
	};

	addCommandWithDescription("setpact",ACCESS_OWNERS,"установить переменную на активную руку: name=""test""; age = 4; etc...")
	{
		checkIfMobExists();
		private _item = callSelf(getItemInActiveHand);
		if isNullReference(_item) exitWith {
			callSelfParams(localSay,"Пустая рука" arg "log");
		};
		callSelfParams(localSay,"Start setting values to pointer " + getVar(_item,pointer) arg "log");
		{
			_v = (_x splitString "=");
			if (count _v != 2) then {
				callSelfParams(localSay,"Error on set var. PARSING ERROR: " + _x);
				continue;
			};
			
			_reflectName = (_v select 0)regexReplace [" ",""];
			setVarReflect(_item,_reflectName,call compile(_v select 1));
			_ft = format[" with new value: %1",getVarReflect(_item,_reflectName)];
			callSelfParams(localSay,"Setted var " + _reflectName + _ft arg "log");
			
		} foreach (args splitString ";")
	};
	
	addCommand("getpact",ACCESS_OWNERS)
	{
		checkIfMobExists();
		private _item = callSelf(getItemInActiveHand);
		if isNullReference(_item) exitWith {
			callSelfParams(localSay,"Пустая рука" arg "log");
		};
		callSelfParams(localSay,"Start getting values to pointer " + getVar(_item,pointer) arg "log");
		{			
			_reflectName = (_x)regexReplace [" ",""];
			_ft = format[" = %1",getVarReflect(_item,_reflectName)];
			callSelfParams(localSay,"	" + _reflectName + _ft arg "log");
		} foreach (args splitString ";")
	};
	
	addCommand("dumpact",ACCESS_OWNERS)
	{
		checkIfMobExists();
		private _item = callSelf(getItemInActiveHand);
		if isNullReference(_item) exitWith {
			callSelfParams(localSay,"Пустая рука" arg "log");
		};
		callSelfParams(localSay,"PTR DUMP INFO:" + getVar(_item,pointer) + "-------------------------------------" arg "log");
		{
			_ft = format[" = %1",getVarReflect(_item,_x)];
			callSelfParams(localSay,"	" + _x + sanitizeHTML(_ft) arg "log");
		} foreach (allVariables _item);
	};

#endif

addCommandWithDescription("data",ACCESS_ADMIN,"Запрос данных об объекте. Для получения помощи введите: data help")
{
	args = args splitString " ";
	if (count args == 0) exitWith {};
	if (count args == 1 && ((args select 0) == "help")) exitWith {
		private _d = [objNUll,"help"] call oop_getData;
		modvar(_d) + sbr+"Первый аргумент это имя клиента. Пример: data User a.b.c d->e.f g.h().i";
		callFuncParams(thisClient,localSay,_d arg "log");
	};
	_name = args deleteAt 0;
	if ("!"in _name) exitWith {
		private _ret = (([_name select [0,count _name]] + args) call oop_getData) joinString sbr;
		callFuncParams(thisClient,localSay,_ret arg "log");
	};
	private _ret = (_name call cm_findClientByName);
	if isNullReference(_ret) exitWith {
		callFuncParams(thisClient,localSay,"ERROR NO OBJECT" arg "error");
	};
	private _mob = getVar(_ret,actor);
	if isNullReference(_mob) exitWith {
		callFuncParams(thisClient,localSay,"ERROR NO ACTOR" arg "error");
	};
	
	private _ret = ((([_mob] + args) call oop_getData) joinString sbr);
	callFuncParams(thisClient,localSay,_ret arg "log");
};
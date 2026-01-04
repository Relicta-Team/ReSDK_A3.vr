// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\GameObjects\GameConstants.hpp>

addCommandWithDescription("returnlobby",ACCESS_ADMIN,"Возвращает выбранного клиента в лобби без уничтожения сущности")
{
	_handler = {
		private _success = false;
		call {
			private _cli = _value call cm_findClientByName;
			if isNullReference(_cli) exitwith {};
			if !callFunc(_cli,isInGame) exitwith {};
			_act = getVar(_cli,actor) getvariable vec2("link",nullPtr);
			if isNullReference(_act) exitwith {};

			[_act,"Lobby"] call cm_switchToMob;
			_success = true;
		};
		callSelf(CloseMessageBox);
		callSelfParams(localSay,"Выполнено - " + ifcheck(_success,"да","нет") arg "system");
	};

	_dat = ["Выберите кого вернуть в лобби:"];
	{
		//#ifndef EDITOR
		//	if equals(_x,thisClient) then {continue};
		//#endif

		_m = getVar(_x,actor) getvariable vec2("link",nullPtr);
		if !isNullReference(_m) then {
			_dat pushback (format["%1|%2",
				callFuncParams(gm_currentMode,getCreditsInfo,_m arg false),
				getVar(_x,name)
			]);
		};
	} foreach (call cm_getAllClientsInGame);
	
	if (count _dat == 1) exitWith {
		callFuncParams(thisClient,localSay,"Пустой список" arg "error");
	};
	callFuncParams(thisClient,ShowMessageBox,"Listbox" arg _dat arg _handler);
};

addCommandWithDescription("tpto",ACCESS_ADMIN,"Телепортироваться к персонажу клиента (если в игре)")
{
	checkIfMobExists();
	_handler = {
		private _success = false;
		call {
			private _cli = _value call cm_findClientByName;
			if isNullReference(_cli) exitwith {};
			if !callFunc(_cli,isInGame) exitwith {};
			_act = getVar(_cli,actor) getvariable vec2("link",nullPtr);
			if isNullReference(_act) exitwith {};

			//callSelfParams(setPos,callFunc(_act,getPos));
			[this,callFunc(_act,getPos)] call teleportMobToPoint;
			
			_success = true;
		};
		callSelf(CloseMessageBox);
		callSelfParams(localSay,"Выполнено - " + ifcheck(_success,"да","нет") arg "system");
	};

	_dat = ["Выберите к кому телепортироваться:"];
	{
		if equals(_x,thisClient) then {continue};

		_m = getVar(_x,actor) getvariable vec2("link",nullPtr);
		if !isNullReference(_m) then {
			_dat pushback (format["%1|%2",
				callFuncParams(gm_currentMode,getCreditsInfo,_m arg false),
				getVar(_x,name)
			]);
		};
	} foreach (call cm_getAllClientsInGame);
	
	if (count _dat == 1) exitWith {
		callSelfParams(localSay,"Пустой список" arg "error");
	};
	callSelfParams(ShowMessageBox,"Listbox" arg _dat arg _handler);
};

addCommandWithDescription("tptome",ACCESS_ADMIN,"Телепортировать персонажа клиента к себе (если в игре)")
{
	checkIfMobExists();
	_handler = {
		private _success = false;
		call {
			private _cli = _value call cm_findClientByName;
			if isNullReference(_cli) exitwith {};
			if !callFunc(_cli,isInGame) exitwith {};
			_act = getVar(_cli,actor) getvariable vec2("link",nullPtr);
			if isNullReference(_act) exitwith {};
			//callFuncParams(_act,setPos,callFunc(this,getPos));
			[_act,callFunc(this,getPos)] call teleportMobToPoint;
			_success = true;
		};
		callSelf(CloseMessageBox);
		callSelfParams(localSay,"Выполнено - " + ifcheck(_success,"да","нет") arg "system");
	};

	_dat = ["Выберите кого телепортировать к себе:"];
	{
		if equals(_x,thisClient) then {continue};

		_m = getVar(_x,actor) getvariable vec2("link",nullPtr);
		if !isNullReference(_m) then {
			_dat pushback (format["%1|%2",
				callFuncParams(gm_currentMode,getCreditsInfo,_m arg false),
				getVar(_x,name)
			]);
		};
	} foreach (call cm_getAllClientsInGame);
	
	if (count _dat == 1) exitWith {
		callSelfParams(localSay,"Пустой список" arg "error");
	};
	callSelfParams(ShowMessageBox,"Listbox" arg _dat arg _handler);
};

addCommandWithDescription("mindmes",ACCESS_ADMIN,"Совесть говорит...")
{

	_h = {
		if (_value == "") exitwith {
			callSelfParams(localSay,"Пустое сообщение" arg "error");
		};

		_handler = {
			private _success = false;
			private _text = getSelf(__internal_mindmes_lastvalue);
			setSelf(__internal_mindmes_lastvalue,null);
			private _name = ifcheck(isTypeOf(this,ServerClient),getSelf(name),getVar(getSelf(client),name));

			call {
				private _cli = _value call cm_findClientByName;
				if isNullReference(_cli) exitwith {};
				if !callFunc(_cli,isInGame) exitwith {};
				_act = getVar(_cli,actor) getvariable vec2("link",nullPtr);
				if isNullReference(_act) exitwith {};
				
				private _m = format["<t size='1.6' color='#52eb34' font='RobotoCondensed'><t color='#52eb34'>Ваша совесть говорит:</t> %1</t>",_text];
				callFuncParams(_act,localSay,_m);
				callFuncParams(_act,playSoundUI,"effects\tension5" arg 1 arg 4);
				_success = true;

				private _mStr = format["(from %1 to %2): %3",_name,getVar(_cli,name),_text];
				["ADMIN_CONS: "+ _mStr] call adminLog;
				["@everyone ADMIN_CONS: "+_mStr] call disc_adminlog_provider;
			};
			callSelf(CloseMessageBox);
			callSelfParams(localSay,"Выполнено - " + ifcheck(_success,"да","нет") arg "system");
		};
		private _dat = ["Выберите кому отправить:"];
		{
			#ifndef EDITOR
			if equals(_x,this) then {continue};
			#endif

			_m = getVar(_x,actor) getvariable vec2("link",nullPtr);
			if !isNullReference(_m) then {
				_dat pushback (format["%1|%2",
					callFuncParams(gm_currentMode,getCreditsInfo,_m arg false),
					getVar(_x,name)
				]);
			};
		} foreach (call cm_getAllClientsInGame);
		
		if (count _dat == 1) exitWith {
			callSelfParams(localSay,"Пустой список" arg "error");
		};
		setSelf(__internal_mindmes_lastvalue,_value);
		callSelfParams(ShowMessageBox,"Listbox" arg _dat arg _handler);
	};
	callFuncParams(thisClient,ShowMessageBox,"Input" arg ["Сначала сообщение"] arg _h);
};

addCommandWithDescription("adminmes",ACCESS_ADMIN,"Админское сообщение человеку")
{
	_h = {
		private _name = ifcheck(isTypeOf(this,ServerClient),getSelf(name),getVar(getSelf(client),name));
		(_value splitString "@") params [["_n",""],["_m",""]];
		private _success = false;
		call {
			if (_n == "") exitwith {};
			if (_m == "") exitwith {};

			_cli = _n call cm_findClientByName;
			if isNullReference(_cli) exitwith {};
			_mes = format["<t size='1.5' color='#C20000'><t align='center'>Сообщение от админа:</t>%3%2</t>",_name,_m,sbr];
			callFuncParams(_cli,localSay,_mes);

			private _ft = format["(from %1 to %2)",_name,getVar(_cli,name)];
			["ADMIN_MES: "+_ft+ (_m)] call adminLog;
			["@everyone ADMIN_MES: "+_ft+_m] call disc_adminlog_provider;

			_success = true;
		};

		callSelfParams(localSay,"Выполнено - " + ifcheck(_success,"да","нет") arg "system");
		callSelf(CloseMessageBox);
	};
	callFuncParams(thisClient,ShowMessageBox,"Input" arg ["Введите сообщение по форме nickname@ message где @ - просто символ разделителя сикея и сообщения"] arg _h);
};

addCommandWithDescription("jonblow",ACCESS_ADMIN,"Взрывает головы юродивым")
{
	checkIfMobExists();
	_handler = {
		private _success = false;
		call {
			private _cli = _value call cm_findClientByName;
			if isNullReference(_cli) exitwith {};
			if !callFunc(_cli,isInGame) exitwith {};
			_act = getVar(_cli,actor) getvariable vec2("link",nullPtr);
			if isNullReference(_act) exitwith {};
			//callFuncParams(_act,setPos,callFunc(this,getPos));
			//[_act,callFunc(this,getPos)] call teleportMobToPoint;
			callFuncParams(_act,destroyLimb,BP_INDEX_HEAD);
			callFuncParams(_act,playSoundUI,"emotes\fart2" arg 1 arg 4);
			private _mobName = callFuncParams(_act,getNameEx,"кого");
			callFuncParams(_act,worldSay,"<t size='2.0' color='#f41cff'>" + "У " + _mobName + " заканчивается томная жизнь</t>");
			callFuncParams(_act,localSay,"<t size='3.0' color='#ff0000'>ВЫ КОНЧЕНЫЙ ВАС НЕНАВИДЯТ</t>");			
			_success = true;
		};
		callSelf(CloseMessageBox);
		callSelfParams(localSay,"Выполнено - " + ifcheck(_success,"да","нет") arg "system");
	};

	_dat = ["Выберите кто будет освобожден от РП процесса:"];
	{
		//if equals(_x,thisClient) then {continue};

		_m = getVar(_x,actor) getvariable vec2("link",nullPtr);
		if !isNullReference(_m) then {
			_dat pushback (format["%1|%2",
				callFuncParams(gm_currentMode,getCreditsInfo,_m arg false),
				getVar(_x,name)
			]);
		};
	} foreach (call cm_getAllClientsInGame);
	
	if (count _dat == 1) exitWith {
		callSelfParams(localSay,"Пустой список" arg "error");
	};
	callSelfParams(ShowMessageBox,"Listbox" arg _dat arg _handler);
};


//only owners cmd
addCommand("addpoints",ACCESS_OWNERS)
{
	(args splitString " ")params["_cli","_num"];
	_targ = _cli call cm_findClientByName;
	if isNullReference(_targ) exitwith {};
	_num = round parseNumber _num;
	if (_num < 1) exitwith {};
	callFuncParams(_targ,addPoints,_num);
	callFuncParams(thisClient,localSay,"ok" arg "system");
};

addCommand("rempoints",ACCESS_OWNERS)
{
	(args splitString " ")params["_cli","_num"];
	_targ = _cli call cm_findClientByName;
	if isNullReference(_targ) exitwith {};
	_num = round parseNumber _num;
	if (_num < 1) exitwith {};
	callFuncParams(_targ,removePoints,_num);
	callFuncParams(thisClient,localSay,"ok" arg "system");
};

addCommandWithDescription("setdiscordroleprotect",ACCESS_ADMIN,"Включить или выключить доступ к ролям от дискорд ролей")
{
	private _oldval = dsm_accounts_enableRoleAccessCheck;
	
	dsm_accounts_enableRoleAccessCheck = (parseNumber args) > 0;

	if not_equals(dsm_accounts_enableRoleAccessCheck,_oldval) then {
		[format["<t size='1.6'>%1 %2 систему доступа к ролям от дискорд ролей</t>",getVar(thisClient,name),ifcheck(dsm_accounts_enableRoleAccessCheck,"включил","выключил")],"system"] call cm_sendLobbyMessage;
	};
};
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
days
NNN hours
NNN minutes
NNN months
NNN years
*/
addCommandWithDescription("ban",ACCESS_ADMIN,"модификаторы (name;reason;days;hours;minutes;months;years) (модификаторы времени - до 4 штук, без мод. времени - перманентный бан); Прим: ban name:User;years:1;days:30;reason:Причина бана")
{
	forceUnicode 1;

	private _error = 0;
	private _errorCtx = "";
	private _mapCmd = hashMapNew;
	private _modifMap = [];
	private _reason = "";
	private _name = "";
	private _errormap = [
		"token_count_error",
		"key_double_defined",
		"value_out_of_range",
		"time_modif_max_value",
		"key_not_found",
		"name_not_defined"
	];
	//parse command
	{
		if (_error!=0) exitWith {};
		_toks = (_x splitString ":");
		if (count _toks != 2) exitWith {_error = 1};
		_toks params ["_key","_val"];
		_key = toLower _key;
		if (_key in _mapCmd) exitWith {
			_error = 2;
		};

		call {
			if (_key == "name") exitWith {
				_mapCmd set [_key,_val];
				_name = _val;
			};
			if (_key in ["days","hours","minutes","months","years"]) exitWith {
				_val = parseNumber _val;
				if (_val <= 0 || _val > 999) exitWith {_error = 3};
				_mapCmd set [_key,_val];
				_modifMap pushBack [_key,_val];
			};
			if (_key == "reason") exitWith {
				_mapCmd set [_key,_val];
				_reason = _val;
			};
			_error = 5;
			_errorCtx = _key;
		};
	} foreach (args splitString ";");

	if (count _modifMap > 4) then {_error = 4};

	if (_name == "") then {_error = 6};

	if (_error!=0) exitWith {
		callFuncParams(thisClient,localSay,"Ошибка бана: " + (_errormap select (_error-1))+"; ctx: "+ str _errorCtx arg "log");
	};

	private _banResult = [thisClient,_name,_reason,_modifMap] call db_banByName;
	callFuncParams(thisClient,localSay,_banResult arg "log");
	
	[format["ADMIN_BAN (%1): %2",getVar(thisClient,name),_banResult]] call disc_adminlog_provider;
	[format["ADMIN_BAN (%1): %2",getVar(thisClient,name),_banResult]] call adminLog;
};

addCommand("unban",ACCESS_ADMIN) {
	private _unbanResult = [args,thisClient] call db_unbanByName;
	[format["ADMIN_UNBAN (%1): %2",getVar(thisClient,name),_unbanResult]] call disc_adminlog_provider;
	[format["ADMIN_UNBAN (%1): %2",getVar(thisClient,name),_unbanResult]] call adminLog;
};

// name:User;years:1;days:30;reason:Причина бана
addCommandWithDescription("roleban",ACCESS_ADMIN,"Работает по аналогии с банами аккаунтов: name:User;role:RHead;Reason: Причина;days:4; - Временные модификаторы до 4х штук")
{
	forceUnicode 1;

	private _error = 0;
	private _errorCtx = "";
	private _mapCmd = hashMapNew;
	private _modifMap = [];
	private _reason = "";
	private _name = "";
	private _role = "";
	private _errormap = [
		"token_count_error",
		"key_double_defined",
		"value_out_of_range",
		"time_modif_max_value",
		"key_not_found",
		"name_not_defined",
		"role_not_defined",
		"role_not_exist"
	];
	//parse command
	{
		if (_error!=0) exitWith {};
		_toks = (_x splitString ":");
		if (count _toks != 2) exitWith {_error = 1};
		_toks params ["_key","_val"];
		_key = toLower _key;
		if (_key in _mapCmd) exitWith {
			_error = 2;
		};

		call {
			if (_key == "name") exitWith {
				_mapCmd set [_key,_val];
				_name = _val;
			};
			if (_key in ["days","hours","minutes","months","years"]) exitWith {
				_val = parseNumber _val;
				if (_val <= 0 || _val > 999) exitWith {_error = 3};
				_mapCmd set [_key,_val];
				_modifMap pushBack [_key,_val];
			};
			if (_key == "reason") exitWith {
				_mapCmd set [_key,_val];
				_reason = _val;
			};
			if (_key == "role") exitWith {
				_role = _val;
			};
			_error = 5;
			_errorCtx = _key;
		};
	} foreach (args splitString ";");

	if (count _modifMap > 4) then {_error = 4};

	if (_name == "") then {_error = 6};
	if isNullReference(_role call gm_getRoleObject) then {_error = 8; _errorCtx = _role};
	if (_role == "") then {_error = 7; _errorCtx = _role};

	if (_error!=0) exitWith {
		callFuncParams(thisClient,localSay,"Ошибка бана: " + (_errormap select (_error-1))+"; ctx: "+ str _errorCtx arg "log");
	};

	_role = callFunc(_role call gm_getRoleObject,getClassName);

	private _banResult = [thisClient,_name,_role,_reason,_modifMap] call db_banJobByName;
	if !isNullVar(_FLAG_EXTERNAL_CMD_JOBBAN_SUCCESS) then {
		_FLAG_EXTERNAL_CMD_JOBBAN_SUCCESS = !("ERROR:" in _banResult);
	};
	[format["ADMIN_ROLE_BAN (%1): %2",getVar(thisClient,name),_banResult]] call disc_adminlog_provider;
	[format["ADMIN_ROLE_BAN (%1): %2",getVar(thisClient,name),_banResult]] call adminLog;
	callFuncParams(thisClient,localSay,_banResult arg "log");
};

addCommandWithDescription("roleunban",ACCESS_ADMIN,"Использование: roleunban User RoleName")
{
	(args splitString " ") params ["_name","_role"];
	private _unbanResult = [thisClient,_name,_role] call db_unbanJobByName;
	callFuncParams(thisClient,localSay,_unbanResult arg "log");
	
	[format["ADMIN_ROLE_UNBAN (%1): %2",getVar(thisClient,name),_unbanResult]] call disc_adminlog_provider;
	[format["ADMIN_ROLE_UNBAN (%1): %2",getVar(thisClient,name),_unbanResult]] call adminLog;
};

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

 ---------------------------------------------- HIGH-LEVEL BAN SYSTEM ---------------------------------------------

 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */



addCommandWithDescription("doban",ACCESS_ADMIN,"открывает бан меню")
{
	_h = {
		private thisClient = ifcheck(isTypeOf(this,ServerClient),this,getSelf(client));
		_success = false;
		call {
			if (":" in _value || ";" in _value) exitwith {};

			_toks = _value splitString endl;
			_txt = "ban ";
			{
				//ban name:User;years:1;days:30;reason:Причина бана
				if (_foreachIndex == 0) then {
					modvar(_txt) + "name:"+_x+";";
				};
				if (_foreachIndex == 1) then {
					modvar(_txt) + "reason:"+_x+";";
				};
				if (_foreachIndex >= 2) then {
					(_x splitString " ") params [["_dnum",""],["_dlet",""]];
					if (_dlet == "" || _dnum == "") exitwith {};

					modvar(_txt) + _dlet+":"+_dnum+";";
				};
			} foreach _toks;

			[thisClient,_txt,true] call cm_processClientCommand;
			_success = true;
		};
		
		callSelfParams(localSay,"Выполнено - " + ifcheck(_success,"да","нет") arg "system");
		callSelf(CloseMessageBox);
	};
	_m = "<t color='#ff0000'>В вводе запрещы символы : и ;</t>"+sbr+
	"На первой строчке ник игрока, на второй причина, далее модификаторы времени. Если время не указано - пермач." +sbr+
	"Модификаторы времени: minutes, hours, days, months, years" + sbr + sbr+"Пример:" + sbr +//days;hours;minutes;months;years
	"TestNickname" + sbr +
	"Забанен по причине пидорас" + sbr +
	"3 days" + sbr +
	"5 hours"; 
	callFuncParams(thisClient,ShowMessageBox,"Input" arg [_m arg "" arg "Забанить"] arg _h);
};

addCommandWithDescription("curjobban",ACCESS_ADMIN,"Блокируем текущую роль выбранному игроку")
{
	_h = {
		private thisClient = ifcheck(isTypeOf(this,ServerClient),this,getSelf(client));
		_success = false;
		_exitText = "Необработанная ошибка внутри cmd roleban";
		call {
			if (":" in _value || ";" in _value) exitwith {_exitText = "Недопустимые символы в переданном тексте: ';' или ':'"};

			_toks = _value splitString endl;
			_txt = "roleban ";
			_name = "";
			{
				//ban name:User;years:1;days:30;reason:Причина бана
				if (_foreachIndex == 0) then {
					modvar(_txt) + "name:"+_x+";";
					_name = _x;
				};
				if (_foreachIndex == 1) then {
					modvar(_txt) + "reason:"+_x+";";
				};
				if (_foreachIndex >= 2) then {
					(_x splitString " ") params [["_dnum",""],["_dlet",""]];
					if (_dlet == "" || _dnum == "") exitwith {};

					modvar(_txt) + _dlet+":"+_dnum+";";
				};
			} foreach _toks;

			private _cliTarget = _name call cm_findClientByName;
			if isNullReference(_cliTarget) exitwith {_exitText = "Не удалось найти клиента по имени '"+_name+"' в онлайне"};
			if !callFunc(_cliTarget,isInGame) exitwith {_exitText = "Клиент '"+_name+"' не находится в игре"};
			_act = getVar(_cliTarget,actor) getvariable vec2("link",nullPtr);
			if isNullReference(_act) exitwith {_exitText = "Не удалось получить персонажа клиента '"+_name+"'"};
			_role = getVar(_act,basicRole);
			if isNullReference(_role) exitwith {_exitText = "Не удалось получить базовую роль у клиента '"+_name+"'"};

			modvar(_txt) + "role:"+callFunc(_role,getClassName);
			private _FLAG_EXTERNAL_CMD_JOBBAN_SUCCESS = false;
			[thisClient,_txt,true] call cm_processClientCommand;
			
			if (_FLAG_EXTERNAL_CMD_JOBBAN_SUCCESS) then {
				//!руками кикаем
				// callFuncParams(_cliTarget,setDeadTimeout,60);
				// callFuncParams(_act,localSay,setstyle("Вам забанили роль - "+getVar(_role,name),style_redbig));
				// [_act,"Lobby"] call cm_switchToMob;
				_success = true;
			};
		};
		
		callSelfParams(localSay,"Выполнено - " + ifcheck(_success,"да","нет")+ ifcheck(_exitText!="","; Текст возврата:"+_exitText,"") arg "system");
		callSelf(CloseMessageBox);
	};
	_m = "<t color='#ff0000'>В вводе запрещы символы : и ;</t>"+sbr+
	"На первой строчке ник игрока, на второй причина, далее модификаторы времени. Если время не указано - пермач." +sbr+
	"Модификаторы времени: minutes, hours, days, months, years" + sbr + sbr+"Пример:" + sbr +//days;hours;minutes;months;years
	"TestNickname" + sbr +
	"Не умеет играть на этой роли" + sbr +
	"3 days" + sbr +
	"5 hours"; 
	callFuncParams(thisClient,ShowMessageBox,"Input" arg [_m arg "" arg "Забанить роль"] arg _h);
};

addCommandWithDescription("jobban",ACCESS_ADMIN,"Открывает меню джоббана. Роли подгружаются из этого режима")
{
	private _handler = {
		private thisClient = ifcheck(isTypeOf(this,ServerClient),this,getSelf(client));
		callSelf(CloseMessageBox);
		private _role = _value;
		setVar(thisClient,__jobban_internal_temp_role,_role);

		private _h = {
			private thisClient = ifcheck(isTypeOf(this,ServerClient),this,getSelf(client));
			_success = false;
			_exitText = "Необработанная ошибка внутри cmd roleban";
			call {
				if (":" in _value || ";" in _value) exitwith {_exitText = "Недопустимые символы в переданном тексте: ';' или ':'"};

				_toks = _value splitString endl;
				_txt = "roleban ";
				_name = "";
				{
					//ban name:User;years:1;days:30;reason:Причина бана
					if (_foreachIndex == 0) then {
						modvar(_txt) + "name:"+_x+";";
						_name = _x;
					};
					if (_foreachIndex == 1) then {
						modvar(_txt) + "reason:"+_x+";";
					};
					if (_foreachIndex >= 2) then {
						(_x splitString " ") params [["_dnum",""],["_dlet",""]];
						if (_dlet == "" || _dnum == "") exitwith {};

						modvar(_txt) + _dlet+":"+_dnum+";";
					};
				} foreach _toks;

				//private _cliTarget = _name call cm_findClientByName;
				//if isNullReference(_cliTarget) exitwith {_exitText = "Не удалось найти клиента по имени '"+_name+"' в онлайне"};
				if equals([_name arg ""]call db_NickToDisId,"") exitwith {
					_exitText = "Ник не найден в базе";
				};
				
				_role = getVar(thisClient,__jobban_internal_temp_role) call gm_getRoleObject;
				if isNullReference(_role) exitwith {_exitText="Системная ошибка. ServerClient.*Runtime*__jobban_internal_temp_role принимает значение null"};

				modvar(_txt) + "role:"+callFunc(_role,getClassName);
				private _FLAG_EXTERNAL_CMD_JOBBAN_SUCCESS = false;
				[thisClient,_txt,true] call cm_processClientCommand;
				
				if (_FLAG_EXTERNAL_CMD_JOBBAN_SUCCESS) then {
					_success = true;
					_exitText = "";
					//!после успешного бана кикайте сами
					// if !callFunc(_cliTarget,isInGame) exitwith {};
					// _act = getVar(_cliTarget,actor) getvariable vec2("link",nullPtr);
					// if isNullReference(_act) exitwith {};
					// if (callFunc(getVar(_act,basicRole),getClassName) == callFunc(_role,getClassName)) then {
					// 	callFuncParams(_cliTarget,setDeadTimeout,60);
					// 	callFuncParams(_act,localSay,setstyle("Вам забанили роль - "+getVar(_role,name),style_redbig));
					// 	[_act,"Lobby"] call cm_switchToMob;
					// };
				};
			};
			
			callSelfParams(localSay,"Выполнено - " + ifcheck(_success,"да","нет") + ifcheck(_exitText!="","; Текст возврата:"+_exitText,"") arg "system");
			callSelf(CloseMessageBox);
		};


		private _m = "<t color='#ff0000'>В вводе запрещы символы : и ;</t>"+sbr+
			"На первой строчке ник игрока, на второй причина, далее модификаторы времени. Если время не указано - пермач." +sbr+
			"Модификаторы времени: minutes, hours, days, months, years" + sbr + sbr+"Пример:" + sbr +//days;hours;minutes;months;years
			"TestNickname" + sbr +
			"Не умеет играть на этой роли" + sbr +
			"3 days" + sbr +
			"5 hours"; 
		callFuncParams(thisClient,ShowMessageBox,"Input" arg [_m arg "" arg "Забанить роль"] arg _h);
	};
	private _dat = ["Выберите какую роль баним:"];
	private _modeObj = null; private _roles = [];
	private _roleObj = null;
	private _uniqueRoles = [];
	private _modeName = "";
	{
		_modeObj = _x call gm_getGameModeObject;
		_roles = callFunc(_modeObj,getLobbyRoles) + callFunc(_modeObj,getLateRoles);
		_modeName = format["%1(%2)",getVar(_modeObj,name),callFunc(_modeObj,getClassName)];
		{
			_roleObj = _x call gm_getRoleObject;
			if !(_x in _uniqueRoles) then {
				_uniqueRoles pushBack _x;
				_dat pushback (format["%4 -> %1(%3)|%2",
					getVar(_roleObj,name),
					callFunc(_roleObj,getClassName),
					callFunc(_roleObj,getClassName),
					_modeName
				]);
			};
		} foreach _roles;

	} foreach (gm_allowedModes);
	
	if (count _dat == 1) exitWith {
		callFuncParams(thisClient,localSay,"Пустой список" arg "error");
	};
	callFuncParams(thisClient,ShowMessageBox,"Listbox" arg _dat arg _handler);
};

addCommandWithDescription("showbans",ACCESS_ADMIN,"Показывает информацию о забаненных ролях человека")
{
	private _disId = [args,""] call db_NickToDisId;
	if (_disId == "") exitwith {};

	private _text = format["Заблокированные роли для %1:",args];
	modvar(_text) + sbr + (([_disId,{
		/* 
	_jobClass - класснейм роли бана
	_addedDate - когда добавлен
	_unbanDate - когда снимется
	_reason - причина бана
	_banner - кто забанил
*/
		format["%1 (%2)%7    - доб:%3;%7    - разбан: %4;%7    Забанил %5 по причине: %6",
			_jobClass,
			getVar(_jobClass call gm_getRoleObject,name),
			_addedDate,
			_unbanDate,_banner,sanitizeHTML(_reason),
			sbr]
	}] call db_getAllBannedRolesWithDescription) joinString sbr);

	callFuncParams(thisClient,ShowMessageBox,"Text" arg _text);
};

addCommandWithDescription("kick",ACCESS_ADMIN,"Кикает игрока с сервера по имени" arg "system")
{
	if (args=="") exitwith {
		callFuncParams(thisClient,localSay,"Не указано имя" arg "system");
	};

	private _cli = args call cm_findClientByName;
	if isNullReference(_cli) exitwith {
		callFuncParams(thisClient,localSay,"Не найден клиент " + args arg "system");
	};

	callFunc(_cli,getOwner) call cm_serverKickById;
	callFuncParams(thisClient,localSay,"Выполнено" arg "system");
};

commands_internal_list_charsettings = [
	["Имя","name"],
	["Пол","gender"],
	["Лицо","face"],
	["Бег","run"], //spr_sync/ cd_sp_lockedSetting
	["Комбат","combat"]
];

commands_internal_convertSettingsToRuName = {
	private _setlist = _this;
	private _out = [];
	{
		private _curset = _x;
		private _fnd = commands_internal_list_charsettings findif {_x select 1 == _curset};
		if (_fnd == -1) then {
			_out pushback (format["Unk::%1",_curset]);
		} else {
			_out pushBack (commands_internal_list_charsettings select _fnd select 0);
		};
	} foreach _setlist;
	_out
};

addCommandWithDescription("bancharsetting",ACCESS_ADMIN,"Забанить человеку определенную настройку персонажа. В параметрах указывается имя аккаунта")
{
	private _disId = [args,""] call db_NickToDisId;
	if (_disId == "") exitwith {
		callFuncParams(thisClient,localSay,"Неизвестное имя" arg "system");
	};

	private _dat = ["Выберите какую настройку баним для '"+args+"':"];
	
	{
		_x params ["_runame","_setname"];
		_dat pushback (format["%1|%2,%3",_runame,_setname,args]);
	} foreach commands_internal_list_charsettings;
	
	private _handler = {
		private thisClient = ifcheck(isTypeOf(this,ServerClient),this,getSelf(client));
		callSelf(CloseMessageBox);
		(_value splitString ",") params ["_setting",["_userName",""]];

		if (_userName=="") exitwith {
			callFuncParams(thisClient,localSay,"Ошибка имени" arg "system");
		};

		private _cli = _userName call cm_findClientByName;
		if !isNullReference(_cli) then {
			if callFunc(_cli,isInLobby) then {
				callFuncParams(_cli,forceDisconnect,"Вам заблокировали одну из настроек персонажа. Перезайдите на сервер.");
			};
			private _delChars = _setting in ["name","gender","face"];
			if (_setting == "name") then {
				callFuncParams(_cli,setCharSetting,"r-name");
			};
			if (_setting == "gender") then {
				callFuncParams(_cli,setCharSetting,_setting arg 0); //reset to man
			};
			if (_setting == "face") then {
				callFuncParams(_cli,setCharSetting,_setting arg "rand"); //set face to random
			};

			if (_setting == "run") then {
				callFuncParams(_cli,fastSendInfo,"cd_sp_lockedSetting" arg true);
				//!callFuncParams(_cli,sendInfo,"spr_sync" arg []);//Пусть синхронизация происходит только при заходе за след.персонажа
			};

			//удаляем всех персонажей...
			if (_delChars) then {
				{
					getVar(_cli,charSettingsTemplates) set [_foreachIndex,null];
				} foreach array_copy(getVar(_cli,charSettingsTemplates));
			};


			//обновляем значение
			private _newidx = getVar(_cli,lockedSettings) pushBackUnique _setting;
			callFuncParams(thisClient,localSay,"Выполнено - " + (str(_newidx!=-1)) arg "system");
		} else {
			private _curlocklist = [_userName] call db_getClientLockedSettings;
			if ((_curlocklist pushBackUnique _setting)!=-1) then {
				[_userName,_curlocklist] call db_updateClientLockedSettings;
			};
		};
	};

	if (count _dat == 1) exitWith {
		callFuncParams(thisClient,localSay,"Пустой список" arg "error");
	};
	callFuncParams(thisClient,ShowMessageBox,"Listbox" arg _dat arg _handler);
};

addCommandWithDescription("unbancharsetting",ACCESS_ADMIN,"Разбанить человеку определенную настройку персонажа")
{
	private _disId = [args,""] call db_NickToDisId;
	if (_disId == "") exitwith {
		callFuncParams(thisClient,localSay,"Неизвестное имя" arg "system");
	};
	private _cli = args call cm_findClientByName;
	if isNullReference(_cli) exitwith {
		callFuncParams(thisClient,localSay,"Не найден клиент на сервере - " + args arg "system");
	};
	private _dat = ["Выберите какую настройку разбаним для '"+args+"':"];
	private _lockRu = getVar(_cli,lockedSettings) call commands_internal_convertSettingsToRuName;
	{
		_dat pushBack (format["%3|%1,%2",_x,args,_lockRu select _foreachIndex]);
	} foreach getVar(_cli,lockedSettings);

	private _handler = {
		private thisClient = ifcheck(isTypeOf(this,ServerClient),this,getSelf(client));
		callSelf(CloseMessageBox);
		(_value splitString ",") params ["_setting",["_userName",""]];

		if (_userName=="") exitwith {
			callFuncParams(thisClient,localSay,"Ошибка имени" arg "system");
		};
		private _cli = _userName call cm_findClientByName;
		if !isNullReference(_cli) then {
			private _remsetidx = getVar(_cli,lockedSettings) find _setting;
			if (_remsetidx!=-1) then {
				getVar(_cli,lockedSettings) deleteAt _remsetidx;
				callFuncParams(thisClient,localSay,"Выполнено удаление заблокированной настройки для "+_userName arg "system");
				if (_setting == "run") then {
					callFuncParams(_cli,fastSendInfo,"cd_sp_lockedSetting" arg false);
				};
			} else {
				callFuncParams(thisClient,localSay,"Настройка "+_setting+" не найдена для "+_userName arg "system");
			};
		} else {
			callFuncParams(thisClient,localSay,"Не найден клиент на сервере - " + _userName arg "system");
		};
	};

	if (count _dat == 1) exitWith {
		callFuncParams(thisClient,localSay,"Пустой список" arg "error");
	};
	callFuncParams(thisClient,ShowMessageBox,"Listbox" arg _dat arg _handler);
};


addCommandWithDescription("getbancharsettings",ACCESS_ADMIN,"Получить заблокированные настройки аккаунта. В параметрах указывается имя аккаунта")
{
	private _list = [];
	private _cli = args call cm_findClientByName;
	if !isNullReference(_cli) then {
		_list = array_copy(getVar(_cli,lockedSettings));
	} else {
		_list = ([args] call db_getClientLockedSettings);
	};
	
	_list = _list call commands_internal_convertSettingsToRuName;

	callFuncParams(thisClient,ShowMessageBox,"Text" arg "Заблокированные настройки для "+args+": "+sbr+(_list joinString sbr));
};
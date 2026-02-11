// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//выклюачем старую систему запроса ролей с диса
#define DISABLE_OLD_DISCORDID_LOAD

//система аккаунтов.
//! Внимание! На рантайме если перелкючать этот флаг, то нужно принудительно вызывать dsm_accounts_loadDiscordId на каждом клиенте в сессии
dsm_accounts_isEnabled = true;

// рантайм система проверки ролей дискорда и ограничения игровых ролей
dsm_accounts_enableRoleAccessCheck = true;

dsm_accounts_canUse = {
	dsm_accounts_isEnabled && dsm_connectedToManager
};

dsm_accounts_mapRegister = createHashMap; //карта регистрации. ключи - токены, значения - данные для регистрации
dsm_accounts_userRequester = createHashMap; //карта юзеров. защита от дублей токенов
dsm_accounts_nickRequester = createHashMap;

dsm_accounts_tokenLifetime = 60 * 5;

//сколько раз нужно зарегаться в городе, чтобы получить роль форсеки
dsm_accounts_arriveInCityCountNeed = 5;

//возвращает результат проверки наличия. вызывается коллбэком
//вызывается из лс сообщений у бота. запрос токена авторизации
//! not used
dsm_accounts_checkSync = {
	params ["_nick","_hash","_chanId","_discordUserId"];
	
	_nick = tolower _nick;

	private _ref = refcreate(0);
	if ([_nick,_ref] call db_da_isSynced) exitwith {
		[_chanId,format["Аккаунт уже привязан к профилю <@%1>",refget(_ref)]] call dsm_sendToChannel;	
	};

	if ([_discordUserId] call db_da_isSyncedAsDiscordId) exitwith {
		[_chanId,format["Повторная регистрация невозможна. Данный аккаунт дискорда уже привязан к профилю <@%1>",_discordUserId]] call dsm_sendToChannel;	
	};

	if (_discordUserId in dsm_accounts_userRequester) exitwith {
		private _timeLeft = (dsm_accounts_userRequester get _discordUserId) - tickTime;
		[_chanId,format["Ваш токен регистрации будет действителен ещё %2 секунд.",_hash,floor _timeLeft]] call dsm_sendToChannel;
	};
	if (_nick in dsm_accounts_nickRequester) exitwith {
		[_chanId,format["На это имя уже создан токен."]] call dsm_sendToChannel;
	};

	if (!([_nick] call db_isNickRegistered)) exitWith {
		[_chanId,format["Никнейм `%1` не зарегистрирован в игре.",_nick]] call dsm_sendToChannel;
	};

	[_chanId,format["Ваш токен регистрации `%1`. Никому не сообщайте его. Зайдите в игру и в окне команд введите команду `discordsync` для активации токена. Токен активен в течении %2 минут.",_hash,dsm_accounts_tokenLifetime/60]] call dsm_sendToChannel;
	
	dsm_accounts_mapRegister set [_hash,[_chanId,_nick,_discordUserId]];
	dsm_accounts_nickRequester set [_nick,null];
	dsm_accounts_userRequester set [_discordUserId,tickTime + (dsm_accounts_tokenLifetime)];
	
	private __postDelete = {
		params ["_nick","_hash","_discordUserId"];
		dsm_accounts_mapRegister deleteAt _hash;
		dsm_accounts_nickRequester deleteAt _nick;
		dsm_accounts_userRequester deleteAt _discordUserId;
	};
	invokeAfterDelayParams(__postDelete,dsm_accounts_tokenLifetime,vec3(_nick,_hash,_discordUserId));
};

//регистрация аккаунта
//выполняет привязку дискорда к учетке и проивзодит синхронизацию ролей
//! not used
dsm_accounts_register = {
	params ["_client","_token"];

	if (!call dsm_accounts_canUse) exitwith {"Функционал отключен"};

	if (!(_token in dsm_accounts_mapRegister)) exitwith {
		format["Неверный токен - '%1'.",_token]
	};

	(dsm_accounts_mapRegister get _token) params ["_chanId","_nick","_discordUserId"];

	if ([_nick] call db_da_isSynced) exitwith {
		format["Ошибка. Ник '%1' уже привязан.",_nick]
	};

	if ([_discordUserId] call db_da_isSyncedAsDiscordId) exitwith {
		"Этот дискорд пользователь уже зарегистрировался."
	};

	if (getVar(_client,name) != _nick) exitWith {
		"Возможна регистрация только для собственного аккаунта"
	};

	//не может выпасть по логике...
	if (!([_nick] call db_isNickRegistered)) exitWith {
		format["Никнейм '%1' не зарегистрирован в базе.",_nick]
	};

	[_nick,_discordUserId] call db_da_register;
	
	setVar(_client,discordIdAcc,_discordUserId);
	setVar(_client,arrivedInCity,0);

	[_chanId,format["Игровой аккаунт `%1` привязан к профилю <@%2>",_nick,_discordUserId]] call dsm_sendToChannel;

	//cleanup data
	dsm_accounts_mapRegister deleteAt _token;
	dsm_accounts_nickRequester deleteAt _nick;
	dsm_accounts_userRequester deleteAt _discordUserId;

	//зарегистрированным игрокам выдаётся двеллер
	callFuncParams(_client,addDiscordRole,"Dweller");

	//roles sync request
	callFunc(_client,requestDiscordRoles);

	format["Игровой аккаунт '%1' привязан к профилю '%2'",_nick,_discordUserId]
};

//загрузка привязки дискорда. Вызывается когда клиент загружается из БД

dsm_accounts_loadDiscordId = {
	params ["_client","_nick"];

	if (!call dsm_accounts_canUse) exitwith {};

	#ifdef DISABLE_OLD_DISCORDID_LOAD
	if (true) exitWith {
		setVar(_client,discordIdAcc,getVar(_client,discordId));
		//setVar(_client,arrivedInCity,0);
		callFunc(_client,requestDiscordRoles);
	};
	#endif

	private _ref = refcreate(0);
	if ([_nick,_ref,true] call db_da_isSynced) then {
		refget(_ref) params [["_disId",""],["_arrived",0]];
		setVar(_client,discordIdAcc,_disId);
		setVar(_client,arrivedInCity,_arrived);
		
		callFunc(_client,requestDiscordRoles);
	};
};

dsm_accounts_list_arriveSessionUnique = [];
//Вызывается когда клиента регистрируют в городе
dsm_accounts_handleRegisterArriveInCity = {
	params ["_cli"];

	if (!call dsm_accounts_canUse) exitwith {};
	
	//защита от слишком частого абуза регистрации
	if (_cli in dsm_accounts_list_arriveSessionUnique) exitWith {};

	dsm_accounts_list_arriveSessionUnique pushBack _cli;
	modVar(_cli,arrivedInCity, + 1);

	//sync in database
	[_cli] call db_da_updateStatArrivedInCity;

	//validate count and adjust role
	if (
		getVar(_cli,arrivedInCity) >= dsm_accounts_arriveInCityCountNeed &&
		{!("Forsaken" in callFunc(_cli,getDiscordRoles))}
	) then {
		callFuncParams(_cli,addDiscordRole,"Forsaken");
	};
};

//запрос в менеджер на обновление ролей
dsm_accounts_requestUpdateRoles = {
	params ["_name","_discordUserId"];
	["pipe_send",["sync_discord_roles",_name,_discordUserId]] call dsm_stdCall;
};

dsm_accounts_addToRole = {
	params ["_discordUserId","_roleName"];
	["pipe_send",["discord_roles_add",_roleName,_discordUserId]] call dsm_stdCall;
};

dsm_accounts_removeFromRole = {
	params ["_discordUserId","_roleName"];
	["pipe_send",["discord_roles_remove",_roleName,_discordUserId]] call dsm_stdCall;
};

//установка никнейма для дискорд клиента
dsm_acconunts_setNickname = {
	params ["_discordUserId","_nickname"];
	["pipe_send",["discord_change_nickname",_nickname,_discordUserId]] call dsm_stdCall;
};

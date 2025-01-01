// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define DB_SETTINGS_SEPARATOR "|"

db_databaseName = "database.rdb";
db_isDatabaseOpened = false;
db_handleDatabaseUpdate = -1;

db_init = {

	if !dbOpen(db_databaseName) exitWith {
		error("Database init fail");
	};

	log("Database init");

	if !dbRead(db_databaseName) exitWith {
		error("Database reading error");
	};

	log("Database readed!");

	private _onDB = {
		dbWrite(db_databaseName)
	};

	db_isDatabaseOpened = true;
	db_handleDatabaseUpdate = startUpdate(_onDB,60);

};

//Закрывает соединение перед выключением сервера
db_closeConnection = {
	if (db_isDatabaseOpened) then {
		stopUpdate(db_handleDatabaseUpdate);
		dbWrite(db_databaseName);
		dbClose(db_databaseName);
	};
};

db_isClientRegistered = {
	params ['this'];
	!isNull(dbGet(db_databaseName,getSelf(uid)))
};

db_registerClient = {
	params ['this'];

	private _uid = getSelf(uid);

	private _clientData = [
		getSelf(name),
		getSelf(access),
		parseSimpleArray str (getSelf(charSettings))
	] joinString DB_SETTINGS_SEPARATOR;

	dbSet(db_databaseName,_uid,_clientData);
};

db_saveClient = {
	params ['this'];

	[this] call db_registerClient;
};

db_loadClient = {
	params ['this'];

	private _clientData_str = dbGet(db_databaseName,getSelf(uid));

	private _clientData = _clientData_str splitString DB_SETTINGS_SEPARATOR;

	if (count _clientData != 3) exitWith {
		errorformat("Error on loading client from database - uid %1",getSelf(uid));
	};

	setSelf(name,_clientData select 0);
	setSelf(access,parseNumber (_clientData select 1));

	private _hasObsoleteSettings = false;
	private _settingsArr = parseSimpleArray (_clientData select 2);
	private _settings = createHashMapFromArray _settingsArr;
	private _roleKey = "";
	
	for "_i" from 1 to 3 do {
		_roleKey = "role"+str _i;
		if (!([_settings get _roleKey] call gm_isDefaultRoleExist) && not_equals(_settings get _roleKey,"none")) then {
			warningformat("db::loadClient() - finded obsolete setting: %1->%2 (client:%3)",_roleKey arg _settings get _roleKey arg getSelf(name));
			_settings set [_roleKey,"none"];
			_hasObsoleteSettings = true;
		};
	};

	setSelf(charSettings,_settings);

	if _hasObsoleteSettings then {
		callSelfParams(localSay,"Одна или несколько настроек не прошли валидацию и были сброшены на значения по-умолчанию" arg "log");
	};
	
	[this] call db_updateClientSettings;
};

//проверяет клиентские настройки. Если что-то не так делает логику...
//При обновлении никнейма, доступа и прочих данных
db_updateClientSettings = {
	params ['this'];
	private _hasModified = false;
	
	//check roles
	private _settings = getSelf(charSettings);
	private _bn = callSelf(getBannedRoles);
	{
		if ((_settings get _x) != "none") then {
			private _robj = (_settings get _x) call gm_getRoleObject;
			if (isNullReference(_robj) || {!callFuncParams(_robj,canTakeInLobby,this arg true)} || {callFuncParams(_robj,isAllowedRoleToClient,this arg _bn)}) then {
				_hasModified = true;
				_settings set [_x,"none"];
			};	
		};	
	} foreach ["role1","role2","role3"];
	
	
	
	if _hasModified then {
		callSelfParams(localSay,"Какие-то настройки были изменены системой." arg "log");
	};
};
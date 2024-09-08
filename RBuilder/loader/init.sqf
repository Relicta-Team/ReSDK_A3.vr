diag_log "[RB] Start initialize engine";

rbuilder_password = "123"; //check password in init.cfg
rbuilder_requireLoad = true;
rbuilder_fatalShutdownServer = {
	[] spawn {
		uisleep 10;
		rbuilder_password serverCommand "#shutdown";
	}
};

//initialize preload module
private _fpp = "preload\init.sqf";
private _fppex = fileExists _fpp;
diag_log (format["[RB] preload found - %1",_fppex]);
if !(_fppex) exitWith {
	diag_log "[RB] Preloading module not found. Fatal exit";
	call rbuilder_fatalShutdownServer;
};
if (ISNIL{call compile preprocessFileLineNumbers _fpp}) exitWith {
	diag_log "[RB] Error on initialize preloading module.";
	call rbuilder_fatalShutdownServer;
};

if (ISNIL{ReBridge_lastError} || {ReBridge_lastError!=""}) exitWith {
	diag_log ("[RB] ReBridge last error: " + ReBridge_lastError);
	call rbuilder_fatalShutdownServer;
};

//loading sources
private _fp = "src\fn_init.sqf";
private _ex = fileExists _fp;
diag_log (format["[RB] sources found - %1",_ex]);
if (_ex) then {
	ISNIL{call compile preprocessFileLineNumbers _fp};
} else {
	diag_log "[RB] Sources not found. Fatal exit";
	call rbuilder_fatalShutdownServer;
};
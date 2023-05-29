clientMob = player;

enableEnvironment false;

if (!isMultiplayer) exitWith {};

if ((count units group clientMob) > 1) then {[clientMob] joinSilent grpnull;};

showHUD [false,false,false,false,false,false,false,false];
titleCut ["","BLACK", 0.001];

clientInit = {
	params ["_sctx_cli","_href"];

	#define apiCall(data) ("url_fetch" callExtension (data))
	#define apiGetStatus() apiCall("OK")

	#define apiOutputIsError(inf) ((inf) == "ERROR")
	#define apiOutputInProgress(inf) ((inf) == "WAIT")
	#define apiOutputIsSuccess(inf) ((inf) == "OK")

	// ------------------------------------------------

	private _status = apiCall(_href);

	if (!apiOutputIsSuccess(_status)) exitWith {
		//error
	};

	private _output = "";
	private _isLoaded = false;

	while {true} do {
		_output = apiGetStatus();
		if apiOutputIsError(_output) exitWith {
			_hasSuccess = false;
		};
		if apiOutputInProgress(_output) then {
			uisleep(0.2);
		} else {
			_isLoaded = true;
			break;
		};
	};

	_output call _sctx_cli

};

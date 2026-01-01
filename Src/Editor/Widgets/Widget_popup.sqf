// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//https://community.bistudio.com/wiki/BIS_fnc_3DENShowMessage
/*
[ 
 "Are you sure you want to delete / modify the selected variables?", 
 "Delete / Modify", 
 [ 
  "Yes", 
  { BIS_Message_Confirmed = true } 
 ], 
 [ 
  "No", 
  { BIS_Message_Confirmed = false } 
 ], 
 "\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa", 
 findDisplay 313 
] call createMessageBox;
*/
function(createMessageBox)
{
	_this call BIS_fnc_3DENShowMessage;
}

/*

text: String - Either text or class from Cfg3DEN >> Notifications
type: Number - (Optional, default 0) 0: Notification (Green) 1: Warning (Red)
duration: Number - (Optional, default 2) Duration in seconds (+ 1 sec for each new line)
animate: Boolean - (Optional, default true) Toggle animation
volume: Number - (Optional, default 1) volume adjustment
*/
function(showInfo)
{
	params ["_text",["_duration",notificationDuration select 0],["_animate",true],["_vol",notificationVolume select 0]];
	[_text] call printLog;
	[_text,0,_duration,_animate,_vol] call playNotificationNative;
}

function(showWarning)
{
	params ["_text",["_duration",notificationDuration select 0],["_animate",true],["_vol",notificationVolume select 0]];
	[_text] call printWarning;
	[_text,1,_duration,_animate,_vol] call playNotificationNative;
}

function(showError)
{
	params ["_text",["_duration",notificationDuration select 0],["_animate",true],["_vol",notificationVolume select 0]];
	[_text] call printError;
	[_text,2,_duration,_animate,_vol] call playNotificationNative;
}

variable_define
	//vec2: cur, default
	notificationWidget = [getEdenDisplay displayCtrl 10312,getEdenDisplay displayCtrl 10312];
	notificationSounds = [
		["3DEN_notificationDefault","3DEN_notificationWarning","3DEN_notificationWarning"],
		["3DEN_notificationDefault","3DEN_notificationWarning","3DEN_notificationWarning"]
	];
	notificationDuration = [2,2];
	notificationVolume = [1,1];

function(setNotificationContext)
{
	params ["_wid","_dur","_soundBank","_volume"];
	if isNullVar(_wid) then {
		_wid = notificationWidget select 1;
	};
	if isNullVar(_dur) then {
		_dur = notificationDuration select 1;
	};
	if isNullVar(_soundBank) then {
		_soundBank = notificationSounds select 1;
	};
	if isNullVar(_volume) then {
		_volume = notificationVolume select 1;
	};	

	notificationWidget set [0,_wid];
	notificationDuration set [0,_dur];
	notificationSounds set [0,_soundBank];
	notificationVolume set [0,_volume];
}

function(playNotificationNative)
{
	private _class = param [0,"",[0,""]];
	private _type = param [1,0,[0,false]];
	private _duration = param [2,-1,[0]];
	private _animate = param [3,true,[true]];
	private _volume = param [4,1,[0]];

	if (typename _class == typename 0) then {
		_class = switch _class do {
			case 0: {"MissionSaved"};
			case 1: {"MissionAutoSaved"};
			case 2: {"VehicleFull"};
			case 3: {"VehicleEnemy"};
			case 4: {"MissionNoPlayer"};
			case 5: {"MissionExportSP"};
			case 6: {"MissionExportMP"};
			case 7: {"MissionExportError"};
			case 8: {"TooltipExported"};
			default {""};
		};
	};

	private _text = _class;
	if (_type isequaltype false) then {_type = parseNumber _type;};
	if (_class != "") then {
		private _cfg = configfile >> "cfg3DEN" >> "Notifications" >> _class;
		if (isclass _cfg) then {
			_text = gettext (_cfg >> "text");
			_type = getnumber (_cfg >> "isWarning");
		};
	};
	_type = _type max 0 min 2;


	private _sounds = notificationSounds select 0;//["3DEN_notificationDefault","3DEN_notificationWarning","3DEN_notificationWarning"];
	playSoundUI [_sounds select _type, _volume];

	if (!is3DEN) exitWith { _type };


	private _colors = ["colorNotificationDefault","colorNotificationError","colorNotificationWarning"];
	//private _display = finddisplay 313;
	private _ctrlNotification = notificationWidget select 0;//_display displayctrl 10312;


	_ctrlNotification ctrlsetstructuredtext parsetext "Schnobble";
	private _ctrlNotificationTextHeight = ctrltextheight _ctrlNotification;

	//set attributes
	if not_equals(_ctrlNotification,notificationWidget select 1) then {
		_text = "<t align='center' color='#ffffff' size='1' font='RobotoCondensedLight'>"+_text+"</t>";
	};

	_ctrlNotification ctrlsetstructuredtext parsetext _text;
	_ctrlNotification ctrlsetbackgroundcolor ((configfile >> "Cfg3DEN" >> "Default" >> "Draw" >> (_colors select _type)) call bis_fnc_colorConfigToRGBA);
	private _ctrlNotificationPos = ctrlposition _ctrlNotification;


	_ctrlNotificationPos set [3,0];
	_ctrlNotification ctrlsetposition _ctrlNotificationPos;
	_ctrlNotification ctrlcommit 0;


	if !(isnil "bis_fnc_3DENNotification_spawn") then {terminate bis_fnc_3DENNotification_spawn;};
	bis_fnc_3DENNotification_spawn = [_ctrlNotification,_ctrlNotificationTextHeight,_duration,_animate] spawn {
		scriptname "BIS_fnc_3DENNotification: Spawn";
		disableserialization;
		_ctrlNotification = _this select 0;
		_ctrlNotificationTextHeight = _this select 1;
		_duration = _this select 2;
		_animate = _this select 3;

		_commitTime = if (_animate) then {0.1} else {0};
		if (_duration < 0) then {_duration = 2 + (ctrltextheight _ctrlNotification / _ctrlNotificationTextHeight);}; 

		_ctrlNotificationPos = ctrlposition _ctrlNotification;
		_ctrlNotificationPos set [3,ctrltextheight _ctrlNotification];
		_ctrlNotification ctrlsetposition _ctrlNotificationPos;
		_ctrlNotification ctrlcommit _commitTime;

		uisleep _duration;
		
		if isNullReference(_ctrlNotification) exitwith {};

		_ctrlNotificationPos set [3,0];
		_ctrlNotification ctrlsetposition _ctrlNotificationPos;
		_ctrlNotification ctrlcommit _commitTime;
	};
	_type
}


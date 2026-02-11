// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

;
	loadingScreen_display = [displayNull];
	loadingScreen_nativeImpl = false; //не включать на деве. может засофтлочить платформу

function(loadingScreen_start)
{
	if (loadingScreen_nativeImpl) exitwith {
		startLoadingScreen ["Загрузка"];
	};
	params [["_parentDisplay",displayNull]];

	if !isNullReference(loadingScreen_display select 0) exitwith {false};

	if isNullReference(_parentDisplay) then {
		_parentDisplay = getEdenDisplay;
	};

	private _d = _parentDisplay createDisplay "RscDisplayEmpty";
	{_x ctrlShow false} foreach (allControls _d);
	
	loadingScreen_display set [0,_d];

	//Старая-добрая копипаста из displayOpen
	_d displayAddEventHandler [
		"keyDown",
		{
			params ["_obj","_key","_shift","_ctrl","_alt"];
			
			//only for debug
			if (_key == KEY_HOME && _shift && cfg_debug_devMode) then {nextFrameParams({(_this select 0) closeDisplay 1},[_obj])};
			
			if (_key == KEY_ESCAPE) then {true;} else {false;}
		}
	];
	private _back = [_d,BACKGROUND,WIDGET_FULLSIZE] call createWidget;
	_d setVariable ["back",_back];
	_back setBackgroundColor [0,0,0,0.8];

	private _sX = 60;
	private _sY = 20;

	private _text = [_d,TEXT,[50-_sX/2,50-_sY/2,_sX,_sY]] call createWidget;
	[_text,"<t align='center' font='RobotoCondensedLight' size='5'>Загрузка</t>"] call widgetSetText;
	_text setBackgroundColor [0.6,0.6,0.6,0.4];
	_d setvariable ["text",_text];

	

	private _ctgDesc = [_d,WIDGETGROUP,[50-_sX/2,50-_sY/2 + _sY,_sX,_sY/2]] call createWidget;
	_d setvariable ["ctgDesc",_ctgDesc];
	private _desc = [_d,TEXT,WIDGET_FULLSIZE,_ctgDesc] call createWidget;
	_desc setBackgroundColor [0,0.2,0,1];
	_d setvariable ["descProgress",_desc];

	private _descTex = [_d,TEXT,WIDGET_FULLSIZE,_ctgDesc] call createWidget;
	//_descTex setBackgroundColor [0,1,0,1];
	_d setvariable ["desc",_descTex];

	true
}

function(loadingScreen_stop)
{
	if (loadingScreen_nativeImpl) exitwith {
		endLoadingScreen;
	};
	private _d = (loadingScreen_display select 0);
	if isNullReference(_d) exitwith {};
	_d closeDisplay 1;
}

function(loadingScreen_setProgress)
{
	params ["_value",["_text",""]];
	if (loadingScreen_nativeImpl) exitwith {
		progressLoadingScreen _value;
	};

	private _d = loadingScreen_display select 0;
	if isNullReference(_d) exitwith {};

	[_d getvariable "descProgress",[0,0,clamp(_value,0,100),100]] call widgetSetPosition;
	[_d getvariable "desc",_text] call widgetSetText;
}
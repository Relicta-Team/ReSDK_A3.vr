// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



ND_INIT(DryChemDisplay)
	_ctg = if (isFirstLoad) then {
		_sx = 18;
		_sy = 30;
		private _ctg = [thisDisplay,WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
		addSavedWdiget(_ctg);

		_back = [thisDisplay,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
		_back setBackgroundColor [0.3,0.3,0.3,0.5];

		_closer = [thisDisplay,[0,90,100,10],_ctg] call nd_addClosingButton;
		_closer ctrlSetText "Закрыть";

		_ctgLeft = [thisDisplay,WIDGETGROUPSCROLLS,[0,0,100,90],_ctg] call createWidget;
		addSavedWdiget(_ctgLeft);

		_ctgLeft
	} else {
		getSavedWidgets select 1
	};

	call nd_cleanupData;
	
	//ctx: name,isLaunchedProcess,isConnectedContainer,edIsEnabled,[timeProcessLeft]
	ctxParams params ["_name","_isLaucnhed","_isConnected","_timeLeft"];
	
	_curY = 0;
	regNDWidget(TEXT,vec4(0,0,100,17),_ctg,null);
	[lastNDWidget,format["<t align='center'>%1</t>",_name]] call widgetSetText;
	lastNDWidget setBackgroundColor [0.6,0.6,0.6,0.9];
	MOD(_curY,+ 17 + 3);
	
	regNDWidget(TEXT,vec4(5,_curY,90,17),_ctg,null);
	[lastNDWidget,format["<t align='center'>Источник: %1</t>",["Не подключен","Подключен"] select _isConnected]] call widgetSetText;
	lastNDWidget setBackgroundColor [0.2,0.2,0.2,0.3];
	MOD(_curY,+ 17);
	
	if (_isLaucnhed && _isConnected) then {
		regNDWidget(TEXT,vec4(5,_curY,90,20),_ctg,null);
		[lastNDWidget,
			if (_timeLeft != 0) then {
				format["<t align='center'>До начала сушки: %1 сек</t>",_timeLeft]
			} else {
				format["<t align='center'>Сушка запущена</t>"]
			}] call widgetSetText;
		lastNDWidget setBackgroundColor [0.2,0.2,0.2,0.3];
	};
	MOD(_curY,+ 20 + 5);
	
	regNDWidget(BUTTON,vec4(20,_curY,60,30),_ctg,null);
	lastNDWidget ctrlSetText (["Включить","Выключить"] select _isLaucnhed);
	lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
		params ["_ct","_bt"];
		if (_bt != MOUSE_LEFT) exitWith {};
		[0] call nd_onPressButton;
	}];
	lastNDWidget setBackgroundColor [0.4,0.11,0.11,0.7];
	MOD(_curY,+ 30);
	
	
ND_END
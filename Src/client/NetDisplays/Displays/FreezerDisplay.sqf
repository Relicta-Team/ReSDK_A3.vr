// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



ND_INIT(FreezerDisplay)

	_ctg = if (isFirstLoad) then {
		_sx = 15;
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
	
	_curY = 0;
	regNDWidget(TEXT,vec4(0,0,100,15),_ctg,null);
	[lastNDWidget,format["<t align='center'>%1</t>",ctxParams deleteat 0]] call widgetSetText;
	lastNDWidget setBackgroundColor [0.4,0.4,0.4,0.8];
	MOD(_curY,+ 15);
	
	/*regNDWidget(TEXT,vec4(0,_curY,100,15),_ctg,null);
	[lastNDWidget,format["<t align='center'>Текущая температура: %1°C</t>",ctxParams deleteat 0]] call widgetSetText;*/
	MOD(_curY,+ 15);
	
	
	/*regNDWidget(TEXT,vec4(0,_curY,100,35),_ctg,null);
	[lastNDWidget,format["<t align='center'>Возможный диапазон: от %1°C до %2°C</t>",ctxParams deleteat 0,ctxParams deleteat 0]] call widgetSetText;*/
	
	MOD(_curY,+ 35);
	/*regNDWidget(BUTTON,vec4(0,_curY,50,15),_ctg,null);
	lastNDWidget ctrlSetText "-";
	lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
		params ["_ct","_bt"];
		if (_bt != MOUSE_LEFT) exitWith {};
		
		[-1] call nd_onPressButton;
	}];
	
	regNDWidget(BUTTON,vec4(50,_curY,50,15),_ctg,null);
	lastNDWidget ctrlSetText "+";
	lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
		params ["_ct","_bt"];
		if (_bt != MOUSE_LEFT) exitWith {};
		
		[1] call nd_onPressButton;
	}];*/
	
	MOD(_curY,+ 15 + 2);
	
	_isEnabled = ctxParams deleteAt 0;
	
	regNDWidget(BUTTON,vec4(0,_curY,100,15),_ctg,null);
	lastNDWidget ctrlSetText (["Включить","Выключить"] select _isEnabled);
	lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
		params ["_ct","_bt"];
		if (_bt != MOUSE_LEFT) exitWith {};
		
		[0] call nd_onPressButton;
	}];
	
ND_END

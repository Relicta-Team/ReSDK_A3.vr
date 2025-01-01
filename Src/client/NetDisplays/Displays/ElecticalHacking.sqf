// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


ND_INIT(ElecticalHacking)

	_ctg = if (isFirstLoad) then {
		_sx = 25;
		_sy = 45;
		private _ctg = [thisDisplay,WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
		addSavedWdiget(_ctg);

		_back = [thisDisplay,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
		_back setBackgroundColor [0.3,0.3,0.3,0.9];

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
	
	regNDWidget(TEXT,vec4(0,_curY,100,8),_ctg,null);
	[lastNDWidget,format["<t align='center'>%1</t>",ctxParams deleteat 0]] call widgetSetText;
	lastNDWidget setBackgroundColor [0.4,0.4,0.4,0.8];

	
	regNDWidget(TEXT,vec4(0,8,50,15-8),_ctg,null);
	[lastNDWidget,format["<t align='center'>%1</t>","Провода"]] call widgetSetText;
	lastNDWidget setBackgroundColor [0.4,0.4,0.4,0.6];
	
	regNDWidget(TEXT,vec4(50,8,50,15-8),_ctg,null);
	[lastNDWidget,format["<t align='center'>%1</t>","Действия"]] call widgetSetText;
	lastNDWidget setBackgroundColor [0.4,0.4,0.4,0.6];
	
	ctxParams params ["_colors","_states"];
	
	MOD(_curY,+ 15);
	

	
	_color = null;
	_actSizeX = 48 / 2;
	{
		_curstate = _states select _forEachIndex;
		_sizeState = if (_curstate == 0) then {10} else {48};
		regNDWidget(TEXT,vec4(2,_curY + 2,_sizeState,8 - 4),_ctg,null);
		//[lastNDWidget,format["<t align='center'>Провод</t>"]] call widgetSetText;
		_color = _x;
		_color pushBack 1;
		lastNDWidget setBackgroundColor _color;
		lastNDWidget setvariable ["wireIndex",_forEachIndex];
		lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			
			[[0,_ct getvariable "wireIndex"]] call nd_onPressButton;
		}];
		
		//actions
		
		regNDWidget(BUTTON,vec4(52 + _actSizeX * 0,_curY,_actSizeX,8),_ctg,null);
		lastNDWidget ctrlSetText "ТЕСТ";
		lastNDWidget setvariable ["wireIndex",_forEachIndex];
		lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			
			[[1,_ct getvariable "wireIndex"]] call nd_onPressButton;
		}];
		
		regNDWidget(TEXT,vec4(52 + _actSizeX * 1,_curY,_actSizeX,8),_ctg,null);
		[lastNDWidget,format["<t align='left'>%1</t>","Вынуть"]] call widgetSetText;
		lastNDWidget ctrlEnable false;
		
		MOD(_curY,+ 8);
	} foreach _colors;
	
	regNDWidget(TEXT,vec4(50,15,2,(_curY-15) max (100-15)),_ctg,null);
	lastNDWidget setBackgroundColor [1,1,1,0.8];
	
ND_END
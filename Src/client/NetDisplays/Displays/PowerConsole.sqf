// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



ND_INIT(PowerConsole)

	_ctg = if (isFirstLoad) then {
		_sx = 70;
		_sy = 70;
		private _ctg = [thisDisplay,WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
		addSavedWdiget(_ctg);
		
		_back = [thisDisplay,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
		_back setBackgroundColor [0.3,0.3,0.3,0.5];
		
		_closer = [thisDisplay,[0,90,100,10],_ctg] call nd_addClosingButton;
		_closer ctrlSetText "Закрыть";
		
		_ctgLeft = [thisDisplay,WIDGETGROUPSCROLLS,[0,0,50,90],_ctg] call createWidget;
		addSavedWdiget(_ctgLeft);
		
		_ctg = [thisDisplay,WIDGETGROUPSCROLLS,[50,0,50,90],_ctg] call createWidget;
		addSavedWdiget(_ctg);
		
		_ctgLeft
	} else {
		getSavedWidgets select 1
	};

	
	call nd_cleanupData;

	_rightCtg = getSavedWidgets select 2;
	regNDWidget(TEXT,vec4(0,0,100,100),_rightCtg,null);
	
	
	[lastNDWidget,format["Резервная мощность: %2 Вт.%1Используется: %3 Вт.%1Выработка: %4 Вт.%1Требуется всего: %5 Вт.",
		sbr,
		(ctxParams deleteat 0) toFixed 0,
		(ctxParams deleteat 0) toFixed 0,
		(ctxParams deleteat 0) toFixed 0,
		(ctxParams deleteat 0) toFixed 0]] call widgetSetText;
	
	_xpos = 0;
	_ypos = 0;
	_wsize = 100;
	_hsize = 8;
	
	_checkEnable = {
		if (_this) then {
			"<t color='#126B0A'>Включен</t>"
		} else {
			"<t color='#D60000'>ВЫКЛЮЧЕН</t>"
		};
	};
	_checkusePower = {
		if (_this) then {
			"<t color='#1271B5'>Питание</t>"
		} else {
			"<t color='#E30981'>НЕТ ПИТАНИЯ</t>"
		};
	};
	
	{
		_x params ["_genName","_isEnabled","_isUsePower"];
		regNDWidget(TEXT,vec4(_xpos,_ypos,_wsize,_hsize),_ctg,null);
		_colback = [0.2,0.8] select _isEnabled;
		lastNDWidget setBackgroundColor [_colback,_colback,_colback,0.3];
		if (!_isEnabled) then {lastNDWidget setFade 0.7; lastNDWidget commit 0};
		
		[lastNDWidget,format["%1 [%2 | %3]",
			_genName,
			_isEnabled call _checkEnable, 
			_isUsePower call _checkusePower
		]
		] call widgetSetText;

		MOD(_ypos,+_hsize);
	} foreach ctxParams;


ND_END

// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\WidgetSystem\widgets.hpp>
#include <..\..\host\engine.hpp>
#include <..\..\host\text.hpp>

namespace(StaminaSystem,stamina_)

decl(void())
stamina_init = {
	private _gui = getGUI;

	_wg = [_gui,WIDGETGROUP,[0 + stamina_bias_x,100 - stamina_size_h - stamina_bias_y,stamina_size_w,stamina_size_h]] call createWidget;
	_wg setVariable ["isVisible",false];
	_wg setFade 1;
	_wg commit 0;

	_bg = [_gui,BACKGROUND,WIDGET_FULLSIZE,_wg] call createWidget;
	_bg setBackgroundColor [0.231,0.459,0.322,1];
	_newCtg = [_gui,WIDGETGROUP,
		[
			stamina_border_size_x,
			stamina_border_size_y,
			100 - stamina_border_size_x * 2,
			100 - stamina_border_size_y * 2
		],_wg] call createWidget;

	_bg3 = [_gui,BACKGROUND,WIDGET_FULLSIZE,_wg] call createWidget;
	_bg3 setBackgroundColor [0.588,0.8,0,0.5];
	_bg3 ctrlEnable true;
	private _visCode = {
		(_this select 0) params ["_wid","_ctg"];

		_precent = (call stamina_convCurToPrec);
		_prec = (_precent / 70) min 1;
		_wid setFade _prec;

		[_wid,[0,rand(-17,+17)],_precent / 1000 - 0.01] call widgetSetPositionOnly;

		ctrlSetFocus (_ctg);

		changeUpdateTime(stamina_heartbeatHandle,_precent / 1000)
	};

	stamina_heartbeatHandle = startUpdateParams(_visCode,0.01,[_bg3 arg _newCtg]);

	_bg2 = [_gui,BACKGROUND,WIDGET_FULLSIZE,_newCtg] call createWidget;
	_bg2 ctrlEnable true;
	_bg2 setBackgroundColor [0,0.718,0.29,1];
	ctrlSetFocus _bg2;

	stamina_widgets = [_bg2,_bg,_wg,_bg3];

	// Время чуть дольше потому что нужно зааплить плавную позицию виджета
	stamina_mainHandle = startUpdate(stamina_onUpdate,stamina_widgetUpdate + 0.001);
};

decl(void())
stamina_onUpdate = {
	//Данный код вызывает ошибку прогресса
	//[getMainBar,[0,0 + rand(-10,10) + stamina_mainbar_size_h / 2]/*,stamina_widgetUpdate / 2*/] call widgetSetPositionOnly;

	_ctg = getCtgBar;
	_precent = call stamina_convCurToPrec;
	if (_precent >= 100) then {
		
		if (_ctg getVariable ["isVisible",false]) then {
			/*if (!(_ctg getVariable ["prepToSetInvisible",false])) then {
				_ctg setVariable ["prepToSetInvisible",true];
				_ctg setVariable ["timeToSetInvisible",tickTime + 5];
			};
			if (tickTime < (_ctg getvariable ["timeToSetInvisible",tickTime + 5])) exitWith {};*/
			_ctg setVariable ["isVisible",false];
			_ctg setFade 1;
			_ctg commit stamina_fadetime_mainctg;
		};
		
	} else {
		if !(_ctg getVariable ["isVisible",false]) then {
			_ctg setVariable ["isVisible",true];
			_ctg setFade 0;
			_ctg commit stamina_fadetime_mainctg;
			
			//_ctg setVariable ["prepToSetInvisible",false];
		};
	};

	if (stamina_lastVal != cd_stamina_cur) then {
		
		call stamina_syncVisual;
		stamina_lastVal = cd_stamina_cur;
	};
};

decl(void(float))
stamina_setValue = {
	params ['_val'];

	private _wid = getMainBar;
	[_wid,[0,0 + stamina_mainbar_size_h / 2,_val,stamina_mainbar_size_h],stamina_widgetUpdate] call widgetSetPosition;
};

stamina_setVisible = {
	params ["_mode"];
	widgetSetFade(getMainBar,ifcheck(_mode,0,1),0);
	widgetSetFade(getBackroundBar,ifcheck(_mode,0,1),0);
	getLowValueBar ctrlShow _mode;
};

decl(float())
stamina_convCurToPrec = {
	(100 * cd_stamina_cur) / cd_stamina_max
};

decl(void())
stamina_syncVisual = {

	[call stamina_convCurToPrec] call stamina_setValue
};

decl(void())
stamina_applyColorTheme = {
	getMainBar setBackgroundColor (["sta_strip"] call ct_getValue);
	getBackroundBar setBackgroundColor (["sta_back"] call ct_getValue);
	getLowValueBar setBackgroundColor (["sta_back_low"] call ct_getValue);
};

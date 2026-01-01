// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

struct(DryChemDisplay) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];
		_ctg = if (_isFirstCall) then {
			_sx = 18;
			_sy = 30;
			private _ctg = [(self getv(thisDisplay)),WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
			self callp(addSavedWidget, _ctg);

			_back = [(self getv(thisDisplay)),BACKGROUND,[0,0,100,100],_ctg] call createWidget;
			_back setBackgroundColor [0.3,0.3,0.3,0.5];

			_closer = [(self getv(thisDisplay)),[0,90,100,10],_ctg] call nd_addClosingButton;
			_closer ctrlSetText "Закрыть";

			_ctgLeft = [(self getv(thisDisplay)),WIDGETGROUPSCROLLS,[0,0,100,90],_ctg] call createWidget;
			self callp(addSavedWidget, _ctgLeft);

			_ctgLeft
		} else {
			(self callv(getSavedWidgets)) select 1
		};

		call nd_cleanupData;
		
		//ctx: name,isLaunchedProcess,isConnectedContainer,edIsEnabled,[timeProcessLeft]
		_args params ["_name","_isLaucnhed","_isConnected","_timeLeft"];
		
		_curY = 0;
		self callp(addWidget, TEXT arg vec4(0,0,100,17) arg _ctg arg null);
		[(self getv(lastNDWidget)),format["<t align='center'>%1</t>",_name]] call widgetSetText;
		(self getv(lastNDWidget)) setBackgroundColor [0.6,0.6,0.6,0.9];
		MOD(_curY,+ 17 + 3);
		
		self callp(addWidget, TEXT arg vec4(5,_curY,90,17) arg _ctg arg null);
		[(self getv(lastNDWidget)),format["<t align='center'>Источник: %1</t>",["Не подключен","Подключен"] select _isConnected]] call widgetSetText;
		(self getv(lastNDWidget)) setBackgroundColor [0.2,0.2,0.2,0.3];
		MOD(_curY,+ 17);
		
		if (_isLaucnhed && _isConnected) then {
			self callp(addWidget, TEXT arg vec4(5,_curY,90,20) arg _ctg arg null);
			[(self getv(lastNDWidget)),
				if (_timeLeft != 0) then {
					format["<t align='center'>До начала сушки: %1 сек</t>",_timeLeft]
				} else {
					format["<t align='center'>Сушка запущена</t>"]
				}] call widgetSetText;
			(self getv(lastNDWidget)) setBackgroundColor [0.2,0.2,0.2,0.3];
		};
		MOD(_curY,+ 20 + 5);
		
		self callp(addWidget, BUTTON arg vec4(20,_curY,60,30) arg _ctg arg null);
		(self getv(lastNDWidget)) ctrlSetText (["Включить","Выключить"] select _isLaucnhed);
		(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			[0] call nd_onPressButton;
		}];
		(self getv(lastNDWidget)) setBackgroundColor [0.4,0.11,0.11,0.7];
		MOD(_curY,+ 30);
		
		
	};

endstruct
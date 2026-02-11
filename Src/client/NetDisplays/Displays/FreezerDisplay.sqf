// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>


struct(FreezerDisplay) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];

		_ctg = if (_isFirstCall) then {
			_sx = 15;
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
		
		_curY = 0;
		self callp(addWidget, TEXT arg vec4(0,0,100,15) arg _ctg arg null);
		[(self getv(lastNDWidget)),format["<t align='center'>%1</t>",_args deleteat 0]] call widgetSetText;
		(self getv(lastNDWidget)) setBackgroundColor [0.4,0.4,0.4,0.8];
		MOD(_curY,+ 15);
		
		/*self callp(addWidget, TEXT arg vec4(0,_curY,100,15) arg _ctg arg null);
		[(self getv(lastNDWidget)),format["<t align='center'>Текущая температура: %1°C</t>",_args deleteat 0]] call widgetSetText;*/
		MOD(_curY,+ 15);
		
		
		/*self callp(addWidget, TEXT arg vec4(0,_curY,100,35) arg _ctg arg null);
		[(self getv(lastNDWidget)),format["<t align='center'>Возможный диапазон: от %1°C до %2°C</t>",_args deleteat 0,_args deleteat 0]] call widgetSetText;*/
		
		MOD(_curY,+ 35);
		/*self callp(addWidget, BUTTON arg vec4(0,_curY,50,15) arg _ctg arg null);
		(self getv(lastNDWidget)) ctrlSetText "-";
		(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			
			[-1] call nd_onPressButton;
		}];
		
		self callp(addWidget, BUTTON arg vec4(50,_curY,50,15) arg _ctg arg null);
		(self getv(lastNDWidget)) ctrlSetText "+";
		(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			
			[1] call nd_onPressButton;
		}];*/
		
		MOD(_curY,+ 15 + 2);
		
		_isEnabled = _args deleteAt 0;
		
		self callp(addWidget, BUTTON arg vec4(0,_curY,100,15) arg _ctg arg null);
		(self getv(lastNDWidget)) ctrlSetText (["Включить","Выключить"] select _isEnabled);
		(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			
			[0] call nd_onPressButton;
		}];
		
	};

endstruct

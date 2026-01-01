// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

struct(ElecticalHacking) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];

		_ctg = if (_isFirstCall) then {
			_sx = 25;
			_sy = 45;
			private _ctg = [(self getv(thisDisplay)),WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
			self callp(addSavedWidget, _ctg);

			_back = [(self getv(thisDisplay)),BACKGROUND,[0,0,100,100],_ctg] call createWidget;
			_back setBackgroundColor [0.3,0.3,0.3,0.9];

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
		
		self callp(addWidget, TEXT arg vec4(0,_curY,100,8) arg _ctg arg null);
		[(self getv(lastNDWidget)),format["<t align='center'>%1</t>",_args deleteat 0]] call widgetSetText;
		(self getv(lastNDWidget)) setBackgroundColor [0.4,0.4,0.4,0.8];

		
		self callp(addWidget, TEXT arg vec4(0,8,50,15-8) arg _ctg arg null);
		[(self getv(lastNDWidget)),format["<t align='center'>%1</t>","Провода"]] call widgetSetText;
		(self getv(lastNDWidget)) setBackgroundColor [0.4,0.4,0.4,0.6];
		
		self callp(addWidget, TEXT arg vec4(50,8,50,15-8) arg _ctg arg null);
		[(self getv(lastNDWidget)),format["<t align='center'>%1</t>","Действия"]] call widgetSetText;
		(self getv(lastNDWidget)) setBackgroundColor [0.4,0.4,0.4,0.6];
		
		_args params ["_colors","_states"];
		
		MOD(_curY,+ 15);
		

		
		_color = null;
		_actSizeX = 48 / 2;
		{
			_curstate = _states select _forEachIndex;
			_sizeState = if (_curstate == 0) then {10} else {48};
			self callp(addWidget, TEXT arg vec4(2,_curY + 2,_sizeState,8 - 4) arg _ctg arg null);
			//[(self getv(lastNDWidget)),format["<t align='center'>Провод</t>"]] call widgetSetText;
			_color = _x;
			_color pushBack 1;
			(self getv(lastNDWidget)) setBackgroundColor _color;
			(self getv(lastNDWidget)) setvariable ["wireIndex",_forEachIndex];
			(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				
				[[0,_ct getvariable "wireIndex"]] call nd_onPressButton;
			}];
			
			//actions
			
			self callp(addWidget, BUTTON arg vec4(52 + _actSizeX * 0,_curY,_actSizeX,8) arg _ctg arg null);
			(self getv(lastNDWidget)) ctrlSetText "ТЕСТ";
			(self getv(lastNDWidget)) setvariable ["wireIndex",_forEachIndex];
			(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				
				[[1,_ct getvariable "wireIndex"]] call nd_onPressButton;
			}];
			
			self callp(addWidget, TEXT arg vec4(52 + _actSizeX * 1,_curY,_actSizeX,8) arg _ctg arg null);
			[(self getv(lastNDWidget)),format["<t align='left'>%1</t>","Вынуть"]] call widgetSetText;
			(self getv(lastNDWidget)) ctrlEnable false;
			
			MOD(_curY,+ 8);
		} foreach _colors;
		
		self callp(addWidget,TEXT arg vec4(50,15,2,(_curY-15) max (100-15)) arg _ctg arg null);
		(self getv(lastNDWidget)) setBackgroundColor [1,1,1,0.8];
		
	};

endstruct
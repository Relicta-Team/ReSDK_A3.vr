// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

struct(TransferStack) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];
	
		//_args = [callSelf(getName),getSelf(stackCount),getSelf(stackMaxAmount),getSelf(pointer)]
		
		_ctg = if (_isFirstCall) then {
			_sx = 30;
			_sy = 30;
			private _ctg = [(self getv(thisDisplay)),WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
			self callp(addSavedWidget, _ctg);
			
			_back = [(self getv(thisDisplay)),BACKGROUND,[0,0,100,100],_ctg] call createWidget;
			_back setBackgroundColor [0.3,0.3,0.3,0.5];
			
			_closer = [(self getv(thisDisplay)),[0,90,100,10],_ctg] call nd_addClosingButton;
			_closer ctrlSetText (pick ["Отмена","Не надо","Расхотелось"]);
				
			_ctg
		} else {
			(self callv(getSavedWidgets)) select 0
		};
		
		call nd_cleanupData;
		
		self callp(addWidget, TEXT arg vec4(0,0,100,20) arg _ctg arg null);
		[(self getv(lastNDWidget)),format["<t align='center'>%1 %2 из %3</t>",_args deleteAt 0,_args select 0,_args select 1]] call widgetSetText;
		
		self callp(addWidget, INPUT arg vec4(0,20,100,40) arg _ctg arg null);
		(self getv(lastNDWidget)) setVariable ["curCount",_args deleteAt 0];
		(self getv(lastNDWidget)) setVariable ["maxCount",_args deleteAt 0];
		
		(self getv(lastNDWidget)) ctrlSetText str (((self getv(lastNDWidget)) getVariable "curCount")-1);
		
		(self getv(lastNDWidget)) ctrlAddEventHandler ["KeyUp",{
			params ["_input","_key"];
			
			_text = parseNumber (ctrlText _input);
			_text = floor _text;
			
			_input ctrlSetText str (_text max 1 min ((_input getvariable "curCount") - 1));
		}];
		_input = (self getv(lastNDWidget));
		
		self callp(addWidget, BUTTON arg vec4(0,20 + 40,100,30) arg _ctg arg null);
		(self getv(lastNDWidget)) ctrlSetText "Разделить";
		(self getv(lastNDWidget)) setVariable ["input",_input];
		
		
		(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
			params ["_bt","_key"];
			
			if (_key == MOUSE_LEFT) then {
				
				//getting text
				_input = _bt getvariable "input";
				
				_amount = parseNumber (ctrlText _input);
				_amount = floor _amount;
				
				[_amount max 1 min ((_input getvariable "curCount") - 1)] call nd_onPressButton;
			};
		}];
		
	};

endstruct
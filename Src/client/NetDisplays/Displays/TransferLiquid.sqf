// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

struct(TransferLiquid) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];
	
		//_args = [callSelf(getName),LIST<getSelf(transferAmount)>]
		
		_ctg = if (_isFirstCall) then {
			_sx = 30;
			_sy = 30;
			private _ctg = [(self getv(thisDisplay)),WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
			self callp(addSavedWidget, _ctg);
			
			_back = [(self getv(thisDisplay)),BACKGROUND,[0,0,100,100],_ctg] call createWidget;
			_back setBackgroundColor [0.3,0.3,0.3,0.5];
			
			_closer = [(self getv(thisDisplay)),[0,90,100,10],_ctg] call nd_addClosingButton;
			_closer ctrlSetText "Закрыть";
			
			_ctg
		} else {
			(self callv(getSavedWidgets)) select 0
		};
		
		call nd_cleanupData;
		
		self callp(addWidget, TEXT arg vec4(0,0,100,20) arg _ctg arg null);
		_curAm = _args select 1;
		[(self getv(lastNDWidget)),format["<t align='center'>%1%2Сколько переливать? (текущ. %3)</t>",_args deleteAt 0,sbr,_args deleteAt 0]] call widgetSetText;
		(self getv(lastNDWidget)) ctrlSetTooltip "Двойное нажатие по элементу списка выберет его";
		
		self callp(addWidget, WIDGETGROUP arg vec4(0,20,100,70) arg _ctg arg null);
		_ctgListbox = (self getv(lastNDWidget));
		
		self callp(addWidget, LISTBOX arg WIDGET_FULLSIZE arg _ctgListbox arg null);
		_list = (self getv(lastNDWidget));
		
		_idx = -1; 
		_selIdx = -1;
		{
			_idx = _list lbAdd str _x;
			_list lbSetData [_idx,str _x];
			if (_x == _curAm) then {_selIdx = _idx};
		} foreach (_args deleteAt 0);
		
		_list setvariable ["lastidx",_selIdx];
		
		_list ctrlAddEventHandler ["MouseButtonUp",{
			_postCheck = {
				params ["_list","_bt"];
				
				if (_bt != MOUSE_LEFT) exitWith {};
				_idx = lbCurSel _list;
				if (_idx < 0) exitWith {};
				if (_idx != (_list getVariable "lastidx")) exitWith {
					_list setVariable ["lastidx",_idx];
				};
				_amount = parseNumber (_list lbData _idx);
				if (_amount <= 0 || _amount >= INFINITY) exitWith {};
				[_amount] call nd_onPressButton;
				nextFrame(nd_onClose);
			};
			nextFrameParams(_postCheck,_this);
		}];
		
		if (_selIdx > -1) then {
			_list lbSetCurSel _selIdx;
		};
		
		//self callp(addWidget, BUTTON arg vec4(0,20 + 30,100,30) arg _ctg arg null);
		//(self getv(lastNDWidget)) ctrlSetText "Перелить";
		
	};

endstruct
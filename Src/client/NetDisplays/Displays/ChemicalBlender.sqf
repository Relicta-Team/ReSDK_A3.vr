// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

struct(ChemicalBlender) base(NDBase)
	
	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];
		private _ctg = if (_isFirstCall) then {
			private _sx = 60;
			private _sy = 60;
			private _ctg = [(self getv(thisDisplay)),WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
			self callp(addSavedWidget, _ctg);

			private _back = [(self getv(thisDisplay)),BACKGROUND,[0,0,100,100],_ctg] call createWidget;
			_back setBackgroundColor [0.3,0.3,0.3,0.9];

			private _closer = [(self getv(thisDisplay)),[0,90,100,10],_ctg] call nd_addClosingButton;
			_closer ctrlSetText "Закрыть";

			private _ctgLeft = [(self getv(thisDisplay)),WIDGETGROUPSCROLLS,[0,0,100,90],_ctg] call createWidget;
			self callp(addSavedWidget, _ctgLeft);

			_ctgLeft
		} else {
			(self callv(getSavedWidgets)) select 1
		};

		call nd_cleanupData;
		
		//_args: name,filled,max,[reagents<Nullable>],isWorking,isEnabled,transferSize,[left:name,filled,max],[right:name,filled,max]
		private _curY = 0;
		self callp(addWidget, TEXT arg vec4(0,0,100,10) arg _ctg arg null);
		[(self getv(lastNDWidget)),format["<t align='center'>%1</t>",_args deleteAt 0]] call widgetSetText;
		(self getv(lastNDWidget)) setBackgroundColor [0.6,0.6,0.6,0.9];
		MOD(_curY,+ 10);
		
		private _startY = _curY;	
		private _contSizeX = 19; //расстояние от границы для левого и правого контейнера
		private _centerZoneSizeX = (100-((_contSizeX+1)*2))/2;
		private _serializedCtg = _ctg;
		
		//creating zone breakers
		self callp(addWidget, BACKGROUND arg vec4(_contSizeX,_curY,1,90) arg _ctg arg null);
		(self getv(lastNDWidget)) setBackgroundColor [0.6,0.6,0.6,0.9];
		
		self callp(addWidget, BACKGROUND arg vec4(100-_contSizeX-1,_curY,1,90) arg _ctg arg null);
		(self getv(lastNDWidget)) setBackgroundColor [0.6,0.6,0.6,0.9];
		
		//not implemented changer reaction type
		//MOD(_curY,+ 14);
		private _sizer = 14;
		private _startYAfterChangeRT = _curY + 14;
		
			private _filled = _args deleteAt 0;
			private _maxSize = _args deleteAt 0;
			
			private _reagents = _args deleteAt 0;
			
			private _isWorking = _args deleteAt 0;
			private _isEnabled = _args deleteAt 0;
			private _transferSize = _args deleteAt 0;
			
			//left and right
			self callp(addWidget, TEXT arg vec4(_contSizeX+1,_curY,_centerZoneSizeX,15+_sizer) arg _ctg arg null);
			if (_isEnabled) then {
				[(self getv(lastNDWidget)),format["<t align='left'>Процесс запущен: %4%1Заполнено: %2%1Вместимость:%3</t>",sbr,_filled,_maxSize,["нет","да"] select _isWorking]] call widgetSetText;
			} else {
				[(self getv(lastNDWidget)),format["<t align='left'>Включите устройство</t>"]] call widgetSetText;
			};
			(self getv(lastNDWidget)) setBackgroundColor [0.1,0.1,0.1,0.9];
			MOD(_curY,+15+_sizer);
			
			
			if (!isNullVar(_reagents) && _isEnabled) then {
				
				self callp(addWidget, BACKGROUND arg vec4(_contSizeX+1,_curY,_centerZoneSizeX,98-_curY) arg _ctg arg null);
				(self getv(lastNDWidget)) setBackgroundColor [0.8,0.8,0.8,0.3];
				
				self callp(addWidget, WIDGETGROUP_H arg vec4(_contSizeX+1,_curY,_centerZoneSizeX,98-_curY) arg _ctg arg null);
				_lrCtg = (self getv(lastNDWidget));

				
				_ySize = 8; //_idx = 0;
				for "_i" from 0 to (count _reagents)-1 step 2 do {
					_rn = _reagents select _i;
					_rc = _reagents select (_i + 1);
					self callp(addWidget, TEXT arg vec4(0,_ySize * _i,100,_ySize) arg _lrCtg arg null);
					[(self getv(lastNDWidget)),format["<t align='left'>%1 : %2</t>",_rn,_rc]] call widgetSetText;
					
					INC(_idx);
				};
				
			};
			
			_curY = _startYAfterChangeRT;
			//create center buttons
			self callp(addWidget, BUTTON arg vec4(_contSizeX+_centerZoneSizeX+1,_curY,_centerZoneSizeX,10) arg _ctg arg null);
			(self getv(lastNDWidget)) ctrlSetText (["Запустить","Остановить"] select _isWorking);
			(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[0] call nd_onPressButton;
			}];
			MOD(_curY,+10);
			
			private _inputSizeX = 12;
			self callp(addWidget, INPUT arg vec4(_contSizeX+_centerZoneSizeX+1,_curY,_inputSizeX,10) arg _ctg arg null);
			(self getv(lastNDWidget)) ctrlSetText str _transferSize;
			(self getv(lastNDWidget)) setVariable ["filled",_filled];
			(self getv(lastNDWidget)) setVariable ["maxSize",_maxSize];
			(self getv(lastNDWidget)) setVariable ["transferSize",_transferSize];
			(self getv(lastNDWidget)) ctrlAddEventHandler ["KeyUp",{
				params ["_input","_key"];
				if (_key in [KEY_PERIOD,KEY_DECIMAL] && !("." in (ctrlText _input))) exitWith {};
				_text = parseNumber (ctrlText _input);
				_text = parseNumber(_text toFixed 2);
				
				_input ctrlSetText str (_text max 0.01 min ((_input getvariable "maxSize")));
				
				if (parseNumber ctrlText _input != (_input getvariable "transferSize")) then {
					_input setBackgroundColor [1,0,0,1];
				} else {
					_input setBackgroundColor [0,0,0,0];
				};
			}];
			_input = (self getv(lastNDWidget));

			
			self callp(addWidget, BUTTON arg vec4(_contSizeX+_centerZoneSizeX+1+_inputSizeX,_curY,_centerZoneSizeX-_inputSizeX,10) arg _ctg arg null);
			(self getv(lastNDWidget)) ctrlSetText "Установить дозу";
			(self getv(lastNDWidget)) setVariable ["input",_input];
			MOD(_curY,+10);
			(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
					
				_amount = parseNumber ctrlText (_ct getVariable "input");
					
				[[1,_amount]] call nd_onPressButton;
			}];
			
			self callp(addWidget, BUTTON arg vec4(_contSizeX+_centerZoneSizeX+1,_curY,_centerZoneSizeX,10) arg _ctg arg null);
			(self getv(lastNDWidget)) ctrlSetText "Очистить";
			MOD(_curY,+10);
			(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[2] call nd_onPressButton;
			}];
			
			self callp(addWidget, BUTTON arg vec4(_contSizeX+_centerZoneSizeX+1,_curY,_centerZoneSizeX,10) arg _ctg arg null);
			(self getv(lastNDWidget)) ctrlSetText "Сделать таблетку";
			MOD(_curY,+10);
			(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[3] call nd_onPressButton;
			}];
			
			self callp(addWidget, BUTTON arg vec4(_contSizeX+_centerZoneSizeX+1,_curY,_centerZoneSizeX,10) arg _ctg arg null);
			(self getv(lastNDWidget)) ctrlSetText "Открыть приёмник таблеток";
			MOD(_curY,+10);
			(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[4] call nd_onPressButton;
			}];
			
			self callp(addWidget, BUTTON arg vec4(_contSizeX+_centerZoneSizeX+1,_curY,_centerZoneSizeX,10) arg _ctg arg null);
			(self getv(lastNDWidget)) ctrlSetText (["Включить","Выключить"] select _isEnabled);
			MOD(_curY,+10);
			(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[5] call nd_onPressButton;
			}];
		
		//left and right holders
		_curY = _startY;
		_leftReagetnInfo = _args deleteAt 0;
		_rightReagetnInfo = _args deleteAt 0;
		
		_hasLeftContainer = !isNullVar(_leftReagetnInfo);
			self callp(addWidget, TEXT arg vec4(0,_curY,_contSizeX,25) arg _ctg arg null);
			(self getv(lastNDWidget)) setBackgroundColor [0.6,0.6,0.6,0.1];
			if (_isEnabled) then {
				if (_hasLeftContainer) then {
					[(self getv(lastNDWidget)),format(["<t align='left'>Левый слот:%1%2 %1Заполнено: %3 из %4</t>",sbr]+_leftReagetnInfo)] call widgetSetText;	
				} else {
					[(self getv(lastNDWidget)),format["<t align='left'>Левый слот:%1Не подключено</t>",sbr]] call widgetSetText;
				};
			} else {
				[(self getv(lastNDWidget)),format["<t align='left'>---</t>",sbr]] call widgetSetText;
			};

			MOD(_curY,+ 25);
			
			self callp(addWidget, BUTTON arg vec4(0,_curY,_contSizeX,10) arg _ctg arg null);
			(self getv(lastNDWidget)) ctrlSetText (if (_hasLeftContainer)then{"Изъять "+(_leftReagetnInfo select 0)}else{"Подключить"});
			(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[[8,0]] call nd_onPressButton;
			}];
			MOD(_curY,+10);
			
			if (_hasLeftContainer && _isEnabled) then {
				self callp(addWidget, BUTTON arg vec4(0,_curY,_contSizeX,10) arg _ctg arg null);
				(self getv(lastNDWidget)) ctrlSetText "Перелить в основной";
				(self getv(lastNDWidget)) ctrlSetTooltip "Транспортирует реагенты внутрь емкости устройства";
				(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
					params ["_ct","_bt"];
					if (_bt != MOUSE_LEFT) exitWith {};
					[[6,0]] call nd_onPressButton;
				}];
				MOD(_curY,+10);
				
				self callp(addWidget, BUTTON arg vec4(0,_curY,_contSizeX,10) arg _ctg arg null);
				(self getv(lastNDWidget)) ctrlSetText "Получить из основного";
				(self getv(lastNDWidget)) ctrlSetTooltip "Транспортирует реагенты из емкости устройства в подсоединённый контейнер";
				(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
					params ["_ct","_bt"];
					if (_bt != MOUSE_LEFT) exitWith {};
					[[7,0]] call nd_onPressButton;
				}];
				MOD(_curY,+10);
				
				self callp(addWidget, BUTTON arg vec4(0,_curY,_contSizeX,10) arg _ctg arg null);
				(self getv(lastNDWidget)) ctrlSetText "Очистить";
				(self getv(lastNDWidget)) ctrlSetTooltip "Удаляет всё содержимое из контейнера";
				(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
					params ["_ct","_bt"];
					if (_bt != MOUSE_LEFT) exitWith {};
					[[9,0]] call nd_onPressButton;
				}];
			};
		
		_curY = _startY;
		
		_hasRightContainer = !isNullVar(_rightReagetnInfo);
			_newxpos = 100-_contSizeX;
			self callp(addWidget, TEXT arg vec4(_newxpos,_curY,_contSizeX,25) arg _ctg arg null);
			(self getv(lastNDWidget)) setBackgroundColor [0.6,0.6,0.6,0.1];
			if (_isEnabled) then {
				if (_hasRightContainer) then {
					[(self getv(lastNDWidget)),format(["<t align='left'>Правый слот:%1%2 %1Заполнено: %3 из %4</t>",sbr]+_rightReagetnInfo)] call widgetSetText;	
				} else {
					[(self getv(lastNDWidget)),format["<t align='left'>Правый слот:%1Не подключено</t>",sbr]] call widgetSetText;
				};
			} else {
				[(self getv(lastNDWidget)),format["<t align='left'>---</t>",sbr]] call widgetSetText;
			};

			MOD(_curY,+ 25);
			
			self callp(addWidget, BUTTON arg vec4(_newxpos,_curY,_contSizeX,10) arg _ctg arg null);
			(self getv(lastNDWidget)) ctrlSetText (if (_hasRightContainer)then{"Изъять "+(_rightReagetnInfo select 0)}else{"Подключить"});
			(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[[8,1]] call nd_onPressButton;
			}];
			MOD(_curY,+10);
			
			if (_hasRightContainer && _isEnabled) then {
				self callp(addWidget, BUTTON arg vec4(_newxpos,_curY,_contSizeX,10) arg _ctg arg null);
				(self getv(lastNDWidget)) ctrlSetText "Перелить в основной";
				(self getv(lastNDWidget)) ctrlSetTooltip "Транспортирует реагенты внутрь емкости устройства";
				(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
					params ["_ct","_bt"];
					if (_bt != MOUSE_LEFT) exitWith {};
					[[6,1]] call nd_onPressButton;
				}];
				MOD(_curY,+10);
				
				self callp(addWidget, BUTTON arg vec4(_newxpos,_curY,_contSizeX,10) arg _ctg arg null);
				(self getv(lastNDWidget)) ctrlSetText "Получить из основного";
				(self getv(lastNDWidget)) ctrlSetTooltip "Транспортирует реагенты из емкости устройства в подсоединённый контейнер";
				(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
					params ["_ct","_bt"];
					if (_bt != MOUSE_LEFT) exitWith {};
					[[7,1]] call nd_onPressButton;
				}];
				MOD(_curY,+10);
				
				self callp(addWidget, BUTTON arg vec4(_newxpos,_curY,_contSizeX,10) arg _ctg arg null);
				(self getv(lastNDWidget)) ctrlSetText "Очистить";
				(self getv(lastNDWidget)) ctrlSetTooltip "Удаляет всё содержимое из контейнера";
				(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
					params ["_ct","_bt"];
					if (_bt != MOUSE_LEFT) exitWith {};
					[[9,1]] call nd_onPressButton;
				}];
			};
	};
	
endstruct
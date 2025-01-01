// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


ND_INIT(ChemicalBlender)
	_ctg = if (isFirstLoad) then {
		_sx = 60;
		_sy = 60;
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
	
	//ctxParams: name,filled,max,[reagents<Nullable>],isWorking,isEnabled,transferSize,[left:name,filled,max],[right:name,filled,max]
	_curY = 0;
	regNDWidget(TEXT,vec4(0,0,100,10),_ctg,null);
	[lastNDWidget,format["<t align='center'>%1</t>",ctxParams deleteAt 0]] call widgetSetText;
	lastNDWidget setBackgroundColor [0.6,0.6,0.6,0.9];
	MOD(_curY,+ 10);
	
	_startY = _curY;	
	_contSizeX = 19; //расстояние от границы для левого и правого контейнера
	_centerZoneSizeX = (100-((_contSizeX+1)*2))/2;
	_serializedCtg = _ctg;
	
	//creating zone breakers
	regNDWidget(BACKGROUND,vec4(_contSizeX,_curY,1,90),_ctg,null);
	lastNDWidget setBackgroundColor [0.6,0.6,0.6,0.9];
	
	regNDWidget(BACKGROUND,vec4(100-_contSizeX-1,_curY,1,90),_ctg,null);
	lastNDWidget setBackgroundColor [0.6,0.6,0.6,0.9];
	
	//not implemented changer reaction type
	//MOD(_curY,+ 14);
	_sizer = 14;
	_startYAfterChangeRT = _curY + 14;
	
		_filled = ctxParams deleteAt 0;
		_maxSize = ctxParams deleteAt 0;
		
		_reagents = ctxParams deleteAt 0;
		
		_isWorking = ctxParams deleteAt 0;
		_isEnabled = ctxParams deleteAt 0;
		_transferSize = ctxParams deleteAt 0;
		
		//left and right
		regNDWidget(TEXT,vec4(_contSizeX+1,_curY,_centerZoneSizeX,15+_sizer),_ctg,null);
		if (_isEnabled) then {
			[lastNDWidget,format["<t align='left'>Процесс запущен: %4%1Заполнено: %2%1Вместимость:%3</t>",sbr,_filled,_maxSize,["нет","да"] select _isWorking]] call widgetSetText;
		} else {
			[lastNDWidget,format["<t align='left'>Включите устройство</t>"]] call widgetSetText;
		};
		lastNDWidget setBackgroundColor [0.1,0.1,0.1,0.9];
		MOD(_curY,+15+_sizer);
		
		
		if (!isNullVar(_reagents) && _isEnabled) then {
			
			regNDWidget(BACKGROUND,vec4(_contSizeX+1,_curY,_centerZoneSizeX,98-_curY),_ctg,null);
			lastNDWidget setBackgroundColor [0.8,0.8,0.8,0.3];
			
			regNDWidget(WIDGETGROUP_H,vec4(_contSizeX+1,_curY,_centerZoneSizeX,98-_curY),_ctg,null);
			_lrCtg = lastNDWidget;

			
			_ySize = 8; //_idx = 0;
			for "_i" from 0 to (count _reagents)-1 step 2 do {
				_rn = _reagents select _i;
				_rc = _reagents select (_i + 1);
				regNDWidget(TEXT,vec4(0,_ySize * _i,100,_ySize),_lrCtg,null);
				[lastNDWidget,format["<t align='left'>%1 : %2</t>",_rn,_rc]] call widgetSetText;
				
				INC(_idx);
			};
			
		};
		
		_curY = _startYAfterChangeRT;
		//create center buttons
		regNDWidget(BUTTON,vec4(_contSizeX+_centerZoneSizeX+1,_curY,_centerZoneSizeX,10),_ctg,null);
		lastNDWidget ctrlSetText (["Запустить","Остановить"] select _isWorking);
		lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			[0] call nd_onPressButton;
		}];
		MOD(_curY,+10);
		
		_inputSizeX = 12;
		regNDWidget(INPUT,vec4(_contSizeX+_centerZoneSizeX+1,_curY,_inputSizeX,10),_ctg,null);
		lastNDWidget ctrlSetText str _transferSize;
		lastNDWidget setVariable ["filled",_filled];
		lastNDWidget setVariable ["maxSize",_maxSize];
		lastNDWidget setVariable ["transferSize",_transferSize];
		lastNDWidget ctrlAddEventHandler ["KeyUp",{
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
		_input = lastNDWidget;

		
		regNDWidget(BUTTON,vec4(_contSizeX+_centerZoneSizeX+1+_inputSizeX,_curY,_centerZoneSizeX-_inputSizeX,10),_ctg,null);
		lastNDWidget ctrlSetText "Установить дозу";
		lastNDWidget setVariable ["input",_input];
		MOD(_curY,+10);
		lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
				
			_amount = parseNumber ctrlText (_ct getVariable "input");
				
			[[1,_amount]] call nd_onPressButton;
		}];
		
		regNDWidget(BUTTON,vec4(_contSizeX+_centerZoneSizeX+1,_curY,_centerZoneSizeX,10),_ctg,null);
		lastNDWidget ctrlSetText "Очистить";
		MOD(_curY,+10);
		lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			[2] call nd_onPressButton;
		}];
		
		regNDWidget(BUTTON,vec4(_contSizeX+_centerZoneSizeX+1,_curY,_centerZoneSizeX,10),_ctg,null);
		lastNDWidget ctrlSetText "Сделать таблетку";
		MOD(_curY,+10);
		lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			[3] call nd_onPressButton;
		}];
		
		regNDWidget(BUTTON,vec4(_contSizeX+_centerZoneSizeX+1,_curY,_centerZoneSizeX,10),_ctg,null);
		lastNDWidget ctrlSetText "Открыть приёмник таблеток";
		MOD(_curY,+10);
		lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			[4] call nd_onPressButton;
		}];
		
		regNDWidget(BUTTON,vec4(_contSizeX+_centerZoneSizeX+1,_curY,_centerZoneSizeX,10),_ctg,null);
		lastNDWidget ctrlSetText (["Включить","Выключить"] select _isEnabled);
		MOD(_curY,+10);
		lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			[5] call nd_onPressButton;
		}];
	
	//left and right holders
	_curY = _startY;
	_leftReagetnInfo = ctxParams deleteAt 0;
	_rightReagetnInfo = ctxParams deleteAt 0;
	
	_hasLeftContainer = !isNullVar(_leftReagetnInfo);
		regNDWidget(TEXT,vec4(0,_curY,_contSizeX,25),_ctg,null);
		lastNDWidget setBackgroundColor [0.6,0.6,0.6,0.1];
		if (_isEnabled) then {
			if (_hasLeftContainer) then {
				[lastNDWidget,format(["<t align='left'>Левый слот:%1%2 %1Заполнено: %3 из %4</t>",sbr]+_leftReagetnInfo)] call widgetSetText;	
			} else {
				[lastNDWidget,format["<t align='left'>Левый слот:%1Не подключено</t>",sbr]] call widgetSetText;
			};
		} else {
			[lastNDWidget,format["<t align='left'>---</t>",sbr]] call widgetSetText;
		};

		MOD(_curY,+ 25);
		
		regNDWidget(BUTTON,vec4(0,_curY,_contSizeX,10),_ctg,null);
		lastNDWidget ctrlSetText (if (_hasLeftContainer)then{"Изъять "+(_leftReagetnInfo select 0)}else{"Подключить"});
		lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			[[8,0]] call nd_onPressButton;
		}];
		MOD(_curY,+10);
		
		if (_hasLeftContainer && _isEnabled) then {
			regNDWidget(BUTTON,vec4(0,_curY,_contSizeX,10),_ctg,null);
			lastNDWidget ctrlSetText "Перелить в основной";
			lastNDWidget ctrlSetTooltip "Транспортирует реагенты внутрь емкости устройства";
			lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[[6,0]] call nd_onPressButton;
			}];
			MOD(_curY,+10);
			
			regNDWidget(BUTTON,vec4(0,_curY,_contSizeX,10),_ctg,null);
			lastNDWidget ctrlSetText "Получить из основного";
			lastNDWidget ctrlSetTooltip "Транспортирует реагенты из емкости устройства в подсоединённый контейнер";
			lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[[7,0]] call nd_onPressButton;
			}];
			MOD(_curY,+10);
			
			regNDWidget(BUTTON,vec4(0,_curY,_contSizeX,10),_ctg,null);
			lastNDWidget ctrlSetText "Очистить";
			lastNDWidget ctrlSetTooltip "Удаляет всё содержимое из контейнера";
			lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[[9,0]] call nd_onPressButton;
			}];
		};
	
	_curY = _startY;
	
	_hasRightContainer = !isNullVar(_rightReagetnInfo);
		_newxpos = 100-_contSizeX;
		regNDWidget(TEXT,vec4(_newxpos,_curY,_contSizeX,25),_ctg,null);
		lastNDWidget setBackgroundColor [0.6,0.6,0.6,0.1];
		if (_isEnabled) then {
			if (_hasRightContainer) then {
				[lastNDWidget,format(["<t align='left'>Правый слот:%1%2 %1Заполнено: %3 из %4</t>",sbr]+_rightReagetnInfo)] call widgetSetText;	
			} else {
				[lastNDWidget,format["<t align='left'>Правый слот:%1Не подключено</t>",sbr]] call widgetSetText;
			};
		} else {
			[lastNDWidget,format["<t align='left'>---</t>",sbr]] call widgetSetText;
		};

		MOD(_curY,+ 25);
		
		regNDWidget(BUTTON,vec4(_newxpos,_curY,_contSizeX,10),_ctg,null);
		lastNDWidget ctrlSetText (if (_hasRightContainer)then{"Изъять "+(_rightReagetnInfo select 0)}else{"Подключить"});
		lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			[[8,1]] call nd_onPressButton;
		}];
		MOD(_curY,+10);
		
		if (_hasRightContainer && _isEnabled) then {
			regNDWidget(BUTTON,vec4(_newxpos,_curY,_contSizeX,10),_ctg,null);
			lastNDWidget ctrlSetText "Перелить в основной";
			lastNDWidget ctrlSetTooltip "Транспортирует реагенты внутрь емкости устройства";
			lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[[6,1]] call nd_onPressButton;
			}];
			MOD(_curY,+10);
			
			regNDWidget(BUTTON,vec4(_newxpos,_curY,_contSizeX,10),_ctg,null);
			lastNDWidget ctrlSetText "Получить из основного";
			lastNDWidget ctrlSetTooltip "Транспортирует реагенты из емкости устройства в подсоединённый контейнер";
			lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[[7,1]] call nd_onPressButton;
			}];
			MOD(_curY,+10);
			
			regNDWidget(BUTTON,vec4(_newxpos,_curY,_contSizeX,10),_ctg,null);
			lastNDWidget ctrlSetText "Очистить";
			lastNDWidget ctrlSetTooltip "Удаляет всё содержимое из контейнера";
			lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt != MOUSE_LEFT) exitWith {};
				[[9,1]] call nd_onPressButton;
			}];
		};
	
ND_END
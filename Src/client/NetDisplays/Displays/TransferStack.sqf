// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



ND_INIT(TransferStack)
	
	//ctxParams = [callSelf(getName),getSelf(stackCount),getSelf(stackMaxAmount),getSelf(pointer)]
	
	_ctg = if (isFirstLoad) then {
		_sx = 30;
		_sy = 30;
		private _ctg = [thisDisplay,WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
		addSavedWdiget(_ctg);
		
		_back = [thisDisplay,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
		_back setBackgroundColor [0.3,0.3,0.3,0.5];
		
		_closer = [thisDisplay,[0,90,100,10],_ctg] call nd_addClosingButton;
		_closer ctrlSetText (pick ["Отмена","Не надо","Расхотелось"]);
			
		_ctg
	} else {
		getSavedWidgets select 0
	};
	
	call nd_cleanupData;
	
	regNDWidget(TEXT,vec4(0,0,100,20),_ctg,null);
	[lastNDWidget,format["<t align='center'>%1 %2 из %3</t>",ctxParams deleteAt 0,ctxParams select 0,ctxParams select 1]] call widgetSetText;
	
	regNDWidget(INPUT,vec4(0,20,100,40),_ctg,null);
	lastNDWidget setVariable ["curCount",ctxParams deleteAt 0];
	lastNDWidget setVariable ["maxCount",ctxParams deleteAt 0];
	
	lastNDWidget ctrlSetText str ((lastNDWidget getVariable "curCount")-1);
	
	lastNDWidget ctrlAddEventHandler ["KeyUp",{
		params ["_input","_key"];
		
		_text = parseNumber (ctrlText _input);
		_text = floor _text;
		
		_input ctrlSetText str (_text max 1 min ((_input getvariable "curCount") - 1));
	}];
	_input = lastNDWidget;
	
	regNDWidget(BUTTON,vec4(0,20 + 40,100,30),_ctg,null);
	lastNDWidget ctrlSetText "Разделить";
	lastNDWidget setVariable ["input",_input];
	
	
	lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
		params ["_bt","_key"];
		
		if (_key == MOUSE_LEFT) then {
			
			//getting text
			_input = _bt getvariable "input";
			
			_amount = parseNumber (ctrlText _input);
			_amount = floor _amount;
			
			[_amount max 1 min ((_input getvariable "curCount") - 1)] call nd_onPressButton;
		};
	}];
	
ND_END
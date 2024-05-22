// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



ND_INIT(Paper)

	private _bufferedText = "";

	_ctg = if (isFirstLoad) then {
		_sx = 40;
		_sy = 70;
		private _ctg = [thisDisplay,WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
		addSavedWdiget(_ctg);

		_back = [thisDisplay,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
		_back setBackgroundColor [0.91,0.914,0.847,1];

		_closer = [thisDisplay,[0,90,100,10],_ctg] call nd_addClosingButton;
		_closer ctrlSetText "Закрыть";

		_ctgLeft = [thisDisplay,WIDGETGROUPSCROLLS,[0,0,100,90],_ctg] call createWidget;
		addSavedWdiget(_ctgLeft);

		_ctgLeft
	} else {
		getSavedWidgets select 1
	};

	private __canWrite = false;

	if (!isFirstLoad) then {
		_bufferedText = ctrlText (_ctg getVariable "writewidget" getVariable "input");
		__canWrite = _ctg getVariable "__canwrite";
	} else {
		if (count ctxParams == 2) then {
			ctxParams deleteAt 0;
			__canWrite = true;
		};
		_ctg setVariable ["__canwrite",__canWrite];
	};

	call nd_cleanupData;

	_curY = 0;
	//header
	regNDWidget(TEXT,vec4(0,0,100,5),_ctg,null);
	[lastNDWidget,format["<t align='center'>%1</t>",ifcheck(_ctg getVariable vec2("iswrite",false),"Прочитать","Записать")]] call widgetSetText;
	lastNDWidget setVariable ["ctg",_ctg];
	_ctg setVariable ["onChangeMode",{
		private _ctg = _this;

		if (_ctg getVariable ["iswrite",false]) then {
			(_ctg getVariable "readwidget") ctrlEnable false; (_ctg getVariable "readwidget") ctrlShow false;
			(_ctg getVariable "writewidget") ctrlEnable true; (_ctg getVariable "writewidget") ctrlShow true;
		} else {
			(_ctg getVariable "readwidget") ctrlEnable true; (_ctg getVariable "readwidget") ctrlShow true;
			(_ctg getVariable "writewidget") ctrlEnable false; (_ctg getVariable "writewidget") ctrlShow false;
		};
	}];
	lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
		params ["_w","_b"];
		_ctg = _w getVariable "ctg";
		_ctg setVariable ["iswrite",!(_ctg getVariable ["iswrite",false])];

		[_w,format["<t align='center'>%1</t>",ifcheck(_ctg getVariable vec2("iswrite",false),"Прочитать","Записать")]] call widgetSetText;

		(_ctg) call (_ctg getVariable "onChangeMode");
	}];

	if (!__canWrite) then {
		lastNDWidget ctrlEnable false;
		lastNDWidget ctrlShow false;
	};

	//text content
	regNDWidget(WIDGETGROUP_H,vec4(0,5,100,100-5),_ctg,null);
	_ctgInside = lastNDWidget;

	_ctg setVariable ["readwidget",_ctgInside];

	regNDWidget(TEXT,WIDGET_FULLSIZE,_ctgInside,null);
	_txt = ctxParams deleteAt 0;
	//fix 190
	_txt = [_txt,"ё","е"] call stringReplace;
	_txt = [_txt,"Ё","Е"] call stringReplace;
	_formatedText = "<t font='KursivC' shadow='0' size='1.4' color='#000000'>" + (_txt) + "</t>";
	[lastNDWidget,_formatedText] call widgetSetText;
	
	[lastNDWidget,[0,0,98,100]] call widgetSetPosition;
	_baseTextH = ctrlTextHeight lastNDWidget;
	lastNDWidget ctrlSetPositionH _baseTextH;
	lastNDWidget ctrlcommit 0;

	regNDWidget(WIDGETGROUP_H,vec4(0,5,100,100-5),_ctg,null);
	_ctgInside = lastNDWidget;
	_ctg setVariable ["writewidget",_ctgInside];

	//ctg textsection (writemode)
	regNDWidget(WIDGETGROUP_H,vec4(0,0,100,70),_ctgInside,null);
	_ctgTextSection = lastNDWidget;
	
	//readprop (inside writemode)
	regNDWidget(TEXT,vec4(0,0,98,100),_ctgTextSection,null);
	[lastNDWidget,_formatedText + format["<t size='1' color='#A600A6'>***конец текста***</t>"]] call widgetSetText;
	lastNDWidget ctrlSetPositionH (_baseTextH);
	lastNDWidget ctrlcommit 0;

	//writeprop (inside writemode)
	regNDWidget(INPUTMULTI,vec4(0,0,98,70),_ctgTextSection,null);
	lastNDWidget ctrlSetPositionY (_baseTextH);
	lastNDWidget ctrlcommit 0;
	_input = lastNDWidget;
	_ctgInside setVariable ["input",lastNDWidget];
	//добавление в инпут переноса строки если newline не имеет переноса
	_replaceCaret = false;
	if (_bufferedText=="" && !([_txt,sbr+"</t>"] call stringEndWith) && _txt!="") then {
		_bufferedText = endl+"";
		_replaceCaret = true;
	};
	lastNDWidget ctrlSetText _bufferedText;
	lastNDWidget setBackgroundColor [0.1,0.1,0.1,.8];
	if (_replaceCaret) then {
		lastNDWidget ctrlSetTextSelection [2,0];
	};
	lastNDWidget ctrlAddEventHandler ["KeyUp",{
		params ["_w","_key"];
		if (_key == KEY_BACKSPACE) exitWith {
			forceUnicode 0;
			_text = ctrlText _w;
			_sel = ctrlTextSelection _w;

			_sel params ["_idxDel","_countDel","_tex"];
			_aText = toArray _text;
			if (_countDel != 0) then {
				if (_countDel > 0) then {
					_aText deleteRange [_idxDel,_countDel];
					_w ctrlSetText (toString _aText);
					_w ctrlSetTextSelection [_idxDel,0];
				} else {
					_aText deleteRange [_idxDel+_countDel,abs _countDel];
					_w ctrlSetText (toString _aText);
					_w ctrlSetTextSelection [_idxDel+_countDel,0];
				};

			} else {
				_aText deleteRange [_idxDel-1,1];
				_w ctrlSetText (toString _aText);
				_w ctrlSetTextSelection [_idxDel-1,0];
			};

		};
		//auto-send by enter press
		if (_key == KEY_RETURN) exitWith {
			if equals(focusedCtrl getDisplay,_w) then {
				_w ctrlSetText (ctrlText _w + endl);
			};
		};
	}];

	lastNDWidget ctrlSetFontHeight 0.05;//debug_fontsize;
	/*lastNDWidget ctrlSetFont "KursivC";
	lastNDWidget ctrlSetTextColor debug_vec4color;*/

	regNDWidget(BUTTON,vec4(5,75,90,20),_ctgInside,null);
	lastNDWidget ctrlSetText "Написать текст";
	lastNDWidget setVariable ["input",_input];
	lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
		params ["_w","_b"];

		_inp = _w getVariable "input";
		_text = ctrlText _inp;
		forceUnicode 1;
		if (count _text >= 1024) exitWith {
			["Слишком много знаков...","error"] call chatPrint;
		};
		if (count _text == 0) exitWith {};

			if (["netdisp_paper_handleinput_writetext",5] call input_spamProtect) exitWith {
			[pick["Рука устала.","Много писать вредно для здоровья.","Хватит с меня писанины."],"error"] call chatPrint;
		};

		_inp ctrlSetText "";

		//preparation of text

		_text = sanitize(_text);
		_text = _text regexReplace ["(\r\n|\n)",sbr];

		[vec2(0,_text)] call nd_onPressButton;
	}];

	(_ctg) call (_ctg getVariable "onChangeMode");

ND_END

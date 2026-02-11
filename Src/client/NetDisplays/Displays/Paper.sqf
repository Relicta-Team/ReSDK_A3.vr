// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

struct(Paper) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];

		private _bufferedText = "";

		_ctg = if (_isFirstCall) then {
			_sx = 40;
			_sy = 70;
			private _ctg = [(self getv(thisDisplay)),WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
			self callp(addSavedWidget, _ctg);

			_back = [(self getv(thisDisplay)),BACKGROUND,[0,0,100,100],_ctg] call createWidget;
			_back setBackgroundColor [0.91,0.914,0.847,1];

			_closer = [(self getv(thisDisplay)),[0,90,100,10],_ctg] call nd_addClosingButton;
			_closer ctrlSetText "Закрыть";

			_ctgLeft = [(self getv(thisDisplay)),WIDGETGROUPSCROLLS,[0,0,100,90],_ctg] call createWidget;
			self callp(addSavedWidget, _ctgLeft);

			_ctgLeft
		} else {
			(self callv(getSavedWidgets)) select 1
		};

		private __canWrite = false;

		if (!_isFirstCall) then {
			_bufferedText = ctrlText (_ctg getVariable "writewidget" getVariable "input");
			__canWrite = _ctg getVariable "__canwrite";
		} else {
			if (count _args == 2) then {
				_args deleteAt 0;
				__canWrite = true;
			};
			_ctg setVariable ["__canwrite",__canWrite];
		};

		call nd_cleanupData;

		_curY = 0;
		//header
		self callp(addWidget, TEXT arg vec4(0,0,100,5) arg _ctg arg null);
		[(self getv(lastNDWidget)),format["<t align='center'>%1</t>",ifcheck(_ctg getVariable vec2("iswrite",false),"Прочитать","Записать")]] call widgetSetText;
		(self getv(lastNDWidget)) setVariable ["ctg",_ctg];
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
		(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
			params ["_w","_b"];
			_ctg = _w getVariable "ctg";
			_ctg setVariable ["iswrite",!(_ctg getVariable ["iswrite",false])];

			[_w,format["<t align='center'>%1</t>",ifcheck(_ctg getVariable vec2("iswrite",false),"Прочитать","Записать")]] call widgetSetText;

			(_ctg) call (_ctg getVariable "onChangeMode");
		}];

		if (!__canWrite) then {
			(self getv(lastNDWidget)) ctrlEnable false;
			(self getv(lastNDWidget)) ctrlShow false;
		};

		//text content
		self callp(addWidget, WIDGETGROUP_H arg vec4(0,5,100,100-5) arg _ctg arg null);
		_ctgInside = (self getv(lastNDWidget));

		_ctg setVariable ["readwidget",_ctgInside];

		self callp(addWidget, TEXT arg WIDGET_FULLSIZE arg _ctgInside arg null);
		_txt = _args deleteAt 0;
		//fix 190
		_txt = [_txt,"ё","е"] call stringReplace;
		_txt = [_txt,"Ё","Е"] call stringReplace;
		_formatedText = "<t font='KursivC' shadow='0' size='1.4' color='#000000'>" + (_txt) + "</t>";
		[(self getv(lastNDWidget)),_formatedText] call widgetSetText;
		
		[(self getv(lastNDWidget)),[0,0,98,100]] call widgetSetPosition;
		_baseTextH = ctrlTextHeight (self getv(lastNDWidget));
		(self getv(lastNDWidget)) ctrlSetPositionH _baseTextH;
		(self getv(lastNDWidget)) ctrlcommit 0;

		self callp(addWidget, WIDGETGROUP_H arg vec4(0,5,100,100-5) arg _ctg arg null);
		_ctgInside = (self getv(lastNDWidget));
		_ctg setVariable ["writewidget",_ctgInside];

		//ctg textsection (writemode)
		self callp(addWidget, WIDGETGROUP_H arg vec4(0,0,100,70) arg _ctgInside arg null);
		_ctgTextSection = (self getv(lastNDWidget));
		
		//readprop (inside writemode)
		self callp(addWidget, TEXT arg vec4(0,0,98,100) arg _ctgTextSection arg null);
		[(self getv(lastNDWidget)),_formatedText + format["<t size='1' color='#A600A6'>***конец текста***</t>"]] call widgetSetText;
		(self getv(lastNDWidget)) ctrlSetPositionH (_baseTextH);
		(self getv(lastNDWidget)) ctrlcommit 0;

		//writeprop (inside writemode)
		self callp(addWidget, INPUTMULTI arg vec4(0,0,98,70) arg _ctgTextSection arg null);
		(self getv(lastNDWidget)) ctrlSetPositionY (_baseTextH);
		(self getv(lastNDWidget)) ctrlcommit 0;
		_input = (self getv(lastNDWidget));
		_ctgInside setVariable ["input",(self getv(lastNDWidget))];
		//добавление в инпут переноса строки если newline не имеет переноса
		_replaceCaret = false;
		if (_bufferedText=="" && !([_txt,sbr+"</t>"] call stringEndWith) && _txt!="") then {
			_bufferedText = endl+"";
			_replaceCaret = true;
		};
		(self getv(lastNDWidget)) ctrlSetText _bufferedText;
		(self getv(lastNDWidget)) setBackgroundColor [0.1,0.1,0.1,.8];
		if (_replaceCaret) then {
			(self getv(lastNDWidget)) ctrlSetTextSelection [2,0];
		};
		(self getv(lastNDWidget)) ctrlAddEventHandler ["KeyUp",{
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

		(self getv(lastNDWidget)) ctrlSetFontHeight 0.05;//debug_fontsize;
		/*(self getv(lastNDWidget)) ctrlSetFont "KursivC";
		(self getv(lastNDWidget)) ctrlSetTextColor debug_vec4color;*/

		self callp(addWidget, BUTTON arg vec4(5,75,90,20) arg _ctgInside arg null);
		(self getv(lastNDWidget)) ctrlSetText "Написать текст";
		(self getv(lastNDWidget)) setVariable ["input",_input];
		(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
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

	};

endstruct

// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(InteractEmote_interactEmote_)

decl(bool)
interactEmote_disableGlobal = false;

decl(bool)
interactEmote_isLoadedMenu = false;

decl(string)
interactEmote_inputText = "";

decl(int)
interactEmote_curTabIdx = 0;

decl(string[][])
interactEmote_actions = [["Эмоции","Эмоция:emt_1"]];
decl(any[])
interactEmote_generatedActs = []; //not used
decl(widget[])
interactEmote_act_widgets = [];

macro_const(interactEmote_zoneSizeHeight)
#define INTERACT_EMOTE_SIZE_H 40
macro_const(interactEmote_zoneSizeWidth)
#define INTERACT_EMOTE_SIZE_W 40
/*
for "_i" from 1 to 50 do {
	(interactEmote_actions select 0) pushBack ("Действие "+str _i +":fuck");
};*/

decl(void())
interactEmote_load = {
	private _d = getDisplay;

	interactEmote_act_widgets = [];
	interactEmote_isLoadedMenu = false;

	private _shownPos = [0,50-INTERACT_EMOTE_SIZE_H/2,INTERACT_EMOTE_SIZE_W,INTERACT_EMOTE_SIZE_H];
	_hiddenPos = [-INTERACT_EMOTE_SIZE_W,50-INTERACT_EMOTE_SIZE_H/2];
	private _ctg = [_d,WIDGETGROUP,_shownPos] call createWidget;
	_d setVariable ["ieMenuCtg",_ctg];

	_ctg setVariable ["hiddenPos",_hiddenPos];
	_ctg setVariable ["shownPos",_shownPos select [0,2]];
	_ctg setVariable ["checkedPos",
		[0,
		50-INTERACT_EMOTE_SIZE_H/2,
		INTERACT_EMOTE_SIZE_W/8, //Размер рамки
		50-INTERACT_EMOTE_SIZE_H/2+INTERACT_EMOTE_SIZE_H]
	];

	private _background = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_background setBackgroundColor [0,0,0,0.9];

	//create emote input
	private _input = [_d,INPUT,[5,5,75,15],_ctg] call createWidget;
	_input ctrlSetText interactEmote_inputText;
	_t = [_d,BACKGROUND,[82,5,8+5,15],_ctg] call createWidget;
	_t setBackgroundColor [0,0.3,0,0.8]; //костыльный фон для кнопки
	private _buttonSend = [_d,BUTTON,[82,5,8+5,15],_ctg] call createWidget;
	_buttonSend ctrlSetText "Действие";
	private _zCol = [0,0.0,0,0.0];
	_buttonSend setBackgroundColor _zCol;
	// ничего из строк ниже не работает для кнопок...
	// _buttonSend ctrlsetactivecolor _zCol;
	// _buttonSend ctrlsetforegroundcolor _zCol;
	// _buttonSend ctrlSetTextColorSecondary _zCol;

	_ctg setVariable ["input",_input];
	_ctg setVariable ["buttonSend",_buttonSend];

	_input ctrlAddEventHandler ["MouseButtonUp",{
		params ["","_key"];
		if (_key == MOUSE_RIGHT) then {ctrlSetFocus getSelfCtgText;};
	}];
	_input ctrlAddEventHandler ["KeyUp",{
		params ["_w","_key"];
		if (interactEmote_disableGlobal) exitWith {};
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
				(call interactEmote_getInputTextParams) params ["_inp","_txt"];
				if (_txt call interactEmote_onSendEmote) then {
					call interactEmote_cleanupInputText;
				};
			};
		};
	}];

	_buttonSend ctrlAddEventHandler ["MouseButtonUp",{
		params ["_w","_key"];
		if (_key == MOUSE_LEFT) exitWith {
			(call interactEmote_getInputTextParams) params ["_inp","_txt"];

			if (_txt call interactEmote_onSendEmote) then {
				call interactEmote_cleanupInputText;
			};

		};
	}];

	interactEmote_isLoadedMenu = false;
	[_ctg,_ctg getVariable "hiddenPos",0] call widgetSetPositionOnly;

	_d displayAddEventHandler ["MouseMoving",interactEmote_onMouseMoving];

	//create categ buttons
	private _ctgCategs = [_d,WIDGETGROUP,[5,15+5+3+1,90,10],_ctg] call createWidget;

	private _allevs = [];
	_t = [_d,TEXT,[0,0,30,100],_ctgCategs] call createWidget;
	//[_t,"<t align='center'>" + slt +"</t>"] call widgetSetText;
	[_t,"<t align='center' color='#235423'><img size='1.4' image='a3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa'/></t>"] call widgetSetText;
	[_t,[0,0.25,0,0.4],[0,0.35,0,0.5]] call widgetSetMouseMoveColors;
	_t setvariable ["actionmode",-1];
	_allevs pushBack _t;
	_ctg setVariable ["ctgPrevActionButton",_t];

	_t = [_d,TEXT,[100-30,0,30,100],_ctgCategs] call createWidget;
	//[_t,"<t align='center'>" + sgt +"</t>"] call widgetSetText;
	[_t,"<t align='center' color='#235423'><img size='1.4' image='a3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa'/></t>"] call widgetSetText;
	[_t,[0,0.25,0,0.4],[0,0.35,0,0.5]] call widgetSetMouseMoveColors;
	_t setvariable ["actionmode",1];
	_allevs pushBack _t;
	_ctg setVariable ["ctgNextActionButton",_t];
	
	_t = [_d,BACKGROUND,[30,0,40,100],_ctgCategs] call createWidget;
	//<img image='%2' size='1.4'/>
	private _icntxt = "a3\3den\data\controls\ctrltree\expandedtexture_ca.paa";
	[_t,format["   <img image='%1' size='1.4'/>",_icntxt]] call widgetSetText;

	_t = [_d,TEXT,[30,0,40,100],_ctgCategs] call createWidget;
	[_t,"<t align='center'>Категория</t>"] call widgetSetText;
	[_t,[0,0.15,0,0.3],[0,0.25,0,0.5]] call widgetSetMouseMoveColors;
	_t setvariable ["actionmode",0];
	_ctg setVariable ["ctgCatAct",_t];
	_ctg setVariable ["categsGroup",_ctgCategs];
	_allevs pushBack _t;
	{
		_x ctrlAddEventHandler ["MouseButtonUp",{
			params ["_w","_b"];
			if (_b == MOUSE_LEFT) then {
				_act = _w getVariable ["actionmode",1];
				if (_act == 0) exitWith {
					[true] call interactEmote_onListCategoryes;
				};
				[_act] call interactEmote_switchActionMenu;
			};
		}];
	} foreach _allevs;

	//create zone buttons
	//[5,5,75,15]
	private _ctgActions = [_d,WIDGETGROUP_H,[5,15+5+3 + 11,90,100-(15+5+3+3 + 11)],_ctg] call createWidget;
	_ctg setVariable ["ctgActions",_ctgActions];

	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctgActions] call createWidget;
	_back setBackgroundColor [0,0.25,0,0.3];
	_ctgActions setVariable ["background",_back];

	call interactEmote_loadActions;
};

//открыть лист категорий
decl(void(bool))
interactEmote_onListCategoryes = {
	params ["_mode"];
	private _d = getDisplay;
	if isNullReference(_d) exitWith {};
	_ieMenuCtg = _d getVariable ["ieMenuCtg",widgetNull];
	if isNullReference(_d) exitWith {};
	_obj = _ieMenuCtg getVariable ["categsGroup",widgetNull];
	if isNullReference(_ctg) exitWith {};
	//already loaded
	if equals(_obj getVariable ["isloadedlist" arg false],_mode) exitWith {};

	if (_mode) then {
		(_obj call widgetGetPosition) params ["_x","_y","_w","_h"];

		_ctg = [
			_d,
			WIDGETGROUP_H,
			[_x,_y,_w,50+_h],
			_ieMenuCtg
		] call createWidget;
		_b = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
		_b setBackgroundColor [0,0.15,0,0.3];

		_lastSizeY = 0;
		_butSize = 20;
		//Подгрузка кнопок
		for "_i" from 0 to (count interactEmote_actions) - 1 do {
			//_txt = str rand(1,1000) + " категория";
			_txt = interactEmote_actions select _i select 0;
			_lastSizeY = _butSize * _i;
			_wt = [_d,TEXT,[0,_lastSizeY,100,_butSize],_ctg] call createWidget;
			if (_i == interactEmote_curTabIdx) then {
				[_wt,[0,0.2,0,0.4],[0.25,0.25,0.25,0.45]] call widgetSetMouseMoveColors;
				_txt = format['[ %1 ]',_txt];
			} else {
				[_wt,[0,0,0,0],[0.2,0.2,0.2,0.4]] call widgetSetMouseMoveColors;
			};
			_wt setVariable ["idx",_i];
			[_wt,format["<t align='center'>%1</t>",_txt]] call widgetSetText;
			_wt ctrlAddEventHandler ["MouseButtonUp",{
				params ["_w","_b"];
				nextFrameParams(interactEmote_onListCategoryes,[false]);
				_idx = _w getVariable ["idx",0];
				[_idx,true] call interactEmote_switchActionMenu;
			}];
		};
		[_b,[0,0,100,(_lastSizeY+_butSize)max 100]] call widgetSetPosition;

		[_ctg,[_x,_y,_w,0]] call widgetSetPosition;
		[_ctg,[_x,_y,_w,50+_h],0.2] call widgetSetPosition;
		_obj setVariable ["ctglistcatsie",_ctg];
		{
			_x setFade 1;
			_x commit 0.15;
			_x ctrlEnable false;
		} foreach [_obj,_ieMenuCtg getVariable "ctgActions"];

	} else {
		(_obj call widgetGetPosition) params ["_x","_y"];
		_ctg = _obj getVariable "ctglistcatsie";
		[_ctg,[_x,_y,100,0],0.05] call widgetSetPosition;
		_ctg ctrlEnable false;
		invokeAfterDelayParams({[_this arg true] call deleteWidget},0.06,_ctg);
		{
			_x setFade 0;
			_x commit 0.06;
			_x ctrlEnable true;
		} foreach [_obj,_ieMenuCtg getVariable "ctgActions"];
	};

	_obj setVariable ["isloadedlist",_mode];
};

decl(void())
interactEmote_cleanupInputText = {
	((call interactEmote_getInputTextParams) select 0) ctrlSetText "";
	interactEmote_inputText = "";
};

//Получение виджета инпута и текста в нём
decl(tuple<widget;string>())
interactEmote_getInputTextParams = {
	private _inp = getDisplay getVariable "ieMenuCtg" getVariable "input";
	[_inp,ctrlText _inp]
};

//Обработчик строки инпута. Возврат bool значений означает ошибку текста
decl(bool(string))
interactEmote_handleInputText = {
	private _text = _this;
	forceUnicode 0;

	//max length 255 symbols
	if (count _text > 255) exitWith {
		true;
	};

	//remove duplicate charachters
	_text = _text regexReplace ["(.)\1{4,}",""];

	//if null text then returns
	private _textPb = _text regexReplace ["[\ \t]+",""];

	//После уборки пробелов букв не осталось
	if (count _textPb == 0) exitWith {
		true;
	};

	//sanitize text
	_text = sanitize(_text);
	//traceformat(" 1 newtext is:%1",_text);

	//replace more than one spaces
	_text = _text regexReplace ["^(\ |\t)*",""];
	//traceformat(" 2 newtext is:%1",_text);

	//if capslock
	/*if (count(_text regexFind ["\w+",0]) == (count(_text regexFind ["[А-Я]+",0]))) then {
		//[pick["Не капси!","Давай нормально напиши, ебарик.","Перепиши по-нормальному."],"error"] call chatPrint;
		_text = toLower _text;
		//traceformat(" 2:1 newtext is:%1",_text);
	};*/

	//first letter lowerize
	_text = toLower (_text select [0,1]) + (_text select [1,count _text - 1]);
	//traceformat(" 3 newtext is:%1",_text);

	//replace all end capses
	_text = _text regexReplace ["(\ |\t|\.|\!|\?)+$","."];

	//if non dot in endword then add this
	_text = _text regexReplace ["[а-я]$","$&."];

	_text
};

decl(bool(string))
interactEmote_onSendEmote = {
	private _text = _this;

	//if unconscious state
	if (!([] call interact_isActive)) exitWith {false};

	_text = _text call interactEmote_handleInputText;
	if equalTypes(_text,true) exitWith {_text};

	rpcSendToServer("emoteTxt",vec2(player,_text));

	//traceformat(" 5 newtext is:%1",_text);
	true
};

decl(void(display))
interactEmote_onMouseMoving = {
	params ["_display"];

	if (isDragProcess) exitWith {};
	if (interactEmote_disableGlobal) exitWith {};
	_ctg = _display getVariable "ieMenuCtg";

	if ((_ctg getVariable "checkedPos") call isMouseInsidePosition &&
			!interactEmote_isLoadedMenu &&
			{!verb_isMenuLoaded && interact_isMouseModeActive &&
				{!(_display getVariable ["isPreparedToDestroy",false])}
			}
		) exitWith {
		interactEmote_isLoadedMenu = true;
		[_ctg,_ctg getVariable "shownPos",TIME_TOLOAD_INTERACTCOMBAT] call widgetSetPositionOnly;
	};

	if (!(_ctg call isMouseInsideWidget) && interactEmote_isLoadedMenu) exitWith {
		interactEmote_isLoadedMenu = false;
		[_ctg,_ctg getVariable "hiddenPos",TIME_TOUNLOAD_INTERACTCOMBAT] call widgetSetPositionOnly;
		ctrlSetFocus getSelfCtgText;
	};
};

decl(void(int;bool))
interactEmote_switchActionMenu = {
	params ["_mode",["_isSetMode",false]];

	//update mode
	if (!_isSetMode) then {
		_mode = interactEmote_curTabIdx + _mode;
	};
	//check range
	if (_mode < 0) then {
		_mode = ((count interactEmote_actions) - 1)max 0;
	} else {
		if (_mode > ((count interactEmote_actions) - 1)) then {
			_mode = 0;
		};
	};
	interactEmote_curTabIdx = _mode;

	call interactEmote_loadActions;
};

decl(void())
interactEmote_loadActions = {
	private _acts = if (count interactEmote_actions == 0) then {
		["Нет действий"]
	} else {
		array_copy(interactEmote_actions select interactEmote_curTabIdx);
	};

	{
		[_x] call deleteWidget;
	} foreach interactEmote_act_widgets;
	interactEmote_act_widgets = [];

	private _d = getDisplay;
	private _ctg = _d getVariable "ieMenuCtg" getVariable "ctgActions";

	//rename cat
	private _namecat = _acts deleteAt 0;
	
	//"a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa"
	//"a3\ui_f\data\gui\rsccommon\rsctree\expandedtexture_ca.paa"
	private _aTxt = format["<t align='center'>%1</t>",_namecat];
	[_d getVariable "ieMenuCtg" getVariable "ctgCatAct",_aTxt] call widgetSetText;


	private _sizeH = 20;
	private _countLine = 4; //сколько элементов на линии
	private _biasX = 2;
	private _biasY = 2;
	private _sizeW = 100 / _countLine;
	//_sizeW = _sizeW - (_biasY * (_countLine/2));
	_sizeW = _sizeW - (_biasY * 2);

	private _lastX = _biasX;
	private _lastY = _biasY;
	private _itmPerLine = 1;

	private _backButtons = ["0C3604"] call color_HTMLtoRGBA;
	private _backButtonsFocused = ["1A6B0A"] call color_HTMLtoRGBA;

	_eventOnAction = {
		params ["_w","_key"];
		if (_key == MOUSE_LEFT) then {
			_act = _w getVariable ["act",""];
			if (_act == "") exitWith {};
			[_act] call interactEmote_doEmoteAction;
		};
	};

	for "_i" from 0 to count _acts - 1 do {

		_txt = [_d,TEXT,[
			_lastX,
			_lastY,
			_sizeW,
			_sizeH
		],_ctg] call createWidget;

		((_acts select _i)splitString ":" )params ["_actname","_actcode"];

		[_txt,format["<t align='center'>%1</t>",_actname]] call widgetSetText;
		[_txt,_backButtons,_backButtonsFocused] call widgetSetMouseMoveColors;
		_txt setVariable ["act",_actcode];
		_txt ctrlAddEventHandler ["MouseButtonUp",_eventOnAction];

		interactEmote_act_widgets pushBack _txt;

		_lastX = _lastX + _sizeW + _biasX;
		INC(_itmPerLine);

		if (_itmPerLine > _countLine) then {
			_lastX = _biasX;
			_lastY = _lastY + _sizeH + _biasY;
			_itmPerLine = 1;
		};
	};

	//now resize background
	[_ctg getVariable "background",[0,0,100,(if (_itmPerLine==1) then {_lastY+_biasY} else {_lastY+_sizeH+_biasY}) max 100]] call widgetSetPosition;

	#ifdef SP_MODE
	call sp_gui_syncInventoryVisible;
	#endif
};

//Отправка эмоута
decl(void(string))
interactEmote_doEmoteAction = {
	params ["_act"];
	if (["emoteAction"] call input_spamProtect) exitWith {};
	private _args = [player arg _act];
	private _text = "";
	(call interactEmote_getInputTextParams) params ["_inp","_txParam"];
	if ("inputed" in _act) then {
		_text = _txParam call interactEmote_handleInputText;
		_args pushBack _text;
	};
	if equalTypes(_text,true) then {
		if (_text) then {
			call interactEmote_cleanupInputText;
		};
	} else {
		if (_text != "") then {
			call interactEmote_cleanupInputText;
		};
		rpcSendToServer("emoteAct",_args);
	};
};

//not used
decl(any[])
interactEmote_unloadActions = {
	private _acts = _this;
};

decl(void(any[]))
interactEmote_RpcLoadEmotes = {
	interactEmote_actions = _this;

	if (interact_isOpenMousemode) then {
		call interactEmote_loadActions;
	};
}; rpcAdd("loadEmotes",interactEmote_RpcLoadEmotes);

decl(void(string;any[]))
interactEmote_RpcUpdateCateg = {
	params ["_cat","_list"];
	//trace("START UPDATE")
	private _doReload = false;

	private _idx = interactEmote_actions findif {_x select 0 == _cat};

	private _newarr = [_cat];
	_newarr append _list;

	if (count _newarr == 1) then {
		if (_idx != -1) then {
			interactEmote_actions deleteAt _idx;
			_doReload = true;
		} else {
			//уже не существует
		};
		//traceformat("cur index %1, do reload %2, %4; data %3",_idx arg _doReload arg interactEmote_actions arg _list)
		if (interactEmote_curTabIdx == _idx) then {
			//вкладка удалена, перезагружаем
			_doReload = true;
			interactEmote_curTabIdx = 0;
		};

	} else {
		if (_idx != -1) then {
			interactEmote_actions set [_idx,_newarr];

			//do reload
			_doReload = true;
		} else {
			interactEmote_actions pushBack _newarr;
		};
	};
	//traceformat("%1 -->> %2",_doReload arg interact_isOpenMousemode)

	if (_doReload && interact_isOpenMousemode) then {
		[false] call interactEmote_onListCategoryes;
		call interactEmote_loadActions;
	};

}; rpcAdd("updateEmoteCat",interactEmote_RpcUpdateCateg);

// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\ClientRpc\clientRpc.hpp"
#include "..\..\host\keyboard.hpp"
#include "..\WidgetSystem\widgets.hpp"
#include "..\..\host\text.hpp"
#include "interactMenu.hpp"
#include <..\ClientData\ClientData.hpp>

namespace(InteractMenu,interactMenu_)

macro_def(interactMenu_debug_use_borders)
#define DEBUG_USE_BORDERS

macro_func(interactMenu_debug_colorize,void(widget))
#define debug_colorize(wid) wid setBackgroundColor [random 1,random 1,random 1,1]
macro_func(interactMenu_debug_colorizeButton,void(widget))
#define debug_colorizeButton(wid) wid setBackgroundColor  [random 1,random 1,random 1,1]

macro_func(interactMenu_colorizeCategory,void(widget))
#define colorizeCategory(wid) wid setBackgroundColor [.3,.3,.3,.7]
macro_func(interactMenu_colorizeButton,void(widget))
#define colorizeButton(wid) wid setBackgroundColor [.1,.1,.1,.7]

//setting text for attr (skill)
macro_func(interactMenu_setButtonText,void(widget,string))
#define setButtonText(wid,text) wid ctrlSetStructuredText (parseText format["<t size='0.8' align='center' valign='middle'>%1</t>" arg text])
macro_func(interactMenu_setCategText,void(widget,string))
#define setCategText(wid,text) wid ctrlSetStructuredText (parseText format ["<t size='0.8' align='center' valign='middle'>%1</t>" arg text])
macro_func(interactMenu_setAttrText,void(widget,string,string))
#define setAttrText(wid,text,addit) setText(wid,format["<t size='1.2'>%1</t><t size='0.8'>%2</t>" arg text arg addit])
macro_func(interactMenu_setTextBase,void(widget,string))
#define setText(wid,text) [wid,text] call widgetSetText

macro_const(interactMenu_view_widthAttr)
#define WIDTH_ATTR 30
macro_const(interactMenu_view_heightCategory)
#define HEIGHT_CATEGORY 2.5
macro_const(interactMenu_view_sizeIntentButton)
#define SIZE_INTENT_BUTTON 10
macro_const(interactMenu_view_stdBiasY)
#define STD_BIAS_Y 1.5
macro_const(interactMenu_view_stdBiasX)
#define STD_BIAS_X 1.5

#include "interactMenu_defines.sqf"
#include "interactMenu_functions.sqf"

decl(void())
interactMenu_load = {

	private _d = getDisplay;
	//_d displayAddEventHandler ["KeyUp",onGameKeyInputs]; //for debug

	private _ctg = [_d,WIDGETGROUP,[70,0,30,100]] call createWidget;

	private _back = [_d,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
	_back setBackgroundColor [0,0,0,0.9];

	#define createText(sizes) [_d,TEXT,sizes,_ctg] call createWidget
	#define createButton(sizes) [_d,BUTTONMENU,sizes,_ctg] call createWidget
	#define createSpecButton(sizes) [_d,BUTTONMENU,sizes,_ctgSpec] call createWidget

	#define vec4(x,y,w,h) [x,y,w,h]

	private _height = HEIGHT_CATEGORY;
	private _ypos = 0;

	//--------------creating stats--------------
	private _statsText = createText(vec4(0, _ypos, 100, _height));
	setCategText(_statsText,"Статистика");
	colorizeCategory(_statsText);

	MOD(_ypos,+ _ypos + _height + STD_BIAS_Y);
	_height = 3;

	private _memoryYpos = _ypos;

	private _counter = 0;
	private _refwid = interactMenu_skillWidgets;
	private _refnm = interactMenu_skillNames;

	for "_i" from 1 to 4 do {
		_st = createText(vec4(0,_ypos,WIDTH_ATTR,_height));
		_refwid set [_counter,_st];
		setAttrText(_st,_refnm select _counter,"");
		//debug_colorize(_st);

		MOD(_ypos, + _height);

		INC(_counter);
	};

	_ypos = _memoryYpos;

	for "_i" from 1 to 4 do {
		_st = createText(vec4(WIDTH_ATTR,_ypos,WIDTH_ATTR,_height));
		_refwid set [_counter,_st];
		setAttrText(_st,_refnm select _counter,"");
		//debug_colorize(_st);

		MOD(_ypos, + _height);

		INC(_counter);
	};

	//create buttons
	_ypos = _memoryYpos;
	_butt = createButton(vec4(WIDTH_ATTR + WIDTH_ATTR,_ypos,100 - (WIDTH_ATTR * 2),_height * 2));
	setButtonText(_butt,"Воспоминания");
	colorizeButton(_butt);
	_butt ctrlAddEventHandler ["MouseButtonUp",{[0] call interactMenu_getMemories}];

	MOD(_ypos, + _height * 2);

	_butt = createButton(vec4(WIDTH_ATTR + WIDTH_ATTR,_ypos,100 - (WIDTH_ATTR * 2),_height * 2));
	setButtonText(_butt,"Навыки");
	colorizeButton(_butt);
	_butt ctrlAddEventHandler ["MouseButtonUp",{[1] call interactMenu_getMemories}];

	MOD(_ypos, + _height * 2 + STD_BIAS_Y);

	//--------------creating intent menu--------------
	/*_height = HEIGHT_CATEGORY;
	private _intentsText = createText(vec4(0, _ypos, 100, _height));
	setCategText(_intentsText,"Режим взаимодействия");
	colorizeCategory(_intentsText);

	MOD(_ypos,+_height + STD_BIAS_Y);

	private _int_but_w = (getWidthByHeightToSquare(SIZE_INTENT_BUTTON)) * 3.5;*/

	/*for "_i" from 0 to 2 do {
		_intent = [_d,ACTIVEPICTURE,vec4(_int_but_w * _i + STD_BIAS_X * (_i + 1),_ypos,_int_but_w,SIZE_INTENT_BUTTON),_ctg] call createWidget;
		_intent setvariable ["mode",_i];
		interactMenu_intentWidgets set [_i,_intent];
		[_intent,interactMenu_intentPath select _i] call widgetSetPicture;
		_intent ctrlSetActiveColor (interactMenu_intentActiveColors select _i);
		_intent ctrlAddEventHandler ["MouseButtonUp",{
			params ["_wid","_button"];
			[_wid,CALLING_IN_DISPLAY_MODE] call interactMenu_setIntent;
		}];
		//debug_colorize(_intent);
	};
	//loading active intent color
	[0,CALLING_IN_DISPLAY_MODE,true] call interactMenu_setIntent;*/

	//create changer self/world
	/*private _interModeX = _int_but_w * 3 + STD_BIAS_X * 4;
	_butt = createButton(vec4(_interModeX,_ypos,100 - _interModeX - STD_BIAS_X,SIZE_INTENT_BUTTON));
	[_butt,CALLING_IN_DISPLAY_MODE,true] call interactMenu_setInteractionSrc;
	//setButtonText(_butt,sbr + "Я/Мир" + sbr + format["<img size='1.5' image='%1'/>" arg INT_PATH("selfworld")]);
	colorizeButton(_butt);
	_butt ctrlAddEventHandler ["MouseButtonUp",{
		params ["_wid","_button"];
		[_wid,CALLING_IN_DISPLAY_MODE] call interactMenu_setInteractionSrc;
	}];

	MOD(_ypos,+SIZE_INTENT_BUTTON + STD_BIAS_Y);*/

	//------------creating selections zones--------------
	_height = HEIGHT_CATEGORY;
	_intentsText = createText(vec4(0, _ypos, 100, _height));
	setCategText(_intentsText,"Область взаимодействия");
	colorizeCategory(_intentsText);

	MOD(_ypos,+_height + STD_BIAS_Y);

	macro_const(interactMenu_view_maxSelectionsToDown)
	#define MAX_SELECTIONS_TODOWN 6

	inline_macro
	#define allocSelectionId(wid,sel) wid setvariable ['id',sel]; \
	wid ctrlAddEventHandler ["MouseButtonUp",{params ["_w","_button"]; \
	[_w getVariable 'id',_button] call interactMenu_setSelection}];

	inline_macro
	#define allocSelectionId_limb(wid,sel) allocSelectionId(wid,sel); \
	INC(_counter); interactMenu_selectionWidgets set [MAX_SELECTIONS_TODOWN + _counter,_butt];

	_counter = 0;
	for "_i" from 0 to MAX_SELECTIONS_TODOWN do {
		_butt = createButton(map_hit(50 - 16,_ypos + SIZE_HITPART_ZONE * _i));
		setButtonText(_butt,map_zonenames select _i);
		colorizeButton(_butt);
		allocSelectionId(_butt,map_zoneindex select _i);
		interactMenu_selectionWidgets set [_i,_butt];

		if (_i == 1) then {
			//hands create
			_butt = createButton(map_hit(50 - 16 - 32,_ypos + SIZE_HITPART_ZONE * _i));
			setButtonText(_butt,"Левый глаз");
			colorizeButton(_butt);
			allocSelectionId_limb(_butt,map_limbs select _counter);

			_butt = createButton(map_hit(50 + 16,_ypos + SIZE_HITPART_ZONE * _i));
			setButtonText(_butt,"Правый глаз");
			colorizeButton(_butt);
			allocSelectionId_limb(_butt,map_limbs select _counter);
		};
		if (_i == 4) then {
			//hands create
			_butt = createButton(map_hit(50 - 16 - 32,_ypos + SIZE_HITPART_ZONE * _i));
			setButtonText(_butt,"Левая рука");
			colorizeButton(_butt);
			allocSelectionId_limb(_butt,map_limbs select _counter);

			_butt = createButton(map_hit(50 + 16,_ypos + SIZE_HITPART_ZONE * _i));
			setButtonText(_butt,"Правая рука");
			colorizeButton(_butt);
			allocSelectionId_limb(_butt,map_limbs select _counter);
		};
		if (_i == 5) then {
			//hands create
			_butt = createButton(map_hit(50 - 16 - 32,_ypos + SIZE_HITPART_ZONE * _i));
			setButtonText(_butt,"Левая нога");
			colorizeButton(_butt);
			allocSelectionId_limb(_butt,map_limbs select _counter);

			_butt = createButton(map_hit(50 + 16,_ypos + SIZE_HITPART_ZONE * _i));
			setButtonText(_butt,"Правая нога");
			colorizeButton(_butt);
			allocSelectionId_limb(_butt,map_limbs select _counter);
		};
	};
	call interactMenu_syncCurSelection;

	MOD(_ypos,+SIZE_HITPART_ZONE * count(map_zonenames) + STD_BIAS_Y);

	//------------creating special buttons--------------
	_height = HEIGHT_CATEGORY;
	_intentsText = createText(vec4(0, _ypos, 100, _height));
	setCategText(_intentsText,"Особые действия");
	colorizeCategory(_intentsText);

	MOD(_ypos,+_height + STD_BIAS_Y);

	//_butt = createButton(vec4(STD_BIAS_X,_ypos,100 - STD_BIAS_X * 2,5));
	//setButtonText(_butt,"Куснуть");
	//colorizeButton(_butt);

	private _ctgSpec = [_d,WIDGETGROUP_H,vec4(0,_yPos,100,100 - _yPos),_ctg] call createWidget;
	_d setVariable ["ctgSpecialActions",_ctgSpec];
	
	[true] call interactMenu_syncSpecialActions;

	//adding mouse event
	interactMenu_isLoadedMenu = false;//disable if enabled
	_d displayAddEventHandler ["MouseMoving",interactMenu_onMouseMove];
	_d setvariable ["interactMenuCtg",_ctg];
	_ctg setFade 1;
	[_ctg,[100,0]] call widgetSetPositionOnly;


	call interactMenu_onUpdateSkills;
};

decl(void(display;float;float))
interactMenu_onMouseMove = {
	params ["_display", "_xPos", "_yPos"];

	if (isDragProcess) exitWith {};

	(call mouseGetPosition) params ["_x","_y"];
	if (_x >= 90 && !interactMenu_isLoadedMenu && {!verb_isMenuLoaded && interact_isMouseModeActive && {!(_display getVariable ["isPreparedToDestroy",false])}}) exitWith {
		if (interactMenu_disableGlobal) exitWith {};
		interactMenu_isLoadedMenu = true;
		_ctg = _display getVariable "interactMenuCtg";
		_ctg setFade 0;

		[_ctg,[70,0],TIME_PREPARE_SLOTS] call widgetSetPositionOnly;
	};
	if (_x <= 70 && interactMenu_isLoadedMenu) exitWith {
		call interactMenu_unloadMenu;
	};
};

decl(void())
interactMenu_unloadMenu = {
	interactMenu_isLoadedMenu = false;
	_ctg = getDisplay getVariable "interactMenuCtg";
	_ctg setFade 1;

	[_ctg,[100,0],TIME_PREPARE_SLOTS] call widgetSetPositionOnly;
};

decl(void(bool))
interactMenu_syncSpecialActions = {
	params [["_isInit",true]];
	
	private _setFadeSpec = {
		private _oldw = interactMenu_curActiveSpecAct select 0;
		if (!isNullReference(_oldw) && _oldw getVariable ["isActive",false]) then {
			_oldw setFade 0;
			_oldw commit FADE_TIME;
			_oldw setvariable ['isActive',false];
			interactMenu_curActiveSpecAct set [0,widgetNull];
		};
		_this setFade FADEIN_SPECACT;
		_this commit FADE_TIME;
		_this setvariable ['isActive',true];
		interactMenu_curActiveSpecAct set [0,_this];
	};
	
	if (_isInit) then {
		macro_const(interactMenu_view_specact_bias_x)
		#define _specact_bias_x 5
		macro_const(interactMenu_view_specact_bias_y)
		#define _specact_bias_y 2
		macro_const(interactMenu_view_specact_size_h)
		#define _specact_size_h 15
		
		private _refSpec = interactMenu_specialActions;
		_counter = 0;
		private _modifRow = 0;
		private _specactypos = _specact_bias_y;
		private _lastY = _specactypos;
	
		for "_i" from 0 to (count _refSpec) - 1 do {
			(_refSpec select _i) params ["_name","_action","_type"];
			
			//vm fix - макросы работают больше чем в 2х уровнях похоже...
			_butt = createSpecButton(
				vec4(_specact_bias_x + (50 * _modifRow),_specactypos,50 - _specact_bias_x * 2,_specact_size_h)
			);
			interactMenu_specActWidgets set [_i,_butt];
			MOD(_specactypos,+ _specact_size_h + _specact_bias_y);
			setButtonText(_butt,_name);
			_butt setvariable ["actionName",_name];
			_butt setvariable ["action",_action];
			_butt setvariable ["actionType",_type];
			if (_action == cd_specialAction) then {
				_butt call _setFadeSpec
			};
			colorizeButton(_butt);
			INC(_counter);
	
			if (_counter > 0) then {
				_counter = 0;
				INC(_modifRow);
				if (_modifRow > 1) then {
					_lastY = _specactypos;
					_modifRow = 0;
				};
				_specactypos = _lastY;
			};
		};
	
		//adding event for special action
		{
			_x ctrlAddEventHandler ["MouseButtonUp",interactMenu_onPressSpecAct];
		} foreach interactMenu_specActWidgets;
	} else {
		if (!interact_isOpenMousemode) exitWith {}; //setted on closed display
		private ["_action"];
		private _isSetted = false;
		{
			_action = _x getVariable "action";
			if (_action == cd_specialAction) then {
				_x call _setFadeSpec;
				_isSetted = true;
			};
		} foreach interactMenu_specActWidgets;
		
		if (!_isSetted) then {
			private _oldw = interactMenu_curActiveSpecAct select 0;
			if (!isNullReference(_oldw) && _oldw getVariable ["isActive",false]) then {
				_oldw setFade 0;
				_oldw commit FADE_TIME;
				_oldw setvariable ['isActive',false];
				interactMenu_curActiveSpecAct set [0,widgetNull];
			};
		};
	};
	
};

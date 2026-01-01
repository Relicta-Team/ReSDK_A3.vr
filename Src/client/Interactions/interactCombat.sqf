// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\CombatSystem\CombatSystem.hpp>
#include <interactCombat.hpp>
#include <..\..\host\text.hpp>
#define vec4(x,y,w,h) [x,y,w,h]
#include "interactCombat_defines.sqf"

#include "..\..\host\lang.hpp"

namespace(InteractCombat,interactCombat_)

macro_const(interactCombat_sizeDefaultWidth)
#define size_def_w 30

decl(void(display;vector4;int))
interactCombat_initCombatStyles = {
	params ["_d","_pos","_index",["_modeLoad",0]]; //_mode: 0 create, 1 load

	private _IDX_TEXT = ifcheck(interactCombat_csModesType==1,CS_MAP_INDEX_TEXT_RANGED,CS_MAP_INDEX_TEXT);
	private _refMap = curWidgets;
	if (_modeLoad == 0) then {
		private _cs_ref_data = interactCombat_styleMap select _index;
		private _newtext = format["<t align='center' color='%1'>%2</t>",
			_cs_ref_data select CS_MAP_INDEX_COLOR,
			_cs_ref_data select _IDX_TEXT
		];
		private _mode = _cs_ref_data select CS_MAP_INDEX_ENUM;

		private _butt = [_d,TEXT,_pos,_ctg] call createWidget;
		_butt setvariable ['mode',_mode];
		[_butt,_newtext] call widgetSetText;
		if (_mode == cd_curCombatStyle) then {_butt setFade FADE_BUT_CS; _butt commit 0; _refMap set [CM_CUR_IND_CS,_butt]};
		_butt ctrlAddEventHandler ["MouseEnter",{
			params ["_but"]; _but setBackgroundColor [.15,.15,.15,.6];
		}];
		_butt ctrlAddEventHandler ["MouseExit",{
			params ["_but"]; _but setBackgroundColor [0,0,0,0];
		}];
		_butt ctrlAddEventHandler ["MouseButtonUp",interactCombat_onPressCS];
		interactCombat_map_widgetStyles set [_mode,_butt];
	} else {
		private _newtext = format["<t align='center' color='%1'>%2</t>",
			_index select CS_MAP_INDEX_COLOR,
			_index select _IDX_TEXT
		];
		private _mode = _index select CS_MAP_INDEX_ENUM;
		private _butt = interactCombat_map_widgetStyles getOrDefault [_mode,widgetNull];
		[_butt,_newtext] call widgetSetText;
		private _old = _refMap select CM_CUR_IND_CS;
		//fade if mode
		if (_mode==cd_curCombatStyle) then {
			if !isNullReference(_old) then {
				//defade old
				_old setFade 0;
				_old commit TIME_BUT_CS;
				_refMap set [CM_CUR_IND_CS,widgetNull];
			};
			
			_butt setFade FADE_BUT_CS; 
			_butt commit TIME_BUT_CS; 
			_refMap set [CM_CUR_IND_CS,_butt];
		} else {
			if equals(_old,_butt) then {
				//defade old
				_old setFade 0;
				_old commit TIME_BUT_CS;
				_refMap set [CM_CUR_IND_CS,widgetNull];
			};
		};
	};
};

decl(void(int))
interactCombat_updateAttackTypes = {
	params [["_assocEnum",interactCombat_at_assocEnum]];
	
	if !(_assocEnum in ata_assoc_map) exitWith {
		errorformat("interactCombat::updateAttackTypes() - Undefined enum (%1)",_assocEnum);
	};

	//first update data
	private _curType = cd_curAttackType;
	private _list = ata_assoc_map get _assocEnum;
	private _doRecreate = not_equals(_list,interactCombat_at_list_types);
	interactCombat_at_list_types = _list;
	
	//closed display not 
	if !interact_isOpenMousemode exitWith {};
	if (count interactCombat_at_widgets == 0 || {isNullReference(_x)} count interactCombat_at_widgets > 0) then {
		_doRecreate = true;
	};
	
	private _d = getDisplay;
	private _ctg = _d getVariable ["combatMenuCtg",widgetNull];
	if isNullReference(_ctg) exitWith {
		error("interactCombat::updateAttackTypes() - null ctg error");
	};
	//traceformat("DO RECREATE %1",_doRecreate);

	//removing prev widgets
	if (_doRecreate) then {
		{
			[_x] call deleteWidget;
		} foreach interactCombat_at_widgets;
		interactCombat_at_widgets = [];
	};
	
	private _refMap = curWidgets;
	private _countTypes = count _list;
	private _size_h = 100 / _countTypes;
	
	private ["_pos","_butt","_oldbut"];
	
	for "_i" from 0 to _countTypes - 1 do {
		_pos = vec4(100 - size_def_w,_size_h * _i,size_def_w,_size_h);
		(_list select _i) params ["_mode","_txt"];
		
		_butt = if (_doRecreate) then {
			private _ibt = [_d,BUTTON,_pos,_ctg] call createWidget;
			_ibt setvariable ['mode',_mode];
			_ibt ctrlSetText _txt;
			interactCombat_map_attTypeWidgets set [_mode,_ibt];
			_ibt ctrlAddEventHandler ["MouseButtonUp",interactCombat_onPressAttType];
			_ibt ctrlSetTextColor [0.886,0,0.282,1];
			interactCombat_at_widgets pushBack _ibt;
			//traceformat("CHECK ATT TYPE: %1 - %2",_txt arg equals(_curType,_mode))
			if equals(_curType,_mode) then {
				_ibt setFade FADE_BUT_AT; 
				_ibt commit 0;
				_refMap set [CM_CUR_IND_ATT,_ibt];
				_ibt setVariable ["isactive",true];
			} else {
				_ibt setVariable ["isactive",false];
			};
			_ibt
		} else {
			interactCombat_map_attTypeWidgets get _mode
		};
		
		_oldbut = _refMap select CM_CUR_IND_ATT;
		if equals(_curType,_mode) then {
			
			if not_equals(_oldbut,_butt) then {
				_oldbut setFade 0;
				_oldbut commit 0;
			};
			_butt setFade FADE_BUT_AT; 
			_butt commit 0;
			_refMap set [CM_CUR_IND_ATT,_butt];
			_butt setVariable ["isactive",true];
		} else {
			if equals(_oldbut,_butt) then {
				
			};
		};

	};
	
};

decl(void())
interactCombat_load = {

	private _d = getDisplay;

	private _ctg = [_d,WIDGETGROUP,[50 - CS_SIZE_W / 2,0,CS_SIZE_W,CS_SIZE_H]] call createWidget;
	_d setVariable ["combatMenuCtg",_ctg];
	_ctg setvariable ["hiddenPos",[50 - CS_SIZE_W / 2,-CS_SIZE_H]];

	private _back = [_d,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
	_back setBackgroundColor [0,0,0,0.9];

	macro_const(interactCombat_sizeColumn)
	#define size_col 2
	inline_macro
	#define centerizeText(mes) mes

	inline_macro
	#define setFadeIfMode(checked,enum,fade,index) \
		if (equals(checked,enum)) then { \
			_butt setFade fade; _butt commit 0; \
			curWidgets set [index,_butt]; \
		}

	inline_macro
	#define allocDefButton(sizes,name,_mode) \
		_butt = [_d,BUTTON,sizes,_ctg] call createWidget; \
		_butt setvariable ['mode',_mode]; \
		_butt ctrlSetText name; \
		interactCombat_map_defTypeWidgets set [_mode,_butt]; \
		_butt ctrlAddEventHandler ["MouseButtonUp",interactCombat_onPressDef]; \
		_butt ctrlSetTextColor [0.275,0.58,0,1]

	#define allocAttTypeButton(sizes,name,_mode) \
		_butt = [_d,BUTTON,sizes,_ctg] call createWidget; \
		_butt setvariable ['mode',_mode]; \
		_butt ctrlSetText name; \
		interactCombat_map_attTypeWidgets set [_mode,_butt]; \
		_butt ctrlAddEventHandler ["MouseButtonUp",interactCombat_onPressAttType]; \
		_butt ctrlSetTextColor [0.886,0,0.282,1]

	//use interactCombat_initCombatStyles
/*	#define allocCombatStyle(pos,name,_mode) \
		_butt = [_d,TEXT,pos,_ctg] call createWidget; \
		_butt setvariable ['mode',_mode]; \
		[_butt,name] call widgetSetText; \
		if (_mode == _curCSMode) then {_butt setFade FADE_BUT_CS; _butt commit 0; curWidgets set [CM_CUR_IND_CS,_butt]}; \
		_butt ctrlAddEventHandler ["MouseEnter",{ \
			params ["_but"]; _but setBackgroundColor [.15,.15,.15,.6]; \
		}]; \
		_butt ctrlAddEventHandler ["MouseExit",{ \
			params ["_but"]; _but setBackgroundColor [0,0,0,0]; \
		}]; \
		_butt ctrlAddEventHandler ["MouseButtonUp",interactCombat_onPressCS]; */

	//category def type

	allocDefButton(vec4(0,0,size_def_w,50),"Уклонение",DEF_TYPE_DODGE);
	setFadeIfMode(cd_curDefType,DEF_TYPE_DODGE,FADE_BUT_DEF,CM_CUR_IND_DEF);

	allocDefButton(vec4(0,50,size_def_w,50),"Парирование",DEF_TYPE_PARRY);
	setFadeIfMode(cd_curDefType,DEF_TYPE_PARRY,FADE_BUT_DEF,CM_CUR_IND_DEF);

	//category attack type
	[null] call interactCombat_updateAttackTypes;
	/*allocAttTypeButton(vec4(100 - size_def_w,0,size_def_w,50),"Точечные",ATTACK_TYPE_THRUST);
	setFadeIfMode(cd_curAttackType,ATTACK_TYPE_THRUST,FADE_BUT_AT,CM_CUR_IND_ATT);

	allocAttTypeButton(vec4(100 - size_def_w,50,size_def_w,50),"Размашистые",ATTACK_TYPE_SWING);
	setFadeIfMode(cd_curAttackType,ATTACK_TYPE_SWING,FADE_BUT_AT,CM_CUR_IND_ATT);*/


	//creating cols
	_back = [_d,BACKGROUND,[size_def_w,0,size_col,100],_ctg] call createWidget;
	_back setBackgroundColor [.3,.3,.3,.7];

	_back = [_d,BACKGROUND,[100 - size_def_w - size_col,0,size_col,100],_ctg] call createWidget;
	_back setBackgroundColor [.3,.3,.3,.7];

	private _countCs = count interactCombat_styleMap;
	private _yPos = 0;
	private _size_h = 100 / _countCs;
/*	private _refCs = interactCombat_styleMap;
	private _cs_ref_data = 0;*/
	//private _curCSMode = cd_curCombatStyle;

	for "_i" from 0 to (_countCs) - 1 do {

		//_cs_ref_data = _refCs select _i;

		[
			_d,
			vec4(
					size_def_w + size_col,
					_size_h * _i,
					100 - (size_def_w * 2) - (size_col * 2),
					_size_h
				),
			_i
		] call interactCombat_initCombatStyles;
	};


	[_ctg,_ctg getVariable 'hiddenPos'] call widgetSetPositionOnly;
	_d displayAddEventHandler ["MouseMoving",interactCombat_onMouseMoving];
};

//Событие при движении мыши
decl(void(display))
interactCombat_onMouseMoving = {
	params ["_display"];

	if (isDragProcess) exitWith {};

	_ctg = _display getvariable 'combatMenuCtg';

	(call mouseGetPosition) params ["_x","_y"];

	_ctgXpos = 50 - CS_SIZE_W / 2;

	if ([_ctgXpos,0,_ctgXpos + CS_SIZE_W,10 * CS_SIZE_H / 100] call isMouseInsidePosition &&
			!interactCombat_isLoadedMenu &&
			{!verb_isMenuLoaded && interact_isMouseModeActive &&
				{!(_display getVariable ["isPreparedToDestroy",false])}
			}
		) exitWith {
		if (interactCombat_disableGlobal) exitWith {};
		interactCombat_isLoadedMenu = true;
		[_ctg,[_ctgXpos,0],TIME_TOLOAD_INTERACTCOMBAT] call widgetSetPositionOnly;
	};

	if (!([_ctgXpos,0,_ctgXpos + CS_SIZE_W,CS_SIZE_H] call isMouseInsidePosition) && interactCombat_isLoadedMenu) exitWith {
		interactCombat_isLoadedMenu = false;
		[_ctg,_ctg getVariable "hiddenPos",TIME_TOUNLOAD_INTERACTCOMBAT] call widgetSetPositionOnly;
	};
};

macro_func(interactCombat_getModeNameWidget,any(widget))
#define getMode(wid) wid getVariable "mode"

//вызывается когда нажимается один из комбат стилей
//перегрузка метода принимет первый параметр как стиль
decl(void(widget;int))
interactCombat_onPressCS = {
	params ["_ct","_butt"];
	
	if (["pressCombatStyle",0.3] call input_spamProtect) exitWith {};
	
	private _mode = ifcheck(equalTypes(_ct,widgetNull),getMode(_ct),_ct);
	
	//если самонажатие то сбрасываем
	if (_mode == cd_curCombatStyle) then { 
		_mode = COMBAT_STYLE_NO;
	};
	rpcSendToServer("onUpdCS",[player arg _mode]);
};

//событие при нажатии на кнопку типа защиты
decl(void(widget;int))
interactCombat_onPressDef = {
	params ["_ct","_butt"];
	private _mode = getMode(_ct);
	if (_mode == cd_curDefType) exitWith {};//already setted

	private _refMap = curWidgets;
	private _old = _refMap select CM_CUR_IND_DEF;
	if (not_equals(_old,widgetNull)) then {
		//defade old
		_old setFade 0;
		_old commit TIME_BUT_DEF;
	};
	SETARR(_refMap,CM_CUR_IND_DEF,_ct);
	_ct setFade FADE_BUT_DEF;
	_ct commit TIME_BUT_DEF;

	cd_curDefType = _mode;

	rpcSendToServer("onUpdateDefType",[player arg _mode]);
};

//событие при нажатии на кнопку типа атаки
decl(void(widget;int))
interactCombat_onPressAttType = {
	params ["_ct","_butt"];
	if (["pressAttackType",0.2] call input_spamProtect) exitWith {};
	private _mode = if equalTypes(_ct,"") then {_ct} else {getMode(_ct)};
	if (_mode == cd_curAttackType) exitWith {};//already setted

	rpcSendToServer("onUpdateAttackType",[player arg _mode]);
};

decl(void(string))
interactCombat_syncView_onSBH = {
	private _buffer = _this;
	//[hand(1 byte)][cur combat style(1 byte)][attacktype(2 byte)][attack typelist enum(2 byte)].[targetzone(2 byte)][spec act(2 byte)]
	//2 1 99 99.99 99
	_ah = [_buffer,"activeHand",false] call ata_buf_process;//+
	_combatStyle = [_buffer,"combatStyle",false] call ata_buf_process;//+
	_attackType = [_buffer,"attackType",false] call ata_buf_process;//+
	_attTypeList = [_buffer,"attackTypesList",false] call ata_buf_process;//+
	_tz = [_buffer,"targetZone",false] call ata_buf_process;
	_specAct = [_buffer,"specialAction",false] call ata_buf_process;//+
	
	//set only before rpc onChangeAttackType
	cd_curCombatStyle = _combatStyle;
	
	//sync hud combat overlay
	call hud_combStyle_onCombatUpdate;
	
	[cd_activeHand,_ah,true] call inventory_onChangeActiveHand;
	_combat_type = ifcheck(ATTACK_TYPE_ASSOC_IS_SHOOTING(_attTypeList),1,0);
	//rpcCall("onChangeAttackType",[_attackType arg _combat_type]);
	cd_curAttackType = _attackType;
	interactCombat_csModesType = _combat_type;
	
	//sync cs mode visual
	if (interact_isOpenMousemode) then {
		{
			[getDisplay,null,_x,1] call interactCombat_initCombatStyles;
		} foreach interactCombat_styleMap;
	};

	interactCombat_at_assocEnum = _attTypeList;
	//call only after setted cd_curAttackType
	//[_attTypeList] call interactCombat_updateAttackTypes; ONLY NEXT FRAME...
	nextFrameParams(interactCombat_updateAttackTypes,[_attTypeList]);
	cd_specialAction = _specAct;
	call hud_specAct_update;
	[false] call interactMenu_syncSpecialActions;
	
	cd_curSelection = _tz;
	call interactMenu_syncCurSelection;
	
	#ifdef SP_MODE
	call sp_gui_syncInventoryVisible;
	#endif
}; rpcAdd("onSBH",interactCombat_syncView_onSBH);

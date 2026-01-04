// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\..\host\keyboard.hpp"
#include "..\WidgetSystem\widgets.hpp"
//invokeAfterDelay({inventory_isHoldMode = true},2);

decl(bool(any;int;bool;bool;bool))
onGameInputs_Down = {
	params ["","_key","_shift","_ctrl","_alt"];

	if (isDisplayOpen) exitWith {false};
	_kupc = unpackKeyData(_this);
	#define isPressed(var) isPressedKey(_kupc,var)

	if (isPressed(input_act_inventory) && {inventory_isHoldMode}) exitWith {
		call openInventory;
		false
	};

	#ifdef SP_DEBUG
	if (_key == KEY_ADD) exitWith {
		if !(call sp_ai_debug_isCapturing) then {
			sp_ai_debug_captureMove = _ctrl;
		};
		call sp_ai_debug_processCaptureSwitch;
	};
	if (_key == KEY_NUMPADENTER) exitWith {
		call sp_ai_debug_playLastAnim;
	};
	if (_key == KEY_G && {call sp_ai_debug_isCapturing}) exitWith {
		call sp_ai_debug_addScriptedState;
	};
	#endif

	#ifdef EDITOR
	//editorDebug functionality

	if (_key in [KEY_UP,KEY_LEFT,KEY_RIGHT,KEY_DOWN]) exitWith {
		[
			["up","left","right","down"]select ([KEY_UP,KEY_LEFT,KEY_RIGHT,KEY_DOWN]find _key),
			_shift
		] call editorDebug_handleKeyPress;
	};
	if (_key in [KEY_I,KEY_J,KEY_L,KEY_K]) exitWith {
		[
			["up","left","right","down"]select ([KEY_I,KEY_J,KEY_L,KEY_K]find _key),
			_shift
		] call editorDebug_handleKeyPress;
	};
	#endif
};

//клавиши в режиме игры
decl(bool(any;int;bool;bool;bool))
onGameKeyInputs = {
	params ["","_key","_shift","_ctrl","_alt"];

	if (isDisplayOpen) exitWith {false};

	// Эскейп не хандлится
	//if (_key == KEY_ESCAPE) exitWith {
	//	[false] call esc_openMenu;
	//};

	//TODO add debug console executor with comments fix
	// #ifdef EDITOR
	// if (_key == KEY_P) exitWith {
	// 	call compile (profileNamespace getVariable 'rscdebugconsole_expression')
	// };
	// #endif

	_kupc = unpackKeyData(_this);

	#define isPressed(var) isPressedKey(_kupc,var)


	if isPressed(input_act_chatHistory) exitWith {
		call chatshowhistory;
	};
	if isPressed(input_act_openAhelp) exitwith {
		call cd_openAhelp;
	};
/*	#ifdef EDITOR
	if isPressed(input_act_craft) exitWith {
		[[1],[1]] call craft_open;
	};
	#endif*/
	if isPressed(input_act_inventory) exitWith {
		call openInventory;
	};

	if isPressed(input_act_changeActHand) exitWith {
		call inventory_changeActiveHand;
	};
	if isPressed(input_act_commandMenu) exitWith {
		[false] call cd_openSendCommandWindow
	};

	if (!([] call interact_isActive)) exitWith {};
	
	if (craft_isPreviewEnabled) exitWith {};

	if isPressed(input_act_switchTwoHands) exitWith {call inventory_changeTwoHandsMode};
	if isPressed(input_act_pointTo) exitWith {call interact_pointTo};
	
	if (!isNull(relicta_global_textChatEnabled) && {isPressed(input_act_speak)}) exitWith {call chatos_onSay};
	
	
	if isPressed(input_act_mainAction) exitWith {
		if (call smd_isStunned) exitWith {};
		call interact_onMainAction;
	};
	
	if isPressed(input_act_extraAction) exitWith {
		if (call smd_isStunned) exitWith {};
		call interact_onExtraAction;
	};
	if isPressed(input_act_dropitem) exitWith {
		[] call inventory_onDropItem;
	};
	if isPressed(input_act_putdownitem) exitWith {
		[null,true] call inventory_onPutDownItem;
	};

	if isPressed(input_act_resist) exitWith {
		if (call smd_isStunned) exitWith {};
		call interact_processResist;
	};
	if isPressed(input_act_examine) exitWith {
		call interact_examine;
	};
	if isPressed(input_act_combatMode) exitWith {
		if (call smd_isStunned) exitWith {};
		if (call input_passThroughWallsProtect) exitWith {};
		[!([player] call smd_isCombatModeEnabled)] call interact_setCombatMode;
	};

	// next all debuger inputs
#ifdef EDITOR

	if (_key == KEY_U) exitWith {
		call proxEd_openEditor;
	};
	// if (_key == KEY_J) exitWith {
	// 	call ped_openMenu
	// };
	// if (_key == KEY_K) exitWith {
	// 	call led_openMenu;
	// };
	#define attr ([#st,#ht,#dx,#iq,#fp,#will,#per,#hp] select ind_stat)
	#define dbg_addAtr(name,amount) [(player),amount] call ((player) getVariable 'proto' getVariable ('add'+ name))

	if (_key == KEY_N) exitWith {
		call relicta_debug_openPPEditor;
	};
	if (_key == KEY_M) exitWith {
		if (isnil {ind_stat}) then {ind_stat = 0};
		if (_shift) then {
			DEC(ind_stat);
			if (ind_stat < 0) then {ind_stat = 7};
		} else {
			INC(ind_stat);
			if (ind_stat >= 8) then {ind_stat = 0};
		};

		warningformat("NOW CURRENT STAT IS <%1>",toUpper attr);
	};

	if (_key == KEY_COMMA) exitWith {//left
	    //code
		dbg_addAtr(attr,-1);
	};
	if (_key == KEY_PERIOD) exitWith {//right
		dbg_addAtr(attr,1);
	};
#endif
};

//мышь в режиме игры
decl(bool(any;int;any;any;bool;bool;bool))
onGameMouseInputs = {
	params ["","_button", "", "", "_shift", "_ctrl", "_alt"];

	if (isDisplayOpen || call smd_isStunned || !([] call interact_isActive)) exitWith {false};
	if (craft_isPreviewEnabled) exitWith {};

	#ifdef EDITOR
	if ([_button,_shift,_ctrl,_alt] call inputDebug_handleMouseEvent) exitWith {false};
	#endif

	if (_button == MOUSE_LEFT) exitwith {
		[true] call interact_onLMBPress
	};
	if (_button == MOUSE_RIGHT) exitWith {
		[true] call interact_onRMBPress;
	};
};

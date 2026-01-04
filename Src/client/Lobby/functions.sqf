// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\..\host\keyboard.hpp"
#include "..\WidgetSystem\widgets.hpp"

namespace(Lobby,lobby_)

macro_const(lobby_color_background)
#define BACKGROUND_COLOR [0,0,0,0.7]
macro_const(lobby_time_onload)
#define TIME_ONLOAD 2.2

macro_func(lobby_getLoadingTimeout,float())
#define LOBBY_LOADING_TIME rand(10,20)
macro_const(lobby_hint_time_minimum)
#define LOBBY_HINT_TIME_MINIMUM 2.5
macro_const(lobby_hint_time_per_symbol)
#define LOBBY_HINT_TIME_PER_SYMBOL 0.07


decl(void(...any[]))
lobbyOpen = {

	private _settings = _this;

	if (isInventoryOpen) then {
		if (inventory_isOpenContainer) then {
			call inventory_closeContainer;
		};
		call inventory_resetPositionHandWidgets;call closeInventory_handle;
	};
	if (craft_isMenuOpen) then {call craft_close};
	if (esc_isMenuOpened) then {call esc_closeMenu};
	if (nd_isOpenDisplay) then {call nd_onClose};
	if (chat_isHistoryOpen) then {chat_isHistoryOpen = false; call displayClose};

	//fix after 0.8.281 (дисплей закрывается только в след кадре)
	if (isDisplayOpen) exitWith {
		nextFrameParams(lobbyOpen,_settings);
	};

	//dispose smd serivce
	call smd_stopUpdate;

	[] call discrpc_setInLobbyStatus; //discord interact in lobby

	private _hasSettings = !isNullVar(_settings) && {count _settings > 0};

	isLobbyOpen = true;
	
	nd_lobby_isOpen = false;
	
	lobby_isReadyToPlay = false;

	lobby_charSetWidList = [];
	lobby_openedCharSetWidList = [];
	lobby_listResizingName = [];

	[true] call setBlackScreenGUI;

	lobby_sys_isActive = false;

	lobby_isSelectedEmbarkRole = false;

	private _d = call displayOpen;

	//hide ingame chat
	private _ingameChat = (call chatgetwidget);
	_ingameChat setFade 1;
	_ingameChat commit 0;

	private _pic = [_d,PICTURE,[0,0,100,100]] call createWidget;
	setBackground(_pic);
	_pic setFade 1;
	_pic commit 0;
	_pic setFade 0;
	_pic commit (TIME_ONLOAD / 2);

	lobby_backgroundWidget = [_pic];
	[_pic,lobby_background] call widgetSetPicture;

	//sprites
	#ifdef LOBBY_USING_SPRITE_RENDERER
		//call
		call (lobby_sprite_onUpdateCode);
	#endif

	//if true exitWith {}; //for testing sprites
	//---------- create inlobby chat --------------

	private _wgTf = [_d,WIDGETGROUP_H,[0,0,CHAT_SIZE_X,90]] call createWidget;
	_wgTf setFade 1;
	_wgTf commit 0;
	setTextFieldWg(_wgTf);

	//			------------- chat input ---------------
	_sendButt = [_d,BUTTONMENU,[0,90,5,5]] call createWidget;
	setButtonSend(_sendButt);
	_sendButt ctrlSetText ">>>";
	_sendButt setBackgroundColor [0.1,0.235,0,0.7];
	_sendButt ctrlAddEventHandler ["MouseButtonUp",{
		params ["_butt","_key"];

		_text = ctrlText getInputChat;
		_text call lobby_onSendChatMessage;
		getInputChat ctrlSetText "";

	}];

	_inpChat = [_d,INPUTCHAT,[5,90,CHAT_SIZE_X - 5,5]] call createWidget;
	setInputChat(_inpChat);

	_inpChat ctrlAddEventHandler ["KeyUp",{
		params ["_butt","_key"];

		if (_key == KEY_RETURN) then {
			_text = ctrlText getInputChat;
			_text call lobby_onSendChatMessage;
			getInputChat ctrlSetText "";
		};

	}];

	private _bg = [_d,BACKGROUND,[0,0,100,100],_wgTf] call createWidget;//бэкграунд чата
	_bg setBackgroundColor BACKGROUND_COLOR;
	_wgTf setVariable ['background',_bg];
	//_bg setVariable ['minpos',ctrlPosition _bg]; //does not use

	private _tf = [_d,TEXT,[0,0,100,100],_wgTf] call createWidget;
	setTextField(_tf);
	setFocus _tf;

	//auto scroll chat
	_wgTf call widgetWGScrolldown;


	//ready button
	_rb = [_d,TEXT,[50 - READY_BUTTON_SIZE_X / 2,90,READY_BUTTON_SIZE_X,5]] call createWidget;
	setReadyButton(_rb);
	_rb setBackgroundColor READY_BUTTON_COLOR_OFF;
	call lobby_initReadyButton;
	_rb ctrlAddEventHandler ["MouseButtonUp",lobby_switchReady];


	// -------------- create main -------------
	private _ctg = [_d,WIDGETGROUP,[CHAT_SIZE_X + 1,20,CHARSETMENU_SIZE_X,60]] call createWidget;
	setMainCtg(_ctg);

	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	setMainWid('background',_back);
	_back setBackgroundColor [.6,.6,.6,0.6];

	setMainWid("currentControl",widgetNull);
	//init some buttons
	//left lifeline
	_biasX = 2;
	_biasY = 2; setMainProp("biasY",_biasY);
	_curY = 2;
	_curX = 2;
	_sizeH = 5; setMainProp("sizeH",_sizeH);
	_sizeW = 30 - _biasX;

	#define addWid(type,pos) [_d,type,pos,_ctg] call createWidget
	#define vec4(x,y,w,h) [x,y,w,h]
	#if __GAME_VER_MIN__ < 01
		#define initButtonMenu(wid) wid ctrlSetFont "PuristaBold";wid ctrlSetBackgroundColor [0,0,0,0.1]; wid ctrlSetFontHeight 0.8;
	#else
		//В дебаг ветке сломан ctrlSetFontHeight
		#define initButtonMenu(wid) wid ctrlSetFont "PuristaBold";wid ctrlSetBackgroundColor [0,0,0,0.1];
	#endif
	#define iniTextInfoStyle(wid) lobby_charSetWidList pushBack wid; wid setBackgroundColor [0,0,0,0.1]
	#define iniText(text) _wid ctrlSetText (text)
	#define iniVar(var) setMainWid(var,_wid); lobby_charSetWidList pushBack _wid
	#define iniOnSetCode(code) _wid setVariable ["onSetCode",code]
	#define iniOnPress(event) _wid ctrlAddEventHandler ["MouseButtonUp",event]
	#define iniVarResizingName(name) iniVar(name); lobby_listResizingName pushBack name

	// face
	_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW,_sizeH));
	//_wid ctrlEnable false;
	initButtonMenu(_wid);
	iniText("Лицо: случайно");
	iniVar("setFace");
	iniOnPress(lobby_setFace);
	iniOnSetCode(lobby_onSetFaceCode);
	MOD(_curY,+_sizeH + _biasY);

	//hairstyle  
	#ifndef DISABLE_NOT_USED_SETTINGS
		_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW - _sizeW / 6 - _biasX / 2,_sizeH)); initButtonMenu(_wid);
		iniText("Волосы: нет");
		iniVar("setHair");
			//hair color
			_wid = addWid(BUTTONMENU,vec4(_curX + (_sizeW - _sizeW / 6),_curY,_sizeW / 6,_sizeH)); initButtonMenu(_wid);
			iniVar("setHairColor");
		MOD(_curY,+_sizeH + _biasY);
	#endif

	//beards
	#ifndef DISABLE_NOT_USED_SETTINGS
		_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW - _sizeW / 6 - _biasX / 2,_sizeH)); initButtonMenu(_wid);
		iniText("Борода: нет");
		iniVar("setBeard");
			//beards color
			_wid = addWid(BUTTONMENU,vec4(_curX + (_sizeW - _sizeW / 6),_curY,_sizeW / 6,_sizeH)); initButtonMenu(_wid);
			iniVar("setBeardColor");
		MOD(_curY,+_sizeH + _biasY);
	#endif

	//bloodtype
	#ifndef DISABLE_NOT_USED_SETTINGS
		_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW ,_sizeH)); initButtonMenu(_wid);
		iniText("Кровь: AB+");
		iniVar("setBlood");
		iniOnPress(lobby_setBlood);
		iniOnSetCode(lobby_onSetBloodCode);
		MOD(_curY,+_sizeH + _biasY);
	#endif

	//eyes
	#ifndef DISABLE_NOT_USED_SETTINGS
		_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW ,_sizeH)); initButtonMenu(_wid);
		iniText("Глаза: ");
		iniVar("setEyeColor");
		MOD(_curY,+_sizeH + _biasY);
	#endif

	//addict (vice)
	#ifndef DISABLE_NOT_USED_SETTINGS
		_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW ,_sizeH)); initButtonMenu(_wid);
		iniText("Недостаток: случайно");
		iniVar("setVice");
		iniOnPress(lobby_setVice);
		iniOnSetCode(lobby_onSetViceCode);
		MOD(_curY,+_sizeH + _biasY);
	#endif

	//main hand
	_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW ,_sizeH)); initButtonMenu(_wid);
	iniText("Правша");
	iniVar("setMainHand");
	iniOnPress(lobby_onSetMainHand);
	iniOnSetCode(lobby_onSetMainHandCode);
	MOD(_curY,+_sizeH + _biasY);

	// ========= CENTER ===========
	_curX = _biasX * 2.5 + _sizeW;
	_curY = _biasY;

	//name
	_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW * 1.08 - _sizeW * 1.08 / 6 - _biasX / 2,_sizeH)); initButtonMenu(_wid);
	iniText("Имя");
	iniVar("setName");
	iniOnPress(lobby_setName);
	iniOnSetCode(lobby_onSetNameCode);

	//rand name
	_wid = addWid(BUTTONMENU,vec4(_curX + (_sizeW * 1.08 - _sizeW * 1.08 / 6),_curY,_sizeW * 1.08 / 6,_sizeH));
	iniOnPress(lobby_onSetRandomName);
	iniVar("setRandomName");
	MOD(_curY,+_sizeH + _biasY);
	/*_randomizeColor = {
		private _wid = _this select 0;
		if equals(_wid,widgetNull) exitWith {
			stopThisUpdate();
		};
		_wid setBackgroundColor [random 1,random 1,random 1,rand(0.2,0.8)];
	}; startUpdateParams(_randomizeColor,1,_wid);*/

	// Возраст
	_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW * 1.08,_sizeH)); initButtonMenu(_wid);
	iniText("Возраст");
	iniVarResizingName("setAge");
	iniOnPress(lobby_setAge);
	iniOnSetCode(lobby_onSetAgeCode);
	MOD(_curY,+_sizeH + _biasY);

	// Потолок
	_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW * 1.08,_sizeH)); initButtonMenu(_wid);
	iniText("Пол");
	iniVarResizingName("setGender");
	iniOnPress(lobby_onSetGender);
	iniOnSetCode(lobby_onSetGenderCode);
	MOD(_curY,+_sizeH + _biasY);

	// =------------------> CENTER FUNCTIONALITY

	// family
	#ifndef DISABLE_NOT_USED_SETTINGS
		_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW * 1.08,_sizeH)); initButtonMenu(_wid);
		iniText("Одиночество");
		iniVarResizingName("setFamily");
		iniOnPress(lobby_onSetFamily);
		iniOnSetCode(lobby_onSetFamilyCode);
		MOD(_curY,+_sizeH + _biasY);
	#endif

	// faith
	_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW * 1.08,_sizeH)); initButtonMenu(_wid);
	iniText("Вера: Аккузат");
	iniVarResizingName("setFaith");
	iniOnPress(lobby_setFaith);
	iniOnSetCode(lobby_onSetFaithCode);
	MOD(_curY,+_sizeH + _biasY);

	//antag
	_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW * 1.08,_sizeH)); initButtonMenu(_wid);
	iniText("Злодей - нет.");
	iniVarResizingName("setAntag");
	iniOnPress(lobby_setAntag);
	iniOnSetCode(lobby_onSetAntagCode);
	MOD(_curY,+_sizeH + _biasY);

	#ifndef DISABLE_NOT_USED_SETTINGS
		//define trait
		_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW * 1.08,_sizeH)); initButtonMenu(_wid);
		iniText("Особенность?!");
		iniOnPress(lobby_setTrait);
		iniVarResizingName("setTrait");
		MOD(_curY,+_sizeH + _biasY);
	#endif

	// ===== RIGHT ====
	_curX = _biasX * 5 + _sizeW * 2;
	_curY = _biasY;


	_text = [_d,TEXT,[_curX,_curY,_sizeW,_sizeH],_ctg] call createWidget;

	[_text,"<t align='center'>Выбранные роли:</t>"] call widgetSetText;
	iniTextInfoStyle(_text);
	MOD(_curY,+_sizeH + _biasY);


	//roles
	_wid = addWid(TEXT,vec4(_curX,_curY,_sizeW,_sizeH)); initButtonMenu(_wid);
	_wid setvariable ['roleIndex',1];
	iniText("Роль 1");
	iniVar("setRole1");
	iniOnPress(lobby_setRole);
	iniOnSetCode(lobby_onSetRoleCode);
	MOD(_curY,+_sizeH + _biasY);


	call lobby_sysLoadMenu;

	true call lobby_onLoad;


	// special internal flag for disable reload faces on gender update
	//private _isLoadSettingsFlag = true;

	if _hasSettings then {
		_settings call lobby_loadSettings;
	} else {

		// Загрузка настроек персонажа из памяти
		private _vdata = null;
		{
			_vdata = lobby_charData getVariable _x;
			if isNullVar(_vdata) exitWith {
				rpcCall("clientDisconnect",vec2("Ошибка загрузки лобби","Не удалось загрузить пользовательские данные"));
			};
			// fix varg if role field
			if ("role" in _x) then {_vdata=_vdata select 0};

			rpcCall("onCharSettingCallback",vec2(_x,_vdata));
		} foreach (allVariables lobby_charData);
	};

	//set main lobby state
	"lobby" call client_setState;

	call lobby_initLoadingScreen;

	#ifdef SP_MODE
		private _b = [_d,BACKGROUND,WIDGET_FULLSIZE] call createWidget;
		_b setBackgroundColor [0,0,0,1];
		_b ctrlEnable true;
		ctrlSetFocus _b;
		startAsyncInvoke
		{
			params ["_b"];
			if !isNullReference(_b) then {
				ctrlSetFocus _b;
			};

			isNullReference(_b)
		},{},
		[_b]
		endAsyncInvoke
		
	#endif
};

decl(bool)
lobby_isMusicEnabled = true;

decl(void(bool))
lobby_handleMusic = {
	params ["_mode"];
	if (_mode) then {
		if (music_lobbyTheme != "") then {
			[music_lobbyTheme,MUSIC_CHANNEL_LOBBY,
				[
					["repeat",MUSIC_REPEAT_YES],
					["smooth",MUSIC_SMOOTH_FULL],
					["wait",false]
				]
			] call music_play;
		};
	} else {
		[MUSIC_CHANNEL_LOBBY] call music_stop;
	};
};

decl(void(bool))
lobby_onLoad = {
	private _isOpenMode = _this;

	if (_isOpenMode) then {

		if (call gmc_isRoundPreload) then {
			getMainCtg setFade 1;
			getMainCtg commit 0;
			getMainCtg ctrlEnable false;

		};
	};

	private _finMode = if (_isOpenMode) then {
		lobby_isMusicEnabled
	} else {
		false
	};
	[_finMode] call lobby_handleMusic;


	private _fade = if (_isOpenMode) then {0} else {1};

	#ifdef FAST_INIT_LOBBY
		#define TIME_ONLOAD 0
	#endif

	getBackground setFade _fade;
	getBackground commit (TIME_ONLOAD * 1.5);

	getTextFieldWg setFade _fade;
	getTextFieldWg commit TIME_ONLOAD;

	if (_isOpenMode) then {
		(call chat_getAllText) call chat_onRenderLobby;
	};
};

decl(void())
lobby_initLoadingScreen = {
	if (!isMultiplayer) exitwith {};
	#ifdef DEBUG
	if (true) exitwith {};
	#endif

	private _wEnabled = [];
	{
		if (ctrlEnabled _x) then {
			_wEnabled pushBack _x;
			_x ctrlEnable false;
			_x ctrlShow false;
		};
	} foreach [getButtonSend,getInputChat,getSettingCtg,getTextFieldWg,getMainCtg];

	private _d = getDisplay;
	_d setvariable ["__lobby_hints_loadingProgress",true];
	private _ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;
	private _back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0,0,0,1];

	_loadTime = LOBBY_LOADING_TIME;

	_srnd = 170;
	_px = -(_srnd-100) + rand(0,70);
	_py = -(_srnd-100) + rand(0,70);

	//_px = -50;
	//_py = -50;
	_backer = [_d,PICTURE,[_px,_py,_srnd,_srnd],_ctg] call createWidget;
	[_backer,"rel_ui\Assets\backer.paa"] call widgetSetPicture;
	[_backer,[randInt(-20,20) + _px,randInt(-20,20) + _py,_srnd*1.2,_srnd*1.2],_loadTime * 3.5] call widgetSetPosition;

	private _txt = [_d,TEXT,[50-60/2,50,60,50],_ctg] call createWidget;

	//focused handler
	startAsyncInvoke
		{
			params ["_d","_txt"];
			
			if isNullReference(_txt) exitWith {true};

			ctrlSetFocus _txt;
			//trace("DISABLED INPUT");
			disableUserInput true;
			false
		},
		{
			//trace("ENABLED INPUT");
			disableUserInput false;
			//костылики...
			if (userInputDisabled) then {
				while {userInputDisabled} do {
					disableUserInput !userInputDisabled;
				};
			};
		},
		[_d,_txt]
	endAsyncInvoke

	_ctg setVariable ["txt",_txt];

	private _deleteCode = {
		params ["_wEnabled","_ctg"];
		{
			if !isNullReference(_x) then {
				_x ctrlEnable true;
				_x ctrlShow true;
			};
		} foreach _wEnabled;
		
		if !isNullReference(_ctg) then {
			[_ctg getvariable "txt"] call deleteWidget;
			widgetSetFade(_ctg,1,0.7);
			getDisplay setvariable ["__lobby_hints_loadingProgress",null];
			invokeAfterDelayParams(deleteWidget,0.71,[_ctg]);
		};
	};
	invokeAfterDelayParams(_deleteCode,_loadTime,vec2(_wEnabled,_ctg));
	
	private _algPickRand = {
		params ["_t","_curidx"];
		private _copyHints = array_copy(lobby_loading_allHints);
		if (_curidx != -1) then {
			_copyHints deleteAt _curidx;
		};
		_newtxt = pick _copyHints;
		_newidx = lobby_loading_allHints find _newtxt;
		[_t,format["<t align='center' size='1.6' font='RobotoCondensed' color='#66AD78'>%1</t>",_newtxt]] call widgetSetText;
		forceunicode 1;
		_EXREF_TIME =  ((count _newtxt) * LOBBY_HINT_TIME_PER_SYMBOL) max LOBBY_HINT_TIME_MINIMUM;
		_newidx
	};
	private _EXREF_TIME = 1;
	private _newidx = [_txt,-1] call _algPickRand;
	private _aftercallCode = {
		params ["_txt","_newidx","_algPickRand","_aftercallCode"];
		if isNullReference(_txt) exitWith {};
		_EXREF_TIME = 1;
		_newidx = [_txt,_newidx] call _algPickRand;
		invokeAfterDelayParams(_aftercallCode,_EXREF_TIME,[_txt arg _newidx arg _algPickRand arg _aftercallCode]);
	};
	invokeAfterDelayParams(_aftercallCode,_EXREF_TIME,[_txt arg _newidx arg _algPickRand arg _aftercallCode]);
};

decl(void(...any[]))
lobby_loadSettings = {

	{
		rpcCall("onCharSettingCallback",_x);
	} foreach _this;
};

decl(void(string))
lobby_onSendChatMessage = {
	private _text = _this;

	_text = sanitize(_text);

	if (_text == "") exitWith {};
	if (count _text > 2048) exitWith {
		warningformat("lobby::onSendChatMessage() - Message size exceeded by %1 bytes",count _text - 2048);
	};

	rpcSendToServer("onSendLobbyMessage",[clientOwner arg _text]);
	//[profileNameSteam + ": " + _text] call chatPrint;
};

decl(bool)
lobby_internal_progressclose = false;

decl(void())
lobbyClose = {
	if (lobby_internal_progressclose) exitWith {};
	
	lobby_internal_progressclose = true;
	
	//Защита от ломания логики эскейпа в лобби
	if (getDisplay getVariable ["escapeMenu_isOpenedInLobbyContext",false]) then {
		call esc_closeMenu;
	};

	false call lobby_onLoad;

	_postCode = {
		#define DEFADE_GUI_ELEMENTS_TIME 5
		
		call nd_closeND_lobbyImpl;
		
		isLobbyOpen = false;
		call displayClose;
		//[false arg DEFADE_GUI_ELEMENTS_TIME] call setBlackScreenGUI; //DO NOT DISABLE BLACK SCREEN
		private _ingameChat = (call chatgetwidget);
		_ingameChat setFade 0;
		_ingameChat commit DEFADE_GUI_ELEMENTS_TIME;
		lobby_internal_progressclose = false;
	};

	invokeAfterDelay(_postCode,TIME_ONLOAD * 1.5);
};

decl(void(int;int))
lobby_onChangeGameState = {
	params ["_oldState","_newState"];

	if (!isLobbyOpen) exitWith {

	};


	_newState = _newState call gmc_getState;
	_oldStateName = _oldState call gmc_getState;

	//gamemode loadede
	if (_newState == "GAME_STATE_END") exitWith {
		invokeAfterDelay(lobby_initReadyButton,0.01);
	};
	if (_newState == "GAME_STATE_LOBBY" && _oldStateName == "GAME_STATE_PRELOAD") exitWith {
		//enable visible char set
		if (!lobby_sys_isActive) then {
			getMainCtg setFade 0;
			getMainCtg commit 0.5;
			getMainCtg ctrlEnable true;
		};

		invokeAfterDelay(lobby_initReadyButton,0.4);
	};
	//round started
	if (_newState == "GAME_STATE_PLAY" && (_oldStateName == "GAME_STATE_LOBBY")) exitWith {
		invokeAfterDelay(lobby_initReadyButton,0.4); //минимальная задержка от пролагов сети (400 мс)
	};
};

//коллбэк сервера на показ списка ролей
decl(void(any[]|int))
lobby_openSelectLateRole = {
	_data = _this;

	if (!isLobbyOpen) exitWith {
		error("lobby::openeSelectLateRole() - Lobby already closed");
	};

	__closeButtonHandle = {nextFrameParams({call lobby_onCloseSetting; getReadyButton ctrlEnable true;},_this)};

	__closingEvent = {
		_close = [getDisplay,BUTTON,[10 + 41,91,39,8],getMainCtg] call createWidget;
		_close ctrlSetText "Отмена";
		addWidToList(_close);
		_close ctrlAddEventHandler ["MouseButtonUp",__closeButtonHandle];
	};

	if equalTypes(_data,0) exitWith {
		//настройки теже или ошибка на сервере. не пускать!
		if (_data == -1) exitWith {
			getReadyButton ctrlEnable true;
		};

		false call lobby_setEnableCharSetting;
		_w = [getDisplay,TEXT,[5,90-60,90,60],getMainCtg] call createWidget;
		//[_w,sbr + "<t align='center'>Вы недавно умерли и сможете взять новую роль через " + ([_data,["секундочку","секундочки","секундочек"],true] call toNumeralString) + "</t>"] call widgetSetText;
		addWidToList(_w);
		_close = widgetNull;
		call __closingEvent;

		__evOnFrame = {
			(_this select 0) params ["_data","_w","__closeButtonHandle","_close"];

			if (_data <= 0) exitWith {stopThisUpdate(); call __closeButtonHandle};
			if (isNullReference(_w) || isNullReference(_close)) exitWith {stopThisUpdate(); call __closeButtonHandle};
			if (_data <= 5) then {_close ctrlEnable false; _close ctrlShow false};

			[_w,sbr + "<t align='center' size='1.8'>Вы недавно умерли и сможете взять новую роль через " + ([_data,["секундочку","секундочки","секундочек"],true] call toNumeralString) + "</t>"] call widgetSetText;

			(_this select 0) set [0,_data - 1];
		}; startUpdateParams(__evOnFrame,1,vec4(_data,_w,__closeButtonHandle,_close));
	};

	_gameDuration = _data deleteAt 0;

	false call lobby_setEnableCharSetting;

	_randmes = pick ["Выбери кем хочешь стать","Выбери свой путь","Выбери кем быть","А кто ты?"];
	_randtime = pick [
		"Игра идёт уже: ",
		"Куралесим на протяжении ",
		"Суета наводится ",
		"История пишется ",
		"Мир живёт ",
		"Раунд длится: "
	];

	_timeVal = floor(_gameDuration / 60);
	_timeText = if (_timeVal <= 0) then {
		"История только началась"
	} else {
		_randtime + str _timeVal + ([_timeVal,[" минуту"," минуты"," минут"]]call toNumeralString);
	};

	_w = [getDisplay,TEXT,[10,0,80,20],getMainCtg] call createWidget;
	[_w,sbr + "<t align='center'>" + _randmes + "</t>" + sbr +sbr + _timeText] call widgetSetText;
	addWidToList(_w);

	_list = [getDisplay,LISTBOX,[10,20,80,70],getMainCtg] call createWidget;
	addWidToList(_list);

	{
		_x params ["_name","_class"];
		_ind = _list lbAdd _name;
		_list lbSetData [_ind, _class];
	} foreach _data;

	setMainWid("currentControl",_list);

	_select = [getDisplay,BUTTON,[10,91,39,8],getMainCtg] call createWidget;
	_select ctrlSetText "Выбрать";
	addWidToList(_select);
	_select ctrlAddEventHandler ["MouseButtonUp",{nextFrameParams(lobby_onSelectedLateRole,_this)}];

	//closing button
	call __closingEvent;

}; rpcAdd("onSelectLateRole",lobby_openSelectLateRole);

decl(void())
lobby_onSelectedLateRole = {

	_list = getMainWid("currentControl");
	_ind = lbCurSel _list;
	if (_ind == -1) then {
		_mes = pick ["А роль-то и не выбрана.","Ты забыл сделать выбор","Нужно выбрать роль"];
		[_mes,"error"] call chatPrint;
	} else {

		_roleClass = _list lbData _ind;
		rpcSendToServer("spawnSelectedLateRole",[_roleClass arg clientOwner]);
	};

	//only after getting data
	call lobby_onCloseSetting;
	getReadyButton ctrlEnable true;
};

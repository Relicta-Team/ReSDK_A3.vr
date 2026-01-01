// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\..\host\oop.hpp"
#include "..\..\host\text.hpp"
#include "..\..\host\keyboard.hpp"
#include <..\WidgetSystem\widgets.hpp>
#include <..\Inventory\helpers.hpp>


#include <..\..\host\CombatSystem\CombatSystem.hpp>
#include <..\..\host\SpecialActions\SpecialActions.hpp>
#include <..\..\host\GameObjects\Mobs\MobSkills_idx.hpp>

#include <..\Rendering\Camera\CameraControl.hpp>

#include <..\ClientRpc\clientRpc.hpp>

#include <ClientData.hpp>

#include "ClientDataGamemode.sqf"

#include "EyeHandler.sqf"

#include "SendCommand.sqf"

#include "EscapeMenu.sqf"

#include "VersionViewer.sqf"

#include "ClientData_ConnectionManager.sqf"

#include "ClientData_forceWalk.sqf"

#include "ClientData_customAnims.sqf"

namespace(clientData,cd_)

//уникальное имя клиента
decl(string)
cd_clientName = "";
decl(string)
cd_charName = "Обитатель Сети";
inline_macro
#define sk_nan [0,0]
decl(string[])
cd_skillNames = ["СЛ","ИН","ЛВ","ЗД","ВНС","ВОЛЯ","ВОС","ЖЗ"];
decl(int[][])
cd_skills = [sk_nan,sk_nan,sk_nan,sk_nan,sk_nan,sk_nan,sk_nan,sk_nan]; //массив со скиллами

//stamina vars
decl(float)
cd_stamina_cur = 100;
decl(float)
cd_stamina_max = 100;

//if client get new skills data - apply this
decl(void(...any[]))
cd_OnSkillsUpdate = {
	private _skillList = _this;
#ifdef DEBUG
	_skillList = parseSimpleArray str _skillList;
#endif
	{
		_x params ["_id","_val"];
		if (_val isEqualType []) then {
			cd_skills set [_id,_val];
			/*switch _id do {
				#define interp(skill) linearConversion [1, 100, (cd_skills select skill select 0) + (cd_skills select skill select 1), 0.5, 2]
				case SKILL_INDEX_ST: {["internal\skillcheckst",player,1,interp(_id),100,"wav"] call soundLocal_play};
				case SKILL_INDEX_DX: {["internal\skillcheckdx",player,1,interp(_id),100,"wav"] call soundLocal_play};
				case SKILL_INDEX_IQ: {["internal\skillcheckiq",player,1,interp(_id),100,"wav"] call soundLocal_play};
				case SKILL_INDEX_HT: {["internal\skillcheckht",player,1,interp(_id),100,"wav"] call soundLocal_play};
			};*/
		} else {
			errorformat("Wrong type in param ClientData::OnSkillUpdate() -> %1",toLower typename _val);
			traceformat("Errored enum - %1 in array %2", _forEachindex arg _skillList)

		};
	} foreach _skillList;

	call interactMenu_onUpdateSkills;
}; rpcAdd("OnSkillsUpdate",cd_OnSkillsUpdate);

//текущая зона взаимодействия
decl(int)
cd_curSelection = TARGET_ZONE_TORSO;
decl(int)
cd_specialAction = SPECIAL_ACTION_NO;

//комбат штуки
decl(string)
cd_curDefType = DEF_TYPE_DODGE;
decl(string)
cd_curCombatStyle = COMBAT_STYLE_NO;
decl(string)
cd_curAttackType = ATTACK_TYPE_THRUST;
decl(int)
cd_activeHand = INV_HAND_L;
//last combat action colorizer
decl(int)
cd_lca_r = 0;
decl(int)
cd_lca_l = 0;

decl(int) cd_cameraSetting = CAMERA_MODE_ARCADE;
[cd_cameraSetting] call cam_setCameraSetting;

decl(int) cd_videoSettings = VIDEO_SETTINGS_MAX; //пользовательские настройки графики
decl(void(int))
cd_setVideoSettings = {
	private _value = _this;

	if not_equalTypes(_value,0) exitWith {
		errorformat("cd::setVideoSettings() - Unexpected type %1",tolower typename _value);
	};
	if (_value < VIDEO_SETTINGS_MIN || _value > VIDEO_SETTINGS_MAX) exitWith {
		error("cd::setVideoSettings() - Unknown enum value");
	};

	if (cd_videoSettings == _vaule) exitWith {};

	cd_videoSettings = _value;

	//do reload light
	call le_reloadLightSystem;

}; rpcAdd("setVideoSettings",cd_setVideoSettings);

#include "ClientDataUnconscious.sqf"

decl(void(vector3;int))
cd_onPrepareClient = {

	params ["_atlPos","_vision"];

/*	cd_skills = _skills;
	cd_curSelection = _targZone;
	cd_specialAction = _specAct;

	//combat
	cd_curDefType = _def;
	cd_curCombatStyle = _cstyle;
	cd_curAttackType = _attType;
	
	cd_activeHand = _actHand;
	[null,_actHand] call inventory_onChangeActiveHand;*/

	//todo preliminary handle unconscious state

	//discord interaction
	call discrpc_setPlayingStatus;

	//before init setposition
	player setPosAtl _atlPos;

	//initialize chunk system
	call noe_client_startListening;

	//create temp object
	private _tempObject = createSimpleObject ["rel_vox\obj\block_dirt.p3d",[0,0,0],true];
	_tempObject setposatl _atlPos;

	//async await section
	_asyncPositionCheck = {
		(_this select 0) params ["_atlPos","_timestamp","_hasError","_tempObject","_vision"];
		if (_hasError) then {
			error("Initialization timeout...");
			rpcCall("clientDisconnect",vec2("Ошибка инициализации персонажа","Истекло время ожидания инициализации персонажа"));
			stopThisUpdate();
		};
		//if (_timestamp + 5 < tickTime) exitWith {};

		_aslPos = ATLToASL _atlPos;
		_trace = lineIntersectsSurfaces [
			_aslPos,
			_aslPos vectorAdd [0,0,-500],
			player,
			objNull,
			true,
			1,
			"GEOM",
			"NONE"
		];

		if (tickTime > (_timestamp + 120) && {!_hasError}) then {
			(_this select 0) set [2,true];
			errorformat("<async>__rpc::onPrepareClient() - Load position %1 timeout",_atlPos);
		};

		_tempObject setposatl (_atlPos vectordiff [0,0,0.1]);

		#ifdef SP_MODE
		_trace = [[0,0,_tempObject]];
		#endif

		if (count _trace == 0) then {
			player setPosAtl _atlPos;
		} else {
			if (not_equals(_trace select 0 select 2,objNULL) && {call noe_client_isPlayerPositionChunksLoaded}) then {
				deleteVehicle _tempObject;

				trace("Position loaded");
				player setPosAtl _atlPos;
				player setVelocity [0,0,0];

				//run smd service
				call smd_startUpdate;

				//initialize antigeometry after chunks loaded
				call gf_start;

				//initialize onesync services
				call os_start;

				//enable atmos packets
				[true] call noe_client_nat_setEnabled;

				//set client game state
				"game" call client_setState;

				rpcCall("onChangeEyeState",[_vision arg "load"]);

				call vs_connectToVoiceSystem;

				stopThisUpdate();

				#ifdef SP_MODE
				if (!sp_gc_isPlayerInitialized) then {
					sp_gc_isPlayerInitialized = true;
					[call sp_getActor] call sp_gc_onPlayerAssigned;
				};
				#endif
			} else {
				if (_atlPos distance (getPosATL player) > 1) then {
					player setPosATL _atlPos;
				};
			};

		};
	};

	startUpdateParams(_asyncPositionCheck,0,[_atlPos arg tickTime arg false arg _tempObject arg _vision]);

}; rpcAdd("onPrepareClient",cd_onPrepareClient);

decl(vector3)
cd_internal_lastTPPos = vec3(0,0,0);
decl(NULL|float)
cd_internal_lastTPDir = null;
decl(int)
cd_internal_tpHandle = -1;
	decl(bool)
	cd_internal_hasTPError = false;
decl(mesh)
cd_internal_lastTPObj = objnull;
decl(float)
cd_internal_startLoadTime = 0;

decl(void(vector3;float))
cd_tpLoad = {
	params ["_pos","_dir"];
	
	//close eyes one one time
	if (cd_eyeState < 1000) then {
		rpcCall("onChangeEyeState",[cd_eyeState + 1000 arg "clseye"]);
	};

	cd_internal_lastTPPos = _pos;
	cd_internal_lastTPDir = _dir;
	
	//!do not init position...
	//before init setposition
	//player setPosAtl _pos;
	
	//load temp object
	private _tempObj = createSimpleObject ["rel_vox\obj\block_dirt.p3d",[0,0,0],true];
	_tempObj setposatl _pos;
	if (!isNULL cd_internal_lastTPObj) then {
		deletevehicle cd_internal_lastTPObj;
	};
	cd_internal_lastTPObj = _tempObj;

	if equals(cd_internal_tpHandle,-1) then {
		private _upd = {
			if (cd_internal_hasTPError) exitwith {
				stopThisUpdate();
				error("Load position timeout...");
				rpcCall("clientDisconnect",vec2("Ошибка загрузки позиции","Истекло время ожидания загрузки позиции"));
			};

			_setTransform = {
				player setPosAtl cd_internal_lastTPPos;
				if !isNull(cd_internal_lastTPDir) then {
					player setDir cd_internal_lastTPDir;
				};
				player setVelocity [0,0,0];
			};

			_atlPos = cd_internal_lastTPPos;
			_tobj = cd_internal_lastTPObj;

			_tobj setposatl (_atlPos vectordiff [0,0,0.1]);

			_aslPos = ATLToASL _atlPos;
			_trace = lineIntersectsSurfaces [
				_aslPos,
				_aslPos vectorAdd [0,0,-500],
				player,
				objNull,
				true,
				1,
				"GEOM",
				"NONE"
			];
			
			if (tickTime > (cd_internal_startLoadTime + (180)) && {!cd_internal_hasTPError}) exitwith {
				cd_internal_hasTPError = true;
				errorformat("<async>__rpc::tpLoad() - Load position %1 timeout",_atlPos);
			};

			_tobj setposatl (_atlPos vectordiff [0,0,0.1]);

			_canDone = true;
			if (tickTime <= (cd_internal_startLoadTime + 0.31)) then {
				call _setTransform;
			 	_canDone = false;
			};

			if (count _trace == 0) then {
				call _setTransform;
			} else {
				//private _lobj = player nearObjects 30;
				if (
					not_equals(_trace select 0 select 2,objNULL) 
					&& {call noe_client_isPlayerPositionChunksLoaded}
					&& {_canDone}
					//&& {{30 preloadObject _x}count _lobj == (count _lobj)} //dosent work
					//&& {tickTime > (cd_internal_startLoadTime + (1))}
				) then {
					call _setTransform;

					deleteVehicle _tobj;

					//now position loaded
					if (cd_eyeState >= 1000) then {
						rpcCall("onChangeEyeState",[cd_eyeState - 1000 arg "opneye"]);
					};

					stopThisUpdate();
					cd_internal_tpHandle = -1;
					// _c = {
					// 	params ["_pos","_dir"];
					// 	player setposatl _pos;
					// 	if !isNullVar(_dir) then {player setdir _dir};
					// };
					// nextFrameParams(_c,vec2(_atlPos,cd_internal_lastTPDir));
				} else {
					//perma sync pos
					//if (_atlPos distance (getPosATL player) > 1) then {
						call _setTransform;
					//};
				};
			};
		};

		cd_internal_tpHandle = startUpdate(_upd,0);
	};

	cd_internal_hasTPError = false;
	cd_internal_startLoadTime = tickTime;

}; rpcAdd("tpLoad",cd_tpLoad);

decl(void(mesh;vector3;float))
cd_syncObjTransform = {
	params ["_src","_pos","_dir"];
	//todo check distance
	_src setPosAtl _pos;
	_src setdir _dir;
}; rpcAddGlobal("syncObjTransform",cd_syncObjTransform);

// attack animation playing
rpcAdd("attanm",anim_doAttack);

decl(void(...any[]))
cd_clientDisconnect = {
	private _args = _this;

	call vs_stopHandleProcessPlayerPos;

	private _notNullArgs = !isNullVar(_args);
	private _actualArgs = if (_notNullArgs) then {count _args == 2} else {false};

	if (_notNullArgs && _actualArgs) then {
		_args call widget_createDisconnectMessage;

		rpcSendToServer("_kickself_",[clientOwner arg (_args select 0)]);
/*		[] spawn {
			waitUntil {
				!isnull(findDisplay 10000 displayctrl 235106)
			};
			ctrlActivate (findDisplay 10000 displayctrl 235106);
			uinamespace setvariable ['BIS_fnc_guiMessage_status',true];
		};*/

		endMission "LOSER";
	} else {
		endMission "LOSER";
	};

}; rpcAdd("clientDisconnect",cd_clientDisconnect);

decl(void())
cd_authproc = {
	call cd_openAuth;
}; rpcAdd("authproc",cd_authproc);


// Открытие окна регистрации клиента
decl(void())
cd_openAuth = {
	private _d = call displayOpen;
	private _back = [_d,BACKGROUND,[0,0,100,100]] call createWidget;
	_back setBackgroundColor [0,0,0,1];

	private _sizeW = 60;
	private _sizeH = 20;

	private _backcol = [0.3,0.3,0.3,0.4];

	private _errWidget = [_d,TEXT,[50-(_sizeW/2),5,_sizeW,10]] call createWidget;
	_errWidget setBackgroundColor [0.62,0,0,1];
	_errWidget setFade 1;
	_errWidget commit 0;

	private _header = [_d,TEXT,[50-(_sizeW/2),20,_sizeW,_sizeH]] call createWidget;
	_header setBackgroundColor _backcol;

	private _txt = "%1<t align='center'><t size='1.5' font='Ringbear' color='#508A50'>Добро пожаловать!</t>%1<t size='1.2' font='Ringbear' color='#508A50'>Введите имя вашего аккаунта.%1Под этим именем вы будете известны всем остальным игрокам в лобби, ООС чате и при показе статистики раунда.%1%1Допускаются символы англ.раскладки, цифры и нижнее подчеркивание</t>";
	_txt = _txt + "</t>";
	[_header,format[_txt,sbr]] call widgetSetText;

	private _inp = [_d,INPUT,[50-(_sizeW/2),20+_sizeH+5,_sizeW,20]] call createWidget;
	_inp ctrlsetbackgroundcolor _backcol;
	_inp ctrlSetFontHeight 0.2;

	private _butSizeH = 20+_sizeH+5+20+5;
	private _ok = [_d,BUTTON,[50-(_sizeW/2),_butSizeH,(_sizeW/2)-5,10]] call createWidget;
	_ok ctrlsettext "Регистрация";
	_ok ctrlSetBackgroundColor _backcol;
	_ok setVariable ["input",_inp];
	_ok setVariable ["errWidget",_errWidget];

	private _setEWText = {
		params ["_mes"];
		private _ew = getDisplay getVariable ["errWidget",widgetNull];
		[_ew,format["%2<t size='1.2' align='center' shadow='2'>%1</t>",_mes,sbr]] call widgetSetText;
		_ew setFade 0;
		_ew commit 0.2;
		getDisplay setVariable ["lasterrortime",tickTime + 3];
		getDisplay setVariable ["lasterrorlock",false];

	};
	_d setVariable ["lasterrortime",tickTime];
	_d setVariable ["lasterrorlock",true];
	_d setVariable ["printError",_setEWText];


	_updateCode = {
		(_this select 0) params ["_ew","_d"];
		if (tickTime > (_d getVariable "lasterrortime")) then {
			if !(_d getVariable "lasterrorlock") then {
				_d setVariable ["lasterrorlock",true];
				_ew setFade 1;
				_ew commit 0.5;
			};
		};
	};
	_handleUpdate = startUpdateParams(_updateCode,0,[_errWidget arg _d]);
	_d setVariable ["handleUpdate",_handleUpdate];

	_eventOnClose = {
		stopUpdate(getDisplay getVariable vec2("handleUpdate",-1))
	};
	_d setVariable ["event_onClosed",_eventOnClose];

	_ok ctrlAddEventHandler ["MouseButtonUp",{
		params ["_d","_key"];

		forceUnicode 0;

		_txt = ctrlText (_d getVariable "input");


		if (count (_txt regexFind ["[^a-zA-Z0-9\_]/i"]) > 0) exitWith {rpcCall("authResult",2)};
		_matches = _txt regexFind ["[a-zA-Z]/i"];
		if (count _matches == 0) exitWith {rpcCall("authResult",3)};
		(_matches select 0 select 0)params ["_tok","_idx"];
		if (_idx != 0) exitWith {rpcCall("authResult",3)};

		if (count _txt > 32) exitWith {rpcCall("authResult",4)};
		if (count _txt < 3) exitWith {rpcCall("authResult",5)};
		if (count (_txt regexFind ["[a-zA-Z]/ig"]) < 3) exitWith {rpcCall("authResult",6)};

		(getDisplay getVariable "closebutton") ctrlEnable false;
		_d ctrlEnable false;

		rpcSendToServer("authRequest",[_txt arg clientOwner]);
	}];
	_d setVariable ["errWidget",_errWidget];

	private _cancel = [_d,"RscButton",[50-(_sizeW/2)+((_sizeW/2)+5),_butSizeH,(_sizeW/2)-5,10]] call createWidget;
	_cancel ctrlsettext "Отмена";
	_cancel ctrlSetBackgroundColor _backcol;
	_cancel ctrlAddEventHandler ["MouseButtonUp",{
		call (getDisplay getVariable ["event_onClosed",{}]);

		call displayClose;
		nextFrame({rpcCall("clientDisconnect",null)});
	}];
	_d setVariable ["closebutton",_cancel];
	_d setVariable ["regbutton",_ok];

};

decl(void(int;string))
cd_authResult = {
	params ["_code","_nick"];

	(getDisplay getVariable "closebutton") ctrlEnable true;
	(getDisplay getVariable "regbutton") ctrlEnable true;

	inline_macro
	#define printerr(code,text) if (_code == code) exitWith {[text] call (getDisplay getVariable ["printError",{}])}
	call {
		if (_code == 0) exitWith {
			call (getDisplay getVariable ["event_onClosed",{}]);
			call displayClose;

			//Do register process account
			private _nextFrame = {
				rpcSendToServer("onRegClient",[clientOwner arg _this]);
			};
			nextFrameParams(_nextFrame,_nick);
		};
		printerr(1,"Никнейм """+ _nick + """ уже занят.");
		printerr(2,"Недопустимые символы в никнейме: Только буквы англ.раскладки, цифры и символы нижнего подчеркивания.");
		printerr(3,"Никнейм должен начинаться с буквы английского алфавита.");
		printerr(4,"Слишком длинный никнейм.");
		printerr(5,"Никнейм должен быть длиннее 3х символов.");
		printerr(6,"Никнейм должен содержать не менее 3х букв");
		printerr(100,"Системная ошибка при регистрации.");
	};
}; rpcAdd("authResult",cd_authResult);

//client side animator
decl(void(actor;string))
cd_switchMove_anim = {
	(_this select 0) switchmove (_this select 1);
}; rpcAdd("switchMove",cd_switchMove_anim);

decl(void(actor;string))
cd_switchMove_force_anim = {
	(_this select 0) switchmove (_this select 1);
	(_this select 0) playMoveNow (_this select 1); //fix force switchmove for fuckedup animations configs
}; rpcAdd("switchMove_force",cd_switchMove_force_anim);

//Плавная смена анимации
decl(void(actor;string))
cd_playMove_anim = {
	(_this select 0) playMove (_this select 1)
}; rpcAdd("playMove",cd_playMove_anim);

//установить мимику
decl(void(actor;string))
cd_setMimic_anim = {
	(_this select 0) setMimic (_this select 1)
}; rpcAdd("setMimic",cd_setMimic_anim);
//для кнокдауна
decl(void(actor;string))
cd_switchAction_anim = {
	(_this select 0) switchAction (_this select 1)
}; rpcAdd("switchAction",cd_switchAction_anim);

decl(void(vector3))
cd_syncongrabrot_setvdirup = {
	params ["_m"];
	private _worldObj = player;
	_worldObj setVectorDirAndUp [_m,vec3(0,0,1)];
	_worldObj setPosASL getPosASL _worldObj;
}; rpcAdd("syncongrabrot",cd_syncongrabrot_setvdirup);

//теперь cam_addCamShake можно вызывать удаленно
decl(void(...float[]))
cd_camshake_proc = {_this call cam_addCamShake};
rpcAdd("camshake",cd_camshake_proc); //fix initialization error

//Репликация любых методов. универсальный удаленный вызов
decl(void(string;any))
cd_replicate_replloc = {
	params ["_method","_ctx"];
	_ctx call (repl_map_funcs getOrDefault [(_method),{
		errorformat("repl::doLocal<net>() - unsupported method ctx[%1]",_method);
	}]);
}; rpcAdd("replloc",cd_replicate_replloc);

if (isMultiplayer) then {
	decl(void(string;any))
	repl_doLocal = {
		params ["_method","_ctx"];
		
		_ctx call (repl_map_funcs getOrDefault [(_method),{
			errorformat("repl::doLocal() - unsupported method ctx[%1]",_method);
		}]);
	};

};


//! НЕ РАБОТАЕТ
// исправление 0.7.578: при открытом динамическом дисплее кик вызывает зависание
//system connection close
/*
_syscc = {
	_d = getDisplay;
	if isNullReference(_d) exitwith {};
	if (_d getVariable ["$dynflag$",false]) then {
		//manually closing display
		_d closeDisplay 0;
		log("sys_connection_close - display finded")
	} else {
		log("sys_connection_close - no display found");
	};
	call removealldisplayevents;
}; rpcAdd("syscc",_sysddcls);
*/
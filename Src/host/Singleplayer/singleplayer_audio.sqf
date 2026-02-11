// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\struct.hpp"
#include "..\text.hpp"
#include "..\thread.hpp"
#include "..\..\client\WidgetSystem\widgets.hpp"
#include "..\NOEngine\NOEngine.hpp"
#include "..\GameObjects\GameConstants.hpp"

sp_audio_setMusicVolume = {
	params ["_vol",["_dur",0]];
	[_vol,_dur] call music_internal_setFade;
};

sp_audio_playMusic = {
	params ["_name",["_looped",false],["_toqueue",false]];
	if (sp_debug_skipAudio) exitWith {};
	private _params = [];
	if (_looped) then {
		_params pushBack ["repeat",true];
	};
	if (_toqueue) then {
		_params pushback ["wait",true];
	};

	["sp\" + _name,30,_params] call music_play;
};
sp_audio_stopMusic = {
	params ["_temp"];
	[30] call music_stop;
};

sp_audio_setMusicPause = {
	params ["_mode",["_smooth",true]];
	if (sp_debug_skipAudio) exitWith {};
	[30,_mode,_smooth] call music_setPause;
};

sp_audio_sayPlayer = {
	params ["_pathPost",["_vol",1],["_offset",0]];
	if (sp_debug_skipAudio) exitWith {-1};

	["singleplayer\sp_guide\" + _pathPost,
		_vol,null,
		true, //redirect to effect audio channel
		null,
		_offset
	] call soundUI_play;
};

sp_audio_waitForEndSound = {
	params ["_handle"];
	if (sp_debug_skipAudio) exitWith {};
	if equalTypes(_handle,objNull) exitWith {
		{isNullReference(_handle)} call sp_threadWait;
	};
	{count soundParams _handle == 0} call sp_threadWait;
};

sp_audio_sayPlayerList = {
	private _pathlist = _this;
	if (sp_debug_skipAudio) exitWith {scriptNull};
	
	[{
		params ["_pathlist"];
		{
			private _h = [_x] call sp_audio_sayPlayer;
			{count soundParams _h == 0} call sp_threadWait;
		} foreach _pathlist;
	},[_pathlist]] call sp_threadStart;
	
};

sp_audio_isSoundHandleDone = {
	params ["_handle"];
	if equalTypes(_handle,objNull) exitWith {
		isNullReference(_handle)
	};
	private _spr = soundParams _handle;
	if (count soundParams _handle == 0) exitWith {true};
	if ((_spr select 1) >= 1) exitWith {true};
	if ((_spr select 2) == (_spr select 3)) exitWith {true};
	false
};

sp_audio_list_soundbuff = [];

sp_audio_setDistConstant = {
	params ["_dist"];
	sp_audio_distConstantSayTarget = _dist;
};
sp_audio_distConstantSayTarget = null;

sp_audio_sayAtTarget = {
	params ["_target","_pathPost",["_dist",20],["_startOffset",0]];
	if (sp_debug_skipAudio) exitWith {-1};
	_target = [_target] call sp_audio_internal_resolveTarget;
	if isNullReference(_target) exitWith {-1};

	if equals(_target,player) exitWith {
		[_pathPost] call sp_audio_sayPlayer;
	};

	if (!isNull(sp_audio_distConstantSayTarget) && {_dist == 20}) then {
		_dist = sp_audio_distConstantSayTarget;
	};

	private _probConfigName = (_pathPost splitstring "\/" joinString "_") splitstring "." select 0;
	private _cfgRoot = 
	#ifdef EDITOR
		missionConfigFile
	#else
		configFile
	#endif
	;
	
	if !isNullReference(_cfgRoot >> "cfgsounds" >> _probConfigName) exitWith {

		{
			private _list = sp_audio_list_soundbuff;
			private _found = false;
			{
				if (equals(_x select 0,objNull)) then {
					_list set [_forEachIndex,objnull];
					_found = true;
				};
			} foreach _list;
			if (_found) then {
				sp_audio_list_soundbuff = _list - [objNull];
			};

		} call sp_threadCriticalSection;

		private _obj = [_target,_probConfigName,_dist,null,_startOffset] call sound3d_playOnObject;
		private _dur = getNumber(_cfgRoot >> "cfgsounds" >> (_probConfigName + "__dur"));
		_startTime = tickTime;
		sp_audio_list_soundbuff pushback [_obj,_startTime,_dur];

		_obj
	};

	private _mpath = "singleplayer\sp_guide\" + _pathPost;
	//params ["_source","_class","_dist",["_pitch",1],["_offset",0]];
	private _vol = 1;
	if (typeof _target == BASIC_MOB_TYPE) then {
		_target = _target modelToWorldVisual (_target selectionPosition "head");
	};
	[_mpath,_target,_vol,null,_dist,null,_startOffset] call soundGlobal_play;
};

sp_audio_playSound = {
	params ["_pos","_pathPost",["_dist",20]];
	private _vol = 1;
	private _startOffset = 0;
	private _mpath = "singleplayer\sp_guide\" + _pathPost;
	[_mpath,_pos,_vol,null,_dist,null,_startOffset] call soundGlobal_play;
};

sp_audio_internal_resolveTarget = {
	params ["_target"];
	if equalTypes(_target,"") then {
		//check mob
		private _ptarg = sp_ai_mobs getOrDefault [_target,objNull];
		if !isNullReference(_ptarg) exitWith {_target = _ptarg};

		//check gref
		private _ptarg = _target call sp_getObject;
		if !isNullReference(_ptarg) exitWith {_target = callFunc(_ptarg,getBasicLoc)};
		_target = objNull;
	};
	_target
};

/* 
	[
		["target1","audio1",[["param1",0],["param2","value"]]],
		["target1","audio2"]
	] call sp_audio_startDialog;
	params:
	endoffset - старт следующего диалога на конце текущего
	canstart - условие возможности старта диалога
	onstart - код вызываемый при старте диалога
	onend - код вызываемый при окончании диалога
	distance - дистанция звука
*/
sp_audio_startDialog = {
	private _dlg = _this;
	
	if (count _dlg == 0) exitWith {};

	{
		if (count _x > 2) then {
			private _params = _x select 2;
			if (count _params == 2 
				&& {equalTypes(_params select 0,"")}) then {
					_params = [_params];
				};
			_x set [2,createHashMapFromArray _params];
		} else {
			_x set [2,createHashMap];
		};
	} foreach _dlg;

	private _stateSeq = [
		_dlg, //state list
		0 //current state
	];

	[_stateSeq] call sp_audio_internal_procDialog;

	_stateSeq
};

sp_audio_isDoneDialog = {
	params [["_dlglst",[]],["_idx",0]];
	_idx >= count _dlglst	
};

sp_audio_waitForEndDialog = {
	private _dlgData = _this;
	if (sp_debug_skipAudio) exitWith {};
	{
		_dlgData call sp_audio_isDoneDialog
	} call sp_threadWait;
};

sp_audio_internal_procDialog = {
	params ["_stateSeq",["_canCheckStartCond",true]];
	_stateSeq params ["_dlg","_cur"];
	private _curSeq = _dlg select _cur;
	_curSeq params ["_tgt","_pathPost","_ctxParams"];
	private _tgtReal = [_tgt] call sp_audio_internal_resolveTarget;
	
	private _canStartCode = _ctxParams getOrDefault ["canstart",{true}];

	if (!([_tgtReal] call _canStartCode) && _canCheckStartCond) exitWith {
		startAsyncInvoke
			{
				params ["_tgtReal","_canStartCode","_stateSeq"];
				[_tgtReal] call _canStartCode;
			},
			{
				params ["_tgtReal","_canStartCode","_stateSeq"];
				[_stateSeq,false] call sp_audio_internal_procDialog;
			},
			[_tgtReal,_canStartCode,_stateSeq]
		endAsyncInvoke
	};

	private _handle = [_tgt,_pathPost,_ctxParams get "distance"] call sp_audio_sayAtTarget;
	traceformat("SAY DIALOG %1 (hndl:%2) %3",_pathPost arg _handle arg ifcheck(equalTypes(_handle,objNull),_handle,soundParams _handle));
	if (ifcheck(equalTypes(_handle,objNull),isNullReference(_handle),equals(soundParams _handle,[])) && !sp_debug_skipAudio) exitWith{};
	
	[_tgtReal] call (_ctxParams getOrDefault ["onstart",{}]);
	_tgtReal setRandomlip true;
	
	//can cause error on change distance 
	//[0.6,0.5] call sp_audio_setMusicVolume;
	
	startAsyncInvoke
		{
			params ["_stateSeq","_handle","_ctxParams"];
			_endoffset = _ctxParams getOrDefault ["endoffset",0];

			if (equalTypes(_handle,objNull)) then {
				_id = sp_audio_list_soundbuff findif {equals(_x select 0,_handle)};
				if (_id == -1) exitWith {true};
				(sp_audio_list_soundbuff select _id) params ["","_startTime","_dur"];
				_time = tickTime - _startTime;
				_time>=(_dur - _endoffset)
			} else {
				_spar = soundParams _handle;
				if equals(_spar,[]) exitWith {true};
				_spar params ["","","_len","_time"];
				//traceformat("TIMECHECK FOR %1"+endl + "		%2 %3 (-%4) => %5",_spar select 0 arg _time arg _len arg _endoffset arg _time >= (_len - _endoffset));
				_time>=(_len - _endoffset)
			};
		},
		{
			params ["_stateSeq","_handle","_ctxParams","_tgtReal"];
			_tgtReal setRandomlip false;
			//[1,0.5] call sp_audio_setMusicVolume;

			//increment stateseq
			_curId = _stateSeq select 1;
			_origCurId = _curId;
			
			[] call (
				(_stateSeq select 0 select _origCurId select 2)
					getOrDefault ["onend",{}]
			);
			
			INC(_curId);
			if (_curId >= (count (_stateSeq select 0))) exitWith {
				//end of dialog
				_stateSeq set [1,_curId];
			};

			_stateSeq set [1,_curId];
			[_stateSeq] call sp_audio_internal_procDialog;
		},
		[_stateSeq,_handle,_ctxParams,_tgtReal]
	endAsyncInvoke
};
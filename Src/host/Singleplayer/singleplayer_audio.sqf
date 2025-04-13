// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
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

sp_audio_sayPlayer = {
	params ["_pathPost"];
	if (sp_debug_skipAudio) exitWith {-1};

	["singleplayer\sp_guide\" + _pathPost,
		null,null,
		true //redirect to effect audio channel
	] call soundUI_play;
};

sp_audio_waitForEndSound = {
	params ["_handle"];
	if (sp_debug_skipAudio) exitWith {};
	
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

sp_audio_sayAtTarget = {
	params ["_target","_pathPost",["_dist",20],["_startOffset",0]];
	if (sp_debug_skipAudio) exitWith {-1};
	_target = [_target] call sp_audio_internal_resolveTarget;
	if isNullReference(_target) exitWith {-1};

	if equals(_target,player) exitWith {
		[_pathPost] call sp_audio_sayPlayer;
	};

	private _mpath = "singleplayer\sp_guide\" + _pathPost;
	//params ["_source","_class","_dist",["_pitch",1],["_offset",0]];
	private _vol = 1;
	[_mpath,_target,_vol,null,_dist,null,_startOffset] call soundGlobal_play;
};

sp_audio_internal_resolveTarget = {
	params ["_target"];
	if equalTypes(_target,"") then {
		//check mob
		private _ptarg = sp_ai_mobs getOrDefault [_target,objNull];
		if !isNullReference(_ptarg) exitWith {_target = getVar(_ptarg,owner)};

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
	volume - громкость звука
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
				params ["_tgtReal","_canStartCode","_startSeq"];
				[_tgtReal] call _canStartCode;
			},
			{
				params ["_tgtReal","_canStartCode","_startSeq"];
				[_startSeq,false] call sp_audio_internal_procDialog;
			},
			[_tgtReal,_canStartCode,_startSeq]
		endAsyncInvoke
	};

	private _handle = [_tgt,_pathPost,_ctxParams get "volume"] call sp_audio_sayAtTarget;
	traceformat("SAY DIALOG %1 (hndl:%2) %3",_pathPost arg _handle arg soundParams _handle);
	if equals(soundParams _handle,[])exitWith{};
	
	[_tgtReal] call (_ctxParams getOrDefault ["onstart",{}]);
	startAsyncInvoke
		{
			params ["_stateSeq","_handle","_ctxParams"];
			_spar = soundParams _handle;
			if equals(_spar,[]) exitWith {true};
			_spar params ["","","_len","_time"];
			_endoffset = _ctxParams getOrDefault ["endoffset",0];
			//traceformat("TIMECHECK FOR %1"+endl + "		%2 %3 (-%4) => %5",_spar select 0 arg _time arg _len arg _endoffset arg _time >= (_len - _endoffset));
			_time>=(_len - _endoffset)
		},
		{
			params ["_stateSeq","_handle","_ctxParams"];
			//increment stateseq
			_curId = _stateSeq select 1;
			_origCurId = _curId;
			INC(_curId);
			if (_curId >= (count (_stateSeq select 0))) exitWith {
				//end of dialog
			};

			[] call (
				(_stateSeq select 0 select _origCurId select 2)
					getOrDefault ["onend",{}]
			);

			_stateSeq set [1,_curId];
			[_stateSeq] call sp_audio_internal_procDialog;
		},
		[_stateSeq,_handle,_ctxParams]
	endAsyncInvoke
};
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(ClientStatistic,clistat_)

decl(int) clistat_onupdate_handle = -1;
decl(bool) clistat_isEnabled = false;
decl(widget[]) clistat_widgets = [widgetNull,widgetNull,widgetNull];

_gui = getGUI;
private _ctg = [_gui,WIDGETGROUP,[0,40,20,60]] call createWidget;
_ctg ctrlShow false;

_back = [_gui,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
_back setBackgroundColor [0,0.07,0.01,0.4];
_text = [_gui,TEXT,[0,0,100,100],_ctg] call createWidget;

clistat_widgets = [_ctg,_back,_text];
inline_macro
#define colortext(clr,txt) "<t color='#"+'clr'+"'>"+txt+"</t>"
decl(float[])
clistat_internal_allch_buffer = [0,0,0];
decl(float)
clistat_internal_allch_buffer_frame = 0;
decl(any[][])
clistat_buffer = [];
	#ifdef EDITOR
clistat_buffer pushback [colortext(CC5460,"ReNode:"),{
		ifcheck(call nbp_isEditorConnected,"CONNECTED","off")
	}];
	#endif
clistat_buffer append [
	[colortext(CC5460,"fps: "),{
		format["cur:%1; min:%2; dt:%3;",round diag_fps,round diag_fpsmin,diag_deltaTime]
	}],
	[colortext(CC5460,"frame: "),{diag_frameno toFixed 0}],
	// [colortext(E4F500,"LightRender(depr): "),{_nonvis = 0; _sceneObj = 0;
	// 	{
	// 		if !(_x getvariable ["isRndrd",false]) then {INC(_nonvis)};
	// 		if (_x call hasObjectInScene) then {INC(_sceneObj)};
	// 	} foreach le_allLights; format["all:%1 (dis:%2;rend:%3)		s:%4",count le_allLights,_nonvis,(count le_allLights)-_nonvis,_sceneObj]
	// }],
	[colortext(E4F500,"LightSC: "),{
		format["cnt:%1;cull:%2",count lesc_list_allDataObjs,lesc_cullCnt]
	}]
];
	#ifdef EDITOR_OR_SP_MODE
clistat_buffer pushBack [colortext(E4F500,"ALt: "),{format["%1 lum",(getLightingAt cam_object) select 3]}];
clistat_buffer pushback [colortext(E4F500,"ServerLightRender: "),{count (attachedObjects slt_const_dummyMob)}];
	#endif

clistat_buffer append [
	[colortext(D3C857,"NOE packets: "),{format["amount %1; packets query %2",noe_client_packetId,count noe_client_packets]}],
	[colortext(D3C857,"NOE progress: "),{
		_ppos = getPosATL player; _buf = [];
		{
			_buf pushBack (["NON_LD","LD","DNE"] select ((noe_client_cs get _x get (str([_ppos,_x] call noe_posToChunk))) select 4))
		} foreach noe_client_allChunkTypes;

		_dt = ["{""%1"",""%2"",""%3""}"]+_buf;
		_dt call formatLazy;
	}],
	[colortext(D3C857,"NOE objs: "),{
		_ppos = getPosATL player; _buf = [];
		{
			_chInfo = (noe_client_cs get _x get (str([_ppos,_x] call noe_posToChunk)));
			_iCtr = _buf pushBack (count(_chInfo select 2));
			clistat_internal_allch_buffer_frame = clistat_internal_allch_buffer_frame + 1;
			if (clistat_internal_allch_buffer_frame > 10) then {
				if (_iCtr == -1) then {continue};

				_curBuf = _buf select _iCtr;
				_chT = _x;
				{
					_curBuf = _curBuf + (count((noe_client_cs get _chT get (str(
						([_ppos,_chT] call noe_posToChunk) vectorAdd _x
					))) select 2) );
				} foreach [ 
					[1,0],
					[0,1],
					[1,1],
					[-1,0],
					[0,-1],
					[-1,-1],
					[1,-1],
					[-1,1]
				];
				if !(finite _curBuf) then {_curBuf = 0.1};
				if isNullVar(_curBuf) then {_curBuf = 0.01};

				clistat_internal_allch_buffer set [_foreachIndex,_curBuf];
				clistat_internal_allch_buffer_frame = 0;
			};

		} foreach noe_client_allChunkTypes;
		
		_dt = ["{%1,%2,%3}"]+_buf;
		_dt call formatLazy
	}],
	[colortext(D3C857,"NOE all: "),{
		_all = 0;
		{_all = _all + _x; true} count clistat_internal_allch_buffer;
		_dt = (["{%1,%2,%3}=%4"]+(clistat_internal_allch_buffer apply {ifcheck(!isInt(_x),"loading",_x)}));
		_dt pushBack _all;
		format _dt
	}],
	[colortext(57D4AC,"NAT:"),{
		#include "..\NOEngineClient\NOEngineClient_NetAtmos.hpp"
		_ar = [getposatl player call atmos_getAreaIdByPos] call noe_client_nat_getArea;
		_state = _ar get "state";
		format["st:%1(%2)",NAT_LOADING_SLIST_STATES select (_state+1),_state]
	}]
];
	#ifdef ENABLE_OPTIMIZATION
clistat_buffer pushback [colortext(57D4AC,"NAT_RGC:"),{
		_ar = [getposatl player call atmos_getAreaIdByPos] call noe_client_nat_getArea;
		format["%1",(_ar get "_regions") apply {count _x}]
	}];
	#endif
	#ifdef NET_ATMOS_OPTIMIZATION_RENDER
clistat_buffer pushback [colortext(57D4AC,"NAT_CULL:"),{
		format["cull:%1;gbf:%2;ms:%3",aopt_cli_culledCnt,aopt_cli_gbuffCull,aopt_cli_prevCallTime*1000]
	}];
	#endif
	#ifdef EDITOR
clistat_buffer pushback [colortext(57D4AC,"ATMOS_SRV: "),{
		format["R:%1 C:%2 A:%3",count atmos_map_chunkAreas,atmos_chunks,atmos_areas]
	}];
	#endif
clistat_buffer append [
	[colortext(5D56DB,"Receiver in world:"),{format["wrld %1; inv %2; pltrns %3",count vs_allRadioSpeakers,count vs_allInventoryRadios,count vs_localReceivers]}],
	[colortext(5D56DB,"Listen users:"),{count(flatten(values vs_map_waveSpeakers apply {keys _x})) }],
	[colortext(1FC4C4,"Cur music: "),{ifcheck(isNull(music_playedObject),"no",music_playedObject get "file")}],
	[colortext(1FC4C4,"m_playedtime:"),{ifcheck(isNull(music_playedObject),"no",str(music_playedObject get "curtime"))}],
	[colortext(1FC4C4,"minf:"),{format["vol:%1;ch:%2",musicVolume,music_internal_lastPriority]}]
];
	#ifdef EDITOR_OR_SP_MODE
clistat_buffer append [
	[colortext(1FC4C4,"stepdat: "),{format["%1 x%2; ptr:%3 all:%4"
		,os_steps_currentSoundName
		,os_steps_currentSoundCount
		,os_steps_lastPtr
		,count os_steps_map_objToMaterialPtr]}]
	,[colortext(1FC4C4,"snds: "),{format["v:%1; bf:%2",(count call vs_audio_getAllSoundsIds),count sound3d_internal_list_soundBuff]}]
	,["<t color='#832DCF'>[ENGINE]</t> Global threads:",{format["upd %1; hndl %2",count cba_common_perFrameHandlerArray,count cba_common_PFHhandles]}]
	,["<t color='#832DCF'>[ENGINE]</t> Delayed:",{str count cba_common_waitAndExecArray}]
	,["<t color='#832DCF'>[ENGINE]</t> Async delayed:",{str count cba_common_waitUntilAndExecArray}]
	,["<t color='#2BA639'>[OBJ]</t> Created objects:",{str oop_cco}]
	,["<t color='#2BA639'>[OBJ]</t> Active objects:",{str oop_cao}]
	,["<t color='#2BA639'>[OBJ]</t> Threads:",{str oop_upd}]
];
	#endif
	/*,
	["Processed SMD:",{count smd_allInGameMobs}],
	["Objects:",{count (allSimpleObjects [])}]*/
	#ifdef NOE_CLIENT_THREAD_DEBUG
clistat_buffer pushback ["NOE_CTD:",{
			_s = format["c:%1",count noe_debug_allthreads];
			modvar(_s) + str noe_debug_allthreads;
			_s
		}];
	#endif

decl(void())
clistat_onupdate = {
	
	if (!clistat_isEnabled) exitwith {};

	_text = "";

	{
		_text = _text + (_x select 0) + format["%1",(call (_x select 1))] + sbr;
	} foreach clistat_buffer;

	[(clistat_widgets select 2),_text] call widgetSetText;
};

decl(void(bool))
clistat_setLogVars = {
	params ["_mode"];

	if (clistat_isEnabled == _mode) exitWith {
		warningformat("clistat::setLogVars() - already setted on %1",_mode);
	}; //clistat::isEnabled already setted on _mode

	clistat_isEnabled = _mode;

	(clistat_widgets select 0) ctrlShow  clistat_isEnabled;

	if (_mode) then {
		clistat_onupdate_handle = startUpdate(clistat_onupdate,0);
	} else {
		stopUpdate(clistat_onupdate_handle);
		clistat_onupdate_handle = -1;
	};
};

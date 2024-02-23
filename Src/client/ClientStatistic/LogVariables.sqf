// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


clistat_onupdate_handle = -1;
clistat_isEnabled = false;
clistat_widgets = [widgetNull,widgetNull,widgetNull];

_gui = getGUI;
private _ctg = [_gui,WIDGETGROUP,[0,50,20,50]] call createWidget;
_ctg ctrlShow false;

_back = [_gui,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
_back setBackgroundColor [0,0.07,0.01,0.4];
_text = [_gui,TEXT,[0,0,100,100],_ctg] call createWidget;

clistat_widgets = [_ctg,_back,_text];

#define colortext(clr,txt) "<t color='#"+'clr'+"'>"+txt+"</t>"

clistat_internal_allch_buffer = [];
clistat_internal_allch_buffer_frame = 0;

clistat_buffer = [
	#ifdef EDITOR
	[colortext(CC5460,"ReNode:"),{
		ifcheck(call nbp_isEditorConnected,"CONNECTED","off")
	}],
	#endif
	[colortext(CC5460,"fps: "),{
		format["cur:%1; min:%2; dt:%3;",round diag_fps,round diag_fpsmin,diag_deltaTime]
	}],
	[colortext(CC5460,"frame: "),{diag_frameno toFixed 0}],
	[colortext(E4F500,"LightRender: "),{_nonvis = 0; _sceneObj = 0;
		{
			if !(_x getvariable ["isRndrd",false]) then {INC(_nonvis)};
			if (_x call hasObjectInScene) then {INC(_sceneObj)};
		} foreach le_allLights; format["all:%1 (dis:%2;rend:%3)		s:%4",count le_allLights,_nonvis,(count le_allLights)-_nonvis,_sceneObj]
	}],
	#ifdef EDITOR
	[colortext(E4F500,"ServerLightRender: "),{count (attachedObjects slt_const_dummyMob)}],
	#endif
	[colortext(D3C857,"NOE packets: "),{format["amount %1; packets query %2",noe_client_packetId,count noe_client_packets]}],
	[colortext(D3C857,"NOE progress: "),{
		_ppos = getPosATL player; _buf = [];
		{
			_buf pushBack (["NON_LD","LD","DNE"] select ((noe_client_cs get _x get (str([_ppos,_x] call noe_posToChunk))) select 4))
		} foreach noe_client_allChunkTypes;

		_dt = ["{""%1"",""%2"",""%3""}"]+_buf;
		format(_dt)
	}],
	[colortext(D3C857,"NOE objs: "),{
		_ppos = getPosATL player; _buf = [];
		{
			_iCtr = _buf pushBack (count((noe_client_cs get _x get (str([_ppos,_x] call noe_posToChunk))) select 2));
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
				clistat_internal_allch_buffer set [_foreachIndex,_curBuf];
				clistat_internal_allch_buffer_frame = 0;
			};

		} foreach noe_client_allChunkTypes;
		
		_dt = ["{%1,%2,%3}"]+_buf;
		format(_dt)
	}],
	[colortext(D3C857,"NOE all: "),{
		_all = 0;
		{_all = _all + _x; true} count clistat_internal_allch_buffer;
		_dt = (["{%1,%2,%3}=%4"]+clistat_internal_allch_buffer);
		_dt pushBack _all;
		format _dt
	}],
	[colortext(5D56DB,"Receiver in world:"),{count vs_allWorldRadios}],
	[colortext(5D56DB,"TF local transport:"),{count vs_processingRadiosList}],
	[colortext(1FC4C4,"Cur music: "),{ifcheck(isNull(music_playedObject),"no",music_playedObject get "file")}],
	[colortext(1FC4C4,"m_playedtime:"),{ifcheck(isNull(music_playedObject),"no",str(music_playedObject get "curtime"))}],
	[colortext(1FC4C4,"m_vol:"),{str musicVolume}],
	[colortext(1FC4C4,"m_curchan:"),{str music_internal_lastPriority}]
	#ifdef EDITOR
	,["<t color='#832DCF'>[ENGINE]</t> Global threads:",{format["upd %1; hndl %2",count cba_common_perFrameHandlerArray,count cba_common_PFHhandles]}]
	,["<t color='#832DCF'>[ENGINE]</t> Delayed:",{str count cba_common_waitAndExecArray}]
	,["<t color='#832DCF'>[ENGINE]</t> Async delayed:",{str count cba_common_waitUntilAndExecArray}]
	,["<t color='#2BA639'>[OBJ]</t> Created objects:",{str oop_cco}]
	,["<t color='#2BA639'>[OBJ]</t> Active objects:",{str oop_cao}]
	,["<t color='#2BA639'>[OBJ]</t> Threads:",{str oop_upd}]
	#endif
	/*,
	["Processed SMD:",{count smd_allInGameMobs}],
	["Objects:",{count (allSimpleObjects [])}]*/
	#ifdef NOE_CLIENT_THREAD_DEBUG
	,["NOE_CTD:",{
		_s = format["c:%1",count noe_debug_allthreads];
		modvar(_s) + str noe_debug_allthreads;
		_s
		}]
	#endif
];

clistat_onupdate = {
	
	if (!clistat_isEnabled) exitwith {};

	_text = "";

	{
		_text = _text + (_x select 0) + format["%1",(call (_x select 1))] + sbr;
	} foreach clistat_buffer;

	[(clistat_widgets select 2),_text] call widgetSetText;
};


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

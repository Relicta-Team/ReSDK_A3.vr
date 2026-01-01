// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\ClientRpc\clientRpc.hpp>

namespace(chatos,chatos_)

inline_macro
#define mlp(v) 'v'

// Список селекшонов мобов
decl(string[])
chatos_mobSelections = [
				mlp(neck),
				mlp(head),
				mlp(spine3),
				mlp(spine2),
				mlp(pelvis),
				//right side
				mlp(rightshoulder),
				mlp(rightforearmroll),
				mlp(rightforearm),
				mlp(rightupleg),
				mlp(rightleg),
				mlp(rightfoot),
				//left side
				mlp(leftshoulder),
				mlp(leftforearmroll),
				mlp(leftforearm),
				mlp(leftupleg),
				mlp(leftleg),
				mlp(leftfoot)
			];

#undef mlp

// Ссылка на контрольную группу текстового чата
decl(widget[])
chatos_guiCtg = [widgetNull];

decl(map<string;widget>)
chatos_renderedWidgets = createHashMap;
decl(map<string;widget>)
chatos_renderedWidgetsPrint = createHashMap;

decl(float)
chatos_postMessageVisibleDelay = 2.5;

decl(void())
chatos_onUpdate = {
	if (isDisplayOpen && !(nd_openedDisplayType=="Input" || isInventoryOpen)) exitwith {
		{
			[_x,false] call deleteWidget;
		} foreach (values chatos_renderedWidgets);
		chatos_renderedWidgets = createHashMap;
	};
	/*
		данные о мобах/виджетах хранятся в двойном буфере 
		hashvalue(object),widget
		Algorithm:
			nearset mobs by max distance - (call vs_getMaxVolume)
		
			each object
	*/
	_maxDist = call vs_getMaxVolume;
	private _list = player nearEntities _maxDist;
	_list = _list - [player];
	_checked = [];
	_mob = 0;
	{
		//если сущность не имеет виджета
		_mob = hashValue _x;
		_messages = _x call chatos_getMobMessages;

		if !(_mob in chatos_renderedWidgets) then {
			_gui = getGUI;
			_text = [_gui,TEXT,[0,0,0,0],chatos_guiCtg select 0] call createWidget;
			_text setBackgroundColor (["chat_back"] call ct_getValue);

			chatos_renderedWidgets set [_mob,_text];
		};
		
		_text = chatos_renderedWidgets get _mob;

		_messages params ["_mes","_visDist","_addTime"];
		if (_addTime == 0 || tickTime >= (
			([_x,_mes] call chatos_getTimeText)
			+ _addTime + chatos_postMessageVisibleDelay //Время видимости дополнительное
		)) then {
			[_text,[-100,-100]] call widgetSetPositionOnly;
			continue;
		};

		_checked pushBack _mob;

		_distToTarget = player distance _x;
		_hiddenVoice = false;
		_minHiddenValue = 0;
		//если половина от громкости маньше или равна дистанции до цели то объект слышно
		_firstCheck = ifcheck(_visDist/2>_distToTarget,{_hiddenVoice = true; true},{_x call chatos_canSeeObject});
			
		//if cannot see mob then hide widget
		if (!(call _firstCheck) 
			|| {_distToTarget > _visDist}
		) then {
			[_text,[-100,-100]] call widgetSetPositionOnly;
			continue;
		};
		
		if (_hiddenVoice && {!(_x call chatos_canSeeObject)}) then {
			_minHiddenValue = 0.5;
		};

		//compose widgets
		//use widgetGetTextHeight

		call chatos_inlinecode;
		
		
	} forEach _list;

	if ((count _checked) != (count chatos_renderedWidgets)) then {
		{
			if !(_x in _checked) then {
				chatos_renderedWidgets deleteAt _x;
				[_y,false] call deleteWidget;
			};
		} foreach array_copy(chatos_renderedWidgets);
	};

};

decl(void())
chatos_inlinecode = {
	_convTsize = linearConversion [1,_visDist,_distToTarget,2.5,0.1,true];
	_convWidSize = linearConversion [1,_visDist,_distToTarget,30,0,true];
	[_text,format["<t size='%1' align='center'>%2</t>",_convTsize,_mes]] call widgetSetText;
	_wSize = _text call widgetGetTextHeight;
	_convWidSizeW = linearConversion [1,_visDist,_distToTarget,_wSize,2,true];

	((_x modelToWorldVisual ((_x selectionPosition "head") vectoradd [0,0,0.2])) 
		call positionWorldToScreen) params ["_xpos","_ypos"]; 
	[_text,[
		_xpos-(_convWidSize/2),
		_ypos-_convWidSizeW,
		_convWidSize,
		_convWidSizeW
	]] call widgetSetPosition;

	_fadeVal =linearConversion [_visDist/2,_visDist,_distToTarget,_minHiddenValue,1,true];
	
	//TODO use voice intersections
	//_ites = [_x,1] call vs_calcVoiceIntersection;
	//if (_ites<=0.3) then {_fadeVal = 1};

	widgetSetFade(_text,_fadeVal,0);
};

//get message buffer
decl(tuple<string;float;float>(actor))
chatos_getMobMessages = {
	_this getVariable ["__local_mob_onchatmessage",["",0,0]]
};

decl(float(actor;string))
chatos_getTimeText = {
	params ["_mob","_text"];
	(_mob getvariable ["__local_mob_voiceblobParams",[
			"undeclared",1,0.5
		]]) params ["_voiceType","_basePitch","_baseSpeed","_pertick"];
	if (_voiceType == "undeclared") exitwith {1};
	//1,20.5,0.07
	forceUnicode 1;
	private _speed = (count _text) / _baseSpeed;
	_speed
};

//standart check
decl(bool(actor))
chatos_canSeeObject = {
	params ["_obj"];

	if (call cd_isEyesClosed) exitwith {false};
	FHEADER;

	//Алгоритм пересечений. 
	private _alg_canSeePoint = {
		private _checked = (([_startPos,_this,_unit,_obj] call interact_th_getItscData) select 0);
		if isNullReference(_checked) exitWith {true};
		if (_checked call noe_client_isNGO) then {
			equals(_obj,_checked call noe_client_getNGOSource)
		} else {
			false
		};
	};

	private _unit = player;
	private _startPos = cam_renderPos;
	private _countView = 0;

	if (_obj getVariable ["mob_flag",false]) then {
		{
			if ((_obj modelToWorldVisual (_obj selectionPosition _x)) call _alg_canSeePoint) then {
				INC(_countView);
				if (_countView >= 2) exitWith {
					RETURN(true);
				};
			};
			true
		} count chatos_mobSelections;
	} else {
		(0 boundingBoxReal _obj) params ["_min","_max"];
		/*
			[-1,-1,-2] [1,1,2]
			8 points
			[-1,-1,-2]
			[-1,-1,2]
			[-1,1,2]
			[1,1,2]
			[-1,1,-2]
			[1,1,-2]
		*/
		private ["_y","_z","_bZ","_bY","_bX"];
		_bX = [_min select 0,_max select 0];
		_bY = [_min select 1,_max select 1];
		_bZ = [_min select 2,_max select 2];
		private _countView = 0;
		{
			_y = _x;
			{
				_z = _x;
				{
					if ((_obj modelToWorldVisual vec3(_x,_y,_z)) call _alg_canSeePoint) then {
						INC(_countView);
						if (_countView >= 2) exitWith {
							RETURN(true);
						}
					};
				} count _bX;
				true
			} count _bZ;
			reverse _bZ;
			true
		} count _bY;

	};

	false
};

decl(any[])
chatos_list_blobMobs = [];

chatos_actBlob = {
	params ["_mob","_mes","_distance","_voiceType","_basePitch","_baseSpeed",["_pertick",0.5]];
	/*
		частота проигрыша

	*/
	_mob setRandomLip true;
	forceUnicode 1;
	private _speed = (count _mes) / _baseSpeed;
	private _ctxparams = [
		tickTime,
		_pertick,
		[_mob,_distance,_voiceType,_basePitch,_mes],
		tickTime + _speed,
		tickTime
	];
	chatos_list_blobMobs pushBack _ctxparams;
};

decl(void())
chatos_onUpdateBlobTask = {
	_deleted = false;
	
	{
		_x params ["_nextcall","_speed","_thisArgs","_deleteAfter","_startTime"];
		if (tickTime >= _deleteAfter) then {
			(_thisArgs select 0) setRandomLip false;

			_deleted = true;
			chatos_list_blobMobs set [_foreachIndex,objnull];
			continue;
		};
		if (tickTime >= _nextcall) then {
			_x set [0,tickTime + _speed];
			_thisArgs params ["_mob","_distance","_voiceType","_basePitch","_mes"];
			forceUnicode 1;
			_curletInd = linearConversion [_startTime,_deleteAfter,tickTime,0,count _mes - 1,true];
			forceUnicode 1;
			_let = _mes select [_curletInd,1];
			traceformat("curlet:%1",_let)
			if ([_let,"[\!\?\,\.\-\ ]"] call regex_isMatch) exitWith {
				
			};
			if(_let=="") exitWith {};
			_mob setRandomLip true;
			["voice\" + _voiceType ,getPosATL _mob,1,
			_basePitch + rand(-0.1,0.1),_distance,
			null,null,null,false] 
			call soundLocal_play;
		};
	} foreach chatos_list_blobMobs;
	chatos_list_blobMobs = chatos_list_blobMobs - [objnull];
};

decl(void())
chatos_onUpdatePrintingSay = {
	if (isDisplayOpen && !(nd_openedDisplayType=="Input" || isInventoryOpen)) exitwith {
		{
			[_x,false] call deleteWidget;
		} foreach (values chatos_renderedWidgetsPrint);
		chatos_renderedWidgetsPrint = createHashMap;
	};

	private _list = player nearEntities 20;
	_list = _list - [player];
	_refToWidget = "__smd_chatos_widgetPrinting";
	private _checked = [];
	{
		_mob = hashValue _x;
		_mv = _x getvariable [_refToWidget,widgetNull];
		if (_x call chatos_isMobPrinting) then {
			if isNullReference(_mv) then {
				_mv = [getGUI,TEXT,[0,0,0,0],chatos_guiCtg select 0] call createWidget;
				_x setvariable [_refToWidget,_mv];
				chatos_renderedWidgetsPrint set [_mob,_mv];
			};
			_checked pushBack _mob;
		} else {

		};
	} foreach _list;
};

decl(bool(actor))
chatos_isMobPrinting = {
	_this getvariable ["smd_isPrintingSay",false]
};


if !isNull(relicta_global_textChatEnabled) then {
	chatos_guiCtg = [
		[getGUI,WIDGETGROUP,[0,0,100,100]] call createWidget
	];
	
	decl(void(actor;bool))
	chatos_event_onSpeak = {
		eventHandlerArgs params ["_mob","_isspeaking"];
		
		if (_isspeaking && !isDisplayOpen && equals(_mob,player)) then {
			rpcSendToServer("textchatrequest",[_mob arg vs_speak_volume_meters]);
		};
	};

	decl(void())
	chatos_onSay = {
		private eventHandlerArgs = [player,true];
		call chatos_event_onSpeak;
	};

	decl(int) chatos_onupdate_handle = startUpdate(chatos_onUpdate,0);
	decl(int) chatos_taksblobs_handle = startUpdate(chatos_onUpdateBlobTask,0);
	//chatos_onUpdatePrintingSay_handle = startUpdate(chatos_onUpdatePrintingSay,0);
};
// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\ClientRpc\clientRpc.hpp>

//#include "MusicManager.sqf"
#include "Music.sqf"


// params: ["_file","_source","_vol","_pitch","_maxDist",["_soundExtension","ogg"]];
rpcAdd("soundPlayGlobal",soundGlobal_play);
rpcAdd("sl_p",soundLocal_play);
rpcAdd("sui_p",soundUI_play);

//Рантайм вычисление процессор громкости звука
soundProcessor_play = {
	FHEADER;
	_this set [7,true];
	_this set [8,true];
	
	_srcObj = _this select 1;
	if equalTypes(_srcObj,"") then {
		private _srcPtr = noe_client_allPointers get _srcObj;
		if isNullVar(_srcPtr) exitWith {
			RETURN(false);
		};
		_this set [1,_srcPtr];
	//} else {
		
	};
	
	
	_this call soundGlobal_play;
}; rpcAdd("sl_p_rt",soundProcessor_play);

//воспроизводит объектный звук. Источник
//функция локальна
sound3d_playOnObject = {
	params ["_source","_class","_dist",["_pitch",1],["_offset",0]];

/*	if (typeOf _source == BASIC_MOB_TYPE) then {
		private _dummy = "#particlesource" createVehicleLocal [0,0,0];
		_dummy attachto [player,[0,0,0],"head"];
	};*/
	if ("\" in _class || ".ogg" in _class) exitWith {
		errorformat("sound3d::playOnObject() - Wrong type sound class - path (%1). Expected class",_class);
	};
	if equalTypes(_pitch,[]) then {
		_pitch = rand(_pitch select 0,_pitch select 1);
	};
	private _sound = _source say3d [_class,_dist,_pitch,false,_offset];

	//TODO autodelete timing

	/*
	obj = [player, player] say3D ["test", 100, 1, false, 0];

	[{deleteVehicle obj},[],0.2] call cba_fnc_waitAndExecute
	*/

	//just returning sound source
	_sound
}; rpcAdd("soundPlayOnObject",sound3d_playOnObject);

//функция локальна
sound3d_playOnObjectLooped = {
	params ["_additionalObjects","_3dSoundData",["_soundDuration",-1]];

	if (_soundDuration <= 0) exitWith {
		error("sound3d:playOnObjectLooped() - Duration is undefined or less than zero");
	};
	if (not_equalTypes(_additionalObjects,objNUll) && not_equalTypes(_additionalObjects,[])) then {
		errorformat("sound3d:playOnObjectLooped() - Source object wrong type - %1",tolower typename _additionalObjects);
	};

	_3dSoundData call sound3d_playOnObject;

	private _postCode = {
		params ["_additionalObjects","_3dSoundData","_soundDuration"];

		FHEADER;

		getThisCodeInTimeEvent(_postCode);

		if equalTypes(_additionalObjects,objNUll) then {
			if (isNullReference(_additionalObjects)) exitWith {RETURN(0)};
		} else {
			{
				if (isNullReference(_x)) exitWith {RETURN(0)};
			} foreach _additionalObjects;
		};

		[_additionalObjects,_3dSoundData,_soundDuration] call sound3d_playOnObjectLooped;
	};

	invokeAfterDelayParams(_postCode,_soundDuration,_this);

};

//Проигрывает локальный звук
sound_selfPlay = {
	params ["_path",["_offset",0]];
	playSound [_path, false, _offset]
};	rpcAdd("soundSelfPlay",sound_selfPlay);



// проигрывание локальных звуков
//from say3D [sound, maxDistance, pitch, isSpeech, offset]
sound3d_playLocal = {
	params ["_obj","_clsSound",["_pitch",1],["_distance",10],["_offset",0]];
	
	_obj say3D [_clsSound,_distance,_pitch,false,_offset];
}; rpcAdd("soundPlayLocal",sound3d_playLocal);


//Тестовый обработчик шагов
tmpPos = [0,0,0];
lastpos = getPosWorld player;
_handler = {

	_speedAminCoef = getAnimSpeedCoef player;
	tmpPos = getPosWorld player;

	if (tmpPos distance lastpos >0.4) then {
		logformat("turn! %1",tickTime);
		[PATH_SOUND("steps\step" + str randInt(1,4) + ".ogg"),player,1,getRandomPitch,10] call soundGlobal_play;
		lastpos = tmpPos;
	};

	changeUpdateTime(thisUpdate,delta/((speed player) max 1))

}; 

debug_doFootStep = {
	if (!vst_human_stealth_allowStepsounds) exitWith {};
	["steps\cr_step" + str randInt(1,2),getPosATL player,1,getRandomPitch,10] call soundGlobal_play;
};

debug_lastpos = getPosAtl player;

arrows=["Sign_Sphere10cm_F" createVehicle [0,0,0],"Sign_Sphere10cm_F" createVehicle [0,0,0]];
arrowsGround=["Sign_Sphere10cm_F" createVehicle [0,0,0],"Sign_Sphere10cm_F" createVehicle [0,0,0]];

_handler = {
	
	if !isNullReference(attachedTo player) exitWith {};
	
	_triggerPos = 0;
	_fottes = ["rightfoot","leftfoot"];
	_fottes_inversed = ["leftfoot","rightfoot"];
	_prevFrames = [0,0];
	_getFootPos = {
		player selectionPosition _this select 2
	};
	_getFootPosVec = {
		player selectionPosition _this
	};
	_resetTriggers = {{[_x,false] call _setTrigger} foreach _fottes};
	_getTrigger = {player getVariable [("__fs_isCall_"+_this),false]};
	_setTrigger = {player setVariable [("__fs_isCall_"+(_this select 0)),_this select 1]};
	
	_getLastCall = {player getVariable [("__fs_lastCall_"+_this),0]};
	_setLastCall = {player setVariable [("__fs_lastCall_"+(_this select 0)),_this select 1]};
	
	/*{
		(arrows select _forEachIndex) setposatl (player modelToWorldVisual ((_x call _getFootPosVec) vectorAdd ([0,0.1,0])));
		_ins = lineIntersectsSurfaces [
	  		AGLToASL getposatl (arrows select _forEachIndex),
	  		AGLToASL ((getposatl (arrows select _forEachIndex)) vectorDiff [0,0,100]),
	  		player,
			arrows select _forEachIndex,
			true,
			1,
			"GEOM","NONE"
	 	];
		if (count _ins == 1) then {
			(arrowsGround select _forEachIndex) setPosAtl (ASLToATL(_ins select 0 select 0))
		};

		
		
		_leg = arrows select _forEachIndex;
		_ground = arrowsGround select _forEachIndex;
		#define distLTG (_leg distance _ground )
		#define lastDist (_ground getVariable ["lastdistance",distLTG])
		#define isNegativize (distLTG < lastDist)
		#define isPositivize (distLTG > lastDist)
		if (distLTG <= 0.25 && isNegativize && !(_ground getVariable ["isTriggered",false])) then {
			_ground setVariable ["isTriggered",true];
			_leg setObjectTexture [0,"#(rgb,8,8,3)color(1,0,0,1)"];
			call debug_doFootStep;
		};
		if (isPositivize && (_ground getVariable ["isTriggered",false])) then {
			_ground setVariable ["isTriggered",false];
			_leg setObjectTexture [0,"#(rgb,8,8,3)color(0,1,0,1)"];
		};
		
		_ground setVariable ["lastdistance",_leg distance _ground];
	} foreach _fottes;*/
	
	
	
	if not_equals(debug_lastpos,getPosATL player) then {
		if (debug_lastpos distance getPosATL player < 0.11) exitWith {};
		{
			if (
					(_x call _getFootPos <= _triggerPos 
						&& ((_x call _getFootPos) < (_prevFrames select _forEachIndex))) 
					
					&& !(_x call _getTrigger) 
					//&& tickTime >= (_x call _getLastCall)
				) 
				then {
				call debug_doFootStep;
				[_x,true] call _setTrigger;
				//[_x,tickTime+0.6] call _setLastCall;
				//[_fottes_inversed select _forEachIndex,false] call _setTrigger;
			};
			if (
				(_x call _getFootPos >= 0.05 
				&& (_x call _getFootPos) > (_prevFrames select _forEachIndex))
				&& (_x call _getTrigger) 
				//&& tickTime >= (_x call _getLastCall)
			) then {
				[_x,false] call _setTrigger;
			};
			
			_prevFrames set [_forEachIndex,_x call _getFootPos]
		} foreach _fottes;
		
		debug_lastpos = getPosATL player;
	} else {
		call _resetTriggers;
		
	};
	
};
startUpdate(_handler,0);

/*

h = [] spawn {
	private _lastPos = getPosWorld player;
	private _tmpPos  = [0,0,0];
	private _positions = [];
	private _footsteps = [];
	private _i = 0;

	while {true} do {
		_tmpPos = getPosWorld player;
		if (_tmpPos distance _lastPos >1) then {
			_footstep = createSimpleObject [
				format ["a3\characters_f\footstep_%1.p3d", ['l', 'r'] select (_i %2)],
				AGLtoASL (player modelToWorldVisual ([[0,0.2,0],[0.2,0,0]] select (_i %2)))
			];
			_footstep setDir (getDir player);
			_positions pushBack [_tmpPos, time, _footstep];

			_i = _i + 1;
			_lastPos = _tmpPos;
		};
		hintSilent format ["FOOTSTEPS: %1", count _positions];
		sleep (1/((speed player) max 1));
	};
};

*/

//player selectionPosition "leftfoot"
//player selectionPosition "righttoebase"
//player setVariable ["laststep_leftfoot",tickTime + 0.4];
//player setVariable ["laststep_rightfoot",tickTime+ 0.4];
/*_simulateStep = {
	{
		_d = ((player selectionPosition _x) select 2);
		if (_d <= 0.01 && _d >= -0.01 && abs speed player > 1) then {
			if (tickTime > (player getVariable ("laststep_"+_x))) then {
				[("steps\step" + str randInt(1,4)),player,1,getRandomPitch,20] call soundGlobal_play;
				player setvariable ["laststep_"+_x,tickTime+0.4];
			}
			
		};
	} foreach ["leftfoot","rightfoot"];
}; //startUpdate(_simulateStep,0);*/
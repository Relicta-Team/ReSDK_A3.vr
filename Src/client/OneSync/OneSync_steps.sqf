// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\LightEngine\LightEngine.hpp"

os_steps_handle = -1;

os_steps_currentSoundName = "";
os_steps_currentSoundCount = 0;

#define OS_STEPS_DEFAULT_SOUND_KEY SLIGHT_DAM_STONE

//os_steps_soundsType = [];
os_steps_getStepData = { materials_map_stepData };
os_steps_map_objToMaterialPtr = createHashMap; //key - strPtr, value - materials_map_stepData:key
os_steps_lastPtr = stringEmpty;
os_steps_canUseRequests = false;

os_steps_lastpos = vec3(0,0,0);

os_steps_const_foots = ["rightfoot","leftfoot"];
os_steps_const_foots_inversed = ["leftfoot","rightfoot"];

os_steps_setEnable = {
	params ["_mode"];
	if (_mode) then {
		os_steps_handle = startUpdate(os_steps_onUpdate,0);
	} else {
		stopUpdate(os_steps_handle);
		os_steps_handle = -1;

		call os_steps_resetAllVariables;
	};
};

os_steps_handleStepData = {
	params ["_ptr"];
	if (_ptr==stringEmpty) exitWith {};
	//if (_ptr==os_steps_lastPtr) exitWith {};

	private _matKey = os_steps_map_objToMaterialPtr get _ptr;
	if isNullVar(_matKey) then {
		//send request
		rpcSendToServer("os_sgd",vec2(player,_ptr));
		//os_steps_lastPtr = _ptr; //prevent network spam
	} else {
		if (_matKey == -1) then {
			//no default material. apply stone by default:
			_matKey = OS_STEPS_DEFAULT_SOUND_KEY;
		};
		private _mStepData = materials_map_stepData get _matKey;
		if isNullVar(_mStepData) exitWith {
			warningformat("os::steps::handleStepData - No material found %1",_matKey);
		};

		//unpack and apply material
		_mStepData params ["_stepSound"];
		_stepSound params ["_pattern","_count"];
		
		os_steps_currentSoundName = _pattern;
		os_steps_currentSoundCount = _count;
		os_steps_lastPtr = _ptr;
	};
};

os_steps_getObjectOnFoot = {
	private _footObjParams = [getPosAtl player,(getPosAtl player) vectorDiff [0,0,1000],player] call interact_getRayCastData;
	private _footObj = _footObjParams select 0;
	if isNullReference(_footObj) exitWith {""};
	[_footObj] call noe_client_getObjPtr
};

os_steps_onGetStepData = {
	params ["_wobjPtr","_sdPtr"];

	os_steps_map_objToMaterialPtr set [_wobjPtr,_sdPtr];

}; rpcAdd("os_gs",os_steps_onGetStepData);

// -------- internal processes -------------

os_steps_updateLastPos = {
	os_steps_lastpos = getPosAtl player;
};

os_steps_getFootPos = {
	player selectionPosition _this select 2
};

os_steps_getFootPosVec = {
	player selectionPosition _this
};

os_steps_resetTriggers = {
	{{[_x,false] call os_steps_setTrigger} foreach os_steps_const_foots};
};

os_steps_resetAllVariables = {
	{
		player setVariable [("__fs_isCall_"+_x),null];
		player setVariable [("__fs_lastCall_"+_x),null];
	} foreach os_steps_const_foots;
	os_steps_lastPtr = stringEmpty;
};

os_steps_getTrigger = {
	player getVariable [("__fs_isCall_"+_this),false];
};

os_steps_setTrigger = {
	player setVariable [("__fs_isCall_"+(_this select 0)),_this select 1];
};

os_steps_getLastCall = {
	player getVariable [("__fs_lastCall_"+_this),0];
};

os_steps_setLastCall = {
	player setVariable [("__fs_lastCall_"+(_this select 0)),_this select 1];
};

os_steps_onUpdate = {
	if !isNullReference(attachedTo player) exitWith {};
	if (!os_steps_canUseRequests) exitWith {};
	
	_triggerPos = 0;
	_fottes = os_steps_const_foots;
	_fottes_inversed = os_steps_const_foots_inversed;
	_prevFrames = [0,0];

	//functions references
	_getFootPos = os_steps_getFootPos;
	_getFootPosVec = os_steps_getFootPosVec;
	_resetTriggers = os_steps_resetTriggers;
	_getTrigger = os_steps_getTrigger;
	_setTrigger = os_steps_setTrigger;
	
	_getLastCall = os_steps_getLastCall;
	_setLastCall = os_steps_setLastCall;

	#ifdef EDITOR
	if (os_steps_enable_debugInfo) then {
		call os_steps_debug_renderInfo;
	};
	#endif

	_o = call os_steps_getObjectOnFoot;
	[_o] call os_steps_handleStepData;

	if (os_steps_currentSoundName == "") exitWith {};

	if not_equals(os_steps_lastpos,getPosATL player) then {
		if (os_steps_lastpos distance getPosATL player < 0.11) exitWith {};
		{
			if (
					(_x call _getFootPos <= _triggerPos 
						&& ((_x call _getFootPos) < (_prevFrames select _forEachIndex))) 
					
					&& !(_x call _getTrigger) 
					//&& tickTime >= (_x call _getLastCall)
				) 
				then {
				call os_steps_doFootStep;
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
		
		call os_steps_updateLastPos;
	} else {
		call _resetTriggers;
		
	};
};

os_steps_doFootStep = {
	if (!vst_human_stealth_allowStepsounds) exitWith {};

	private _soundPath = format["steps\%1%2",os_steps_currentSoundName, randInt(1,os_steps_currentSoundCount)];
	[_soundPath,getPosATL player,rand(1.3,1.35),getRandomPitch,10] call soundGlobal_play;
};

os_steps_onUpdateSoundData = {
	params ["_pattern","_count"];
	os_steps_currentSoundName = _pattern;
	os_steps_currentSoundCount = _count;
}; rpcAdd("stupd",os_steps_onUpdateSoundData);

#ifdef EDITOR

os_steps_debug_arrows=["Sign_Sphere10cm_F" createVehicle [0,0,0],"Sign_Sphere10cm_F" createVehicle [0,0,0]];
os_steps_debug_arrowsGround=["Sign_Sphere10cm_F" createVehicle [0,0,0],"Sign_Sphere10cm_F" createVehicle [0,0,0]];

os_steps_enable_debugInfo = false;

os_steps_debug_renderInfo = {
	{
		(os_steps_debug_arrows select _forEachIndex) setposatl (player modelToWorldVisual ((_x call _getFootPosVec) vectorAdd ([0,0.1,0])));
		_ins = lineIntersectsSurfaces [
	  		AGLToASL getposatl (os_steps_debug_arrows select _forEachIndex),
	  		AGLToASL ((getposatl (os_steps_debug_arrows select _forEachIndex)) vectorDiff [0,0,100]),
	  		player,
			os_steps_debug_arrows select _forEachIndex,
			true,
			1,
			"GEOM","NONE"
	 	];
		if (count _ins == 1) then {
			(os_steps_debug_arrowsGround select _forEachIndex) setPosAtl (ASLToATL(_ins select 0 select 0))
		};

		
		
		_leg = os_steps_debug_arrows select _forEachIndex;
		_ground = os_steps_debug_arrowsGround select _forEachIndex;
		#define distLTG (_leg distance _ground )
		#define lastDist (_ground getVariable ["lastdistance",distLTG])
		#define isNegativize (distLTG < lastDist)
		#define isPositivize (distLTG > lastDist)
		if (distLTG <= 0.25 && isNegativize && !(_ground getVariable ["isTriggered",false])) then {
			_ground setVariable ["isTriggered",true];
			_leg setObjectTexture [0,"#(rgb,8,8,3)color(1,0,0,1)"];
			call os_steps_doFootStep;
		};
		if (isPositivize && (_ground getVariable ["isTriggered",false])) then {
			_ground setVariable ["isTriggered",false];
			_leg setObjectTexture [0,"#(rgb,8,8,3)color(0,1,0,1)"];
		};
		
		_ground setVariable ["lastdistance",_leg distance _ground];
	} foreach _fottes;
};
#endif
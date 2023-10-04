//call call compile preprocessfile "src\client\Lobby\debug.sqf"
if (isnull lobby_internal_rttcamera) exitwith {
	["CAMNULL"] call messageBox;
};



lobby_internal_rttcamera cameraEffect ["INTERNAL", "BACK", "lobby_face_rtt"];
lobby_internal_rttcamera setdir 180;

private _campos = (lobby_glob_dummy_man modeltoworldvisual (lobby_glob_dummy_man selectionPosition "head"));

lobby_internal_rttcamera setposatl (_campos vectoradd [0,1,0.15]);
lobby_internal_rttcamera campreparetarget (_camPos vectoradd [-0.05,0,0.11]);
lobby_internal_rttcamera campreparefov 0.16;
lobby_internal_rttcamera camcommitprepared 1;

private _rttlt = lobby_internal_rttlight;
_rttlt setPosAtl (_campos vectoradd [1,0.2,1.7]);
private _ps = -90;
[_rttlt,[0,_ps,0]] call BIS_fnc_setObjectRotation;
[_rttlt,[0,_ps,0]] call BIS_fnc_setObjectRotation;

_rttlt setLightConePars [122.52,30.46,2];
_rttlt setLightColor [0.18,0.28,0.25];
lobby_internal_backwallObject setposatl (_campos vectoradd [0,-1,0]);

//lobby_internal_rttcamera campreparetarget (_campos vectoradd [-0.05,10.5,0.1]);
//lobby_internal_rttcamera camcommitprepared 0;
//lobby_internal_rttcamera setdir 180;
//lobby_internal_rttcamera camSetFov 0.2;

// 0 = [] spawn {
// 	lobby_internal_rttcamera setdir 0;
// 	uisleep 1;
// 	lobby_internal_rttcamera setdir 90;
// 	uisleep 1;
// 	lobby_internal_rttcamera setdir 180;
// 	uisleep 1;
// 	lobby_internal_rttcamera setdir 270;
// 	uisleep 1;
// };

//call debug_syncpic;

//lobby_internal_rttcamera camCommit 0;




debug_pic ctrlSetText "#(argb,512,512,1)r2t(lobby_face_rtt,1)";
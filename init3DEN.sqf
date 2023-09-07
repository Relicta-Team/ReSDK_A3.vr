#include <src\host\engine.hpp>

setAperture -1;

//disable discord extension
"DiscordRichPresence" callExtension ["CloseRichPresence",[]];
//and reload...
#include <src\client\DiscordRPC\DiscordRPC_init.sqf>
call discrpc_editor_init;

#define getEdenDisplay (findDisplay 313)
#define getEdenMenu (getEdenDisplay displayCtrl 120)

compileEditor = {
	(call compile preprocessFileLineNumbers "src\Editor\Editor_init.sqf")
};
0 = [] spawn {
	uiSleep 0.5;
	isnil compileEditor;
};

/*if (getEdenMenu menuSize [8] != 0) then {
	getEdenMenu menuDelete [8];
	//getEdenMenu menuDelete [8];
};	

_mainMenu = getEdenMenu menuAdd [[], "RelcitaEditor"];

_item = getEdenMenu menuAdd [[_mainMenu], "Prepare client-side scripts"];
getEdenMenu menuSetAction [[_mainMenu,_item], 'call compile preprocessFile "src\packClientOnly.sqf";'];*/

if (true) exitWith {};

removealldisplayevents = {
	/*(findDisplay 46) displayRemoveAllEventHandlers "keydown";
	(findDisplay 46) displayRemoveAllEventHandlers "keyup";
	(findDisplay 46) displayRemoveAllEventHandlers "mousebuttondown";
	(findDisplay 46) displayRemoveAllEventHandlers "mousebuttonup";
	(findDisplay 46) displayRemoveAllEventHandlers "MouseZChanged";*/
	
	if (!isNil{h_d3d_recomp}) then {
		removeMissionEventHandler ["Draw3D",h_d3d_recomp];
		h_d3d_recomp = nil;
	};
};

//disable arma input
call removealldisplayevents;
//adding recompile button
/*(findDisplay 46) displayAddEventHandler ["keyup",{
	params ["_obj","_key"];
	
	if (_key == KEY_F6) then {
		call go;
	};
}];*/

h_d3d_recomp = addMissionEventHandler ["Draw3d", {
	if(!isnil{(getEdenDisplay)}) then {
		#define precent_to_real(proc_val) (proc_val / 100)
		//_abort1 = (findDisplay 49 displayCtrl 103);
		//_abort1 ctrlEnable false;
		
		/*_bt = (findDisplay 49) ctrlCreate ["RscButton",-1];
		tds = diag_ticktime;
		
		_bt ctrlSetPosition [precent_to_real(0) * safezoneW + safezoneX,
		precent_to_real(20) * safezoneH + safezoneY,
		precent_to_real(20) * safezoneW,
		precent_to_real(10) * safezoneH];
		_bt ctrlCommit 0;
		_bt ctrlSetText "COMPILE AND RUN";
		_bt ctrlAddEventHandler ["MouseButtonUp",{
				call go;
				(findDisplay 49) closeDisplay 0;
			}];*/
		
		/*_bt = getEdenDisplay ctrlCreate ["RscButton",-1];
		_bt ctrlSetPosition [precent_to_real(0) * safezoneW + safezoneX,
		precent_to_real(32) * safezoneH + safezoneY,
		precent_to_real(20) * safezoneW,
		precent_to_real(10) * safezoneH];
		_bt ctrlCommit 0;
		_bt ctrlSetText "PREPARE CLIENT";
		_bt ctrlAddEventHandler ["MouseButtonUp",{
				call compile preprocessFile "src\packClientOnly.sqf";
				//(findDisplay 49) closeDisplay 0;
			}];*/
	};
}];

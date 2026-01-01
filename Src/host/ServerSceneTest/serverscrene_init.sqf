// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
//#include "..\ServerRpc\serverRpc.hpp"
#include <..\..\client\ClientRpc\clientRpc.hpp>
#include "..\..\client\Inventory\inventory.hpp"
#include <..\GamemodeManager\GamemodeManager.h>

#define vecForward(bias) (getposatl player) vectorAdd [sin (getdir player) * bias,cos (getdir player) * bias,0]


if (!isMultiplayer) then {
	setTimeMultiplier 0.1;
	player switchaction "";
	
	tptomap = {player setposatl [3789.56,3779.98,28.9044]/*[3807.36,3822.13,40.1514]*/};
	setnight = {_dateToSync = [1985,5,20,0,00];setDate _dateToSync;};
	if (isNull(lastplayerpos)) then {lastplayerpos = getPosATL player};
	if (isNull(lastplayerdir)) then {lastplayerdir = getdir player};
	
	_upd = {
		_dateToSync = [1985,5,20,0,00];
		if (date select 4 != _dateToSync select 4 || date select 3 != _dateToSync select 3) then {
			setDate _dateToSync;
		};
	};
	//startUpdate(_upd,1);

	debug_setReadySettings = {
		#ifdef ENABLE_LAG_NETWORK
		_c = {
			_hasLobbystart = !false;
			_doStartRound = !false;
			if (_hasLobbystart) then {
				rpcSendToServer("onClientChangeCharSetting",["role1" arg 'EDITOR_STARTUP_ROLE' arg 0]);
				rpcSendToServer("onClientPrepareToPlay",[true arg 0]);
				if (_doStartRound) then {gm_lobbyTimeLeft = 1};
			} else {
				gm_startFromLobbyCondition = {true};
				if (_doStartRound) then {gm_lobbyTimeLeft = 1};
			};
		}; invokeAfterDelay(_c,LAG_NETWORK_TICKTIME_MAX * 5);
		#else
		_hasLobbystart = !false;
		_doStartRound = !false;
		if (_hasLobbystart) then {
			rpcSendToServer("onClientChangeCharSetting",["role1" arg 'EDITOR_STARTUP_ROLE' arg 0]);
			rpcSendToServer("onClientPrepareToPlay",[true arg 0]);
			if (_doStartRound) then {gm_lobbyTimeLeft = 1};
		} else {
			//gm_startFromLobbyCondition = {true};
			//if (_doStartRound) then {gm_lobbyTimeLeft = 1};
		};
		#endif

	};
	/*#ifdef DO_NOT_CREATE_MAP
		invokeAfterDelay(debug_setReadySettings,0.3);
	#else
		invokeAfterDelay(debug_setReadySettings,0.8);
	#endif*/

	debug_asyncCode = {
		//stopUpdate(gm_handleLobbyLoop);
		//call gm_startRound;
		//if (true) exitWith {};


		//onClientChangeCharSetting> send 21 bytes to SERVER with ["role1","Char",0]
		//rpcCall("onClientChangeCharSetting",["role1" arg "Char" arg 0]);
		//gm_lobbyTimeLeft = -1;

		//["Torch",vecForward(2),null,false] call createItemInWorld;
		//["Campfire",[1933.98,2215.39,5.36419],null,false] call createStructure;
		
		//["SmallChair",[1940.2,2216.94,5.35687],null,false] call createStructure;
			// if need this declare:  classForTest = "class";
			//[classForTest,[1934.88,2217.54,5.36093],0,false] call createItemInWorld;
		//["SteelDoorThinSmall",[1935.02,2219.29,5.35602],0,false] call createStructure;
		
		{
			//[_x,lastplayerpos vectorAdd [random 15,random 15,0],0,false] call createItemInWorld;
			//[_x,lastplayerpos vectorAdd [random 10,random 10,0],0,false] call createStructure;
		} foreach getAllObjectsTypeOf(SContainer);//(pt_Cloth getVariable "__childList");
		
		//
		_genpos = [1943.29,2217.69,5.33485];
		_transfpos = [1945.37,2219.15,5.36733];//[1943.66,2215,5.36274];
		_lightpos = [1944.96,2222.26,5.36589];
		_bagpos = [1934.01,2218.97,5.35509];

		_gen = ["PowerGenerator",_genpos,0-90,false] call createStructure; pg = _gen;
		_sh = ["ElectricalShield",_transfpos,0-90,false] call createStructure;
		callFuncParams(_gen,addConnection,_sh);
		_rub = ["PowerSwitcher",[1944.45,2219.03,6.13552],0,false] call createStructure;
		callFuncParams(_sh,addConnection,_rub);
		_rub2 = ["PowerSwitcherBox",[1944.45,2219.03,5.63552],0,false] call createStructure;
		callFuncParams(_rub,addConnection,_rub2);
		for "_i" from 0 to 1 do {
			_lam = ["StreetLamp",_lightpos vectorAdd [0,2 * -_i,0],0,false] call createStructure;
			callFuncParams(_rub2,addConnection,_lam);
		};
		
		//autodoors test
		_gates = ["GateCity",[1947.56,2227.56,5.36733],180,false] call createstructure;
		_r3 = ["PowerSwitcherBox_Activator",[1949.98,2223.64,6.79575],-90,false] call createStructure;
		callFuncParams(_r3,connectTo,_rub2);
		callFuncParams(_gates,connectTo,_r3);
		
		//effects govnelin
		_eff = ["EffectAsStruct",[1947.56,2227.56,5.36733],0,false] call createStructure;
		callFuncParams(_eff,setEffectType,"govnelin");
		
		["SmallChair",[1932.48,2215.41,5.36429],230.419-180,false] call createItemInWorld;
		
		/*_chemtool = ["MedicalFreezer",[1945.42,2217.39,5.36712],90,false] call createStructure;
		callFuncParams(_chemtool,connectTo,_rub2);
		_drytool = ["DryChemStruct",[1948.49,2217.01,5.76733],0,false] call createStructure;
		callFuncParams(_drytool,connectTo,_rub2);
		_chemBlend = ["ChemicalBlender",[1946.73,2225.59,5.06733],180,false] call createStructure;
		callFuncParams(_chemBlend,connectTo,_rub2);*/
		
		/*
		["ChemDistiller",[1945.32,2214.98,5.36194],0,false] call createItemInWorld;
		["ChemBowl",[1946.26,2214.57,5.36733],0,false] call createItemInWorld;
		["Pestik",[1946.36,2214.57,5.36733],0,false] call createItemInWorld;
		*/
		_post={
			//["BookChemReactions",player getVariable 'link',INV_HAND_L] call createItemInInventory;
			//["Multimeter",player getVariable 'link',INV_HAND_R] call createItemInInventory;
			
			//["Paper",player getVariable 'link',INV_HAND_L] call createItemInInventory;
			//["PenBlack",player getVariable 'link'] call createItemInInventory;
			//["SmallBattery",player getVariable 'link',INV_HAND_L] call createItemInInventory;
			//["Flashlight",player getVariable 'link',INV_HAND_R] call createItemInInventory;
		};
		invokeAfterDelay(_post,0.5);
		
		//["Kastrula",lastplayerpos,0,false] call createItemInWorld;
		//["SoupPlate",lastplayerpos,0,false] call createItemInWorld;
		//chair test
		
		//["DeliveryPipe",[1940,2217.5,5.35147],0,false] call createStructure;
		/*_p = ["RegistrationPanel",[1940,2217.5,5.35147],0,false] call createStructure;
		_r = ["RegistratorPanelReceiver",[1942,2217.5,5.35147],0,false] call createStructure;
		callFuncParams(_p,setReceiverObj,_r);*/
		
		//["FarmGarden",[1940,2217.5,5.35147],0,false] call createStructure;
		
		//new merchant test
		_c = ["MerchantConsole",[1940,2217.5,5.35147],0,false] call createStructure;
		_p = ["DeliveryPipe",[1942,2217.5,5.35147],0,false] call createStructure;
		callFuncParams(_c,linkPipe,_p);
		callFuncParams(_p,connectTo,_rub);
		callFuncParams(_c,connectTo,_rub);
		
		
		//["BunchOfShit",[1940,2217.5,5.35147],0,false] call createStructure;
		
		//["FryingPan",vecForward(1),0,false] call createItemInWorld;
		["FryingPan",[1930.29,2214.53,5.36575],0,false] call createItemInWorld;
		["Egg",[1930.29,2214.53,5.36575],0,false] call createItemInWorld;
		["Lepeshka",[1930.29,2214.53,5.36575],0,false] call createItemInWorld;
		
		_adel = {
			obj = objNull;
			{
				if ("stulcasual.p3d" in str _x) exitwith {obj = _x};
			} foreach (player nearobjects 10);
			
			if equals(obj,objNull) exitWith {};
			debug_mode = true;
			_upd = {
				if (debug_mode) then {
					player attachTo [obj,[0,0,-1.45]];
					//player setdir 90;
					detach player;
				} else {
					//detach player;
					//player setdir 90;
				};
				debug_mode = !debug_mode;
			}; startUpdate(_upd,0);
		};
		//invokeAfterDelay(_adel,1);
		
		/*
		player attachTo [obj,[0,0,-0.45]];

		detach player;
		player setdir 90;

		*/
		
		//struct container tests
		_cont = ["OldWoodenBox",[1939.68,2214.49,5.36509],0,false] call createStructure;
		for "_i" from 1 to 30 do {
			_it = ["Candle",_cont] call createItemInContainer;
		};
		
		//speaker test
		_sp1 = ["StationSpeaker",[1939.15,2214.33,7.36536],180,false] call createStructure;
		_sp2 = ["StationSpeaker",[1928.68,2236.59,10.3208],180,false] call createStructure;
		_ic1 = ["Intercom",[1933.28,2219.38,5.85409],180,false] call createStructure;
		_ic2 = ["HeadControlPanel",[1948.39,2225.32,5.36733],180,false] call createStructure;
		
		if isTypeOf(_ic2,HeadControlPanel) then {
			{callFuncParams(_ic2,addSpeaker,_x)} foreach [_sp1,_sp2];
			
			
			//_ar = ["RegistrationPaperArchive",[1940,2217.2,5.35147],90,false] call createStructure;
			//callFuncParams(_ar,linkHeadConsole,_ic2)
		};
		
		{callFuncParams(_x,connectTo,_rub2)} forEach [_sp1,_sp2,_ic1,_ic2];

		/*allgens = [];
		_pcd = {for "_i" from 1 to 10 step 2 do {
			_sh = ["ElectricalShield",[1939.89,2214.67 + _i,5.36482],0-90,false] call createStructure;
			allgens pushBack _sh;
			callFuncParams(pg,addConnection,_sh);
			_rub = ["PowerSwitcher",[1937.89,2214.67 + _i,6.56482],0,false] call createStructure;
			callFuncParams(_sh,addConnection,_rub);
			_lam = ["StreetLamp",[1932.89,2214.67 + _i,6.56482],0,false] call createStructure;
			callFuncParams(_rub,addConnection,_lam);

			//
			//
			callFuncParams(_lam,setEnable,true);
			callFuncParams(_rub,setEnable,true);
			callFuncParams(_sh,setEnable,true);

			for "_r" from 1 to _i * 2 do {
				_lam = ["StreetLamp",[1932.89 - _r * 12,2214.67 + _i,6.56482],0,false] call createStructure;
				callFuncParams(_rub,addConnection,_lam);
				callFuncParams(_lam,setEnable,true);
			};
		};
		}; invokeAfterDelay(_pcd,2);
		reloadgens = {
			{
				callFuncParams(_x,setEnable,false);
				callFuncParams(_x,setEnable,true);
			} foreach allgens;
			pg setvariable ['energyleft',_this];
		};

		showHUD true;
		_postcode = {
			{

				_link = _x getVariable 'link';
				if (!isNullVar(_link)) then {

					if isTypeOf(_link,IStruct) then {

						_txt =  (format["%1 Это узел: %2 %1 Включен: %3 %1 Использует энергию: %4","|",
							getVar(_link,edIsNode),
							getVar(_link,edIsEnabled),
							getVar(_link,edIsUsePower)]);
						drawIcon3D ["", [0,1,0,1], (ASLToAGL getPosASL _x) vectorAdd [0,0,0.5], 0, 0, 0, _txt, 1, 0.04, "PuristaMedium","center"];
					};
				};
			} foreach (player nearobjects 10);
		}; startUpdate(_postcode,0);*/


		/*_post = {_k = ["Key",player getVariable 'link' getVariable 'slots' select INV_CLOTH] call createItemInContainer;

		for "_i" from 1 to 5 do {
			["Zvak",vecForward(2),null,false] call createItemInWorld;
		};

		_dr = ["SteelGridDoor",[1934.33,2213.66,5.36672],0,false] call createStructure;
		setVar(_k,keyOwner,["test"]);
		setVar(_dr,keyTypes,["test"]);

		//cont
		_cont = ["FabricBagBig1",[1933.78,2216.31,5.36284],null,false] call createItemInWorld;
		{
			[_x,_cont] call createItemInContainer;
		} foreach (pt_organ getVariable "__childList");

		}; invokeAfterDelay(_post,1);

		["ChairLibrary",_bagpos,0,false] call createItemInWorld;
		["Flashlight",[1935.63,2219.07,5.35861],0,false] call createItemInWorld;
		["SmallBattery",[1935.63,2219.19,5.35861],0,false] call createItemInWorld;
		["Campfire",[1937.77,2217.16,5.36128],null,false] call createStructure;*/


		//reg vasya
		_vasa = vasya;
		vasya setVariable ["mob_flag",true];
		_mob = new(Mob);
		callFuncParams(_mob,initAsActor,_vasa);
		[_mob,14,14,14,14] call gurps_initSkills;
		setVar(_mob,name,"Васёк");
		[_mob,"Вася","Реликтов"] call naming_generateName;
		//["CaveAxe",_mob,INV_HAND_L] call createItemInInventory;
		
		smd_allInGameMobs pushBackUnique vasya;
		callFuncParams(_mob,setMobFace,pick faces_list_man);
		setVar(_mob,curTargZone,9);//lhand
		
		
		debug_lastattacktime = tickTime + 0;
		_c = {
			_m = vasya getVariable 'link';
			_m setVariable ['stamina',9999];
			if (vasya distance player <= 1.5) then {
				if (tickTime < debug_lastattacktime) exitWith {};
				debug_lastattacktime = tickTime + 2.3;
				callFuncParams(_m,attackOtherMob,player getVariable 'link');
			};
		}; 
		//callFuncParams(_mob,setCombatMode,true);startUpdate(_c,0);
	};

	startAsyncInvoke
		{
			params ["_timeToStart"];
			isLobbyOpen && false
		},
		debug_asyncCode,
		[tickTime + 1]
	endAsyncInvoke
} else {
	_dateToSync = [1985,5,20,0,00];
	setDate _dateToSync;
};



#ifdef IS_ENABLE_GAMEMODEMANAGER
	if (true) exitWith {};
#endif
if (true) exitWith {};

//["src\host\MapManager\Maps\testmap.sqf"] call MapManager_loadmap;
//wm_fists = new(Fists);

#define dist_it 1
#define forwardPos (getposatl player) vectorAdd [sin (getdir player) * dist_it,cos (getdir player) * dist_it,0]

_playerObject = player;
_vMob = new(Mob);
callFuncParams(_vMob,initAsActor, _playerObject); // сначала владельца чтобы отправить ему инфу
[_vMob,10,12,16,9] call gurps_initSkills;


callFunc(_vMob,initAnims);

callFunc(_vMob,onConnected); //sending main info for client
setVar(_vMob,name,"Йодис");
[_vMob,"Йодис","Седов"] call naming_generateName;

/*if (true) exitWith {
	_c = {["Torch",forwardPos,null] call createItemInWorld;};
	invokeAfterDelay(_c,3)
};*/


//Добавим васю
_vasa = vasya;
_mob = new(Mob);
callFuncParams(_mob,initAsActor,_vasa);
[_mob,14,14,14,14] call gurps_initSkills;
setVar(_mob,name,"Васёк");
[_mob,"Вася","Реликтов"] call naming_generateName;
//callFuncParams(_mob,setUnconscious,1000);
//["Breastplate" arg _mob arg INV_ARMOR] call createItemInInventory;
//invokeAfterDelayParams({["Breastplate" arg _this arg INV_ARMOR] call createItemInInventory},5,_mob);

/*["item",(getposatl player) vectorAdd [0.07,0.2,0]] call createItemInWorld;*/
//_clothObj = ["cloth",(getposatl player) vectorAdd [0,0.2,0]] call createItemInWorld;
_virtCloth = ["cloth",_playerObject,INV_CLOTH] call createItemInInventory;
_virtArmor = ["Breastplate",_playerObject,INV_ARMOR] call createItemInInventory;
["CaveAxe",_playerObject,INV_HAND_L] call createItemInInventory;


["Torch",_playerObject,INV_HAND_R] call createItemInInventory;
private _groundItem = ["Torch",(getposatl player) vectorAdd [sin (getdir player) * dist_it,cos (getdir player) * dist_it,0]] call createItemInWorld;
//private _vback = _backpack getVariable 'link';
//setVar(_vback,weight,70);

//снаряга васи
["CaveAxe",_mob,INV_HAND_L] call createItemInInventory;

for "_i" from 1 to 5 do {
	zv = [selectRandom ["Zvak","Bryak"],_backpack getVariable 'link'] call createItemInContainer;
};

_backp = ["SmallBackpack",_playerObject,INV_BACKPACK] call createItemInInventory;
for "_i" from 1 to 5 do {
	[selectRandom ["Zvak","Bryak"],_backp] call createItemInContainer;
};


for "_i" from 1 to 1000 do {
	#define randDist_chunk 65
	#define rd rand(-randDist_chunk,randDist_chunk)
	[selectRandom ["Zvak","Bryak"],getPosATL player vectorAdd [rd,rd,0],null,false] call createItemInWorld;
};

memcloth = _virtCloth;
memplay = _vMob;
warningformat("Sizeof %2 %1 bytes",_virtCloth call oop_getobjsize arg callFunc(_virtCloth,getClassName));
warningformat("Sizeof mob %1 bytes",_vMob call oop_getobjsize);
#include "Debug.sqf"

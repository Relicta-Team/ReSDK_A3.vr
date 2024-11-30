clientMob = player;

if (!isMultiplayer) exitWith {};

if ((count units group clientMob) > 1) then {[clientMob] joinSilent grpnull;};

showHUD [false,false,false,false,false,false,false,false];
titleCut ["","BLACK", 0.001];
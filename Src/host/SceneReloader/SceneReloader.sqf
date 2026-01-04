// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

if (isMultiplayer) exitWith {};

clientMob = player;

_nearObjs = nearestObjects [player, [], 10000] - allunits;
{
	deleteVehicle _x;
} foreach (_nearObjs);

// removing agents
{
	if (count allVariables _x > 0) then {deleteVehicle _x};
} foreach ((entities [[],[]])- [player,vasya]);

{
	removeUniform _x;
	removeVest _x;
	removeBackpack _x;
	_x removeAllEventHandlers "AnimDone";
	_x removeAllEventHandlers "AnimChanged";
	_x removeAllEventHandlers "AnimStateChanged";
	_x removeAllEventHandlers "HandleDamage";
	
	if (!isPlayer _x) then {
		_x playActionNow  "narnalnlrnll_0000";
		_unit = _x;
		{
			_unit setVariable [_x,nil];
		} foreach (allVariables _unit);
		_x switchMove 'amovppnemstpsnonwnondnon';
		_x setPosAtl [1935.4,2216.2,5.36289];
	};
	_x setUnitPos "UP"; //осторожно поднимаем на ноги
	
} foreach allUnits;

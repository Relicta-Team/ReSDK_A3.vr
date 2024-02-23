// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



{
	_mob = _x;

	if ((_mob getVariable ["__smd_lastUpdate",0]) != (_mob getvariable ["__smd_local_lastUpdate",0])) then {
		_mob setVariable ["__smd_local_lastUpdate",_mob getVariable "__smd_lastUpdate"];
		//do sync update
		{
			if !isNull(_mob getvariable (_x select 0)) then {
				[_mob,_x select 0] call smd_syncVar;
			};
		} foreach smd_list_variables;
	};
	
	//regular check
	{

		_var = _x select 0;
		if !isNull(_mob getvariable _var) then {
			_fnc = _x select 1;
			if not_equals(_mob getvariable _var,_mob getvariable [(smd_local_prefix + _var) arg 0]) then {
				[_mob,_var,_fnc] call smd_onUpdateSetting;
			};
		};

	} foreach smd_list_variables;
	
	//update NGO in grabbed state
	if (_mob getVariable ["__loc_smd_isgrb",false]) then {
		_p = _mob getVariable "__loc_smd_grb_pool";
		if (_mob distance player < 10) then {
			if (count _p == 0) then {
				for "_i" from 1 to 5 do {
					_p pushBack ([_mob,null,true] call NGOExt_create);
				};
			};
			
			{
				_c = _p select _forEachIndex;
				/*_c setPosATL (_mob modelToWorld (_mob selectionPosition _x));
				_c setObjectScale .05;*/
				_c attachTo [_mob,_x select 2,_x select 0,true];
				_c setObjectScale (_x select 1);
				detach _c;
			} foreach [
				["head",0.02,[-0.05,-0.1,0.1]],
				["spine3",0.03,[0,0,0]],
				["pelvis",0.03,[0,0,0]],
				["leftleg",0.02,[0,0,0]],
				["rightleg",0.02,[0,0,0]]
			];
		} else {
			{deleteVehicle _x} foreach _p;
			_mob setVariable ["__loc_smd_grb_pool",[]];
		};
	};
	

} foreach smd_allInGameMobs;

// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//"a3\structures_f_heli\civ\constructions\gastank_01_khaki_f.p3d"

regVST(VST_CLOTH_METALARMOR)
	_var = "cl_metal";
	VSTCreate {
		private _list = [];
		
		{
			_x params ["_bias","_slot","_vec","_scale"];
			_o = createSimpleObject ["a3\structures_f_heli\civ\constructions\gastank_01_khaki_f.p3d",[0,0,0],true];
			_o attachTo [src,_bias,_slot,true];
			[_o,_vec] call model_SetPitchBankYaw;
			_o setObjectScale _scale;
			_list pushBack _o;
		} foreach [
			[[0,-.07,-0.25],"neck",[0,0,180],1.2],
			[[0,0.14,-0.21],"spine3",[-20,180,0],1.1]
		];
		
		[src,_var,_list] call le_vst_regVar;
	};
	VSTDestroy {
		{deleteVehicle _x} foreach ([src,_var] call le_vst_getVar);
		[src,_var] call le_vst_remVar;
	};
endRegVST
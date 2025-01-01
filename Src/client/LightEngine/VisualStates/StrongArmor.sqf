// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//"a3\structures_f\items\vessels\waterbarrel_f.p3d"
/*

*/
regVST(VST_CLOTH_STRONGARMOR)
	private _var = "cl_strongarmor";
	VSTCreate {
		private _list = [];
		
		{
			_x params ["_bias","_slot","_vec","_scale"];
			_o = createSimpleObject ["a3\structures_f\items\vessels\waterbarrel_f.p3d",[0,0,0],true];
			_o attachTo [src,_bias,_slot,true];
			[_o,_vec] call model_SetPitchBankYaw;
			_o setObjectScale _scale;
			_list pushBack _o;
		} foreach [
			[[0,0,0.05],"spine3",[-3,0,0],0.37],
			[[0,0,0],"pelvis",[-180,0,0],0.34],
			[[0,0,-0.15],"rightupleg",[20,0,50],0.23],
			[[0,0,-0.15],"leftupleg",[20,0,-50],0.23]
		];
		
		[src,_var,_list] call le_vst_regVar;
	};
	VSTDestroy {
		{deleteVehicle _x} foreach ([src,_var] call le_vst_getVar);
		[src,_var] call le_vst_remVar;
	};
endRegVST
// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



regVST(VST_ATTACHED_OBJECTS)
	_var = "attached_objects";
	VSTCreate {
		private _list = [];
		
		{
			_x params ["_ptr","_model","_bias","_selection","_vec",["_scale",1]];
			_o = createSimpleObject [_model,[0,0,0],true];
			_o attachTo [src,_bias,_selection,true];
			[_o,_vec] call model_SetPitchBankYaw;
			_o setObjectScale _scale;
			_list pushBack _o;
		} foreach vstParams;
		
		[src,_var,_list] call le_vst_regVar;
	};
	VSTDestroy {
		{deleteVehicle _x} foreach ([src,_var] call le_vst_getVar);
		[src,_var] call le_vst_remVar;
	};
endRegVST
// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//"a3\structures_f_epb\items\vessels\barrelwater_grey_f.p3d"
//"a3\structures_f_epb\items\vessels\barrelempty_grey_f.p3d"
/*
obj1 attachTo [player,[0.005,.01,-0.06],"spine3",true];


[obj1,[4,0,0]]call model_SetPitchBankYaw;
obj1 setObjectScale 0.69;

*/
regVST(VST_CLOTH_CERAMIC)
	_var = "cloth_ceramic";
	VSTCreate {
		private _obj = createSimpleObject ["a3\structures_f_epb\items\vessels\barrelempty_grey_f.p3d",[0,0,0],true];
		_obj attachTo [src,[0.005,.01,-0.06],"spine3",true];
		[_obj,[4,0,0]] call model_SetPitchBankYaw;
		_obj setObjectScale 0.69;
		[src,_var,_obj] call le_vst_regVar;
	};
	VSTDestroy {
		deleteVehicle ([src,_var] call le_vst_getVar);
		[src,_var] call le_vst_remVar;
	};
endRegVST
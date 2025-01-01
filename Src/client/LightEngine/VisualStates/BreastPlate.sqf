// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
obj1 attachTo [player,[0.03,.19,-0.4],"spine3",true];
obj2 attachTo [player,[-0.14,0.01,0.15],"spine3",true];
obj3 attachTo [player,[0.18,0.06,-0.28],"spine3",true];

[obj1,[10,0,0]]call model_SetPitchBankYaw;
[obj2,[-5,-180,-70]]call model_SetPitchBankYaw;
[obj3,[5,0,55]]call model_SetPitchBankYaw;
obj1 setObjectScale 0.26;
obj2 setObjectScale 0.20;
obj3 setObjectScale 0.20;

//other
obj1 attachTo [player,[0.0,.12,-0.10],"spine3",true];
[obj1,[90,0,0]]call model_SetPitchBankYaw;
obj1 setObjectScale 0.29;



*/
regVST(VST_CLOTH_BREASTPLATE)
	_listModels = "cloth_bp_listparts";
	VSTCreate {
		_createobj = {
			createSimpleObject [
				["ml_exodusnew\bsg_eft\dverbun.p3d","ml\ml_object_new\model_05\kazan.p3d"] select _this,
			[0,0,0],true];
		};
		private _list = [];
		[src,_listModels,_list] call le_vst_regVar;
		{
			_x params ["_t","_bias","_vec","_scale"];
			_o = _t call _createobj;
			_list pushBack _o;
			_o attachTo [src,_bias,"spine3",true];
			[_o,_vec] call model_SetPitchBankYaw;
			_o setObjectScale _scale;
		} foreach [
			[0,[0.03,.19,-0.4],[10,0,0],0.26],
			[0,[-0.14,0.01,0.15],[-5,-180,-70],0.20],
			[0,[0.18,0.06,-0.28],[5,0,55],0.20],
			[1,[0.0,.12,-0.10],[90,0,0],0.29]
		];
	};
	VSTDestroy {
		{deleteVehicle _x} foreach ([src,_listModels] call le_vst_getVar);
		[src,_listModels] call le_vst_remVar;
	};
endRegVST
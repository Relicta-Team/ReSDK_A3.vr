// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

namespace(VisualState.Configs,vst_)

struct(VSTBreastPlate) base(VSTBase)
	decl(override) def(name) "VST_CLOTH_BREASTPLATE";
	decl(mesh[]) def(_listModels) [];

	decl(override) def(onCreated)
	{
		params ["_ctx"];
		private _createObj = {
			createSimpleObject [
				["ml_exodusnew\bsg_eft\dverbun.p3d","ml\ml_object_new\model_05\kazan.p3d"] select _this,
			[0,0,0],true];
		};

		private _list = [];
		self setv(_listModels,_list);

		{
			_x params ["_t","_bias","_vec","_scale"];
			private _o = _t call _createobj;
			_list pushBack _o;
			_o attachTo [self getv(_src),_bias,"spine3",true];
			[_o,_vec] call model_SetPitchBankYaw;
			_o setObjectScale _scale;
		} foreach [
			[0,[0.03,.19,-0.4],[10,0,0],0.26],
			[0,[-0.14,0.01,0.15],[-5,-180,-70],0.20],
			[0,[0.18,0.06,-0.28],[5,0,55],0.20],
			[1,[0.0,.12,-0.10],[90,0,0],0.29]
		];
	};

	decl(override) def(onDestroy)
	{
		params ["_ctx"];
		{deleteVehicle _x} foreach (self getv(_listModels));
	}
endstruct
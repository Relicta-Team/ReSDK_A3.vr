// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

namespace(VisualState.Configs,vst_)

struct(VSTMetalArmor) base(VSTBase)

	decl(override) def(name) "VST_CLOTH_METALARMOR";

	decl(mesh[]) def(_meshList) [];

	decl(override) def(onCreated)
	{
		params ["_ctx"];
		
		private _list = [];
		
		{
			_x params ["_bias","_slot","_vec","_scale"];
			_o = createSimpleObject ["a3\structures_f_heli\civ\constructions\gastank_01_khaki_f.p3d",[0,0,0],true];
			_o attachTo [self getv(_src),_bias,_slot,true];
			[_o,_vec] call model_SetPitchBankYaw;
			_o setObjectScale _scale;
			_list pushBack _o;
		} foreach [
			[[0,-.07,-0.25],"neck",[0,0,180],1.2],
			[[0,0.14,-0.21],"spine3",[-20,180,0],1.1]
		];

		self setv(_meshList,_list);
	}

	decl(override) def(onDestroy)
	{
		params ["_ctx"];
		{deleteVehicle _x} foreach (self getv(_meshList));
		self setv(_meshList,[]);
	}

endstruct
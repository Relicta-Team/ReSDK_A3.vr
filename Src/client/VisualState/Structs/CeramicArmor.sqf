// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

namespace(VisualState.Configs,vst_)

//2 variations
//"a3\structures_f_epb\items\vessels\barrelwater_grey_f.p3d"
//"a3\structures_f_epb\items\vessels\barrelempty_grey_f.p3d"

struct(VSTCeramicArmor) base(VSTBase)
	decl(override) def(name) "VST_CLOTH_CERAMIC";

	decl(mesh) def(_clothMesh) objNull;

	decl(override) def(onCreated)
	{
		params ["_ctx"];
		private _obj = createSimpleObject ["a3\structures_f_epb\items\vessels\barrelempty_grey_f.p3d",[0,0,0],true];
		_obj attachTo [self getv(_src),[0.005,.01,-0.06],"spine3",true];
		[_obj,[4,0,0]] call model_SetPitchBankYaw;
		_obj setObjectScale 0.69;
		self setv(_clothMesh,_obj);
	}

	decl(override) def(onDestroy)
	{
		deleteVehicle (self getv(_clothMesh));
	}
endstruct
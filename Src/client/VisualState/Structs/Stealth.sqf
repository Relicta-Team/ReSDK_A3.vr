// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

namespace(VisualState.Configs,vst_)

decl(bool)
vst_human_stealth_allowStepsounds = true;

struct(VSTStealth) base(VSTBase)
	decl(override) def(name) "VST_HUMAN_STEALTH";

	decl(override) def(onCreated)
	{
		params ["_ctx"];
		if equals(self callv(getLocalPlayer),self getv(_src)) then {
			hud_stealth = 1;
			vst_human_stealth_allowStepsounds = false;    
		} else {
			(self getv(_src)) hideObject true;
			[self getv(_src),false] call smd_setSlotDataProcessor;

			self callp(setHideProxyMeshes,true);
		};
	}

	decl(override) def(onDestroy)
	{
		params ["_ctx"];
		if equals(self callv(getLocalPlayer),self getv(_src)) then {
			hud_stealth = 0;
			vst_human_stealth_allowStepsounds = true;
		} else {
			(self getv(_src)) hideObject false;
			[self getv(_src),true] call smd_setSlotDataProcessor;
			
			self callp(setHideProxyMeshes,false);
		};
	}

	decl(void(bool)) def(setHideProxyMeshes)
	{
		params ["_mode"];
		private _eaterVst = [self getv(_src),"VST_EATER_NIGHTVISION"] call vst_getSourceHandler;
		if !isNullVar(_eaterVst) then {
			(_eaterVst getv(_headMesh)) hideObject _mode;  
		};
		private _attVst = [self getv(_src),"VST_ATTACHED_OBJECTS"] call vst_getSourceHandler;
		if !isNullVar(_attVst) then {
			{
				_x hideObject _mode;
			} foreach (_attVst getv(_objList));
		}
	}

endstruct
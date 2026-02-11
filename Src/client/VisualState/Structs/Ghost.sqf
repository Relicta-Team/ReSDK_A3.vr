// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

namespace(VisualState.Configs,vst_)

decl(bool)
vst_ghost_lockSyncStateGlobal = false;

struct(VSTGhost) base(VSTBase)
	decl(override) def(name) "VST_GHOST_EFFECT";

	decl(mesh) def(_dummyMesh) objNull;

	decl(override) def(onCreated)
	{
		params ["_ctx"];
		if equals(self callv(getLocalPlayer),self getv(_src)) then {
			private _dummy = [] call vst_createDummyMesh;
			self setv(_dummyMesh,_dummy);
			_dummy attachTo [self getv(_src),[0,0,0],"head",true];

			(self getv(_src)) call cd_fw_syncForceWalk;
			//для самого себя клиент виден
			//звуки шагов вырубаем
			vst_human_stealth_allowStepsounds = false;
		} else {
			//нужно скрыть моба если на нем нет флага
			private _isGhostMe = [player,self getv(name)] call vst_containsConfig;
			if (_isGhostMe) then {
				(self getv(_src)) hideObject false;
			} else {
				(self getv(_src)) hideObject true;
				[self getv(_src),false] call smd_setSlotDataProcessor;
			};
		};

		//пост синхронизация видимости гостов
		if !(vst_ghost_lockSyncStateGlobal) then {
			vst_ghost_lockSyncStateGlobal = true;
			private _otherUsers = smd_allInGameMobs - [self getv(_src)];
			{
				[_x,"onVisualStates",true] call smd_syncVar;
			} foreach _otherUsers;

			vst_ghost_lockSyncStateGlobal = false;
		};

		//пост синхронизация частей тела
		[self getv(_src),"onChangeBodyParts",true] call smd_syncVar;
	}

	decl(override) def(onDestroy)
	{
		params ["_ctx"];
		if !isNullReference(self getv(_dummyMesh)) then {
			deleteVehicle (self getv(_dummyMesh));
			self setv(_dummyMesh,objNull);

			vst_human_stealth_allowStepsounds = true; //возвращаем звуки шагов
		};
		(self getv(_src)) hideObject false;
		[self getv(_src),true] call smd_setSlotDataProcessor;
	}
endstruct
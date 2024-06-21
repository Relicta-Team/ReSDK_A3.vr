// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


class(GasBase)
	var(volume,0);
	getter_func(getParticleTypes,vec3(SLIGHT_ATMOS_SMOKE_1,SLIGHT_ATMOS_SMOKE_2,SLIGHT_ATMOS_SMOKE_3));
	func(getParticleBySize)
	{
		objParams();
		round (linearConversion [1,10,getSelf(volume),0,2,true])
	};

	func(adjustVolume)
	{
		objParams_1(_vol);
		modSelf(volume, + _vol);
	};

	func(onMixing)
	{
		objParams_1(_to);
	};

	func(onBreathing)
	{
		objParams_1(_mob);
		
		if callFunc(_mob,canBreath) then {
			callFuncParams(_mob,adjustToxin,+8);
			callFuncParams(_mob,adjustOxyLoss,-5);
		};
	};

	func(onSkinContact)
	{
		objParams_1(_mob);
	};

endclass
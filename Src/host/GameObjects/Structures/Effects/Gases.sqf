

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

endclass
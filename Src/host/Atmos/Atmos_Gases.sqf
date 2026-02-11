// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


struct(GasBase)
	def(volume) 0 //количество газа
	def(name) "Газ"; //название газа
	def(affectedReagent) "ReagentBase" //реагент реакции

	//типы визуала частиц
	def(particleTypes) vec3("SLIGHT_ATMOS_SMOKE_1" call lightSys_getConfigIdByName,"SLIGHT_ATMOS_SMOKE_2" call lightSys_getConfigIdByName,"SLIGHT_ATMOS_SMOKE_3" call lightSys_getConfigIdByName)

	def(getParticleBySize)
	{
		round (linearConversion [1,10,self getv(volume),0,(count (self getv(particleTypes)))-1,true])
	}

	def(getLightCfg)
	{
		(self getv(particleTypes)) select (self callv(getParticleBySize))
	}

	def(adjustVolume)
	{
		params ["_vol"];
		self setv(volume,(self getv(volume)) + _vol);
	}

	def(onMixing) { params ["_to"]; }

	def(str)
	{
		format["%1(%2)",self getv(name),self getv(volume)]
	}

	def(onBreathing)
	{
		params ["_mob"];
		
		if callFunc(_mob,canBreath) then {
			callFuncParams(_mob,adjustToxin,+8);
			callFuncParams(_mob,adjustOxyLoss,-5);
		};
	}

	def(onSkinContact)
	{
		params ["_mob"];
	}

endstruct

// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("EffectClass" arg "type:particle")
class(EffectAsStruct) extends(ILightibleStruct)
	var(name,"Окружение");
	//У частиц нельзя поменять модель
	editor_attribute("InternalImpl")
	var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
	editor_attribute("InternalImpl")
	var(light,-1);
	editor_attribute("InternalImpl")
	var(lightIsEnabled,false);
	var(hasInitEffect,false);

	editor_attribute("alias" arg "Effect type")
	editor_attribute("EditorVisible" arg "custom_provider:effect_configs" arg "possible_values:dust_pieces_10m|dust_clouds_10m|govnelin")
	var(__effInit,"");

	func(getEffectEnum)
	{
		objParams_1(_ef);

		private _efstr = ["dust_pieces_10m","dust_clouds_10m","govnelin","rotten_human"];
		private _efenm = ["SLIGHT_EFF_DUST_PARTICLES" call lightSys_getConfigIdByName,"SLIGHT_EFF_DUST_CLOUDS" call lightSys_getConfigIdByName,"SLIGHT_EFF_DUST_GREEN" call lightSys_getConfigIdByName,"SLIGHT_EFF_DUST_ROTTEN_HUMAN" call lightSys_getConfigIdByName];

		private _idx = _efstr find _ef;
		if (_idx == -1) exitWith {
			warningformat("EffectAsStruct::getEffectEnum() - cant find effect <%1> in string list. Return by default EFF_DUST_PARTICLES",_ef);
			"SLIGHT_EFF_DUST_PARTICLES" call lightSys_getConfigIdByName //some random enum effect
		};

		_efenm select _idx
	};

	func(setEffectType)
	{
		objParams_1(_effectConfig);

		if (getSelf(hasInitEffect)) exitWith {
			warningformat("EffectAsStruct::setEffectType() - effect already inited in object %1",getSelf(pointer));
		};

		setSelf(hasInitEffect,true);

		setSelf(light,callSelfParams(getEffectEnum,tolower _effectConfig));
		callSelfParams(lightSetMode,true);
	};

endclass

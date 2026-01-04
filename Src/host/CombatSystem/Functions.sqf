// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define tzndef(name,a,b,c) [name,[a,b,c]]
gurps_internal_tzn = hashMapNewArgs [ //reference type
	tzndef(TARGET_ZONE_TORSO,"грудь","груди","грудь"),
	tzndef(TARGET_ZONE_ABDOMEN,"живот","животу","живот"),
	tzndef(TARGET_ZONE_HEAD,"голова","голове","голову"),
	tzndef(TARGET_ZONE_EYE_L,"левый глаз","левому глазу","левый глаз"),
	tzndef(TARGET_ZONE_EYE_R,"правый глаз","правому глазу","правый глаз"),
	tzndef(TARGET_ZONE_FACE,"лицо","лицу","лицо"),
	tzndef(TARGET_ZONE_NECK,"шея","шее","шею"),
	tzndef(TARGET_ZONE_GROIN,"пах","паху","пах"),
	tzndef(TARGET_ZONE_ARM_L,"левая рука","левой руке","левую руку"),
	tzndef(TARGET_ZONE_ARM_R,"правая рука","правой руке","правую руку"),
	tzndef(TARGET_ZONE_LEG_L,"левая нога","левой ноге","левую ногу"),
	tzndef(TARGET_ZONE_LEG_R,"правая нога","правой ноге","правую ногу"),
	tzndef(TARGET_ZONE_MOUTH,"рот","рту","рот"),
	tzndef(TARGET_ZONE_RANDOM,"случайное место","случайному месту","случайное место")
];

// данная функция выбирает рандомную зону для метания в зависимости от сложности броска _cat которое варьируется от 1 до 3 где 3 это 100% попадание в цель
//Внимание! Входящая зона как TARGET_ZONE_RANDOM конвертится в реально рандомную часть
gurps_pickThrowingZone = {
	params ["_sel","_cat"];

	//Сохраняющая конвертация
	if (_sel == TARGET_ZONE_RANDOM) then {
		_sel = pick(TARGET_ZONE_LIST_HEAD + TARGET_ZONE_LIST_LIMBS + TARGET_ZONE_LIST_TORSO);
	};

	if (_cat >= 3) exitWith {_sel};
	if (_cat == 2) exitWith {
		private _check = [];
		_check = TARGET_ZONE_LIST_HEAD;
		if (_sel in _check) exitWith {pick _check};
		_check = [TARGET_ZONE_ARM_R,TARGET_ZONE_ARM_L,TARGET_ZONE_TORSO,TARGET_ZONE_ABDOMEN,TARGET_ZONE_GROIN];
		if (_sel in _check) exitWith {pick _check};
		_check = [TARGET_ZONE_LEG_L,TARGET_ZONE_LEG_R];
		if (_sel in _check) exitWith {pick _check};
		traceformat("gurps::pickThroingZone() unk zone - %1",_sel)
		_sel
	};

	pick(TARGET_ZONE_LIST_HEAD + TARGET_ZONE_LIST_LIMBS + TARGET_ZONE_LIST_TORSO)
};

//Конвертирует таргет зону в строковое название со склонением
gurps_convertTargetZoneToString = {
	params ["_zoneIndex",["_z_n",TARGET_ZONE_NAME_MAIN]];
	gurps_internal_tzn get _zoneIndex select _z_n
};

//Тоже что и gurps_convertTargetZoneToString но вовзращает только фактические имена частей тела
gurps_convertTargetZoneToStringSafe = {
	params ["_zoneIndex",["_z_n",TARGET_ZONE_NAME_MAIN]];
	[[[_zoneIndex] call gurps_convertTargetZoneToBodyPart] call gurps_convertBodyPartToTargetZone,_z_n] call gurps_convertTargetZoneToString
};


gurps_internal_tzToSel = hashMapNewArgs [ //reference type
		vec2(TARGET_ZONE_TORSO,"spine3"),
		vec2(TARGET_ZONE_ABDOMEN,"pelvis"),
		vec2(TARGET_ZONE_HEAD,"head"),
		vec2(TARGET_ZONE_EYE_L,"head"),
		vec2(TARGET_ZONE_EYE_R,"head"),
		vec2(TARGET_ZONE_FACE,"head"),
		vec2(TARGET_ZONE_NECK,"neck"),
		vec2(TARGET_ZONE_GROIN,"pelvis"),
		vec2(TARGET_ZONE_ARM_L,"leftforearm"),
		vec2(TARGET_ZONE_ARM_R,"rightforearm"),
		vec2(TARGET_ZONE_LEG_L,"leftleg"),
		vec2(TARGET_ZONE_LEG_R,"rightleg"),
		vec2(TARGET_ZONE_MOUTH,"head"),
		vec2(TARGET_ZONE_RANDOM,"spine3")
	];

//таргетзону в селекшон на мобе
gurps_convertTargetZoneToArmaSelection = {
	params ["_zone"];
	gurps_internal_tzToSel getOrDefault [_zone,"spine3"];
};

//применяет к дамагу модификатор после прохождения через DR
gurps_applyDamageType = {
	params ["_dam","_type"];
	if (_type == DAMAGE_TYPE_PIERCING_SM) exitWith {floor(_dam * 0.5)};
	if (_type in [DAMAGE_TYPE_CUTTING,DAMAGE_TYPE_PIERCING_LA]) exitWith {floor(_dam * 1.5)};
	if (_type in [DAMAGE_TYPE_PIERCING_HU,DAMAGE_TYPE_IMPALING]) exitWith {floor(_dam * 2)};
	_dam
};

//конвертирует тип повреждений в тип раны
gurps_convertDamageToWound = {
	params ["_type"];
	if (_type == DAMAGE_TYPE_CRUSHING) exitWith {WOUND_TYPE_BRUISE};
	if (_type in [DAMAGE_TYPE_BURN]) exitWith {WOUND_TYPE_BURN};
	WOUND_TYPE_BLEEDING
};

//Конвертирует таргет зону в боди парт нумератор
gurps_convertTargetZoneToBodyPart = {
	params ["_zone"];
	if (_zone in [TARGET_ZONE_HEAD,TARGET_ZONE_FACE,TARGET_ZONE_EYE_R,TARGET_ZONE_EYE_L,TARGET_ZONE_MOUTH,TARGET_ZONE_NECK]) exitWith {
		BP_INDEX_HEAD
	};
	if (_zone == TARGET_ZONE_ARM_R) exitWith {BP_INDEX_ARM_R};
	if (_zone == TARGET_ZONE_ARM_L) exitWith {BP_INDEX_ARM_L};
	if (_zone == TARGET_ZONE_LEG_R) exitWith {BP_INDEX_LEG_R};
	if (_zone == TARGET_ZONE_LEG_L) exitWith {BP_INDEX_LEG_L};
	if (_zone in [TARGET_ZONE_ABDOMEN,TARGET_ZONE_TORSO,TARGET_ZONE_GROIN]) exitWith {
		//errorformat("illegal zone - %1. Returned by default - BP_INDEX_HEAD",_zone);
		BP_INDEX_TORSO
	};
	errorformat("Cant find body part zone: %1. Returned by default - BP_INDEX_TORSO",_zone);
	BP_INDEX_TORSO
};

//Обратная конвертация из бодипарта в таргет зону
gurps_convertBodyPartToTargetZone = {
	params ["_zone"];

	if (_zone == BP_INDEX_HEAD) exitWith {TARGET_ZONE_HEAD};
	if (_zone == BP_INDEX_ARM_R) exitWith {TARGET_ZONE_ARM_R};
	if (_zone == BP_INDEX_ARM_L) exitWith {TARGET_ZONE_ARM_L};
	if (_zone == BP_INDEX_LEG_R) exitWith {TARGET_ZONE_LEG_R};
	if (_zone == BP_INDEX_LEG_L) exitWith {TARGET_ZONE_LEG_L};
	if (_zone == BP_INDEX_TORSO) exitWith {TARGET_ZONE_TORSO};
	errorformat("Cant find target zone by body part: %1",_zone);
	TARGET_ZONE_TORSO
};

gurps_convertTargetZoneToSlot = {
	params ["_zone",["_dir",DIR_FRONT]];
	if (_zone == TARGET_ZONE_RANDOM) then {
		_zone = pick (TARGET_ZONE_LIST_HEAD+TARGET_ZONE_LIST_LIMBS+TARGET_ZONE_LIST_TORSO);
	};
	if (_zone == TARGET_ZONE_TORSO) exitWith {
		if (_dir == DIR_FRONT) exitWith {INV_ARMOR};
		if (_dir == DIR_BACK) exitWith {INV_BACKPACK};
		INV_BACK
	};
	if (_zone in [TARGET_ZONE_FACE,TARGET_ZONE_MOUTH]) exitWith {
		if (_dir != DIR_FRONT) exitWith {INV_HEAD};
		INV_FACE
	};
	if (_zone == TARGET_ZONE_HEAD) exitWith {INV_HEAD};
	if (_zone in [TARGET_ZONE_GROIN,TARGET_ZONE_LEG_R,TARGET_ZONE_LEG_L]) exitWith {INV_BELT};
	if (_zone == TARGET_ZONE_ABDOMEN) exitWith {INV_CLOTH};
	if (_zone == TARGET_ZONE_ARM_R) exitWith {INV_HAND_R};
	if (_zone == TARGET_ZONE_ARM_L) exitWith {INV_HAND_L};
	INV_CLOTH
};

gurps_convertSlotToBodyPart = {
	params ["_slot"];
	if (_slot in [INV_FACE,INV_HEAD]) exitWith {BP_INDEX_HEAD};
	if (_slot in [INV_ARMOR,INV_BELT,INV_CLOTH,INV_BACK,INV_BACKPACK]) exitWith {BP_INDEX_TORSO};
	if equals(_slot,INV_HAND_R) exitWith {BP_INDEX_ARM_R};
	if equals(_slot,INV_HAND_L) exitWith {BP_INDEX_ARM_L};
	errorformat("gurps::convertSlotTOBodyPart() - Unknown slot type (%1). Returned by default BP_INDEX_TORSO",_slot);
	BP_INDEX_TORSO
};

gurps_convertHitZoneToDefZone = {
	params ["_hitZone"];
	if (_hitZone == TARGET_ZONE_RANDOM) exitWith {
		warning("gurps::convertHitZoneToDefZone() - random zone is unavailable. Return UPPER_TORSO by default");
		UPPER_TORSO
	};

	call {
		#define hitRet(val,ret) if (_hitZone == val) exitWith {ret}
		#define hitMultiRet(vals,ret) if (_hitZone in [vals]) exitWith {ret}

		hitRet(TARGET_ZONE_HEAD,HEAD);
		hitMultiRet(TARGET_ZONE_FACE arg TARGET_ZONE_MOUTH,FACE);
		hitMultiRet(TARGET_ZONE_EYE_L arg TARGET_ZONE_EYE_R,EYES);
		hitRet(TARGET_ZONE_NECK,NECK);
		hitRet(TARGET_ZONE_TORSO,UPPER_TORSO);
		hitRet(TARGET_ZONE_ABDOMEN,LOWER_TORSO);
		hitRet(TARGET_ZONE_GROIN,GROIN);
		hitRet(TARGET_ZONE_ARM_L,ARM_LEFT);
		hitRet(TARGET_ZONE_ARM_R,ARM_RIGHT);
		hitRet(TARGET_ZONE_LEG_L,LEG_LEFT);
		hitRet(TARGET_ZONE_LEG_R,LEG_RIGHT);

		errorformat("gurps::convertHitZoneToDefZone() - cant find target zone enum %1. Returns by default UPPER_TORSO",_hitZone);
		UPPER_TORSO
	}
};

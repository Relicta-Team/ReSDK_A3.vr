// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//reset volume
[1] call music_setVolume;

_cfg = 
#ifndef USE_LOCAL_PATHES
configFile
#else
missionConfigFile
#endif
;

{
	_count = getNumber(_cfg >> "cfgMusic" >> (_x + "_count"));
	if (_count == 0) then {
		errorformat("Music manager - non-existent category '%1' or zero count",_x);
	} else {
		private _durations = [];
		for "_i" from 1 to _count do {
			
			music_durations set [
				tolower (_x + "_" + str _i),
				getNumber(_cfg >> "cfgMusic" >> (_x + "_" + str _i) >> "duration")
			]
		};
		music_categories set [_x,
			[_count] call music_internal_createStruct
		];
	};	
} foreach keys music_categories;
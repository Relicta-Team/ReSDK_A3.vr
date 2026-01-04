// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


external_api function(vcom_emit_lowlevel_getCfgData)
{
	scopeName "root";
	params[
		["_cfg", configFile,  [configNull]],
		["_class", "", [""]],
		["_forceled", false, [false]],
		["_value", ""],
		["_sect", "HNEG_emed"]
	];

	if (count _class == 0) exitWith {
		_cfg call BIS_fnc_getCfgData
	};

	_value = (_cfg >> _class) call BIS_fnc_getCfgData;
	/*switch (true) do {
		case (["ped_selected", false] call HNEG_fnc_getVar): {_sect = "HNEG_ped_"};
		case (["led_selected", false] call HNEG_fnc_getVar): {_sect = "HNEG_led_"};
	};*/

	// if value is nil, replace with custom config value
	if (isNil "_value" && {!(_class in ["attachTo", "onSurface"])}) exitWith {
		private _ret = (configFile >> "Display3DEN" >> "controls" >> "HNEG_emed" >> "controls" >> (["HNEG_ped_", _class, "_data"] joinString "") >> "defaultData") call BIS_fnc_getCfgData;
		if (isNil "_ret") then {
			_ret = (configFile >> "Display3DEN" >> "controls" >> "HNEG_emed" >> "controls" >> _class >> "defaultData") call BIS_fnc_getCfgData;
		};
		if (!isNil "_ret") then {
			_ret
		} else {
			(configFile >> "Display3DEN" >> "controls" >> "HNEG_emed" >> "controls" >> (["HNEG_led_", _class, "_data"] joinString "") >> "defaultData") call BIS_fnc_getCfgData
		};

	};

	if (_class in ["onSurface"]) exitWith {
			if (isNil "_value") then {
				_value = 0;
			};

			if (_value isEqualType "") then {//some people still seem to write configs weird and use "true" instead of bool or 0/1 = return as string => not listed in class list..
				_value;
			} else {
				[false, true] # _value;
			};
		};

	if (_class == "attachTo") then {
		if (count (ctrlText ("__ATTACHDATA" call HNEG_fnc_getVar)) == 0 || {isNil {[("__ATTACHDATA" call HNEG_fnc_getVar), "attachTo", nil] call HNEG_fnc_getVarO}}) then {
			"""" breakOut "root";
		};
		([("__ATTACHDATA" call HNEG_fnc_getVar), "attachTo"] call HNEG_fnc_getVarO) breakOut "root";
	};

	//if value is array but contains non-numeric data, return string to fail HNEG_fnc_verifyParticleParams, HNEG_fnc_verifyLightParams doesn't care
	if (_value isEqualType [] && {count _value > 0} && {(_value # 0) isEqualType ""} && {!_forceled}) exitWith {
		""
	};

	if (_value isEqualType [] && {count _value > 0} && {(_value # 0) isEqualType ""} && {_forceled}) exitWith {
		if (["colorR", "colorG", "colorB"] findIf {_x in _value} > -1) then {
			_value apply {
				if (_x in ["colorR", "colorG", "colorB"]) then {1} else {0};
			}
		} else {
			_value
		};
	};

	_value
}

//Returns the all the particle data from the given particleClass, usable with setParticleParams/random/circle/fire and dropInterval..
//[particleParams, particleRandom, particleCricle, particleFire, interval]
external_api
function(vcom_emit_lowlevel_getParticleClassParams)
{
	#define __GETDATA(__a) ([_class, __a] call vcom_emit_lowlevel_getCfgData)
	#define __GETARR(__a) if ((getArray (_class >> __a)) findIf {_x isEqualType "" && {count _x > 0}} > -1) then {\
		{getArray (_this >> __a)}\
	} else {\
		if (!(isNull(_class >> __a))) then {\
			getArray (_class >> __a)\
		} else {\
			[]\
		}\
	}

	private _fnc_getCfgData = {
		if (isNumber _this) exitWith {getNumber _this};
		if (isText _this) exitWith {getText _this};
		if (isArray _this) exitWith {getArray _this};
		null
	};

	#define __GETNR(__a) if (isNumber (_class >> __a)) then {\
		getNumber (_class >> __a)\
	} else {\
		if (!(isNull(_class >> __a))) then {\
			(_class >> __a) call _fnc_getCfgData\
		} else {\
			0\
		}\
	}

	private _class = if not_equalTypes(_this,"") then {_this} else {(configFile >> "CfgCloudlets" >> _this)};

	[
			[ /* Particle params*/
				[__GETDATA("particleShape"),
				__GETDATA("particleFSNtieth"),
				__GETDATA("particleFSIndex"),
				__GETDATA("particleFSFrameCount"),
				__GETDATA("particleFSLoop")],
				/*__GETDATA("animationName"),*/ /* obsolete..*/
				"",
				__GETDATA("particleType"),
				__GETDATA("timerPeriod"),
				__GETDATA("lifeTime"),
				if (__GETDATA("position") isEqualType []) then {
					[__GETDATA("position") # 0, __GETDATA("position") # 2, __GETDATA("position") # 1] /* position in config is [x, z, y], in scripts [x, y, z] */
				} else {
					__GETDATA("position")
				},
				if (__GETDATA("moveVelocity") isEqualType []) then {
					[__GETDATA("moveVelocity") # 0, __GETDATA("moveVelocity") # 2, __GETDATA("moveVelocity") # 1] /* position in config is [x, z, y], in scripts [x, y, z] */
				} else {
					__GETDATA("moveVelocity")
				},
				__GETDATA("rotationVelocity"),
				__GETDATA("weight"),
				__GETDATA("volume"),
				__GETDATA("rubbing"),
				__GETDATA("size"),
				__GETDATA("color"),
				__GETDATA("animationSpeed"),
				__GETDATA("randomDirectionPeriod"),
				__GETDATA("randomDirectionIntensity"),
				__GETDATA("onTimerScript"),
				__GETDATA("beforeDestroyScript"),
				/*__GETDATA("attachTo"),*/
				"",
				__GETDATA("angle"),
				false /*__GETDATA("onSurface")*/,
				-1,
				__GETARR("emissiveColor")
			],

			[/* particle random */
				__GETDATA("lifeTimeVar"),
				if (__GETDATA("positionVar") isEqualType []) then {
					[__GETDATA("positionVar") # 0, __GETDATA("positionVar") # 2, __GETDATA("positionVar") # 1] /* position in config is [x, z, y], in scripts [x, y, z] */
				} else {
					__GETDATA("positionVar")
				},
				if (__GETDATA("moveVelocityVar") isEqualType []) then {
					[__GETDATA("moveVelocityVar") # 0, __GETDATA("moveVelocityVar") # 2, __GETDATA("moveVelocityVar") # 1] /* velocity in config is [x, z, y], in scripts [x, y, z] */
				} else {
					__GETDATA("moveVelocityVar")
				},
				__GETDATA("rotationVelocityVar"),
				__GETDATA("sizeVar"),
				__GETDATA("colorVar"),
				__GETDATA("randomDirectionPeriodVar"),
				__GETDATA("randomDirectionIntensityVar"),
				__GETDATA("angleVar"),
				0 //__GETDATA("bounceOnSurfaceVar") //!Do not used
			],

			[/* Particle circle */
				__GETDATA("circleRadius"),
				if (__GETDATA("circleVelocity") isEqualType []) then {
					[__GETDATA("circleVelocity") # 0, __GETDATA("circleVelocity") # 2, __GETDATA("circleVelocity") # 1]
				} else {
					__GETDATA("circleVelocity")
				}
			],

			// [
			// 	__GETDATA("coreIntensity"),
			// 	__GETDATA("coreDistance"),
			// 	__GETDATA("damageTime")
			// ],
			"",//without native engine damage...

			__GETDATA("interval")//,
			//__GETDATA("damageType")
	]

	#undef __GETDATA
	#undef __GETARR
	#undef __GETNR
}

external_api
function(vcom_emit_lowlevel_getLightClassParams)
{
	#define __GETDATA(__a) ([_cfg, __a, _forceled] call vcom_emit_lowlevel_getCfgData)
	#define __GETDATA_IFNIL(__a, __b) (if (isNil {__GETDATA(__a)}) then {__b} else {__GETDATA(__a)})
	#define __GETATT(__a) ([_cfg >> "Attenuation", __a, _forceled] call vcom_emit_lowlevel_getCfgData)
	#define __RET(__a) _ret pushBack __a

	private _class = _this param [0, "", ["",configFile]];
	private _all = _this param [1, true, [false]]; //TODO: OBSOLETE!!
	private _forceled = _this param [2, true, [false]];
	private _getByConfig = _this param [3,false,[false]];
	private _cfg = if (_getByConfig) then {_class} else {(configFile >> "CfgLights" >> _class)};
	

	private _attenuation = [];
	private _attdata = 0;
	/*private _ret = [];

	private _stuffs = configProperties [_cfg, "true", true] apply {configName _x};
	private _hasData = _stuffs select {
		(toLower _x) in ["color", "ambient", "intensity", "useflare", "flaresize", "flaremaxdist", "daylight", "attenuation", "brightness"];
	};*/

	for "_i" from 0 to (count (_cfg >> "attenuation") - 1) do {
		_attdata = ["start", "constant", "linear", "quadratic", "hardlimitstart", "hardlimitend"] select _i;
		_attenuation pushBack __GETATT(_attdata);
	};
	//fix empty values
	if (count _attenuation!=6) then {
		_attenuation resize 6;
		_attenuation = _attenuation apply {ifcheck(isNullVar(_x),0,_x)};
	};

	if (_all) exitWith {
		[
			[
				__GETDATA("color") select 0,
				__GETDATA("color") select 1,
				__GETDATA("color") select 2
			],
			[
				__GETDATA("ambient") select 0,
				__GETDATA("ambient") select 1,
				__GETDATA("ambient") select 2
			],
			if (isNil {__GETDATA("intensity")}) then {(__GETDATA("brightness")) * 3000} else {
				//custom string check
				private _val = __GETDATA("intensity");
				ifcheck(equalTypes(_val,""),(__GETDATA("brightness")) * 3000,_val)
				},
			/*false,
			/*__GETDATA_IFNIL("useFlare", false),*/
			[false, true] select __GETDATA_IFNIL("useFlare", false),
			/*0,*/
			__GETDATA_IFNIL("flareSize", 0),
			/*0,*/
			__GETDATA_IFNIL("flareMaxDistance", 0),
			/*if ((__GETDATA("drawLight")) isEqualType 0) then {[false, true] select (__GETDATA("drawLight"))} else {false},*/
			[false, true] select __GETDATA_IFNIL("daylight", false),
			_attenuation,
			[
				__GETDATA_IFNIL("outerAngle", 0),
				__GETDATA_IFNIL("innerAngle", 0),
				__GETDATA_IFNIL("coneFadeCoef", 0)
			]
		]
	};

	#undef __GETDATA
	#undef __GETDATA_IFNIL
	#undef __GETATT
	#undef __RET

}

external_api
function(vcom_emit_lowlevel_verifyParticleParams)
{
	_array = param[0, [], [[]]];

	if (
			((_array select 0) isEqualTypeArray [[], "", "", 0, 0, [], [], 0, 0, 0, 0, [], [], [], 0, 0, "", "", "", 0, true, 0, []] || {(_array select 0) isEqualTypeArray [[], "", "", 0, 0, [], [], 0, 0, 0, 0, [], [], [], 0, 0, "", "", "", 0, true, 0]}) && /* check that particleparams matches */
			{(((_array select 1) isEqualTypeArray [0, [], [], 0, 0, [], 0, 0, 0]) || {(_array select 1) isEqualTypeArray [0, [], [], 0, 0, [], 0, 0, 0, 0]})} && /* check that particleRandom matches */
			{(_array select 2) isEqualTypeArray [0, []]} && /* check that paricleCircle matches */
			//{(_array select 3) isEqualTypeArray [0, 0, 0]} && /* check that particleFire matches */
			{(_array select 4) isEqualType 0} /* check that dopInterval is a number and not expression */
	)
	exitWith {true};

	false
}

//DEPRECATED
external_api
function(vcom_emit_lowlevel_getParticleAdressBook)
{
	[
		"particleShape", [0, 0, 0], 
		"particleFSNtieth", [0, 0, 1], 
		"particleFSIndex", [0, 0, 2], 
		"particleFSFrameCount", [0, 0, 3], 
		"particleFSLoop", [0, 0, 4], 
		"particleType", [0, 2], 
		"timerPeriod", [0, 3], 
		"lifeTime", [0, 4], 
		"position", [0, 5], 
		"moveVelocity", [0, 6], 
		"rotationVelocity", [0, 7], 
		"weight", [0, 8], 
		"volume", [0, 9], 
		"rubbing", [0, 10], 
		"size", [0, 11], 
		"color", [0, 12], 
		"animationSpeed", [0, 13], 
		"randomDirectionPeriod", [0, 14], 
		"randomDirectionIntensity", [0, 15], 
		"onTimerScript", [0, 16], 
		"beforeDestroyScript", [0, 17], 
		"attachTo", [0, 18], 
		"angle", [0, 19], 
		"onSurface", [0, 20], 
		"bounceOnSurface", [0, 21], 
		"emissiveColor",  [0, 22], 
		"lifeTimeVar", [1, 0], 
		"positionVar",  [1, 1], 
		"moveVelocityVar", [1, 2], 
		"rotationVelocityVar", [1, 3], 
		"sizeVar",  [1, 4], 
		"colorVar", [1, 5], 
		"randomDirectionPeriodVar", [1, 6], 
		"randomDirectionIntensityVar",  [1, 7], 
		"angleVar",  [1, 8], 
		"bounceOnSurfaceVar",  [1, 9], 
		"circleRadius", [2, 0], 
		"circleVelocity", [2, 1], 
		"coreIntensity", [3, 0], 
		"coreDistance", [3, 1], 
		"damageTime", [3, 2], 
		"interval",  [4], 
		"damageType", [5] 
	]
}

//DEPRECATED
external_api
function(vcom_emit_lowlevel_getLightAdressBook)
{
	//name prop, getter value 
	[ 
		["color", [0]], 
		["ambient", [1]], 
		["intensity", [2]], 
		["useflare", [3]], 
		["flaresize", [4]], 
		["flaremaxdist", [5]], 
		["daylight", [6]], 
		["attenuation", [7]], 
		["attenuationstart", [7, 0]], 
		["attenuationconstant", [7, 1]], 
		["attenuationlinear", [7, 2]], 
		["attenuationquadratic", [7, 3]], 
		["attenuationhardlimitstart", [7, 4]], 
		["attenuationhardlimitend", [7, 5]],
		["coneouterangle", [8,0]],
		["coneinnerangle", [8,1]],
		["conefadecoef", [8,2]]
	]
}

function(vcom_emit_lowlevel_createLightData)
{
	[
		[0,0,0],
		[0,0,0],
		0,
		false,
		0,
		0,
		false,
		[0,0,0,0,0,0],
		[0,0,0]
	]
}

//return all configs in typed: name, values
external_api
function(vcom_emit_lowlevel_getAllLightConfigs)
{
	private _cfgLights = "isclass (_x >> 'Attenuation')" configClasses (configFile >> "CfgLights");
	_cfgLights apply {[configName _x,[_x,null,null,true] call vcom_emit_lowlevel_getLightClassParams]};
}

external_api
function(vcom_emit_lowlevel_getAllReflectorConfigs)
{
	private _l = (configProperties [configFile >> "CfgVehicles", "configName _x != 'access' && {isclass (_x >> 'Reflectors')} && {count (_x >> 'Reflectors') > 0}", true]);
	_l2 = [];
	private _cfg = null;
	private _probVal = null;
	private _probValStr = null;
	private _uniMap = createHashMap;
	{
		{
			_cfg = str _x;
			_probVal = [_x,null,null,true] call vcom_emit_lowlevel_getLightClassParams;
			_probValStr = str _probVal;
			if (!(_probValStr in _uniMap) ) then {
				if ("<null>" in _probValStr) exitwith {};
				_uniMap set [_probValStr,0];
				_splarr = _cfg splitString "\/";
				_l2 pushBack [(_splarr select [3,count _splarr])joinString "/",_probVal];
			};
			;true
		} count ("isclass (_x>>'Attenuation') && ((getArray (_x>>'Color'))select 0) isequaltype 0" configClasses(_x >> 'Reflectors'))
	} foreach _l;
	_l2
}

function(vcom_emit_lowlevel_getAllParticlesConfigs)
{
	private _cloudlets = "\
	count (getText(_x >> 'particleShape')) > 0 && \
	{\
		(((configName _x) call vcom_emit_lowlevel_getParticleClassParams) select 0) isEqualTypeArray [\
			[], '', '', 0, 0, [], [], 0, 0, 0, 0, [], [], [], 0, 0, '', '', '', 0, true, 0, []\
		];\
	} &&\
	{\
		[((configName _x) call vcom_emit_lowlevel_getParticleClassParams)] call vcom_emit_lowlevel_verifyParticleParams;\
	}\
" configClasses (configFile >> "CfgCloudlets");

	private _bad = false;
	if (_bad) then {
		private _badCloudletsBad = "true" configClasses (configFile >> "CfgCloudlets");
		_cloudlets = _badCloudletsBad - _cloudlets
	};

	_cloudlets apply {[configName _x,_x call vcom_emit_lowlevel_getParticleClassParams]};
}

external_api
function(vcom_emit_lowlevel_getAllParticleShapeObjects)
{
	private _list = [];//vec2: shortname, fullpath
	private _modelpaths = [];
	private _str = null;

	for "_i" from 0 to ((count (configFile >> "CfgCloudlets"))-1) do {
		if (isClass ((configFile >> "CfgCloudlets") select _i) && {!( getText ((configFile >> "CfgCloudlets") select _i >> "particleShape") in _modelpaths)}) then {
			_modelpaths pushBack (getText ((configFile >> "CfgCloudlets") select _i >> "particleShape"));
		};
	};

	{
		_str = (_x splitString "\.");
		if (_str find "p3d" > -1) then {// some of the entries in the config have .p3d...
			if (count _str > 1 && {!((_str select ((_str find "p3d")-1)) in _list)}) then {
				_list pushBackUnique [(_str select ((_str find "p3d")-1)), _x];
			};
		} else {// .. and some don't. Holy inconsistencies, Batman.
			if (count _str > 1 && {!((_str select ((count _str) - 1)) in _list)}) then {
				_list pushBackUnique [(_str select ((count _str) - 1)), (_x+".p3d")];
			};
		};
	} forEach _modelpaths;

	//custom particles from non-configs???
	{
		_list pushBackUnique [_x, ["a3\animals_f\", _x, ".p3d"] joinString ""];
	} forEach ["Butterfly", "Cicada", "Dragonfly", "Firefly", "Fly", "Honeybee", "Mosquito"];

	_list
}

init_function(vcom_emit_lowlevel_initConfigs)
{
	if !isNull(vcom_emit_internal_configsLoaded) exitwith {};

	//TODO for performance cached all configs to file manually
	
	//Тут хрянятся vec2: cfgname(str),emit_data(array)
	vcom_emit_lowlevel_allLights = call vcom_emit_lowlevel_getAllLightConfigs;
	vcom_emit_lowlevel_allReflectors = call vcom_emit_lowlevel_getAllReflectorConfigs;
	vcom_emit_lowlevel_allParticles = call vcom_emit_lowlevel_getAllParticlesConfigs;
	{
		_x params ["_name","_data"];
		if (str([_data,"position",vcom_emit_prop_internal_getParticleAssoc] call vcom_emit_prop_getPropByName)!="[0,0,0]") then {
			//update default positions
			[_data,"position",[0,0,0],vcom_emit_prop_internal_getParticleAssoc] call vcom_emit_prop_setPropByName;
		};
	} foreach vcom_emit_lowlevel_allParticles;
	
	//use RscCombo for visualize this, rsccombo contains logic of basic listbox
	vcom_emit_lowlevel_allParticleShapes = call vcom_emit_lowlevel_getAllParticleShapeObjects;

	vcom_emit_internal_configsLoaded = true;
}

function(vcom_emit_lowlevel_getSpriteTexture)
{
	// [[*.p3ds], "texture"] * n
#define __P_ADDRESS [\
	[\
		[\
			"\a3\data_f\particleeffects\cl_basic.p3d"\
		],\
		"a3\data_f\basic.06.paa"\
	],\
	[\
		[\
			"a3\data_f\particleeffects\universal\explosion_4x4.p3d"\
		],\
		"a3\data_f\particleeffects\universal\data\explosion_4x4_ca.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\universal\universal.p3d",\
			"\a3\data_f\particleeffects\universal\universalonsurface.p3d",\
			"\a3\data_f\particleeffects\universal\woodparts_01.p3d",\
			"\a3\data_f\particleeffects\universal\woodparts_02.p3d",\
			"\a3\data_f\particleeffects\universal\woodparts_03.p3d",\
			"\a3\data_f\particleeffects\universal\woodparts_04.p3d"\
		],\
		"a3\data_f\particleeffects\universal\data\universal_ca.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\universal\universal_02.p3d",\
			"\a3\data_f\particleeffects\universal\meat_ca.p3d"\
		],\
		"a3\data_f\particleeffects\universal\data\universal_02_ca.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\universal\smoke.p3d"\
		],\
		"a3\data_f\particleeffects\universal\data\smoke.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\universal\stonesmall.p3d",\
			"\a3\data_f\particleeffects\universal\wheeleffect.p3d",\
			"\a3\data_f\particleeffects\universal\mud.p3d",\
			"\a3\data_f\particleeffects\universal\grass_volume.p3d",\
			"\a3\data_f\particleeffects\universal\grassmesh.p3d"\
		],\
		"a3\data_f\particleeffects\universal\data\wheel_effect_ca.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\pstone\pstone.p3d"\
		],\
		"a3\data_f\particleeffects\pstone\data\pstone_co.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\shard\shard.p3d"\
		],\
		"a3\data_f\particleeffects\shard\data\shard_co.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\shard\shard2.p3d",\
			"\a3\data_f\particleeffects\shard\shard3.p3d",\
			"\a3\data_f\particleeffects\shard\shard4.p3d"\
		],\
		"a3\data_f\particleeffects\shard\data\shard2_co.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\wallpart\wallpart.p3d"\
		],\
		"a3\data_f\particleeffects\wallpart\data\wallpart_co.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\wallpart\wallpart2.p3d"\
		],\
		"a3\data_f\particleeffects\wallpart\data\wallpart2_co.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\universal\ammobelt_links.p3d"\
		],\
		"#(argb,8,8,3)color(0,0,0,1.0,co)"\
	],\
	[\
		[\
			"\a3\weapons_f\ammo\cartridge_762.p3d"\
		],\
		"a3\weapons_f\data\5_56_co.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\universal\refract.p3d"\
		],\
		"a3\data_f\particleeffects\universal\data\refract_ca.paa"\
	],\
	[\
		[\
			"\a3\data_f\cl_fire.p3d"\
		],\
		"a3\data_f\cl_fire_anim.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\universal\underwatersmoke.p3d"\
		],\
		"a3\data_f\particleeffects\universal\data\underwater_smoke_ca.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\universal\sparksball.p3d"\
		],\
		"a3\data_f\proxies\muzzle_flash\data\muzzleflash_rifle_set01_front_ca.paa"\
	],\
	[\
		[\
			"\a3\plants_f\_leafs\leaf_damage_small_green.p3d",\
			"\a3\plants_f\_leafs\leaf_damage_big_green.p3d",\
			"\a3\plants_f\_leafs\leaf_damage_biglong_green_01.p3d"\
		],\
		"a3\plants_f\_leafs\data\leafs_damage_ca.paa"\
	],\
	[\
		[\
			"\a3\plants_f\_leafs\leaf_neriumoleander_d.p3d",\
			"\a3\plants_f\_leafs\leaf_pines.p3d"\
		],\
		"a3\plants_f\_leafs\data\leafs_ca.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\hit_leaves\sticks.p3d",\
			"\a3\data_f\particleeffects\hit_leaves\sticks_green.p3d"\
		],\
		"a3\data_f\particleeffects\hit_leaves\data\t_betula1f_1_ca.paa"\
	],\
	[\
		[\
			"\a3\data_f\particleeffects\universal\glassparts_00.p3d",\
			"\a3\data_f\particleeffects\universal\glassparts_01.p3d",\
			"\a3\data_f\particleeffects\universal\glassparts_02.p3d",\
			"\a3\data_f\particleeffects\universal\glassparts_03.p3d",\
			"\a3\data_f\particleeffects\universal\glassparts_04.p3d",\
			"\a3\data_f\particleeffects\universal\glassparts_05.p3d",\
			"\a3\data_f\particleeffects\universal\glassparts_06.p3d"\
		],\
		"#(argb,8,8,3)color(0,0.0745098,0.109804,0.3,ca)"\
	],\
	[\
		[\
			"\a3\weapons_f_orange\ammo\leaflet_05_f.p3d"\
		],\
		"#(argb,8,8,3)color(0.752941,0.752941,0.752941,1.0,co)"\
	],\
	[\
		[\
			"\a3\weapons_f_orange\ammo\bombdemine_01_dummy_ground_f.p3d"\
		],\
		"a3\air_f_orange\uav_06\data\c_idap_uav_06_co.paa"\
	],\
	[\
		[\
			"a3\animals_f\butterfly.p3d"\
		],\
		"a3\animals_f\data\aglais_urticae_ca.paa"\
	],\
	[\
		[\
			"a3\animals_f\cicada.p3d",\
			"a3\animals_f\firefly.p3d"\
		],\
		"#(argb,8,8,3)color(0.2,0.2,0.2,0.5,ca)"\
	],\
	[\
		[\
			"a3\animals_f\dragonfly.p3d"\
		],\
		"a3\animals_f\data\dragonfly_ca.paa"\
	],\
	[\
		[\
			"a3\animals_f\fly.p3d"\
		],\
		"a3\animals_f\data\fly_ca.paa"\
	],\
	[\
		[\
			"a3\animals_f\honeybee.p3d"\
		],\
		"a3\animals_f\data\honeybee_ca.paa"\
	],\
	[\
		[\
			"a3\animals_f\mosquito.p3d"\
		],\
		"a3\animals_f\data\mosquito_ca.paa"\
	]\
]

	params ["_data"];
	private _constData = __P_ADDRESS;
	if (count _data > 0) exitWith {
	if (count (_constData select {(_x select 0) find (toLower _data) > -1}) > 0) then {
		(_constData select {(_x select 0) find (toLower _data) > -1}) select 0 select 1
	} else {
		""
	};
};

#undef __P_ADDRESS
}
// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//Факел
regLight(LIGHT_FIRE)

	//lightObject setLightBrightness 1.0;
	initBrightness(0.27);
	lightObject setLightColor [1,0.65,0.4];
	lightObject setLightAmbient [0.15,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));//(50 + 400 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0.28,0.05));

	_effect = "FIRE_SMALL";

	_fire	= "";
	_smoke	= "";

	switch (_effect) do {
		case "FIRE_SMALL" : {
			_fire 	= "SmallDestructionFire";
			//_smoke 	= "SmallDestructionSmoke";
		};
		case "FIRE_MEDIUM" : {
			_fire 	= "MediumDestructionFire";
			_smoke 	= "MediumDestructionSmoke";
		};
		case "FIRE_BIG" : {
			_fire 	= "BigDestructionFire";
			_smoke 	= "BigDestructionSmoke";
		};
		case "SMOKE_SMALL" : {
			_smoke 	= "SmallDestructionSmoke";
		};
		case "SMOKE_MEDIUM" : {
			_smoke 	= "MediumSmoke";
		};
		case "SMOKE_BIG" : {
			_smoke 	= "BigDestructionSmoke";
		};
	};


	_eFire = if (_fire != "") then {
		_eFire = "#particlesource" createVehicleLocal [0,0,0];
		joinEmitter(_eFire);
		//_eFire setPosAtl (getPosATL sourceObject vectorAdd [0,0,0.2]);
		_eFire setParticleClass _fire;
		_eFire setDropInterval 0.0513;

		//_eFire attachTo [lightObject,[0,0,0]];
		//linkLight(_eFire,player,vector(0,0,0));
		linkLight(_eFire,lightObject,vector(0,0,0)); //WORKED!!
		_eFire
	};

	private ["_eSmoke","_pieces","_refract"];

	if (cd_videoSettings == VIDEO_SETTINGS_MAX) then {
		_eSmoke = if (_smoke != "") then {
			_eSmoke = "#particlesource" createVehicleLocal [0,0,0];
			joinEmitter(_eSmoke);
			_eSmoke setPosAtl (getPosATL sourceObject);
			_eSmoke setParticleClass _smoke;
			//_eSmoke attachTo [sourceObject,[0,0,0]];
			_eSmoke
		} else {objNUll};

		//fire pieces
		_pieces = "#particlesource" createVehicleLocal [0,0,0];
		joinEmitter(_pieces);
		linkLight(_pieces,lightObject,vector(0,0,0));
		_pieces setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,0.5,[0,0,0],[0,0,0.01],1,1.05,0.88,0.02,[0.03,0.03,0.03,0.03,0.03,0.02,0.02,0.02,0.02,0],[[0.662477,0.553565,0.3,-6.5],[0.84679,0.587077,0.3,-6],[0.637344,0.448842,0.3,-5.5],[1,0.499109,0.3,-4.5],[0.930569,0.553565,0.3,-6.5],[0.779767,0,0,1]],[400,100],0.05,0.2,"","","",0,false,0,[[0,0,0,0]]];
		_pieces setParticleRandom [1.9,[0,0,0],[0.1,0.1,0.1],1,0.004,[0,0.15,0.15,0],1.07,0.0005,360,0];
		_pieces setParticleCircle [0,[0,0,0]];
		_pieces setDropInterval 0.13;

		_refract = "#particlesource" createVehicleLocal [0,0,0];
		_refract setParticleParams [
			["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0],"","Billboard",1,2,[0,0,0],
			[0,0,0.6],0,0.05,0.04,0.05,[0.2,
			0.5,//size
			2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],
			[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,0,[[0,0,0,0]]];
		_refract setParticleRandom [0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0];
		_refract setParticleCircle [0,[0,0,0]];
		_refract setDropInterval 0.1;
		joinEmitter(_refract);
		linkLight(_refract,lightObject,vector(0,0,0));
	};

	addEventOnDestroySource(lightObject arg _eFire arg _pieces arg _refract);

	initAsRenderer(); //init render before blinking effect

	//Blinking light
	#define __event _src = _this select 0; _lt = _src getvariable "__light"; \
		stopUpdateIfNull(_lt); \
		if (!(_src getvariable "isRndrd") || (_src getVariable "__hasprocchangelight")) exitWith {}; \
		_lt setLightColor [rand(0.7,1) , 0.65 , rand(0.4,0.5)]; \
		_lt setLightAmbient [rand(0.15,0.2),0.05,0]; \
		_lt setLightBrightness rand(0.23,0.27);

	startUpdateParams({__event},0.1,sourceObject);

	#define TORCH_SOUND_DELAY 20
	[[lightObject arg sourceObject],[lightObject,"torch_loop",10],TORCH_SOUND_DELAY] call sound3d_playOnObjectLooped;


endRegLight

//Только костры
regLight(LIGHT_CAMPFIRE)

	initBrightness(0.5);
	lightObject setLightColor [1,0.65,0.4];
	lightObject setLightAmbient [0.15,0.05,0];
	//lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0,0.05));

	_eFire = "#particlesource" createVehicleLocal [0,0,0];
	joinEmitter(_eFire);
	_eFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.7],0,0.05,0.04,0.05,[0.24,0],[[1,1,1,-100],[1,1,1,-100],[0,0,0,0]],[1],0,0,"","","",0,false,0,[[0,0,0,0]]];
	_eFire setParticleRandom [0.15,[0.01,0.01,0.15],[0.04,0.04,0.2],0,0.04,[0.1,0.1,0.1,0],0,0,1,0];
	_eFire setParticleCircle [0,[0,0,0]];
	_eFire setDropInterval 0.022;
	linkLight(_eFire,lightObject,vector(0,0,0));

	private ["_eSmoke","_pieces","_refract"];

	if (cd_videoSettings == VIDEO_SETTINGS_MAX) then {
		_eSmoke = "#particlesource" createVehicleLocal [0,0,0];
		joinEmitter(_eSmoke);
		_eSmoke setParticleClass "SmallDestructionSmoke";
		linkLight(_eSmoke,lightObject,vector(0,0,0));

		//fire pieces
		_pieces = "#particlesource" createVehicleLocal [0,0,0];
		joinEmitter(_pieces);
		_pieces setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,0.5,[0,0,0],[0,0,0.01],1,1.05,0.88,0.02,[0.03,0.03,0.03,0.03,0.03,0.02,0.02,0.02,0.02,0],[[0.662477,0.553565,0.3,-6.5],[0.84679,0.587077,0.3,-6],[0.637344,0.448842,0.3,-5.5],[1,0.499109,0.3,-4.5],[0.930569,0.553565,0.3,-6.5],[0.779767,0,0,1]],[400,100],0.05,0.2,"","","",0,false,0,[[0,0,0,0]]];
		_pieces setParticleRandom [1.9,[0,0,0],[0.1,0.1,0.1],1,0.004,[0,0.15,0.15,0],1.07,0.0005,360,0];
		_pieces setParticleCircle [0,[0,0,0]];
		_pieces setDropInterval 0.011;
		linkLight(_pieces,lightObject,vector(0,0,-0.02));


		_refract = "#particlesource" createVehicleLocal [0,0,0];
		_refract setParticleParams [
			["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0],"","Billboard",1,2,[0,0,0],
			[0,0,0.6],0,0.05,0.04,0.05,[0.2,
			0.8,//size
			2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],
			[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,0,[[0,0,0,0]]];
		_refract setParticleRandom [0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0];
		_refract setParticleCircle [0,[0,0,0]];
		_refract setDropInterval 0.1;
		joinEmitter(_refract);
		linkLight(_refract,lightObject,vector(0,0,0));

	};

	addEventOnDestroySource(lightObject arg _eFire arg _eSmoke arg _pieces arg _refract);
	
	initAsRenderer();
	
	#define __event _src = _this select 0; _lt = _src getvariable "__light"; stopUpdateIfNull(_lt); \
		if (!(_src getvariable "isRndrd") || (_src getVariable "__hasprocchangelight")) exitWith {}; \
		_lt setLightColor [rand(0.9,1) , 0.65 , rand(0.4,0.5)]; \
		_lt setLightAmbient [rand(0.15,0.17),0.05,0]; \
		_lt setLightBrightness rand(0.495,0.5);

	startUpdateParams({__event},0.1,sourceObject);

	#define CAMPFIRE_SOUND_DELAY 50
	[[lightObject arg sourceObject],[lightObject,"campfire",10],CAMPFIRE_SOUND_DELAY] call sound3d_playOnObjectLooped;

endRegLight

regLight(LIGHT_CAMPFIRE_BIG)

	lightObject setLightBrightness 4.0;
	lightObject setLightColor [1,0.65,0.4];
	lightObject setLightAmbient [0.15,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(-0.1,0,-.05));

	_eFire = "#particlesource" createVehicleLocal [0,0,0];
	joinEmitter(_eFire);
	_eFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.7],0,0.05,0.04,0.05,[0.54,0],[[1,1,1,-100],[1,1,1,-100],[0,0,0,0]],[1],0,0,"","","",0,false,0,[[0,0,0,0]]];
	_eFire setParticleRandom [0.15,[0.01,0.01,0.15],[0.04,0.04,0.2],0,0.04,[0.1,0.1,0.1,0],0,0,1,0];
	_eFire setParticleCircle [0,[0,0,0]];
	_eFire setDropInterval 0.022;
	linkLight(_eFire,lightObject,vector(0,0,0));

	private ["_eSmoke","_pieces","_refract"];

	if (cd_videoSettings == VIDEO_SETTINGS_MAX) then {
		_eSmoke = "#particlesource" createVehicleLocal [0,0,0];
		joinEmitter(_eSmoke);
		_eSmoke setParticleClass "SmallDestructionSmoke";
		linkLight(_eSmoke,lightObject,vector(0,0,0));

		//fire pieces
		_pieces = "#particlesource" createVehicleLocal [0,0,0];
		joinEmitter(_pieces);
		_pieces setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,0.5,[0,0,0],[0,0,0.01],1,1.05,0.88,0.02,[0.03,0.03,0.03,0.03,0.03,0.02,0.02,0.02,0.02,0],[[0.662477,0.553565,0.3,-6.5],[0.84679,0.587077,0.3,-6],[0.637344,0.448842,0.3,-5.5],[1,0.499109,0.3,-4.5],[0.930569,0.553565,0.3,-6.5],[0.779767,0,0,1]],[400,100],0.05,0.2,"","","",0,false,0,[[0,0,0,0]]];
		_pieces setParticleRandom [2.9,[0,0,0],[0.3,0.3,0.3],1,0.004,[0,0.15,0.15,0],1.07,0.0005,360,0];
		_pieces setParticleCircle [0,[0,0,0]];
		_pieces setDropInterval 0.011;
		linkLight(_pieces,lightObject,vector(0,0,-0.02));


		_refract = "#particlesource" createVehicleLocal [0,0,0];
		_refract setParticleParams [
			["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0],"","Billboard",1,2,[0,0,0],
			[0,0,0.6],0,0.05,0.04,0.05,[0.2,
			1.8,//size
			2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],
			[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,0,[[0,0,0,0]]];
		_refract setParticleRandom [0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0];
		_refract setParticleCircle [0,[0,0,0]];
		_refract setDropInterval 0.1;
		joinEmitter(_refract);
		linkLight(_refract,lightObject,vector(0,0,0));

	};

	addEventOnDestroySource(lightObject arg _eFire arg _eSmoke arg _pieces arg _refract);

	#define __event stopUpdateIfNull(_this select 0); \
		(_this select 0) setLightColor [rand(0.9,1) , 0.45 , rand(0.2,0.3)]; \
		(_this select 0) setLightAmbient [rand(0.15,0.17),0.05,0]; \
		(_this select 0) setLightBrightness rand(0.45,0.5);

	startUpdateParams({__event},0.1,lightObject);

	#define CAMPFIRE_SOUND_DELAY 50
	[[lightObject arg sourceObject],[lightObject,"campfire",10],CAMPFIRE_SOUND_DELAY] call sound3d_playOnObjectLooped;

endRegLight

regLight(LIGHT_SIGARETTE)
	//[false,1,10,2.51,[0.043,0.002,0],0,[0,0,0],[0,50,3,700,4,1]]
	//[false,0,10,4.34,[0.013,0.001,0],0,[0,0,0],[0,50,3,700,4,1]]
	#define light_min_brightness 2.5
	#define light_max_brightness 4.34
	lightObject setLightBrightness light_min_brightness;
	lightObject setLightColor [0.013,0.001,0];
	lightObject setLightAmbient [0.013,0.001,0];
	//lightObject setLightIntensity 10;
	lightObject setLightAttenuation [0,50,3,700,4,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0.01,0));

	//isAttachedToMob()
	if (cd_videoSettings == VIDEO_SETTINGS_MAX && isAttachedToMob() && {equals(attachedMobSlot,INV_FACE)}) then {
		private _multiplier = 1;

		private _fog = "#particleSource" createVehicleLocal [0,0,0];
		joinEmitter(_fog);
		_fog setParticleParams ["\A3\data_f\cl_basic",
		"",
		"Billboard",
		0.5,
		2,
		[0, 0, 0],
		[0, 0.1, -0.1],
		1,
		1.2,
		1,
		0.1,
		[0.1 * _multiplier, 0.2 * _multiplier, 0.1 * _multiplier],
		[[0.2 * _multiplier, 0.2 * _multiplier, 0.2 * _multiplier, 0.3 * _multiplier], [0, 0, 0, 0.01], [1, 1, 1, 0]],
		[500],
		1,
		0.04,
		"",
		"",
		""];
		_fog setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
		_fog setDropInterval 0.005;

		linkLight(_fog,lightObject,vector(0,0.01,0));

		addEventOnDestroySource(lightObject arg _fog);

		_onLighter = {
			params ['lightObject',"_fog","_onLighter","_onTransist","_isModeOn","_curValue"];
			if (isNullReference(lightObject) || isNullReference(_fog)) exitWith {};


			//4.34
			if (_isModeOn) then {
				linkLight(_fog,lightObject,vector(0,0,-10000));
				_curValue = _curValue + 0.35;
				_this set [5,_curValue];
				invokeAfterDelayParams(_onTransist,0.01,_this)
			} else {
				linkLight(_fog,lightObject,vector(0,0,0));
				_fog setDropInterval 0.015;
				_curValue = _curValue - 0.55;
				_this set [5,_curValue];
				invokeAfterDelayParams(_onTransist,0.01,_this)
			};
		};
		_onTransist = {
			params ['lightObject',"_fog","_onLighter","_onTransist","_isModeOn","_curValue"];
			if (isNullReference(lightObject) || isNullReference(_fog)) exitWith {};

			lightObject setLightBrightness _curValue;
			if (_curValue >= light_max_brightness) exitWith {
				_this set [4,false];
				linkLight(_fog,lightObject,vector(0,0,-10000));
				//_fog setDropInterval 5.005;
				invokeAfterDelayParams(_onLighter,rand(0.3,0.8),_this)
			};
			if (_curValue <= light_min_brightness) exitWith {
				_this set [4,true];
				//_fog setDropInterval 5.005;
				linkLight(_fog,lightObject,vector(0,0,-10000));
				invokeAfterDelayParams(_onLighter,rand(4,10),_this)
			};
			if _isModeOn then {
				invokeAfterDelayParams(_onLighter,rand(0.2,0.25),_this)
			} else {
				invokeAfterDelayParams(_onLighter,0.1,_this)
			};

		};

		invokeAfterDelayParams(_onLighter,rand(1,3),[lightObject arg _fog arg _onLighter arg _onTransist arg true arg light_min_brightness]);
	} else {
		addEventOnDestroySource(lightObject);
	};



endRegLight

//lampa kerosin
regLight(LIGHT_LAMP_KEROSENE)

	lightObject setLightBrightness 1.0;
	lightObject setLightColor [1,0.65,0.4];
	lightObject setLightAmbient [0.15,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0,0.05));

	addEventOnDestroySource(lightObject);

	#define __event stopUpdateIfNull(_this select 0); \
		(_this select 0) setLightColor [rand(0.65,0.68) , 0.65 , rand(0.35,0.40)]; \
		(_this select 0) setLightAmbient [rand(0.09,0.12),0.05,0]; \
		(_this select 0) setLightBrightness rand(0.29,0.3);

	startUpdateParams({__event},0.1,lightObject);

endRegLight

regLight(LIGHT_CANDLE)

	lightObject setLightBrightness 1.0;
	lightObject setLightColor [1,0.65,0.4];
	lightObject setLightAmbient [0.15,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));//(50 + 400 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0,0.07));

	private _eFire = "#particlesource" createVehicleLocal [0,0,0];
	joinEmitter(_eFire);
	//_eFire setPosAtl (getPosATL sourceObject vectorAdd [0,0,0.2]);
/*
	_eFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.06],0,0.05,0.04,0.05,[0.03,0],[[1,0.93873,0,-18.962],[1,1,0,-100],[0,0,0,0]],[0.3],0,0,"","","",0,false,0,[[0,0,0,0]]];
	_eFire setParticleRandom [0.51,[0,0,0],[0,0,0.01],0,0.04,[0.280159,0.179065,0.0358475,0],0,0,1,0];
	_eFire setParticleCircle [0,[0,0,0]];
	_eFire setDropInterval 0.012;*/
	_eFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.06],0,0.05,0.04,0.05,[0.03,0],[[1,0.93873,0,-18.962],[1,1,0,-100],[0,0,0,0]],[0.01],0,0,"","","",0,false,0,[[0,0,0,0]]];
	_eFire setParticleRandom [0.31,[0,0,0],[0,0,0.01],0,0.04,[0.280159,0.179065,0.0358475,0],0,0,1,0];
	_eFire setParticleCircle [0,[0,0,0]];
	_eFire setDropInterval 0.012;

	//_eFire attachTo [lightObject,[0,0,0]];
	//linkLight(_eFire,player,vector(0,0,0));
	linkLight(_eFire,lightObject,vector(0,0,0));

	private ["_refract"];

	if (cd_videoSettings == VIDEO_SETTINGS_MAX) then {

		_refract = "#particlesource" createVehicleLocal [0,0,0];
		_refract setParticleParams [
			["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0],"","Billboard",1,2,[0,0,0],
			[0,0,0.6],0,0.05,0.04,0.05,[0.2,
			0.1,//size
			2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],
			[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,0,[[0,0,0,0]]];
		_refract setParticleRandom [0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0];
		_refract setParticleCircle [0,[0,0,0]];
		_refract setDropInterval 0.6;
		joinEmitter(_refract);
		linkLight(_refract,lightObject,vector(0,0,0));
	};

	addEventOnDestroySource(lightObject arg _eFire arg _refract);

	//Blinking light
	#define __event stopUpdateIfNull(_this select 0); \
		(_this select 0) setLightColor [rand(0.7,1) , 0.65 , rand(0.4,0.5)]; \
		(_this select 0) setLightAmbient [rand(0.18,0.2),0.05,0]; \
		(_this select 0) setLightBrightness rand(0.08,0.09);

	startUpdateParams({__event},0.1,lightObject);

	//#define TORCH_SOUND_DELAY 20
	//[[lightObject arg sourceObject],[lightObject,"torch_loop",10],TORCH_SOUND_DELAY] call sound3d_playOnObjectLooped;
endRegLight

regLight(LIGHT_BAKE)

	initBrightness(0.5);
	lightObject setLightColor [1,0.65,0.4];
	lightObject setLightAmbient [0.15,0.05,0];
	//lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(-0.75,1,-3.75));

	_eFire = "#particlesource" createVehicleLocal [0,0,0];
	joinEmitter(_eFire);
	_eFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.7],0,0.05,0.04,0.05,[0.24,0],[[1,1,1,-100],[1,1,1,-100],[0,0,0,0]],[1],0,0,"","","",0,false,0,[[0,0,0,0]]];
	_eFire setParticleRandom [0.15,[0.01,0.01,0.15],[0.04,0.04,0.2],0,0.04,[0.1,0.1,0.1,0],0,0,1,0];
	_eFire setParticleCircle [0,[0,0,0]];
	_eFire setDropInterval 0.022;
	linkLight(_eFire,lightObject,vector(0,0,0));

	private ["_refract"];

	if (cd_videoSettings == VIDEO_SETTINGS_MAX) then {


		_refract = "#particlesource" createVehicleLocal [0,0,0];
		_refract setParticleParams [
			["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0],"","Billboard",1,2,[0,0,0],
			[0,0,0.6],0,0.05,0.04,0.05,[0.2,
			1.3,//size
			2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],
			[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,0,[[0,0,0,0]]];
		_refract setParticleRandom [0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0];
		_refract setParticleCircle [0,[0,0,0]];
		_refract setDropInterval 0.1;
		joinEmitter(_refract);
		linkLight(_refract,lightObject,vector(0,0,0));

	};

	addEventOnDestroySource(lightObject arg _eFire arg _refract);
	
	initAsRenderer();
	
	#define __event _src = _this select 0; _lt = _src getvariable "__light"; stopUpdateIfNull(_lt); \
		if (!(_src getvariable "isRndrd") || (_src getVariable "__hasprocchangelight")) exitWith {}; \
		_lt setLightColor [rand(0.9,1) , 0.65 , rand(0.4,0.5)]; \
		_lt setLightAmbient [rand(0.15,0.17),0.05,0]; \
		_lt setLightBrightness rand(0.495,0.5);

	startUpdateParams({__event},0.1,sourceObject);

	#define CAMPFIRE_SOUND_DELAY 50
	[[lightObject arg sourceObject],[lightObject,"campfire",10],CAMPFIRE_SOUND_DELAY] call sound3d_playOnObjectLooped;

endRegLight

regLight(LIGHT_BAKESTOVE)
	initBrightness(0.5);
	lightObject setLightColor [1,0.65,0.4];
	lightObject setLightAmbient [0.15,0.05,0];
	//lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0,-0.2));

	_eFire = "#particlesource" createVehicleLocal [0,0,0];
	joinEmitter(_eFire);
	_eFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.7],0,0.05,0.04,0.05,[0.24,0],[[1,1,1,-100],[1,1,1,-100],[0,0,0,0]],[1],0,0,"","","",0,false,0,[[0,0,0,0]]];
	_eFire setParticleRandom [0.15,[0.01,0.01,0.15],[0.04,0.04,0.2],0,0.04,[0.1,0.1,0.1,0],0,0,1,0];
	_eFire setParticleCircle [0,[0,0,0]];
	_eFire setDropInterval 0.022;
	linkLight(_eFire,lightObject,vector(0,0,0));

	private ["_pieces","_refract"];

	if (cd_videoSettings == VIDEO_SETTINGS_MAX) then {

		//fire pieces
		_pieces = "#particlesource" createVehicleLocal [0,0,0];
		joinEmitter(_pieces);
		_pieces setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,0.5,[0,0,0],[0,0,0.01],1,1.05,0.88,0.02,[0.03,0.03,0.03,0.03,0.03,0.02,0.02,0.02,0.02,0],[[0.662477,0.553565,0.3,-6.5],[0.84679,0.587077,0.3,-6],[0.637344,0.448842,0.3,-5.5],[1,0.499109,0.3,-4.5],[0.930569,0.553565,0.3,-6.5],[0.779767,0,0,1]],[400,100],0.05,0.2,"","","",0,false,0,[[0,0,0,0]]];
		_pieces setParticleRandom [1.9,[0,0,0],[0.1,0.1,0.1],1,0.004,[0,0.15,0.15,0],1.07,0.0005,360,0];
		_pieces setParticleCircle [0,[0,0,0]];
		_pieces setDropInterval 0.011;
		linkLight(_pieces,lightObject,vector(0,0,-0.02));


		_refract = "#particlesource" createVehicleLocal [0,0,0];
		_refract setParticleParams [
			["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0],"","Billboard",1,2,[0,0,0],
			[0,0,0.6],0,0.05,0.04,0.05,[0.2,
			1.3,//size
			2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],
			[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,0,[[0,0,0,0]]];
		_refract setParticleRandom [0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0];
		_refract setParticleCircle [0,[0,0,0]];
		_refract setDropInterval 0.1;
		joinEmitter(_refract);
		linkLight(_refract,lightObject,vector(0,0,0));

	};

	addEventOnDestroySource(lightObject arg _eFire arg _pieces arg _refract);

	initAsRenderer();

	#define __event _src = _this select 0; _lt = _src getvariable "__light"; stopUpdateIfNull(_lt); \
		if (!(_src getvariable "isRndrd") || (_src getVariable "__hasprocchangelight")) exitWith {}; \
		_lt setLightColor [rand(0.9,1) , 0.65 , rand(0.4,0.5)]; \
		_lt setLightAmbient [rand(0.15,0.17),0.05,0]; \
		_lt setLightBrightness rand(0.495,0.5);

	startUpdateParams({__event},0.1,sourceObject);

	#define CAMPFIRE_SOUND_DELAY 50
	[[lightObject arg sourceObject],[lightObject,"campfire",10],CAMPFIRE_SOUND_DELAY] call sound3d_playOnObjectLooped;
endRegLight

regLight(LIGHT_MATCH)

	lightObject setLightBrightness 1.0;
	lightObject setLightColor [1,0.65,0.4];
	lightObject setLightAmbient [0.15,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));//(50 + 400 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(-0.06,0,-0.02));

	private _eFire = "#particlesource" createVehicleLocal [0,0,0];
	joinEmitter(_eFire);
	//_eFire setPosAtl (getPosATL sourceObject vectorAdd [0,0,0.2]);
/*
	_eFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.06],0,0.05,0.04,0.05,[0.03,0],[[1,0.93873,0,-18.962],[1,1,0,-100],[0,0,0,0]],[0.3],0,0,"","","",0,false,0,[[0,0,0,0]]];
	_eFire setParticleRandom [0.51,[0,0,0],[0,0,0.01],0,0.04,[0.280159,0.179065,0.0358475,0],0,0,1,0];
	_eFire setParticleCircle [0,[0,0,0]];
	_eFire setDropInterval 0.012;*/
	_eFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.06],0,0.05,0.04,0.05,[0.03,0],[[1,0.93873,0,-18.962],[1,1,0,-100],[0,0,0,0]],[0.01],0,0,"","","",0,false,0,[[0,0,0,0]]];
	_eFire setParticleRandom [0.31,[0,0,0],[0,0,0.01],0,0.04,[0.280159,0.179065,0.0358475,0],0,0,1,0];
	_eFire setParticleCircle [0,[0,0,0]];
	_eFire setDropInterval 0.012;

	//_eFire attachTo [lightObject,[0,0,0]];
	//linkLight(_eFire,player,vector(0,0,0));
	linkLight(_eFire,lightObject,vector(0,0,0));

	private ["_refract"];

	if (cd_videoSettings == VIDEO_SETTINGS_MAX) then {

		_refract = "#particlesource" createVehicleLocal [0,0,0];
		_refract setParticleParams [
			["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0],"","Billboard",1,2,[0,0,0],
			[0,0,0.6],0,0.05,0.04,0.05,[0.2,
			0.05,//size
			2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],
			[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,0,[[0,0,0,0]]];
		_refract setParticleRandom [0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0];
		_refract setParticleCircle [0,[0,0,0]];
		_refract setDropInterval 0.6;
		joinEmitter(_refract);
		linkLight(_refract,lightObject,vector(0,0,0));
	};

	addEventOnDestroySource(lightObject arg _eFire arg _refract);

	//Blinking light
	#define __event stopUpdateIfNull(_this select 0); \
		(_this select 0) setLightColor [rand(0.7,1) , 0.65 , rand(0.4,0.5)]; \
		(_this select 0) setLightAmbient [rand(0.18,0.2),0.05,0]; \
		(_this select 0) setLightBrightness rand(0.04,0.043);

	startUpdateParams({__event},0.1,lightObject);

	//#define TORCH_SOUND_DELAY 20
	//[[lightObject arg sourceObject],[lightObject,"torch_loop",10],TORCH_SOUND_DELAY] call sound3d_playOnObjectLooped;
endRegLight


/*

//планктон (пыль) PlanktonEffect
particle_emitter_0 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,13,12,0],"","Billboard",1,5,[0,0,0],[0,0,0],0,1.275,1,0,[0.006],[[0.4,0.4,0.4,0.02],[0.4,0.4,0.4,0.6],[0.4,0.4,0.4,2],[0.4,0.4,0.4,2],[0.4,0.4,0.4,2],[0.4,0.4,0.4,2],[0.4,0.4,0.4,2],[0.4,0.4,0.4,2],[0.4,0.4,0.4,0.6],[0.4,0.4,0.4,0.02]],[1000],0.7,0.006,"","","",0,false,0,[[0,0,0,0]]];
particle_emitter_0 setParticleRandom [1,[4.5,4.5,3.5],[0.02,0.02,0.02],0,0,[0.06,0.06,0.06,0],0.3,0.0009,1,0];
particle_emitter_0 setParticleCircle [0,[0,0,0]];
particle_emitter_0 setDropInterval 0.0015;

*/

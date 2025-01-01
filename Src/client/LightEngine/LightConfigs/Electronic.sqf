// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


regLight(LIGHT_LAMP_WALL)
//[false,0,10,1.43,[0.016,0.006,0.016],0,[0.022,0.023,0.013],[0,0,0,0,0,0]]
	initBrightness(1.43);
	lightObject setLightColor [0.016,0.012,0.012];
	lightObject setLightAmbient [0.022,0.023,0.013];
	lightObject setLightAttenuation [0,0,0,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0,-1));

	addEventOnDestroySource(lightObject);
	initAsRenderer();
endRegLight

regLight(LIGHT_LAMP_CEILING)
	initBrightness(0.843);
	lightObject setLightColor [0.016,0.012,0.012];
	lightObject setLightAmbient [0.022,0.023,0.013];
	lightObject setLightAttenuation [0,0,0,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0,-1));

	addEventOnDestroySource(lightObject);
	initAsRenderer();
endRegLight

regLight(LIGHT_LAMP_CEILING_REDLIGHT)
	initBrightness(1.06);

	lightObject setLightColor [0.08,0.035,0.012];
	lightObject setLightAmbient [0.169,0.009,0.009];
	lightObject setLightAttenuation [0,0,0,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0,-1));

	addEventOnDestroySource(lightObject);
	initAsRenderer();
endRegLight

regCustomLight(LIGHT_STREETLAMP,"Land_LampShabby_F")
	//linkLight(lightObject,player,vector(0,0,0));
	//linkLight(lightObject,sourceObject,vector(0,0,0));
	//lightObject setPosAtl (getPosATL sourceObject);

	linkLight(lightObject,sourceObject,vector(0,0,0));
	if isNullReference(attachedTo sourceObject) then {
		detach lightObject;
	};

	lightObject disableCollisionWith player;

	addEventOnDestroySource(lightObject);

	//initAsRenderer();
endRegLight

regCustomLight(LIGHT_LAMP_CEILING_OLD,"lamp_tarelka")
	//linkLight(lightObject,player,vector(0,0,0));
	//linkLight(lightObject,sourceObject,vector(0,0,0));
	//lightObject setPosAtl (getPosATL sourceObject);

	linkLight(lightObject,sourceObject,vector(0,0,0));
	if isNullReference(attachedTo sourceObject) then {
		detach lightObject;
	};

	lightObject disableCollisionWith player;

	addEventOnDestroySource(lightObject);

	//initAsRenderer();
endRegLight

regCustomLight(LIGHT_LAMP_WALL_OLD,"lamp_stena")
	//linkLight(lightObject,player,vector(0,0,0));
	//linkLight(lightObject,sourceObject,vector(0,0,0));
	//lightObject setPosAtl (getPosATL sourceObject);

	linkLight(lightObject,sourceObject,vector(0,0,0));
	if isNullReference(attachedTo sourceObject) then {
		detach lightObject;
	};

	lightObject disableCollisionWith player;

	addEventOnDestroySource(lightObject);

	//initAsRenderer();
endRegLight

regCustomLight(LIGHT_FLASHLIGHT,"SAN_HeadLight_white_hi")

	_vect = vector(0,0.1,0);
	linkLight(lightObject,sourceObject,_vect);//vector(0,0,-0.065));
	if isNullReference(attachedTo sourceObject) then {
		detach lightObject;
	};

	addEventOnDestroySource(lightObject);
endRegLight


regLight(LIGHT_SIGN_BAR)

	lightObject setLightBrightness 15;
	lightObject setLightColor [0.013,0.001,0];
	lightObject setLightAmbient [0.013,0.001,0];
	//lightObject setLightIntensity 10;
	lightObject setLightAttenuation [0,50,3,700,4,1];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0,0));

	if (cd_videoSettings == VIDEO_SETTINGS_MAX) then {

		_delay = 0.7;
		_posvec = [
			[0.1,-0,0.2], //center
			[0.5,-0,0.4],//up
			[0.5,-0,0.0], //middle
			[0.25,-0,-0.15],//semiarrow
			[-0.2,-0,-0.6], //arrow
			[0,0,-100] //nopos
		];

		_code = {
			params ["_light",'_src',"_stateIndex","_delay","_method","_posvec"];
			if isNullReference(_light) exitWith {};

			linkLight(_light,_src,_posvec select _stateIndex);

			if (_stateIndex >= (count _posvec -1)) then {
				_stateIndex = -1
			} else {
				if (_stateIndex % 2 == 0) then {
					lightObject setLightColor [0.013,0.001,0];
					lightObject setLightAmbient [0.013,0.001,0];
				} else {
					lightObject setLightColor [0.001,0.013,0];
					lightObject setLightAmbient [0.001,0.013,0];
				};
			};
			_this set [2,_stateIndex + 1];

			invokeAfterDelayParams(_method,_delay,_this);
		};
		_params = [lightObject,sourceObject,0,_delay,_code,_posvec];
		invokeAfterDelayParams(_code,_delay,_params);


	};

	addEventOnDestroySource(lightObject);
endRegLight


regLight(LIGHT_SIGN_MEDICAL)
	/*
	lt attachTo [oj,[-0.1,0,0]];
	lt setLightBrightness 3;
	lt setLightColor [0,0.1,0];
	lt setLightAmbient [0,0.1,0];
	//lightObject setLightIntensity 10;
	lt setLightAttenuation [10,25,100,5000,0.01,1];
	*/

	/*
	lt attachTo [oj,[-0.1,0,0]];
lt setLightBrightness 2;
 lt setLightColor [0,0.1,0];
 lt setLightAmbient [0,0.1,0];
 //lightObject setLightIntensity 10;
 lt setLightAttenuation [1,15,50,1000.5,1.1,6.5]; //1000.5 на дистанцию влияет

	*/

	lightObject setLightBrightness 2.15;
	lightObject setLightColor [0,0.13,0.15];
	lightObject setLightAmbient [0,0.18,0];
	//lightObject setLightIntensity 10;
	lightObject setLightAttenuation [0.3,38,70,1.5,1.1,3.5];//[1,15,50,1000.5,1.1,6.5];

	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(-0.1,0,0));

	addEventOnDestroySource(lightObject);
endRegLight

// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


le_internal_shot_bullet_loadLight = {
	params ["_intensity","_timeout"];
	
	makeLight(_light);
	_light setPosAtl _pos;
	_light setLightColor [1,0.65,0.4];
	_light setLightAmbient [0.15,0.05,0];
	_light setLightIntensity (_intensity * 25 + 10 * ((1 + 1) / 2));
	_light setLightAttenuation [0,0,0,1];
	_lc = [rand(0.7,1) , 0.65 , rand(0.4,0.5)];
	_la = [rand(0.15,0.2),0.05,0];
	_light setLightColor _lc;
	_light setLightAmbient _la;
	startAsyncInvoke
		{
			params ["_timeout","_light","_startTime","_lc","_la"];
			_light setLightColor vectorLinearConversion [_startTime,_startTime + _timeout,tickTime,_lc,[0,0,0],false];
			tickTime >= (_startTime + _timeout)
		},
		{
			
		},
		[_timeout,_light,tickTime,_lc,_la]
	endAsyncInvoke
};
le_internal_shot_bullet_getFactPos = {
	params [["_addY",0]];
	if (typeof sourceObject == BASIC_MOB_TYPE) then {
		_sel = if (_side < 0) then {
			"lefthand"
		} else {
			"righthand"
		};
		sourceObject modelToWorld ((sourceObject selectionPosition _sel) vectorAdd [0,_addY,0]);
	} else {
		getPosATL sourceObject;
	};
};

regShot(SHOT_BULLET_PISTOL)
	
	shotParams params [["_side",1]];
	
	#define SHOT_BULLET_PISTOL_TIMEOUT 0.25
	
	_pos = [0.18] call le_internal_shot_bullet_getFactPos;
	[30,SHOT_BULLET_PISTOL_TIMEOUT] call le_internal_shot_bullet_loadLight;
	
	makeParticle(_shotFire);
	_shotFire setPosAtl _pos;
	_shotFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,0,1,0],"","Billboard",2,0.04,[0,0,0],[0,0,0],0,1.275,1,0,[0.25],[[0.9,0.9,0.9,0.3]],[1000],0,0,"","","",0,false,0,[[0,0,0,0]]];
	_shotFire setParticleRandom [0,[0,0,0],[0,0,0],30,0.08,[0,0,0,0],0,0,360,0];
	_shotFire setDropInterval 1.045;
	/*_shotFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,
		0.04 //lifetime
		,[0,0,0],[0,0,0],0,1,0.8,0.5,[2,0],[[1,1,1,-4],[1,1,1,-4],[1,1,1,-2],[1,1,1,0]],[1000],0.1,0.1,"","","",0,false,0,[[0,0,0,0]]];
	_shotFire setParticleRandom [0.02,[0.05,0.05,0.05],[0,0,0.0],0,0.2,[0,0,0,0],0,0,360,0];
	_shotFire setDropInterval(SHOT_BULLET_PISTOL_TIMEOUT + 0.105228);*/
	

	
	_shotFire setPosAtl _pos;
//	_shotFire2 setPosAtl _pos;
	disposeAllAfterTime(SHOT_BULLET_PISTOL_TIMEOUT);
	
endRegShot

/*
//fire eff
setParticleParams [[""\A3\data_f\ParticleEffects\Universal\Universal.p3d"",16,2,80,0],"""",""Billboard"",1,0.51,[0,0,0],[0,0,0],0,1.27,1,0.05,[0.2],[[1,1,1,-15],[1,1,1,-12]],[2],0.2,0.2,"""","""","""",0,false,0,[[0,0,0,0]]];
setParticleRandom [0,[0,0,0],[0.2,0.2,0.3],25,0.2,[0,0,0,0],0,0,1,0];
setParticleCircle [0,[0,0,0]];
setDropInterval 1.02;

	Other particle may be
 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,0,1,0],"","Billboard",2,0.04,[0,0,0],[0,0,0],0,1.275,1,0,[0.25],[[0.9,0.9,0.9,0.3]],[1000],0,0,"","","",0,false,0,[[0,0,0,0]]];
 setParticleRandom [0,[0,0,0],[0,0,0],30,0.08,[0,0,0,0],0,0,360,0];
 setParticleCircle [0,[0,0,0]];
 setDropInterval 1.045;
*/

regShot(SHOT_BULLET_SHOTGUN)
	shotParams params [["_side",1]];

	#define SHOT_BULLET_SHOTGUN_TIMEOUT 0.25

	_pos = [0.65] call le_internal_shot_bullet_getFactPos;
	[70,SHOT_BULLET_SHOTGUN_TIMEOUT] call le_internal_shot_bullet_loadLight;

	makeParticle(_shotFire);
	_shotFire setPosAtl _pos;
	_shotFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,2,80,0],"","Billboard",1,
	0.05 
	,[0,0,0],[0,0,0],0,1.27,1,0.05,[0.2],[[1,1,1,-15],[1,1,1,-12]],[2],0.2,0.2,"","","",0,false,0,[[0,0,0,0]]];
	_shotFire setParticleRandom [0,[0,0,0],[0.2,0.2,0.2],25,0.2,[0,0,0,0],0,0,1,0];
	_shotFire setDropInterval SHOT_BULLET_SHOTGUN_TIMEOUT;
	
	disposeAllAfterTime(SHOT_BULLET_SHOTGUN_TIMEOUT);
endRegShot

regShot(SHOT_BULLET_SHOTRIFLE)
	shotParams params [["_side",1]];

	#define SHOT_BULLET_RIFLE_TIMEOUT 0.25
	
	_pos = [0.75] call le_internal_shot_bullet_getFactPos;
	[140,SHOT_BULLET_RIFLE_TIMEOUT] call le_internal_shot_bullet_loadLight;
	
	makeParticle(_shotFire);
	_shotFire setPosAtl _pos;
	_shotFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,
		0.04 //lifetime
		,[0,0,0],[0,0,0],0,1,0.8,0.5,[2,0],[[1,1,1,-4],[1,1,1,-4],[1,1,1,-2],[1,1,1,0]],[1000],0.1,0.1,"","","",0,false,0,[[0,0,0,0]]];
	_shotFire setParticleRandom [0,[0,0,0],[0,0,0.0],0,0.2,[0,0,0,0],0,0,360,0];
	_shotFire setDropInterval(SHOT_BULLET_PISTOL_TIMEOUT + 0.105228);
	
	disposeAllAfterTime(SHOT_BULLET_RIFLE_TIMEOUT);
endRegShot
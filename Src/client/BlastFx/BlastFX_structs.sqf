// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

struct(BFXBase)
	decl(string) def(name) "";

	decl(string()) def(str)
	{
		format["BFX<%1>",self getv(name)]
	}

	decl(mesh) def(_src) objNull;
	
	decl(mesh[]) def(_disposable) [];

	decl(bool) def(autoDispose) true
	decl(float) def(minDisposeTime) 1
	decl(float) def(maxDisposeTime) 1

	decl(void(mesh)) def(init)
	{
		params ["_src"];
		self setv(_src,_src);
		self setv(_disposable,[]);
	}

	decl(void(any[])) def(activate)
	{
		params ["_ctxParams"];
	}

	decl(void()) def(postActivate)
	{
		if (self getv(autoDispose)) then {
			self callp(disposeAllAfterTime,rand(self getv(minDisposeTime),self getv(maxDisposeTime)));
		};
	}


	decl(mesh()) def(makeLight)
	{
		private _lt = "#lightpoint" createVehicleLocal [0,0,0];
		(self getv(_disposable)) pushBack _lt;
		_lt
	}

	decl(mesh()) def(makeParticle)
	{
		private _pt = "#particlesource" createVehicleLocal [0,0,0];
		(self getv(_disposable)) pushBack _pt;
		_pt
	}

	decl(void(float)) def(disposeAllAfterTime)
	{
		params ["_time"];
		invokeAfterDelayParams({ {deleteVehicle _x} foreach _this },_time,self getv(_disposable));
	}

	decl(void(mesh;vector3;string;bool))
	def(linkToSource)
	{
		params ["_lt",["_offset",vec3(0,0,0)],["_slot",""],["_followBone",false]];

		_lt attachTo [self getv(_src),_offset,_slot,_followBone];
	}


endstruct

//generic human damage effects

struct(BFXMeatSplat) base(BFXBase)
	decl(override) def(name) "BFX_MEATSPLAT";

	decl(override) def(minDisposeTime) 0.1;
	decl(override) def(maxDisposeTime) 0.5;

	decl(override) def(activate)
	{
		params ["_ctxParams"];
		_ctxParams params ["_slot"];

		private _meat = self callv(makeParticle);

		_meat setParticleParams [["\A3\data_f\ParticleEffects\Universal\Meat_ca.p3d",1,0,1,0],"","SpaceObject",
			3,5,
			[0,0,0],
			[0,0,2],
			3,1.6,0.5,0.2,
			[2.1],[[1,1,1,1]],[1],0.1,0.1,"","","",0,false,0.01,[[0,0,0,0]]
		];
		_meat setParticleRandom [2,[0,0,0],[3,3,0.5],0,0.4,[0.05,0.05,0.05,0],0,0,1,0.03];
		_meat setDropInterval 0.1;

		private _blood = self callv(makeParticle);

		_blood setParticleParams 
		[ 
			["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 4, 1], //shape name 
			"", //animation name 
			"Billboard", //type 
			1, 1.7, //timer period & life time 
			[0, 0, 0], //position 
			[0.00,0.0,2], //moveVelocity 
			5, 0.957, 0.2, 5.4, //rotation velocity, weight, volume, rubbing 
			[0.03,0.9], //size 
			[[1,0,0,0.9],[1,0,0,0.45]], 
			[0.1], //animationPhase (animation speed in config) 
			0.0, //randomdirection period 
			0.0, //random direction intensity 
			"", //onTimer 
			"", //before destroy 
			"", //object 
			0, //angle 
			false, //on surface 
			0.0 //bounce on surface 
		]; 
		_blood setParticleRandom [2,[0,0,0],[1.1,1.1,8.1],0,0.4,[0.05,0.05,8.05,0],0,0,1,0.03];
		_blood setDropInterval 0.08;

		self callp(linkToSource,_meat arg null arg _slot);
		self callp(linkToSource,_blood arg null arg _slot);
	}
endstruct

struct(BFXDestroyLimb) base(BFXBase)
	decl(override) def(name) "BFX_DESTROYLIMB";

	decl(override) def(minDisposeTime) 0.1;
	decl(override) def(maxDisposeTime) 0.3;

	decl(override) def(activate)
	{
		params ["_ctxParams"];
		_ctxParams params ["_slot"];

		private _meat = self callv(makeParticle);

		_meat setParticleParams [["\A3\data_f\ParticleEffects\Universal\Meat_ca.p3d",1,0,1,0],"","SpaceObject",
			3,5,
			[0,0,0],
			[0,0,2],
			3,1.6,0.5,0.2,
			[3.1],[[1,1,1,1]],[1],0.1,0.1,"","","",0,false,0.01,[[0,0,0,0]]
		];
		_meat setParticleRandom [2,[0,0,0],[3,3,4.5],0,0.4,[0.05,0.05,0.05,0],0,0,1,0.03];
		_meat setDropInterval 0.01;

		private _blood = self callv(makeParticle);

		_blood setParticleParams 
		[ 
			["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 4, 1], //shape name 
			"", //animation name 
			"Billboard", //type 
			1, 1.7, //timer period & life time 
			[0, 0, 0], //position 
			[0.00,0.0,4], //moveVelocity 
			4, 30.957, 0.2, 5.4, //rotation velocity, weight, volume, rubbing 
			[0.04,0.4], //size 
			[[1,0,0,0.9],[1,0,0,0.45]], 
			[0.1], //animationPhase (animation speed in config) 
			1.0, //randomdirection period 
			0.5, //random direction intensity 
			"", //onTimer 
			"", //before destroy 
			"", //object 
			0, //angle 
			false, //on surface 
			0.0 //bounce on surface 
		]; 
		_blood setParticleRandom [2,[0,0,0],[1.1,1.1,1.1],0,0.4,[0.05,0.05,8.05,0],0,0,1,0.03];
		_blood setDropInterval 0.01;

		self callp(linkToSource,_meat arg null arg _slot);
		self callp(linkToSource,_blood arg null arg _slot);
	}
endstruct

//bullet handlers

struct(BFXBulletBase) base(BFXBase)
	decl(override) def(name) ""

	decl(void(float;float;vector3)) def(addLight)
	{
		params ["_intensity","_timeout","_pos"];

		private _light = self callv(makeLight);
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
	}

	decl(vector3(int;float)) def(getFactPos)
	{
		params ["_side",["_addY",0]];

		if ((typeof (self getv(_src))) == BASIC_MOB_TYPE) then {
			private _sel = if (_side < 0) then {
				"lefthand"
			} else {
				"righthand"
			};

			(self getv(_src)) modelToWorld (((self getv(_src)) selectionPosition _sel) vectorAdd [0,_addY,0]);
		} else {
			getPosATL (self getv(_src));
		};
	}
endstruct

struct(BFXBulletPistol) base(BFXBulletBase)
	decl(override) def(name) "BFX_BULLET_PISTOL"

	decl(override) def(minDisposeTime) 0.25
	decl(override) def(maxDisposeTime) 0.25

	decl(override) def(activate)
	{
		params ["_ctxParams"];
		_ctxParams params ["_side"];

		private _pos = self callp(getFactPos,_side arg 0.18);
		self callp(addLight,30 arg self getv(minDisposeTime) arg _pos);

		private _shotFire = self callv(makeParticle);
		_shotFire setPosAtl _pos;
		_shotFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,0,1,0],"","Billboard",2,0.04,[0,0,0],[0,0,0],0,1.275,1,0,[0.25],[[0.9,0.9,0.9,0.3]],[1000],0,0,"","","",0,false,0,[[0,0,0,0]]];
		_shotFire setParticleRandom [0,[0,0,0],[0,0,0],30,0.08,[0,0,0,0],0,0,360,0];
		_shotFire setDropInterval 1.045;
		_shotFire setPosAtl _pos; //?is really need set twice?
	}
endstruct

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

struct(BFXBulletShotgun) base(BFXBulletBase)
	decl(override) def(name) "BFX_BULLET_SHOTGUN"

	decl(override) def(minDisposeTime) 0.25
	decl(override) def(maxDisposeTime) 0.25

	decl(override) def(activate)
	{
		params ["_ctxParams"];
		_ctxParams params ["_side"];

		private _pos = self callp(getFactPos,_side arg 0.65);
		self callp(addLight,70 arg self getv(minDisposeTime) arg _pos);

		private _shotFire = self callv(makeParticle);
		_shotFire setPosAtl _pos;
		_shotFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,2,80,0],"","Billboard",1,
		0.05 
		,[0,0,0],[0,0,0],0,1.27,1,0.05,[0.2],[[1,1,1,-15],[1,1,1,-12]],[2],0.2,0.2,"","","",0,false,0,[[0,0,0,0]]];
		_shotFire setParticleRandom [0,[0,0,0],[0.2,0.2,0.2],25,0.2,[0,0,0,0],0,0,1,0];
		_shotFire setDropInterval (self getv(minDisposeTime));
	}
endstruct

struct(BFXBulletRifle) base(BFXBulletBase)
	decl(override) def(name) "BFX_BULLET_SHOTRIFLE"

	decl(override) def(minDisposeTime) 0.25
	decl(override) def(maxDisposeTime) 0.25

	decl(override) def(activate)
	{
		params ["_ctxParams"];
		_ctxParams params ["_side"];

		private _pos = self callp(getFactPos,_side arg 0.75);
		self callp(addLight,140 arg self getv(minDisposeTime) arg _pos);

		private _shotFire = self callv(makeParticle);	
		_shotFire setPosAtl _pos;
		_shotFire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,
			0.04 //lifetime
			,[0,0,0],[0,0,0],0,1,0.8,0.5,[2,0],[[1,1,1,-4],[1,1,1,-4],[1,1,1,-2],[1,1,1,0]],[1000],0.1,0.1,"","","",0,false,0,[[0,0,0,0]]];
		_shotFire setParticleRandom [0,[0,0,0],[0,0,0.0],0,0.2,[0,0,0,0],0,0,360,0];
		_shotFire setDropInterval (
			(self getv(minDisposeTime)) + 0.105228
		);
	}
endstruct
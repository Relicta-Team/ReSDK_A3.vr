// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


regShot(SHOT_MEATSPLAT)
	
	shotParams params ["_slot"];
	
	makeParticle(_meat);
	_meat setParticleParams [["\A3\data_f\ParticleEffects\Universal\Meat_ca.p3d",1,0,1,0],"","SpaceObject",
	3,5,
	[0,0,0],
	[0,0,2],
	3,1.6,0.5,0.2,
	[2.1],[[1,1,1,1]],[1],0.1,0.1,"","","",0,false,0.01,[[0,0,0,0]]];
	_meat setParticleRandom [2,[0,0,0],[3,3,0.5],0,0.4,[0.05,0.05,0.05,0],0,0,1,0.03];
	_meat setDropInterval 0.1;
	
	makeParticle(_blood);
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
	
	_blood attachTo [sourceObject,[0,0,0],_slot];
	_meat attachTo [sourceObject,[0,0,0],_slot];
	
	disposeAllAfterTime(rand(0.1,0.5));
	
endRegShot

regShot(SHOT_DESTROYLIMB)
	
	shotParams params ["_slot"];
	
	makeParticle(_meat);
	_meat setParticleParams [["\A3\data_f\ParticleEffects\Universal\Meat_ca.p3d",1,0,1,0],"","SpaceObject",
	3,5,
	[0,0,0],
	[0,0,2],
	3,1.6,0.5,0.2,
	[3.1],[[1,1,1,1]],[1],0.1,0.1,"","","",0,false,0.01,[[0,0,0,0]]];
	_meat setParticleRandom [2,[0,0,0],[3,3,4.5],0,0.4,[0.05,0.05,0.05,0],0,0,1,0.03];
	_meat setDropInterval 0.01;
	
	makeParticle(_blood);
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
	
	_blood attachTo [sourceObject,[0,0,0],_slot];
	_meat attachTo [sourceObject,[0,0,0],_slot];
	
	disposeAllAfterTime(rand(0.1,0.3));
	
endRegShot
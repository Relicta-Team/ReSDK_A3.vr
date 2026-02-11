// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//! this file not used

#define RENDER_EFFECTS_UPDATEDELAY 0.1

#define newParticle() ("#particlesource" createVehicleLocal [0,0,0])

render_effects_lastPlayer = objnull;
render_effects_dustParticles = objnull;
render_effects_dustGlob = objNull;

render_effects_init = {
	
	warning("render::effects::init() - deprecated and will be removed soon");
	
	private _particle_emitter_0 = newParticle();
	_particle_emitter_0 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,5,[0,0,0],[0,0,0],0,1.275,1,0,[0.006,0.01,0.005,0.001],[[0.4,0.4,0.4,0.02],[0.4,0.4,0.4,0.6],[0.4,0.4,0.4,2],[0.4,0.4,0.4,2]],[1000,0],0.7,0.006,"","","",0,false,0,[[0,0,0,0],[0,0,0,0]]];
	_particle_emitter_0 setParticleRandom [2,[4.5,4.5,2.5],[0.05,0.05,0.01],0,0,[0.06,0.06,0.06,0],0.3,0.0019,1,0];
	//particle_emitter_0 setParticleCircle [0,[0,0,0]];
	_particle_emitter_0 setDropInterval 0.001;
	
	render_effects_dustParticles = _particle_emitter_0;
	
	//dust 
	_particle_emitter_0 = newParticle();
	_particle_emitter_0 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,10,[0,0,0],[0,0,0.2],0,0.0525,0.04,0.05,[4.6,3.5],[[0.403772,0.4,0.395348,0.06],[0.5,0.49223,0.483805,0.11],[0.298466,0.290041,0.3,0.06],[0.395348,0.391135,0.3,0.05],[0.5,0.500654,0.49223,0.015],[0.509079,0.5,0.4,0]],[1000],0.1,0.05,"","","",0,false,0,[[0,0,0,0]]];
	_particle_emitter_0 setParticleRandom [2.12,[2,2,1.2],[0.06,0.06,0.45],10,0.2,[0,0,0,0],0,0,0,0];
	_particle_emitter_0 setParticleCircle [10,[1,1,0]];
	_particle_emitter_0 setDropInterval 0.101;
	render_effects_dustGlob = _particle_emitter_0;
	
	startUpdate(render_effects_onUpdate,RENDER_EFFECTS_UPDATEDELAY);
};	

//обновление частиц
render_effects_updateParticles = {
	render_effects_dustParticles attachTo [render_effects_lastPlayer,[0,0,2],"head",true];
	render_effects_dustGlob attachTo [render_effects_lastPlayer,[0,0,-0]];
};	

//цикл обновления частиц
render_effects_onUpdate = {
	if not_equals(player,render_effects_lastPlayer) then {
		render_effects_lastPlayer = player;
		call render_effects_updateParticles;
	};	
};	

/*
//fix dust
render_effects_dustParticles attachTo [render_effects_lastPlayer,[0,0,0]];
render_effects_dustParticles setParticleRandom [2,[5.5,5.5,2],[0.02,0.02,0.01],0,0,[0.06,0.06,0.06,0],0.3,0.0019,1,0];
render_effects_dustParticles setParticleCircle [0.1,[0,0,0]];


//radial dust
particle_emitter_0 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,10,[0,0,0],[0,0,0.2],0,0.0525,0.04,0.05,[10.6,3.5],[[0.5,0.4,0.3,0.06],[0.5,0.4,0.3,0.11],[0.5,0.4,0.3,0.06],[0.5,0.4,0.3,0.05],[0.5,0.4,0.3,0.015],[0.6,0.5,0.4,0]],[1000],0.1,0.05,"","","",0,false,0,[[0,0,0,0]]];
particle_emitter_0 setParticleRandom [5.12,[2,2,5.2],[0.1,0.1,0.15],20,0.2,[0,0,0,0],0,0,0,0];
particle_emitter_0 setParticleCircle [30,[1,1,0]];
particle_emitter_0 setDropInterval 0.001;

*/
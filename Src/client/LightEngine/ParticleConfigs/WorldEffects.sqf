// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//#define stdLink() 	linkLight(emitterObject,player,vector(0,0,0)); linkLight(emitterObject,sourceObject,vector(0,0,0))
#define stdLink(x,y,z) emitterObject setposatl ((getposatl sourceObject) vectorAdd vec3(x,y,z))

//small 5metters ranged (in rooms)
regEffect(EFF_DUST_PARTICLES)

	stdLink(0,0,0);
	
	
	emitterObject setParticleParams [
		["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0]
		,"","Billboard",0.01,5,[0,0,0],[0,0,0],0,1.275,1,0,[0.006,0.01,0.005,0.001],
		[[0.4,0.4,0.4,5.02],[0.4,0.4,0.4,5.6],[0.4,0.4,0.4,5+2],[0.4,0.4,0.4,5+2]],//size
		[1000,0],0.7,0.006,"","","",0,false,0,[[0,0,0,0],[0,0,0,0]]];
	emitterObject setParticleRandom [2,[5.5,5.5,2.8],[0.05,0.05,0.01],0,0,[0.06,0.06,0.06,0],0.3,0.0019,1,0];
	//particle_emitter_0 setParticleCircle [0,[0,0,0]];
	emitterObject setDropInterval 0.001;

	addEventOnDestroySource(emitterObject);
endRegEffect


regEffect(EFF_DUST_CLOUDS)

	stdLink(0,0,0);

	emitterObject setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,10,[0,0,0],[0,0,0.2],0,0.0525,0.04,0.05,[4.6,3.5],[[0.403772,0.4,0.395348,0.06],[0.5,0.49223,0.483805,0.11],[0.298466,0.290041,0.3,0.06],[0.395348,0.391135,0.3,0.05],[0.5,0.500654,0.49223,0.015],[0.509079,0.5,0.4,0]],[1000],0.1,0.05,"","","",0,false,0,[[0,0,0,0]]];
	emitterObject setParticleRandom [2.12,[2,2,1.2],[0.06,0.06,0.45],10,0.2,[0,0,0,0],0,0,0,0];
	emitterObject setParticleCircle [10,[1,1,0]];
	emitterObject setDropInterval 0.101;

	addEventOnDestroySource(emitterObject);
endRegEffect


regEffect(EFF_GREEN_DUST)
	
	stdLink(0,0,0);
	
	emitterObject setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,10,[0,0,0],[0,0,0.2],0,0.0525,0.04,0.05,[4.8,3.5],[[0.204439,0.4,0.0201506,0.116134],[0.285065,0.49223,0.235154,0.0739013],[0.215957,0.49223,0.223636,0.0662227],[0.25435,0.391135,0.3,0.05],[0.246672,0.500654,0.185242,0.015],[0.0700619,0.5,0.0777405,0]],[1000],0.1,0.05,"","","",0,false,0,[[0,0,0,0]]];
	emitterObject setParticleRandom [2.12,[2,2,1.2],[0.06,0.06,0.45],10,0.2,[0,0,0,0],0,0,0,0];
	emitterObject setParticleCircle [4,[0,0,1]];
	emitterObject setDropInterval 0.051;
	
	addEventOnDestroySource(emitterObject);
endRegEffect

regEffect(EFF_ROTTEN_HUMAN)

	stdLink(0,0,0);

	emitterObject setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,10,[0,0,0],[0,0,0.2],0,0.0525,0.04,0.05,[4.8,3.5],[[0.392567,0.154528,0.523104,0.100777],[0.396406,0.146849,0.450157,0.0739013],[0.442478,0.127652,0.453996,0.0662227],[0.60757,0.0777405,0.573016,0.05],[0.519265,0.173724,0.392567,0.015],[0.277387,0.162206,0.327298,0]],[1000],0.1,0.05,"","","",0,false,0,[[0,0,0,0]]];
	emitterObject setParticleRandom [2.12,[2,2,1.2],[0.06,0.06,0.45],10,0.2,[0,0,0,0],0,0,0,0];
	emitterObject setParticleCircle [2.5,[0,0,0]];
	emitterObject setDropInterval 0.151;
	
	addEventOnDestroySource(emitterObject);
endRegEffect
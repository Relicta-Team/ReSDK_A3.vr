// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_FX_GRENADE)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,2,80,0],"","Billboard",1,0.1,[0,0,0],[0,0,0],0,1.27,1,0.05,[1.2],[[1,1,1,0.074],[1,1,1,0.669]],[2],0.2,0.2,"","","",0,false,-1,[]]],
		["setParticleRandom",[0,[0.3,0.3,0.3],[0.2,0.2,0.3],25,0.2,[0,0,0,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.1]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 2")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,2,8,0],"","Billboard",1,0.05,[0,0,0],[0,0,0],0,1.275,1,0,[0.02],[[1,1,0.6,-50]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0,[2,2,2],[0,0,0],0,0,[0,0,0,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.001]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 3")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,0.2,[0,0,0],[0,0,0],1,1.22,1,0.4,[1,8],[[0.1,0.1,0.1,0.07],[0.2,0.2,0.2,0.02],[0.2,0.2,0.2,0.01],[0.2,0.2,0.2,0.005],[0.4,0.4,0.4,0.003]],[1000],0.1,0.1,"","","",0,false,-1,[]]],
		["setParticleRandom",[1,[0.5,0.5,0.5],[1.5,1.5,1.5],10,0,[0,0,0,0],0,0,360,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.001]
	]
	,[
		"pt",
		null,
		_emitAlias("обломки")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Shard\shard2.p3d",1,0,1,0],"","SpaceObject",3,0.1,[0,0,0],[0,0,0],4.454,2.5,1,0.02,[0.1],[[1,1,1,1]],[1],0.293,0.293,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.2,[0,0,0],[5,5,5.5],0,0.15,[0.05,0.05,0.05,0],0,0,1,0]],
		["setParticleCircle",[0,[10.038,6.748,0]]],
		["setDropInterval",0.001]
	]
	,[
		"pt",
		null,
		_emitAlias("Взрыв")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,2,80,0],"","Billboard",1.5,0.4,[0,0,0],[0,0,2],0,0.056,0.04,0.1,[0.5,1],[[1,1,1,-1],[1,1,1,-1],[1,1,1,-0.5],[1,1,1,-0.3],[1,1,1,0]],[1.75],0.5,0.05,"","","",0,false,-1,[]]],
		["setParticleRandom",[0,[0.5,0.5,0.5],[1,1,1],25,0.2,[0,0,0,1],0,0,360,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.01]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 7")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1],"","Billboard",1,0.6,[0,0,0],[0,0,2.1],1,0.88,1,0,[0.7,0.22],[[1,1,1,0.669],[1,1,1,0.187],[1,1,1,0.02],[1,1,1,0.01],[1,1,1,0.001]],[0.8,0.3,0.25],0.3,0.04,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.4,[0.5,0.5,0.2],[5.25,5.25,0.25],9,0,[0,0,0,0],0,0,0.5,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.001]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 8")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,2,[0,0,0],[0,0,2],1,1.85,1,0.15,[1,1],[[0.5,0.5,0.5,0.4],[0.5,0.5,0.5,0.22],[0.6,0.6,0.6,0.09],[0.8,0.8,0.8,0.01]],[1.5,0.5,0.25,0.25],0.2,0.1,"","","",0,false,-1,[]]],
		["setParticleRandom",[1.5,[0.2,0.2,0.2],[1.5,1.5,3],20,0.3,[0,0,0,0.3],0.2,0.05,360,0]],
		["setParticleCircle",[0.55,[0,0,0]]],
		["setDropInterval",0.01]
	]
endScriptEmit
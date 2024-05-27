// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_MAGICSTORM_DEBUG)
	[
		"lt",
		null,
		_emitAlias("Точечный свет 1")
		["linkToSrc",[0,0,0.731001]],
		["setLightColor",[0,0.07,0.09]],
		["setLightIntensity",15991.1],
		["setLightUseFlare",true],
		["setLightFlareSize",3.131],
		["setLightAttenuation",[0,0,0,0,134296,0]]
	]
	,[
		"ltd",
		null,
		_emitAlias("Направленный свет 2")
		["linkToLight",[0,1.274,-0.490999]],
		["setOrient",[-81.136,94.659,0]],
		["setLightColor",[0,0.07,0.05]],
		["setLightAmbient",[0,0,0.04]],
		["setLightIntensity",18302.9],
		["setLightUseFlare",true],
		["setLightFlareSize",3.709],
		["setLightFlareMaxDistance",2.55]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 3")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,1,[0,0,0],[0,0,1.704],0,0.52,0.4,0.45,[0.5,1],[[0.505,0.25,0.443,0.207],[0.3,0.3,0.3,-0.0889999]],[1.5,0.5],0.1,0.2,"","","",0,false,-1,[]]],
		["setParticleRandom",[2,[0.5,0.5,0.5],[2.5,2.5,2.5],10,0.8,[0,1,0,0],0,0,1,0]],
		["setParticleCircle",[2.21,[3.952,-4.438,2.142]]],
		["setDropInterval",0.0001]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 4")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,3.5,[0,0,0],[0,0,1.5],1,1.05,1,0.17,[0.5,0.5,0.5,0.5,0.5,0.28,0.28,0.28,0.28,0],[[1,0.3,0.3,-6.5],[1,0.3,0.3,-6],[1,0.3,0.3,-5.5],[1,0.3,0.3,-4.5]],[1000],0.5,0.55,"","","",0,false,-1,[]]],
		["setParticleRandom",[2.5,[0,0,0.2],[0.2,0.2,0.2],2,0.04,[0,0.15,0.15,0],0.3,0.15,360,0]],
		["setParticleCircle",[2.49,[0,-0.653999,0]]],
		["setDropInterval",0.005]
	]
endScriptEmit

regScriptEmit(SLIGHT_SET123_DEBUG)
	[
		"pt",
		null,
		_emitAlias("test")
		["linkToSrc",[0,0,0.867001]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\GlassParts_05.p3d",1,0,1,0],"","SpaceObject",3,0.8,[0,0,0],[0,0,0],0,5,1,0,[0.125],[[1,1,1,1]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.1,[0.35,0.35,0.475],[0.4,0.4,0.4],6,0.025,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[3.32,[5.432,0,0]]],
		["setDropInterval",0.02]
	]
	,[
		"lt",
		null,
		_emitAlias("Точечный свет 3")
		["linkToLight",[0,0,0]],
		["setLightColor",[1,0.5,0.2]],
		["setLightIntensity",300],
		["setLightAttenuation",[0,0,0,5,0,0]]
	]
	,[
		"ltd",
		null,
		_emitAlias("Направленный свет 2")
		["linkToLight",[0,0,0.2]],
		["setOrient",[0,11.645,0]],
		["setLightColor",[0.2,0.2,0.21]],
		["setLightAmbient",[0.18,0.13,0]],
		["setLightIntensity",5000],
		["setLightAttenuation",[0.3,0.9,0.5,0,0.2,5.1]],
		["setLightConePars",[88.42,5.69,2]]
	]
endScriptEmit

regScriptEmit(SLIGHT_TEMPLATE_DIRECTLIGHT)
	[
		"ltd",
		null,
		_emitAlias("Источник света")
		["linkToSrc",[0.05,0,0]],
		["setOrient",[90,0,0]],
		["linkToSrc",[-0.11,0,0]],
		["setOrient",[-90,0,0]],
		["setLightColor",[0.48,0.48,0.45]],
		["setLightAmbient",[0.03,0.03,0.04]],
		["setLightIntensity",1000],
		["setLightUseFlare",true],
		["setLightFlareSize",0.708],
		["setLightFlareMaxDistance",30.01],
		["setLightAttenuation",[1,0,0,0,5,7]],
		["setLightConePars",[122.52,30.46,2]]
	]
endScriptEmit

regScriptEmit(SLIGHT_TEMPLATE_POINTLIGHT)
	[
		"lt",
		null,
		_emitAlias("Источник")
		["linkToSrc",[0,0,0]],
		["setLightColor",[0.17,0.82,0.33]],
		["setLightIntensity",1000],
		["setLightAttenuation",[3,0,10,8,5,8]]
	]
endScriptEmit

regScriptEmit(SLIGHT_STREET_LAMP)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 1")
		["linkToSrc",[0,0,3.4]],
		["setOrient",[0,-90,0]],
		["setLightColor",[0.7,0.55,0.5]],
		["setLightIntensity",8000],
		["setLightUseFlare",true],
		["setLightFlareSize",0.5],
		["setLightFlareMaxDistance",30],
		["setLightAttenuation",[0,0,0,0,12,14]],
		["setLightConePars",[360,50,5]]
	]
endScriptEmit

regScriptEmit(SLIGHT_SHIT_SMELL)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0.6]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,10,[0,0,0],[0,0,0],0,0.0511,0.04,0.1,[0.2,0.5,1,1.5,2,2.5,3],[[0.1,0.1,0.1,0.05],[0.1,0.2,0.1,0.06],[0.2,0.3,0.1,0.07],[0.3,0.4,0.1,0.08],[0.3,0.5,0.1,0.09],[0.4,0.6,0.3,0.1],[0.5,0.7,0.4,0.1]],[1000],0.1,0.01,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.2,[0.2,0.2,0.2],[0.01,0.01,0.01],5,0.2,[0,0,0,0],0,0,0,0]],
		["setParticleCircle",[0.03,[0.1,0.1,0]]],
		["setDropInterval",0.5]
	]
endScriptEmit

regScriptEmit(SLIGHT_WEAK_FIRE)
	[
		"lt",
		null,
		_emitAlias("Точечный свет 2")
		["linkToSrc",[0,0,0]],
		["setLightColor",[1,0.5,0.2]],
		["setLightAmbient",[0.1,0.05,0.02]],
		["setLightIntensity",255],
		["setLightAttenuation",[0,0,0,5,0,0]]
	]
	,[
		"pt",
		null,
		_emitAlias("Искры")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,0.7,[0,0,0],[0,0,0.005],0.4,1.2,1,0.17,[0.1,0.1],[[1,0.3,0.3,-6.5]],[1000,100],0.5,0.05,"","","",0,false,-1,[]]],
		["setParticleRandom",[2.5,[0,0,0.2],[0.2,0.2,1],2,0.04,[0,0.15,0.15,0],0.3,0.15,360,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.06]
	]
	,[
		"pt",
		null,
		_emitAlias("Дым")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,1.2,[0,0,0],[0,0,0.6],0,0.05,0.04,0.22,[0.14,0.4],[[0.1,0.1,0.1,0.03],[0.2,0.2,0.2,0.05],[0.2,0.2,0.2,0.025],[0.3,0.3,0.3,0.01],[0.4,0.4,0.4,0.005]],[1.5,0.5],0.4,0.02,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.5,[0.03,0.03,0.03],[0.25,0.25,0.5],0,0.1,[0,0,0,0],0.1,0.01,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.01]
	]
	,[
		"pt",
		null,
		_emitAlias("Огонь")
		["linkToLight",[-0.0499992,3.8147e-006,0.0840034]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.4,[0,0,0],[0,0,0.5],0,0.05,0.04,0.16,[0.2],[[1,1,0.6,-80]],[0.2],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.15,[0.15,0.15,0.15],[0.03,0.03,0.09],0,0.02,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.01]
	]
	,[
		"pt",
		null,
		_emitAlias("Рефракт")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Refract.p3d",1,0,1,0],"","Billboard",1,2,[0,0,0],[0,0,0.6],0,0.05,0.04,0.05,[0.5,0.8,2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.1]
	]
endScriptEmit

regScriptEmit(SLIGHT_SPOT_LAMP)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 3")
		["linkToSrc",[0,0,0.100002]],
		["setOrient",[0,-90,0]],
		["setLightColor",[1000,1000,1000]],
		["setLightAmbient",[10,10,10]],
		["setLightIntensity",5],
		["setLightFlareSize",0.1],
		["setLightFlareMaxDistance",250],
		["setLightAttenuation",[0,20,0,0.1,0.005,3]],
		["setLightConePars",[90,0,0]]
	]
endScriptEmit

regScriptEmit(SLIGHT_LAMP_HOUSE)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 1")
		["linkToSrc",[0,0,-0.15]],
		["setOrient",[0,-90,0]],
		["setLightColor",[1,0.7,0.3]],
		["setLightAmbient",[1,0.6,0.3]],
		["setLightIntensity",600],
		["setLightUseFlare",true],
		["setLightFlareSize",0.2],
		["setLightFlareMaxDistance",100],
		["setLightAttenuation",[0,0,0,0,0.01,10]],
		["setLightConePars",[230,0,4]]
	]
endScriptEmit

regScriptEmit(SLIGHT_LIGHT_STOVE)
	[
		"lt",
		null,
		_emitAlias("Точечный свет 1")
		["linkToSrc",[0,0,0]],
		["setLightColor",[1,0.5,0.2]],
		["setLightAmbient",[0.1,0.05,0.02]],
		["setLightIntensity",1000],
		["setLightAttenuation",[0,0,0,5,0.1,2]]
	]
	,[
		"pt",
		null,
		_emitAlias("Огонь")
		["linkToLight",[0,0,-0.1]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.7],0,0.05,0.04,0.05,[0.24,0],[[1,1,1,-100],[1,1,1,-100],[0,0,0,0]],[1],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.15,[0.01,0.01,0.15],[0.04,0.04,0.2],0,0.04,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.022]
	]
	,[
		"pt",
		null,
		_emitAlias("Рефракт")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Refract.p3d",1,0,1,0],"","Billboard",1,2,[0,0,0],[0,0,0.6],0,0.05,0.04,0.05,[0.2,0.8,2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.1]
	]
	,[
		"pt",
		null,
		_emitAlias("Дым")
		["linkToLight",[0,0,0.3]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1],"","Billboard",1,2,[0,0,0],[0,0,0.08],1,1.26,1,0,[0.2,0.25],[[1,1,1,0.06],[1,1,1,0.04],[1,1,1,0.02],[1,1,1,0.01],[1,1,1,0.001]],[0.8,0.3,0.25],0.3,0.04,"","","",0,false,-1,[]]],
		["setParticleRandom",[1,[0.08,0.08,0.01],[0.05,0.05,0.05],9,0,[0,0,0,0],0,0,0.5,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.01]
	]
	,[
		"pt",
		null,
		_emitAlias("Искры")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,1,[0,0,0],[0,0,0.05],1,1.2,1,0.17,[0.1,0.1,0.1,0.1,0.1,0.08,0.08,0.08,0.08,0],[[1,0.3,0.3,-6.5],[1,0.3,0.3,-6],[1,0.3,0.3,-5.5],[1,0.3,0.3,-4.5]],[100],0.5,0.001,"","","",0,false,-1,[]]],
		["setParticleRandom",[2.5,[0,0,0],[0.2,0.2,1],2,0.04,[0,0.15,0.15,0],0.01,0.01,360,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.1]
	]
endScriptEmit

regScriptEmit(SLIGHT_LIGHT_BAKE)
	[
		"lt",
		null,
		_emitAlias("Точечный свет")
		["linkToSrc",[-0.799999,0.600002,-3.3]],
		["setLightColor",[1,0.5,0.2]],
		["setLightAmbient",[0.1,0.05,0.02]],
		["setLightIntensity",2000],
		["setLightAttenuation",[0,0,0,5,0.05,3]]
	]
	,[
		"pt",
		null,
		_emitAlias("Огонь")
		["linkToLight",[-0.8,0.8,-3.6]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.7],0,0.07,0.04,0.05,[0.24,0],[[1,1,1,-100],[1,1,1,-100],[0,0,0,0]],[1],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.15,[0.01,0.01,0.15],[0.04,0.04,0.2],0,0.04,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.022]
	]
endScriptEmit

regScriptEmit(SLIGHT_STREET_LAMP_DORM)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 1")
		["linkToSrc",[0,0,3.298]],
		["setOrient",[0,-90,0]],
		["setLightColor",[1,0.5,0.2]],
		["setLightAmbient",[0.1,0.05,0.02]],
		["setLightIntensity",7000],
		["setLightUseFlare",true],
		["setLightFlareSize",0.2],
		["setLightFlareMaxDistance",30],
		["setLightAttenuation",[0,0,0,0,0.1,20]],
		["setLightConePars",[360,90,0]]
	]
endScriptEmit

regScriptEmit(SLIGHT_DAM_METAL)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",0.07,1.3,[0,0,0],[0,0,0],0,15,9.9,0.3,[0.06,0.09],[[1,0.268,0.017,1],[1,1,0.721,0.196]],[100,100],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[1,[0,0,0],[1.5,1.5,1.3],0,0.3,[0,0,0,0],100,100,0,0]],
		["setParticleCircle",[0,[14.809,13.986,0]]],
		["setDropInterval",0.002]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 7")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1],"","Billboard",1,3,[0,0,0],[0,0,0],1,1.275,1,0.5,[0.4,2.6],[[1,1,1,0.064],[1,1,1,0.111]],[0.8,0.3],0.3,0.1,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.5,[0,0,0],[1.2,1.2,1.2],2,0.2,[0,0,0,0],0,0,0.3,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.8]
	]
endScriptEmit

regScriptEmit(SLIGHT_DAM_STONE)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Shard\shard4.p3d",16,13,2,0],"","SpaceObject",1,0.3,[0,0,0],[0,0,0.800003],0,2.55,1,0.17,[0.3,0.3,0.3,0.3,0.3,0.18,0.18,0.18,0.18,0],[[1,0.3,0.3,-6.5],[1,0.3,0.3,-6],[1,0.3,0.3,-5.5],[1,0.3,0.3,-4.5]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[1.5,[0,0,0],[1.4,1.4,1.4],1.7,0.04,[0,0,0,0],2.2,0.1,209.772,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.008]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 2")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1],"","Billboard",1,2,[0,0,0],[0,0,0],0.594,1.275,1,10,[0.1,0.5,0.8,1.6],[[1,1,1,0.442],[1,1,1,0.319],[1,1,1,0.215],[1,1,1,0.168]],[0.8,0.3,0.25],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[2.5,[0,0,0],[0.5,0.5,0.5],0.01,0.2,[0,0,0,0],0,0,0,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.2]
	]
endScriptEmit

regScriptEmit(SLIGHT_DAM_WOOD)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\ca\buildings\particle_effects\dum_door_piece_b.p3d",16,13,2,0],"","SpaceObject",1,0.3,[0,0,0],[0,0,0],0,1.55,1,0.13,[0.05,0.05,0.05,0.05,0.05,0.01,0.01],[[1,0.3,0.3,-6.5],[1,0.3,0.3,-6],[1,0.3,0.3,-5.5],[1,0.3,0.3,-4.5]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[1.5,[0,0,0],[2,2,2],1.7,0.04,[0,0,0,0],2.2,3.1,359.999,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.005]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 9")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","BillBoard",0.01,1,[0,0,0],[0,0,0.0820007],0,1.4,1.11,0,[0.58,0.3,0.1],[[0.6196,0.5804,0.5451,0.008]],[14,0.5,0.3,0.25,0.25],1,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[2,[0,0,0],[1,1,1],20,0,[0,0,0,0],2,1.5,0,0]],
		["setParticleCircle",[0,[50,50,50]]],
		["setDropInterval",0.01]
	]
endScriptEmit

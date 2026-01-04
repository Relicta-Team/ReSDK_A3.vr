// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_PAPER)
	[
		"pt",
		null,
		_emitAlias("Частицы 3")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\a3\Weapons_F_Orange\Ammo\leaflet_05_f.p3d",1,0,1,0],"","SpaceObject",3,2.8,[0,0,0],[0,0,0],0,1.6,1,1.5,[0.3],[[1,1,1,1]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.1,[0,0,0],[3.5,3.5,3.5],1,0.58,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.02]
	]
endScriptEmit
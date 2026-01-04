// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


render_dist_handle = -1;
render_dist_maxDistance = 170;
render_dist_minDistance = 25;

render_dist_onupdate = {
	
	#define setRendering(dist) setViewDistance (dist); setObjectViewDistance (dist)
	_defpos = AGLToASL positionCameraToWorld [0,0,0];
	____ins = lineIntersectsSurfaces [
		_defpos,
		AGLToASL(positionCameraToWorld [0,0,1000]),
		player,
		objNull,
		true,
		1,
		"GEOM",
		"VIEW"
	];
	if (count ____ins == 0) then {
		setRendering(render_dist_maxDistance);
	} else {
		//ASLToATL (____ins select 0 select 0)
		_distNew = (____ins select 0 select 0) distance _defpos;
		_renderdist = (_distNew max render_dist_minDistance min render_dist_maxDistance);
		setRendering(_renderdist);
	};
};

render_dist_init = {
	render_dist_handle = startUpdate(render_dist_onupdate,0);
};	
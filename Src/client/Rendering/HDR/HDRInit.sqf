// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



render_hdr_init = {
	setApertureNew [6,30,20,200];
};

//ставим новый рендеринг
call render_hdr_init;

#ifdef HDR_DYNAMIC_ENABLED

render_hdr_setMode = {}; //underground, world

render_hdr_setWorldTIme = {};
render_hdr_initWolrdTime = {};

#endif

// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

namespace(Rendering.HDR,render_hdr_)

decl(void())
render_hdr_init = {
	setApertureNew [6,30,20,200];
};

//ставим новый рендеринг
call render_hdr_init;


decl(void())
render_hdr_setMode = {}; //underground, world

decl(void())
render_hdr_setWorldTIme = {};
decl(void())
render_hdr_initWolrdTime = {};


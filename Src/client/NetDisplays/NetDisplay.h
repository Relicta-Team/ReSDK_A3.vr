// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\text.hpp>
#include <..\WidgetSystem\widgets.hpp>

#define ND_INIT(name) nd_map_displays set ['name',{ private _args = _this select 0; private _isFirstCreate = _this select 1; private _w_d_ = widgetNull;

#define ND_END }];

#define vec4(x,y,w,h) [x,y,w,h]
#define ctgNULL NIL

#define addSavedWdiget(wid) getSavedWidgets pushBack(wid)
#define getSavedWidgets (nd_list_widgets select 0)

#define regNDWidget(widgetType,vecpos,probCtg,datatype) _w_d_ = [_d,widgetType,vecpos,probCtg] call createWidget; \
(nd_list_widgets select 1)pushBack _w_d_; \
_w_d_ setVariable ["data",datatype];

#define regNDRPC(evname) _w_d_ setVariable ["__ndevent",evname]; _w_d_ ctrlAddEventHandler ["MouseButtonUp",{ \
params ["_wid","_butt"]; \
todo \
}];

#define lastNDWidget _w_d_
#define thisDisplay _d
#define isFirstLoad _isFirstCreate
#define ctxParams _args

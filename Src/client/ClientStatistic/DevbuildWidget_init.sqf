// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
#include <..\..\host\lang.hpp>
if (ISDEVBUILD) then {
	_gui = getGUI;
	private _ctg = [_gui,WIDGETGROUP,[0,0,100,5]] call createWidget;
	_w = [_gui,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	[_w,"<t align='center'>DEVELOPMENT BUILD</t>"] call widgetSetText;
	_w ctrlSetBackgroundColor [0.9,0.1,0.1,.7];
};

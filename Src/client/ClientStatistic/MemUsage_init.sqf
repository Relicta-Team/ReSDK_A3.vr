// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(ClientMemUsage,mem_)

#ifdef EDITOR

decl(widget[])
cli_mem_widgets = [widgetNull,widgetNull,widgetNull];

macro_const(cli_mem_memvis_size_x)
#define memvis_size_x 14
macro_const(cli_mem_memvis_size_y)
#define memvis_size_y 10

decl(void())
cli_mem_init = {
	private _gui = getGUI;

	private _ctg = [_gui,WIDGETGROUP,[
		100 - memvis_size_x,
		0,
		memvis_size_x,
		memvis_size_y
	]] call createWidget;
	cli_mem_widgets set [0,_ctg];

	private _back = [_gui,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0.1,0.1,0.1,0.1];
	cli_mem_widgets set [1,_back];

	private _text = [_gui,TEXT,WIDGET_FULLSIZE,_ctg] call createWidget;
	cli_mem_widgets set [2,_text];
	startUpdateParams(cli_mem_onupdate,0,[_text]);
};

decl(void(widget))
cli_mem_onupdate = {
	_text = _this select 0 select 0;

	_meminfList = (["ScriptContext","mem",null,true] call rescript_callCommand splitString ",") apply {_x splitString ":" select 1};
	_sb = [];
	
	_sb pushback "<t size='1'>";
	_sb pushback (format["memproc: %1",_meminfList select 0]);
	_sb pushback sbr;
	_sb pushback (format["workingset: %1 MB",_meminfList select 1]);
	_sb pushback sbr;
	_sb pushback (format["privmem: %1 MB",_meminfList select 3]);
	_sb pushback sbr;
	_sb pushback (format["paged: %1 MB",_meminfList select 2]);
	_sb pushBack "</t>";

	[_text,_sb joinString ""] call widgetSetText;
};

#endif
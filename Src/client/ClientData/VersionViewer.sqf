// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"
namespace(ClientDataVersionViewer,cd_vv_)

#include <..\WidgetSystem\widgets.hpp>
#include <..\..\host\text.hpp>

macro_const(cd_vv_timeout_init_clientname)
#define versionviewer_timeout_init_clientname 30

macro_const(versionviewer_size_x)
#define versionviewer_size_x 14
macro_const(versionviewer_size_y)
#define versionviewer_size_y 10
_gui= getGUI;

decl(widget[])
cd_vv_widgets = [];
_ctg = [_gui,WIDGETGROUP,[
	100 - versionviewer_size_x,
	100 - versionviewer_size_y,
	versionviewer_size_x,
	versionviewer_size_y
	]] call createWidget;
_back = [_gui,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
_back setBackgroundColor [0.1,0.1,0.1,0.1];
_txt = [_gui,TEXT,WIDGET_FULLSIZE,_ctg] call createWidget;

cd_vv_widgets = [_ctg,_back,_txt];

decl(void(string))
cd_vv_syncVisual = {
	params [["_cliName",cd_clientName]];
	
	_txt = cd_vv_widgets select 2;
	_rev = "";
	#ifdef ENABLE_HOT_RELOAD
	_rev = format["HRC:%1",client_hrc_ver];
	#endif
	
	[_txt,format["<t align='right' size='0.9'>%1%1Name: %2%1v%3%1%4</t>",sbr,_cliName,client_version,_rev]] call widgetSetText;
};

#ifndef SP_MODE
//Ожидаем пока клиент не загрузится чтобы выдать ему имя
startAsyncInvoke
	{
		cd_clientName != ""
	},
	{
		[] call cd_vv_syncVisual;
	},
	[],
	versionviewer_timeout_init_clientname,
	{
		//Не успел загрузить имя за отведённое время
		["ERR:LOAD_TIMEOUT"] call cd_vv_syncVisual;
	}
endAsyncInvoke

#endif
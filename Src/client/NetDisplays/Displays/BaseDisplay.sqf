// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

struct(NDBase)

	decl(widget) def((self getv(lastNDWidget))) widgetNull;
	decl(display) def((self getv(thisDisplay))) displayNull;

	decl(string) def(str)
	{
		format["NetDisplay<%1>",struct_typename(self)];
	}

	decl(void()) def(init)
	{
		nd_internal_currentStructObj = self;
	}

	//create or update netdisplay context
	decl(void()) def(process)
	{
		params ["_args","_isFirstCall"];

	}

	decl(void()) def(addSavedWidget)
	{
		params ["_wid"];
		(self callv(getSavedWidgets)) pushBack _wid;
	}

	decl(widget[]()) def(getSavedWidgets)
	{
		nd_list_widgets select 0
	}

	decl(widget()) def(addWidget)
	{
		params ["_wtype","_vecpos","_probCtg","_dataType"];
		private _w_d_ = [_d,_wtype,_vecpos,_probCtg] call createWidget;
		(nd_list_widgets select 1) pushBack _w_d_;
		_w_d_ setVariable ["data",_dataType];
	}

endstruct

// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

struct(NDBase)

	//reference to last created widget
	decl(widget) def(lastNDWidget) widgetNull;
	//reference to current display
	decl(display) def(thisDisplay) displayNull;

	decl(string) def(str)
	{
		format["NetDisplay<%1>",struct_typename(self)];
	}

	decl(void()) def(init)
	{
		nd_internal_currentStructObj = self;
	}

	decl(void(display)) def(assignDisplay)
	{
		params ["_disp"];
		assert_str(!isNullReference(_disp),"Display cannot be null on construct ND struct");
		self setv(thisDisplay,_disp);
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
		private _w_d_ = [self getv(thisDisplay),_wtype,_vecpos,_probCtg] call createWidget;
		(nd_list_widgets select 1) pushBack _w_d_;
		self setv(lastNDWidget,_w_d_);
		_w_d_ setVariable ["data",_dataType];
	}

endstruct

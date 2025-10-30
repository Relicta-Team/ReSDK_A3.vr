// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\engine.hpp>
#include <..\..\WidgetSystem\widgets.hpp>

#define DECAL_SPHERE_CONFIG "Sign_Sphere25cm_F"

dec_makeSphere = {
	private _o = createSimpleObject [DECAL_SPHERE_CONFIG,[0,0,0],true];

	_o
};

dec_setRenderTarget = {
	params ["_o","_rtName"];
	_o setObjectTexture [0,format ['#(argb,2048,2048,1)ui("RscDisplayEmpty","%1","ca")', _rtName]];
	_o setObjectMaterial [0,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
	//debug
	private _rc = [_rtName] call dec_getRenderContext;
	private _p = [_rc,PICTURE,[0,0,100,100]] call createWidget;
	_p ctrlsettextcolor [1,0,0,0.7];
	[_p,inventory_const_dirtOverlayIcon] call widgetSetPicture;
	[_rc] call dec_applyContext;
};

dec_getRenderContext = {
	params ["_rtName"];
	findDisplay _rtName
};

dec_applyContext = {
	params ["_rctx"];
	displayUpdate _rctx
};


dec_setRenderUniform = {
	{
		player setObjectTexture [_foreachIndex,"#reset"];
	} foreach (getobjecttextures player);
	//if(true) exitWith {};

	{
		if (_foreachIndex> 0)exitWith{};
		[player,_foreachIndex,"uni_"+(str _foreachIndex)] call dec_setRenderTarget2;
	} foreach (getobjecttextures player);
};

dec_setRenderTarget2 = {
	params ["_o","_ind","_rtName"];
	private _orig = _o getobjecttextures [_ind] select 0;
	_o setObjectTexture [_ind,format ['#(argb,2048,2048,1)uiEx(display:RscDisplayEmpty,uniqueName:%1)', _rtName]];
	//_o setObjectMaterial [_ind,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
	//debug
	private _rc = [_rtName] call dec_getRenderContext;
	(allcontrols _rc) apply {ctrldelete _x};
	private _p = [_rc,PICTURE,[28,23,44,54]] call createWidget;
	[_p,_orig] call widgetSetPicture;
	_p = [_rc,PICTURE,pdat] call createWidget;
	_p ctrlsettext inventory_const_dirtOverlayIcon;
	_p ctrlsettextcolor [1,0,0,0.9];
	[_rc] call dec_applyContext;
};


dec_attachmentList = createHashMapFromArray[
	["head",[
		[[0,0,-0.05],"neck",0.6],
		[[-0.05,-0.08,0.10],"head",0.75]
	]],
	["tors",[
		[[0,0,0],"spine3",1.4],
		[[0.05,0,-0.05],"leftshoulder",0.8],
		[[-0.05,0,-0.05],"rightshoulder",0.8],
		[[0,-0.01,0.1],"pelvis",1.2]
	]],
	["arm_r",[
		[[0,0,0],"rightforearm",0.4],
		[[0,0,0],"rightforearmroll",0.3]
	]],
	["arm_l",[
		[[0,0,0],"leftforearm",0.4],
		[[0,0,0],"leftforearmroll",0.3]
	]],
	["leg_r",[
		[[0,-.03,0],"rightleg",0.5],
		[[0,0,0],"rightupleg",0.7],
		[[0,0,0],"rightfoot",0.6]
	]],
	["leg_l",[
		[[0,-.03,0],"leftleg",0.5],
		[[0,0,0],"leftupleg",0.7],
		[[0,0,0],"leftfoot",0.6]
	]]
];

dec_reloadThis = {
	call compile preprocessfilelinenumbers "src\client\Rendering\Decals\Decals_init.sqf";
};
dec_genattachments = {
	if !isNull(dec_attdata) then {
		_d = "test" call dec_getRenderContext;
		(allcontrols _d) apply {ctrldelete _x};
		deletevehicle dec_attdata;
	};
	dec_attdata = [];
	{
		{
			_x params ["_pos","_slot","_size"];
			_o = call dec_makeSphere;
			dec_attdata pushBack _o;
			[_o,"test"] call dec_setRenderTarget;
			_o attachto [player,_pos,_slot,true];
			_o setobjectscale _size;
		} foreach _y;
	} foreach dec_attachmentList;
};

dec_makePlane = {
	private _o = createSimpleObject ["BloodSplatter_01_Small_New_F",[0,0,0],true];

	_o
};
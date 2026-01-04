// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\engine.hpp>
#include <..\..\WidgetSystem\widgets.hpp>

#ifdef EDITOR
	#include "Decals_debug.sqf"
#endif

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
		//if (_foreachIndex> 0)exitWith{};
		[player,_foreachIndex,"uni_"+(str _foreachIndex)] call dec_setRenderTarget2;
	} foreach (getobjecttextures player);
};

dec_setRenderTarget2 = {
	params ["_o","_ind","_rtName"];
	private _orig = _o getobjecttextures [_ind] select 0;
	_o setObjectTexture [_ind,format ['#(argb,2048,2048,1)uiEx(texType:ca,display:RscDisplayEmpty,uniqueName:%1)', _rtName]];
	//_o setObjectMaterial [_ind,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
	//_o setobjectmaterial [_ind,getobjectmaterials _o select _ind];
	//debug
	private _rc = [_rtName] call dec_getRenderContext;
	(allcontrols _rc) apply {ctrldelete _x};
	private _p = [_rc,PICTURE,[28,23,44,54]] call createWidget;
	_p ctrlsetposition [0,0,1,1];
	_p ctrlcommit 0;
	[_p,_orig] call widgetSetPicture;
	_p = [_rc,PICTURE,WIDGET_FULLSIZE] call createWidget;
	_p ctrlsetposition [0,0,1,1];
	_p ctrlcommit 0;
	_p ctrlsettext inventory_const_dirtOverlayIcon;
	_p ctrlsettextcolor [1,0.4,0,1];
	[_rc] call dec_applyContext;
};

dec_updateUniformRender = {
	params ["_mob","_value"];

	//first initialize for this entity
	private _indUni = _mob getvariable "__dec_internal_index";
	if isNullVar(_indUni) then {
		INC(dec_internal_index);
		_indUni = dec_internal_index;
		_mob setvariable ["__dec_internal_index",_indUni];
	};

	_mob setvariable ["__dec_internal_targetValue",_value];
	private _curUniform = uniform _mob;
	if (not_equals(_curUniform,_mob getvariable vec2("__dec_internal_curUniform",""))) then {
		//cleanup
		private _tpack = [];
		if (_curUniform != "") then {
			//save original texture
			{	
				private _rtName = [_indUni,_foreachIndex] call dec_getRenderLayerName;
				(getTextureInfo _x) params ["_texW","_texH"];
				if (_texW > 0 
					&& {_texH > 0}
					&& {_texW % 2 == 0}
					&& {_texH % 2 == 0}
				) then {
					//инициализируем процедурную текстуру чтобы в следующем кадре она применилась
					_mob setObjectTexture [_foreachIndex,
						format['#(argb,%2,%3,1)uiEx(texType:ca,display:RscDisplayEmpty,uniqueName:%1)', _rtName,_texW,_texH]
					];
				};

				_tpack pushBack _x;
			} foreach (getObjectTextures _mob);
		};
		_mob setvariable ["__dec_internal_origTextures",_tpack];
	};
	_mob setvariable ["__dec_internal_curUniform",_curUniform];

	//обновляем текстуру с задеркжой (исключаем проблему синхронизации со стороны сервера)
	private _applyFnc = {
		params ["_mob","_value","_curUniform","_attempt","_thisFnc"];
		
		if (isNullReference(_mob)) exitWith {};

		if (_curUniform != uniform _mob) exitWith {};//другая одежда - мы не имеем права ее обновлять
		//униформа отличается от примененной - а потому мы не имеем права ее обновлять
		if (_curUniform != (_mob getvariable vec2("__dec_internal_curUniform",""))) exitWith {};
		
		private _targetValue = _mob getvariable ["__dec_internal_targetValue",0];
		if not_equals(_targetValue,_value) exitWith {}; //желаемое отличается от заданного - значит желаемое установится в след.кадре

		private _indUni = _mob getvariable "__dec_internal_index";
		if isNullVar(_indUni) exitWith {}; //не должно быть, но на всякий случай

		private _failed = false;
		private _needRestore = false;
		{
			private _rtName = [_indUni,_foreachIndex] call dec_getRenderLayerName;
			private _rc = [_rtName] call dec_getRenderContext;
			if isNullReference(_rc) exitWith {
				INC(_attempt);
				_failed = true;
			};
			if !([_mob,_x,_foreachIndex,_targetValue] call dec_setRenderGerms) exitWith {
				_failed = true;
			};
		} foreach (_mob getvariable ["__dec_internal_origTextures",[]]);

		if (_failed) then {
			if (_attempt >= 10) exitWith {
				errorformat("Decals: Failed to apply decals to entity %1 after %2 attempts; Mobset index is %3",_mob arg _attempt arg _indUni);
				_needRestore = true;
			};
			traceformat("Decals: Failed to apply decals to entity %1 (attempt %2); Mobset index is %3",_mob arg _attempt arg _indUni);
			nextFrameParams(_thisFnc,[_mob arg _value arg _curUniform arg _attempt arg _thisFnc]);
		};
		if (_needRestore) then {
			{
				_mob setObjectTexture [_foreachIndex,_x];	
			} foreach (_mob getvariable ["__dec_internal_origTextures",[]]);
		};
		
	};
	//nextFrameParams(_applyFnc,[_mob arg _value arg _curUniform arg 1 arg _applyFnc]);
	[_mob arg _value arg _curUniform arg 1 arg _applyFnc] call _applyFnc;

};

//! Вероятно эта функция вызывает графические артефакты при первом вызове\первой установке для сущности
dec_resetUniformRender = {
	params ["_mob"];
	{
		_mob setObjectTexture [_foreachIndex,"#reset"];
	} foreach (getobjecttextures _mob);
};

dec_internal_index = 0;
dec_internal_const_pathPicture = PATH_PICTURE("textures\cloth_dirt.paa");

if (!fileExists(dec_internal_const_pathPicture)) then {
	errorformat("Decals: Picture %1 not found",dec_internal_const_pathPicture);
	if isNull(inventory_const_dirtOverlayIcon) exitWith {
		error("Decals: Backward compatibility picture not found at dec_internal_const_pathPicture");
	};
	dec_internal_const_pathPicture = inventory_const_dirtOverlayIcon; //backward compatibility
};

dec_getRenderLayerName = {
	params ["_indUni","_index"];
	format["dec_entity_%1_layer_%2",_indUni,_index];
};

dec_setRenderGerms = {
	params ["_mob","_tex","_index","_value"];
	private _indUni = _mob getvariable "__dec_internal_index";
	
	if isNullVar(_indUni) exitWith {
		error("Decals: Entity index not found");
		false
	};
	
	private _rtName = [_indUni,_index] call dec_getRenderLayerName;
	
	private _setError = {
		errorformat("Decals: Texture %1 is invalid format",_tex);
	};

	private _success = false;
	if (_tex != "") then {

		(getTextureInfo _tex) params ["_texW","_texH"];

		//check invalid format
		if (_texW <= 0 || _texH <= 0) exitWith {call _setError};
		if (_texW % 2 != 0 || _texH % 2 != 0) exitWith {call _setError};
		
		private _rc = [_rtName] call dec_getRenderContext;

		//при первой установке новой процедурной текстуры контекст еще не создан (появится в следующем кадре)
		if isNullReference(_rc) exitWith {
			private _fd = [_mob getvariable vec2("__dec_internal_curUniform","UNDEFINED"),uniform _mob];
			private _td = [_tex,_value,_index,_texW,_texH];
			errorformat("Decals: Render context %1 not found; formdata: %2; texture data: %3",_rtName arg _fd arg _td);
		};

		//force delete all widgets
		(allcontrols _rc) apply {ctrldelete _x};

		//recreate background (original texture)
		private _p = [_rc,PICTURE,WIDGET_FULLSIZE] call createWidget;
		_p ctrlsetposition [0,0,1,1];
		_p ctrlcommit 0;
		[_p,_tex] call widgetSetPicture;

		//create foreground (dirt overlay)
		_p = [_rc,PICTURE,WIDGET_FULLSIZE] call createWidget;
		_p ctrlsetposition [0,0,1,1];
		_p ctrlcommit 0;
		_p ctrlsettext dec_internal_const_pathPicture;

		//colorize foreground
		private _aval = ["423c13"] call color_HTMLtoRGB;
		_aval pushback clamp(_value,0,1);
		_p ctrlsettextcolor _aval;

		//update uiEx
		[_rc] call dec_applyContext;

		_success = true;
	};

	_success
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

#ifdef DEBUG

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

	#define DECAL_SPHERE_CONFIG "Sign_Sphere25cm_F"

	dec_makeSphere = {
		private _o = createSimpleObject [DECAL_SPHERE_CONFIG,[0,0,0],true];

		_o
	};

#endif
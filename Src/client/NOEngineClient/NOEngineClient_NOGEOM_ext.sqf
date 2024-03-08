// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//Режим отладки NGO позволяет видеть скриптовую геометрию 
//#define NOE_NGO_DEBUG_MODE
//тоже что и выше но для нго-шек в грабнутых мобах
//#define NOE_NGOEXT_DEBUG_MODE


#ifndef DEBUG
	#undef NOE_NGO_DEBUG_MODE
	#undef NOE_NGOEXT_DEBUG_MODE
#endif

//Список моделей без геометрии
#include <..\..\host\NOEngine\NOEngine_NGO.hpp>


NGOExt_create = {
	params ["_obj","_vec",["_imode",false]];
	
	private _bnd = "block_dirt" createVehicleLocal [0,0,0];
	#ifndef NOE_NGOEXT_DEBUG_MODE
	_bnd hideObject true;
	#endif
	
	//_bnd attachto [_obj,_vec];
	_bnd setVariable ["__ngoext_itt",_imode];
	_bnd disableCollisionWith player;
	//_obj setVariable ["ngo_geom",_bnd];
	_bnd setVariable ["ngo_src",_obj];
	_bnd setVariable ["ref",_obj getVariable "ref"];
	#ifndef NOE_NGOEXT_DEBUG_MODE
		_bnd setObjectTexture [0,""]; _bnd setObjectMaterial [0,""];
		_bnd hideObject false;
	#endif
	
	//_bnd enableSimulation false;
	
	_bnd
};

noe_client_ngo_check = {
	params ["_obj","_model"];
	
	if (_model in noe_client_map_ngoext) then {
		
		(noe_client_map_ngoext get _model) params ["_vec","_scale","_class"];
		if equals(_obj getVariable ["ngo_geom" arg objNull],objNull) then {
			private _bnd = _class createVehicleLocal [0,0,0];
			#ifndef NOE_NGO_DEBUG_MODE
			_bnd hideObject true;
			#endif
			_bnd attachto [_obj,_vec];
			_bnd setObjectScale _scale;
			_bnd disableCollisionWith player;
			_obj setVariable ["ngo_geom",_bnd];
			_bnd setVariable ["ngo_src",_obj];
			_bnd setVariable ["ref",_obj getVariable "ref"];
			#ifndef NOE_NGO_DEBUG_MODE
				_bnd setObjectTexture [0,""]; _bnd setObjectMaterial [0,""];
				_bnd hideObject false;
			#endif
		} else {
			private _bnd = _obj getVariable "ngo_geom";
			#ifndef NOE_NGO_DEBUG_MODE
			_bnd hideObject true;
			#endif
			_bnd attachto [_obj,_vec];
			_bnd setObjectScale _scale;
			_bnd disableCollisionWith player;
			_bnd setVariable ["ngo_src",_obj];
			_bnd setVariable ["ref",_obj getVariable "ref"];
			#ifndef NOE_NGO_DEBUG_MODE
				_bnd setObjectTexture [0,""]; _bnd setObjectMaterial [0,""];
				_bnd hideObject false;
			#endif
		};
		
		
	};	
};

// helpers functions

// check if is ngo object
noe_client_isNGO = {!isNullReference(_this getVariable vec2("ngo_src",objNull))};

// getting ngo 
noe_client_getNGOSource = {_this getVariable ["ngo_src",objnull]};
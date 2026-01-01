// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <NOEngine_NGO.hpp>

//Режим отладки NGO позволяет видеть скриптовую геометрию 
//#define NOE_NGO_DEBUG_MODE
//тоже что и выше но для нго-шек в грабнутых мобах
//#define NOE_NGOEXT_DEBUG_MODE

/*
#ifndef DEBUG
	#undef NOE_NGO_DEBUG_MODE
	#undef NOE_NGOEXT_DEBUG_MODE
#endif
*/

//серверный модуль создания геометрии. для специализированных объектов геометрия на сервере скрывается в любом случае.
// ! ВНИМАНИЕ ! Метод копирует функционал noe::client::ngo::check с поправкой на именования (во избежании конфликта имен)
// Вызывается из GameObject::initModel()
noe_server_ngo_check = {
	params ["_obj","_model"];
	#ifdef EDITOR
	if (true) exitWith {};
	#endif
	_model = tolower _model;
	if (_model in noe_client_map_ngoext) then {
		
		(noe_client_map_ngoext get _model) params ["_vec","_scale","_class"];
		if equals(_obj getVariable ["srv_ngo_geom" arg objNull],objNull) then {
			private _bnd = _class createVehicleLocal [0,0,0];
			//#ifndef NOE_NGO_DEBUG_MODE
			_bnd hideObject true;
			//#endif
			_bnd attachto [_obj,_vec];
			_bnd setObjectScale _scale;
			_bnd setPhysicsCollisionFlag false;
			_obj setVariable ["srv_ngo_geom",_bnd];
			_bnd setVariable ["srv_ngo_src",_obj];
			_bnd setVariable ["link",_obj getVariable "link"];
			//#ifndef NOE_NGO_DEBUG_MODE
				_bnd setObjectTexture [0,""]; _bnd setObjectMaterial [0,""];
				_bnd hideObject false;
			//#endif
		} else {
			private _bnd = _obj getVariable "srv_ngo_geom";
			//#ifndef NOE_NGO_DEBUG_MODE
			_bnd hideObject true;
			//#endif
			_bnd attachto [_obj,_vec];
			_bnd setObjectScale _scale;
			_bnd setPhysicsCollisionFlag false;
			_bnd setVariable ["srv_ngo_src",_obj];
			_bnd setVariable ["link",_obj getVariable "link"];
			//#ifndef NOE_NGO_DEBUG_MODE
				_bnd setObjectTexture [0,""]; _bnd setObjectMaterial [0,""];
				_bnd hideObject false;
			//#endif
		};
		
		
	};	
};

// helpers functions

// check if is ngo object
noe_server_isNGO = {!isNullReference(_this getVariable vec2("srv_ngo_src",objNull))};

// getting ngo 
noe_server_getNGOSource = {_this getVariable ["srv_ngo_src",objnull]};
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\ServerRpc\serverRpc.hpp>
#include <Medals.h>

/*
	achievements system
*/

medl_map = hashMapNew;


medl_register = [
	params ["_class","_name","_descr","_delegateCheck"];

	_class = toLower _class;

	if (_class in medl_map) exitWith {
		errorformat("[Medals]: Class '%1' already defined",_class);
	};

	medl_map set [_class,[_name,_descr,_delegateCheck]];
];

//used for checking medal getting condition
// ["test",this,nullPtr] call medl_test
medl_check = {
	params ["_type","_mob","_client"];

	_type = toLower _type;
	if !(_type in medl_map) exitWith {
		errorformat("[Medals]: Cant check medal. Undefine type <%1>",_class);
	};
	//todo check if client already have medal
	0 call((medl_map get _type) select 2);
};

_map = [];
#include "Medals_decl.sqf"
;

{
	_x call medl_register;
} foreach _map;

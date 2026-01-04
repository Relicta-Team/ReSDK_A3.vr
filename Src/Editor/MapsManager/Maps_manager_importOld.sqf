// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

init_function(mm_importOld_mainInit)
{
	mm_list_edConnected = [];
}

//с этого места в функциях доступна переменная хэша _hash

#define customProps (_hash get "customProps")
#define saveHashes [_o,_hash] call golib_setHashData;

function(mm_importOld_postCreated)
{
	params ["_o"];
	if ("edConnected" in _hash) then {
		_conSrc = _hash get "edConnected";
		_hash deleteat "edConnected";
		saveHashes;

		mm_list_edConnected pushback [_o,_conSrc select 0]
	};
}

//инициализатор хэша и возвращение его
function(mm_importOld_initHashData)
{
	params ["_o","_cls"];
	[_o,_cls] call golib_initHashData;
}

function(mm_importOld_regVar)
{
	params ["_o","_vname","_val"];
	_vname = tolower _vname;
	if (_vname == "model") exitWith {
		
		customProps set [_vname,_val];
		saveHashes;

		// private _pos = _oInt call golib_om_getPosition;
			
		// private _obj = create3DENEntity ["Object",_val, _pos];
		
		// if ((format["%1",_obj]) == "<null>") exitWith {
		// 	["Не удалось заменить модель. Для подробностей смотрите лог-консоль"] call showWarning;
		// 	["Cant create eden entity by config %1. It is recommended to cancel the last actions.",_val] call printError;
		// };
		
		// private _rot = _oInt call golib_om_getRotation;
		// private _data = [_oInt,true] call golib_getHashData;
		// delete3DENEntities [_oInt];
		
		// [_obj,_data] call golib_setHashData;
		// [_obj,_pos] call golib_om_setPosition;
		// [_obj,_rot] call golib_om_setRotation;
		
		// [_obj] call golib_om_internal_handleTransformEvent;

		// //update references
		// _hash = [_obj] call golib_getHashData;
		// _o = _obj;
	};

	customProps set [_vname,_val];
	saveHashes;
}

function(mm_importOld_regFunc)
{
	params ["_o","_vname",["_args",[]]];
	_vname = tolower _vname;
	if (_vname == "connectTo") exitWith {
		private _list = _hash getOrDefault ["edConnected",[]];
		_list pushBack (_args select 0);
		_hash set ["edConnected",_list];
		saveHashes;
	};
	if (_vname == "createItemInContainer") exitWith {
		_args params ["_class","_amnt","_prob","_custom"];
		
		private _data = _hash;
		_refContent = _data getOrDefault ["containerContent",[]]; //получаем по ссылке данные
		_internalHash = [objNull,_class,false] call golib_initHashData;
		
		if !isNullVar(_prob) then {
			_internalHash set ["prob",_prob];
		};
		if !isNullVar(_custom) then {
			{
				_x params ["_t","_name","_vals"];
				if (_t == "var") then {
					_internalHash get "customProps" set [tolower _name,_vals];
				} else {
					["ERROR ON PARSING CONTAINER OBJECT %1 (%2)",_hash get "class",_x] call printError;
				};
			} foreach _custom;
		};

		_serializedHash = [_internalHash] call golib_serializeHashData;
		//validate
		if !([_data,_serializedHash,_refContent] call golib_attributes_container_content_validateAdd) exitwith {
			// validate failed
		};

		

		_refContent pushBack [
			_serializedHash,
			_amnt
		]; //добавляем в массив элемент
		_data set ["containerContent",_refContent];
		saveHashes;
	};
	if (_vname == "lightSetMode") then {
		customProps set ["lightisenabled",_args select 0];
		saveHashes;
	};
	
}

function(mm_importOld_regRDIR)
{
	params["_o"];	
	_hash set ["rdir",true];
	saveHashes;
}

function(mm_importOld_regRSPAWN)
{
	params ["_o","_val"];
	_val = _val * 100; //там всё в нормированных от 0 до 1
	_hash set ["prob",_val];
	saveHashes;
}

function(mm_importOld_regRPOS)
{
	params ["_o","_val"];
	_hash set ["rpos",_val];
	saveHashes;
	
}

function(mm_importOld_regMARK)
{
	params ["_o","_mark"];
	_hash set ["mark",_mark];
	saveHashes;
}



function(mm_doImportOldMap)
{
	mm_list_edConnected = [];

	call compile preprocessFileLineNumbers "src\Editor\MapsManager\MM_CONTENT.sqf";

	call golib_cs_syncMarks;

	{
		_hash = [_x select 0,false] call golib_getHashData;
		_newMark = _hash getOrDefault ["mark","NULL_MARK_ON_POST_CREATED"];
		if (_newMark == "NULL_MARK_ON_POST_CREATED") then {
			_hash set ["mark","Imported " + (_hash get "class") + str randInt(1,999999)];
			_newMark = _hash get "mark";
			[_x select 0,_hash] call golib_setHashData; 
		};
		mm_list_edConnected select _foreachIndex set [0,_newMark];
	} foreach mm_list_edConnected;

	{
		_x params ["_from","_to"];
		[_from call golib_cs_getObjectByMark,_to call golib_cs_getObjectByMark] call golib_en_connectObjects;
	} foreach mm_list_edConnected;
}


#undef customProps
#undef saveHashes
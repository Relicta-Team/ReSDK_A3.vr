// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(NOEngine.Client.ObjectManager,noe_client_)

decl(mesh(...any[]))
noe_client_spawnObject = {
	//_chunkObject and _chunkObjData is out reference
	(_this select chunk_objectData_transform) params ["_ref","_isSimple","_model","_pos","_dir","_vec",["_light",0],["_anim",null],["_radio",null]];
	
	if equalTypes(_model,0) exitWith {
		error("NOEngineClient::SpawnObject() - Not implemented exception: only string for create model (NOT NUMBER)");
	};
	
	_obj = if (_isSimple) then {createSimpleObject[_model,[0,0,0],true]} else {_model createVehicleLocal[0,0,0]};
	
	_obj setVariable ["ref",_ref];
	//_obj setVariable ["chunkObjRef",_chunkObject]; //Legacy 0.4.51 - Ссылка на чанк-владелец
	
	#ifdef NOE_CLIENT_THREAD_DEBUG
		_obj setVariable ["create_flag","create"];
		_obj setVariable ["last_update_flag",tickTime];
	#endif
	
	_this set [chunk_objectData_ptr,_obj];
	
	noe_client_allPointers set [_ref,_obj];
	
	if (count _pos == 4) then {
		_obj setPosWorld (_pos select [0,3]);
	} else {
		_obj setPosAtl _pos;
	};
	
	if equalTypes(_dir,0) then {
		_obj setDir _dir;
		_obj setVectorUp _vec;
	} else {
		_obj setVectorDirAndUp [_dir,_vec];
	};
	
	//create geom if need
	[_obj,_model] call noe_client_ngo_check;
	
	//light load
	if (_light > 0) then {
		[_light,_obj] call le_loadLight;
	};
	
	//animate
	if !isNullVar(_anim) then {
		//validate count anims
		if (count _anim % 3 != 0) exitWith {errorformat("NOEngineClient::SpawnObject() - animations count error - %1",count _anim)};	
		private _curanm=[];
		for "_i" from 0 to (count _anim) step 3 do {
			if not_equals(_anim select _i,-1) then {
				_curanm = [_anim select _i,_anim select (_i+1),true]; //fast spawn
				//_curanm set [2,100]; //faster on spawn
				_obj animate _curanm;
			} else {
				//warning("NOEngineClient::SpawnObject() - animation empty data find");
			};
		};

	};
	
	//radio
	if !isNullVar(_radio) then {
		[_obj,_radio,_obj getVariable "ref"] call vs_loadWorldRadio;
	} else {
		if (_obj call vs_isWorldRadioObject) then {[_obj] call vs_unloadWorldRadio};
	};
	
	_obj
};

//Обновляет объект
decl(void(...any[]))
noe_client_updateObject = {
	//_chunkObject is out reference
	(_this select chunk_objectData_transform) params ["_ref","_isSimple","_model","_pos","_dir","_vec",["_light",0],["_anim",null],["_radio",null]];
	private _obj = _this select chunk_objectData_ptr;
	
	// 0.4.50 deprecated sample
	/*if (_ref in noe_client_allPointers) then {
		private _oldObj = noe_client_allPointers get _ref;
		if not_equals(_chunkObject,_oldObj getVariable "chunkObjRef") then {
			//unsubscribe prev chunk
			chunk_getObjectsData(_oldObj getVariable "chunkObjRef") deleteAt _ref;
			deleteVehicle _oldObj;
		};
	};*/
	
	//traceformat("handle update object: %1",_this)
	if equals(_obj,objNUll) then {
		//? не актуально так как обновление с созданием допускается
		//warningformat("NOEngineClient::updateObject() - Object %1 is null",criptPtr(_ref));
		_obj = if (_isSimple) then {createSimpleObject[_model,[0,0,0],true]} else {_model createVehicleLocal[0,0,0]};
		_obj setVariable ["ref",_ref];
		//_obj setVariable ["chunkObjRef",_chunkObject]; //Legacy 0.4.51 - Ссылка на чанк-владелец

		_this set [chunk_objectData_ptr,_obj];
		
		noe_client_allPointers set [_ref,_obj];
		#ifdef NOE_CLIENT_THREAD_DEBUG
			_obj setVariable ["create_flag","update"];
		#endif
	};	
	
	#ifdef NOE_CLIENT_THREAD_DEBUG
	_obj setVariable ["last_update_flag",tickTime];
	#endif

	_obj setVariable ["origData",(_this select chunk_objectData_transform)];

	if (_ref in noe_client_set_lockedPropUpdates) exitWith {};
	
	if (count _pos == 4) then {
		_obj setPosWorld (_pos select [0,3]);
	} else {
		_obj setPosAtl _pos;
	};
	
	if equalTypes(_dir,0) then {
		_obj setDir _dir;
		_obj setVectorUp _vec;
	} else {
		_obj setVectorDirAndUp [_dir,_vec];
	};
	
	//create or update geom
	[_obj,_model] call noe_client_ngo_check;
	
	if (_light > 0) then {
		[_light,_obj] call le_loadLight;
	} else {
		if ([_obj] call le_isLoadedLight) then {
			[_obj] call le_unloadLight;
		};
	};
	
	//animate
	if !isNullVar(_anim) then {
		#ifdef DEBUG_MESSAGE_NOE
		traceformat("anim was %1",_anim)
		#endif
		//validate count anims
		if (count _anim % 3 != 0) exitWith {errorformat("NOEngineClient::UpdateObject() - animations count error - %1",count _anim)};	
		private _curanm=[];
		for "_i" from 0 to (count _anim) step 3 do {
			if not_equals(_anim select _i,-1) then {
				_curanm = [_anim select _i,_anim select (_i+1),_anim select (_i+2)];
				_obj animate _curanm;
			} else {
				//warning("NOEngineClient::UpdateObject() - animation empty data find");
			};
		};

	};
	
	//radio
	if !isNullVar(_radio) then {
		[_obj,_radio,_obj getVariable "ref"] call vs_loadWorldRadio;
	} else {
		if (_obj call vs_isWorldRadioObject) then {[_obj] call vs_unloadWorldRadio};
	};
};

decl(void(vector2;int;any[]))
noe_client_despawnObjectsInChunk = {
	params ["_chunk","_type","_chunkObject"];
	
	[_chunk,_type] call noe_client_unsubscribeChunkListening;
	
	private _odel = [];
	private _objData = chunk_getObjectsData(_chunkObject);
	private _object = objNull;
	{
		_object = _y select chunk_objectData_ptr;
		_odel pushBack _object;
		//removing geometry from custom objects
		if not_equals(_object getVariable ["ngo_geom" arg objNull],objNull) then {
			_odel pushBack (_object getVariable "ngo_geom");
		};
		noe_client_allPointers deleteAt _x;
		[_object] call vs_unloadWorldRadio;
		//0.7.690 - scripted effects without perframe check null
		if ([_object] call le_isLoadedLight) then {[_object] call le_unloadLight;};
		_y set [chunk_objectData_ptr,objNUll];
		
		//_objData deleteat _x;
	} foreach _objData;
	
	chunk_setProgress(_chunkObject,CHUNK_PROGRESS_NOTLOADED);
	chunk_setLoadingState(_chunkObject,CHUNK_STATE_NOT_LOADED);
	
	[_odel] call noe_client_remObjsAlg;
	/*_handle = _odel spawn {
		#ifdef NOE_CLIENT_THREAD_DEBUG
		scriptName "despawn_objs";
		#endif
		{
			deleteVehicle _x;
			stdDelayDelete();//(0.01); //fixed timeout to delete
		} foreach _this;
	};
	#ifdef NOE_CLIENT_THREAD_DEBUG
	noe_debug_allthreads pushBack _handle;
	#endif
	_handle*/
};

decl(void(any[];string[]))
noe_client_doRemoveObjects = {
	params ["_chunkObject","_listPtr"];
	
	private _odel = [];
	private _ptrDat = null;
	private _object = objNull;
	_objData = chunk_getObjectsData(_chunkObject);
	{
		_ptrDat = _objData get _x;
		if (!isNullVar(_ptrDat)) then {
			_object = _ptrDat select chunk_objectData_ptr;
			_odel pushBack _object;
			#ifdef NOE_CLIENT_THREAD_DEBUG
			_object setVariable ['mark_del',true];
			#endif
			//removing geometry from custom objects
			if not_equals(_object getVariable ["ngo_geom" arg objNull],objNull) then {
				_odel pushBack (_object getVariable "ngo_geom");
				#ifdef NOE_CLIENT_THREAD_DEBUG
				(_object getVariable "ngo_geom") setVariable ['mark_del',true];
				#endif
			};
			
			/*
				Если глобальный указатель на объект не равен ссылке _object
				значит ранее объект был обновлён
			*/
			if equals(_object,noe_client_allPointers get _x) then {
				noe_client_allPointers deleteAt _x;
			} 
			#ifdef DEBUG
			else {
				//Обновление объекта спровоцировало подмену объекта в таблице (к примеру объект сменил чанк)
				warningformat("Object reference %1 will not be deleted, since the specified object is not the one that the reference points to",criptPtr(_x));
			}
			#endif
			;
			
			[_object] call vs_unloadWorldRadio;
			//0.7.690 - scripted effects without perframe check null
			if ([_object] call le_isLoadedLight) then {[_object] call le_unloadLight;};
			_objData deleteAt _x;
		} else {
			//hide alg pointer
			private _hiderPtr = criptPtr(_x);
			//to convert use:	 toString (toArray "0x0000000" apply {_x - 16});
			errorformat("NOEngineClient::doRemoveObjects() - Null pointer %1 in chunk storage",_hiderPtr);
		};	
	} foreach _listPtr;
	
	[_odel] call noe_client_remObjsAlg;
	/*_handle = _odel spawn {
		#ifdef NOE_CLIENT_THREAD_DEBUG
		scriptName "del_objs";
		#endif
		{
			deleteVehicle _x;
		} foreach _this;
	};
	#ifdef NOE_CLIENT_THREAD_DEBUG
	noe_debug_allthreads pushBack _handle;
	#endif
	_handle*/
};

//сколько объектов удаляется за цикл
macro_const(noe_client_deleteObjectsCount)
#define NOE_CLIENT_DELETEOBJS_COUNT 50
//задержки между удалениями объектов
macro_const(noe_client_deleteObjectsDelay)
#define NOE_CLIENT_DELETEOBJS_DELAY 0.2

decl(void(mesh[]))
noe_client_remObjsAlg = {
	params ["_odel"];
	private __delMet__ = {
		{deleteVehicle _x} foreach _this
	};
	private __t__ = 0;
	for "_i" from 0 to (count _odel) - 1 step NOE_CLIENT_DELETEOBJS_COUNT do {
		invokeAfterDelayParams(__delMet__,__t__,_odel select vec2(_i,NOE_CLIENT_DELETEOBJS_COUNT));
		modvar(__t__) + NOE_CLIENT_DELETEOBJS_DELAY;
	};
};

//Обновляет информацию об объектах
decl(void(any[];any[]))
noe_client_doUpdateObjects = {
	params ["_chunkObject","_updObjList"];
	//Ещё одна заглушка
	if !(call noe_client_isEnabled) exitWith {};
	
	_odata = chunk_getObjectsData(_chunkObject);
	
	{
		_x params ["_ptr","_data"];
		__odatast = (_odata get _ptr);
		
		if isNullVar(__odatast) then { //allocate object info
			__odatast = newODataStorage(_data);
			_odata set [_ptr,__odatast];
		};	
		
		__odatast set [chunk_objectData_transform,_data]; //обновление даты обязательно
		__odatast call noe_client_updateObject;
	} foreach _updObjList;
	
	
};

decl(any[](string;bool))
noe_client_debug_findChunkObjectByPointer = {
	params ["_pointer",["_retAsData",false]];
	private _ret = [];
	
	#ifdef DEBUG
	
		{
			_chType = _x;
			_chStorage = noe_client_cs get _chType;
			
			{
				_chId = _x;
				//object list info
				_oData = _y select chunk_objectsData;
				{
					if (_x == _pointer) then {
						if (_retAsData) then {
							_ret pushBack [_x,_oData];
						} else {
							_ret pushBack [format["CH:%1:%2",_chId,_chType],_x];
						};
					};	
				} foreach _oData;
			} foreach _chStorage;
		} foreach noe_client_allChunkTypes;
	#endif
	
	_ret
};	
//DEBUG

decl(string(mesh;bool))
noe_client_getObjPtr = {
	params ["_obj",["_checkNGO",true]];
	if (_checkNGO && {_obj call noe_client_isNGO}) then {
		_obj = _obj call noe_client_getNGOSource;
	};
	_obj getvariable ["ref",""];
};


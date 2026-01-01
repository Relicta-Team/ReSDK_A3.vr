// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(NOEngine.Client.Transport,noe_client_)

/*

				=== EVENTS ===

*/
decl(void())
noe_client_debug_requestLoadChunk = {
	#ifdef DEBUG

	_chunk = [getPosATL player,CHUNK_TYPE_ITEM] call noe_posToChunk;
	_obj = [_chunk,CHUNK_TYPE_ITEM] call noe_client_getPosChunkToData;

	[_chunk,CHUNK_TYPE_ITEM,_obj] call noe_client_requestLoadChunk;
	#endif
};


// to server
decl(void(vector2;int;any[]))
noe_client_requestLoadChunk = {
	params ["_chunk","_type","_chunkObject"];

	_id = [_chunkObject] call noe_client_generatePacketId;

	_tick = [_chunk,_type] call noe_client_GetChunkLastUpdate;

	rpcSendToServer("requestChunkLoad",[clientOwner arg _chunk arg _type arg _tick arg _id]);
};

decl(void(any[];float))
noe_client_requestDeleteUpdater = {
	params ["_chunkObject","_time"];
	
	chunk_setLastTicktimeDelete(_chunkObject,_time);
	
	chunk_parseNameToPosAndType(chunk_getName(_chunkObject)) params ["_cht","_type"];
	private _packet = [clientOwner,_cht select 0,_cht select 1,_type];
	{
		_packet pushBack _x
	} foreach chunk_getObjectsData(_chunkObject);
	
	rpcSendToServer("reqDelUpdCh",_packet);
};


// to client

decl(void(...any[]))
noe_client_onUpdateChunk = {
	
	//traceformat("packet get %1",_this);
	_id = _this select 0;
	//Защита от загрузки информации когда клиент не подключен
	if !(call noe_client_isEnabled) exitWith {
		popPacketId(_id);
	};
	_time = _this select 1;
	_delTime = _this select 2;
	_this deleteRange [0,3]; //clear packet

	_serializedChunkNameInfo = noe_client_packetsChunks get (str _id);
	_chunkObject = null;
	if isNullVar(_serializedChunkNameInfo) then {
		errorformat("NOEngineClient::onUpdateChunk() - Cant find chunk name by id %1",_id);
	} else {
		_chunkObject = (parseSimpleArray _serializedChunkNameInfo) call noe_client_getPosChunkToData;
	};

	if (popPacketId(_id)) then {

		private _objList = []; private _remList = [];
		if ([_this,_objList,_remList] call noe_client_byteArrToObjStruct) then {

			[_chunkObject,_objList] call noe_client_loadObjects;
			[_chunkObject,_remList] call noe_client_doRemoveObjects;

			chunk_setLoadingState(_chunkObject,CHUNK_STATE_LOADED);
			chunk_setLastTicktimeUpdate(_chunkObject,_time);
			
			if (_delTime != 0 || not_equals(_delTime,chunk_getLastTicktimeDelete(_chunkObject))) then {
				[_chunkObject,_delTime] call noe_client_requestDeleteUpdater;
			};
			
		} else {
			chunk_setLoadingState(_chunkObject,CHUNK_STATE_NOT_LOADED);
			chunk_parseNameToPosAndType(chunk_getName(_chunkObject)) call noe_client_unsubscribeChunkListeningFull;
			error("NOEngineClient::onUpdateChunk() - Exception on unpack data");
			//TODO send server :remove client on chunk
		};

	} else {
		chunk_setLoadingState(_chunkObject,CHUNK_STATE_NOT_LOADED);
		chunk_parseNameToPosAndType(chunk_getName(_chunkObject)) call noe_client_unsubscribeChunkListeningFull;
		errorformat("NOEngineClient::onUpdateChunk() - Unknown packet error %1",_id);
		//TODO send server :remove client on chunk
	};

}; rpcAdd("onupdch",noe_client_onUpdateChunk);

decl(void(...any[]))
noe_client_onUpdateObject = {
	
	//Защита от загрузки информации когда клиент не подключен
	if !(call noe_client_isEnabled) exitWith {};
	
	_xPos = _this select 0;
	_yPos = _this select 1;
	_type = _this select 2;
	_time = _this select 3;
	_this deleteRange [0,4]; //clear packet


	_chunkObject = [[_xPos,_yPos],_type] call noe_client_getPosChunkToData;
	
	if not_equals(chunk_getLoadingState(_chunkObject),CHUNK_STATE_LOADED) exitWith {
		errorformat("noe::client::onUpdateObject() - Cant update object. State was %1",chunk_getLoadingState(_chunkObject));
	};
	
	private _objList = []; private _remList = [];
	if ([_this,_objList,_remList] call noe_client_byteArrToObjStruct) then {

		//if (count _objList > 0) exitWith {
		//	errorformat("NOEngineClient::onUpdateObject() - Not expected objects to load (%1 objs)",count _objList);
		//};
		
		[_chunkObject,_objList] call noe_client_doUpdateObjects;
		[_chunkObject,_remList] call noe_client_doRemoveObjects;

		//[_chunkObject,_objList] call noe_client_loadObjects;

		chunk_setLastTicktimeUpdate(_chunkObject,_time);
	} else {
		error("NOEngineClient::onUpdateObject() - Exception on unpack data");
		//TODO send server :remove client on chunk
	};

}; rpcAdd("onupdob",noe_client_onUpdateObject);

//fncs

//get original object data; see noe_client_updateObject for info
decl(map<string;any>|any[](string;bool))
noe_client_getOrignalObjectData = {
	params ["_ptr",["_retAsHash",true]];
	private _dat = noe_client_allPointers get _ptr;
	if isNullVar(_dat) exitWith {null};
	_dat = _dat getVariable "origData";
	if isNullVar(_dat) exitWith {null};
	if (!_retAsHash) exitWith {_dat};
	//["_ref","_isSimple","_model","_pos","_dir","_vec",["_light",0],["_anim",null],["_radio",null]];
	["ref","isSimple","model","pos","dir","vec","light","anim","radio"] createHashMapFromArray _dat
};

decl(void(string))
noe_client_resetObjectTransform = {
	params ["_ptr"];
	
	private _obj = noe_client_allPointers get _ptr;
	if isNullVar(_obj) exitWith {};
	if isNullReference(_obj) exitWith {};

	private _map = [_ptr,true] call noe_client_getOrignalObjectData;
	if isNullVar(_map) exitWith {};
	private _pos = _map get "pos";
	private _dir = _map get "dir";
	private _vec = _map get "vec";
	private _light = _map get "light";
	private _radio = _map get "radio";

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

	//radio
	if !isNullVar(_radio) then {
		[_obj,_radio,_obj getVariable "ref"] call vs_loadWorldRadio;
	} else {
		if (_obj call vs_isWorldRadioObject) then {[_obj] call vs_unloadWorldRadio};
	};
};

decl(void(mesh|string;string;any))
noe_client_setObjectTransform = {
	params ["_obj","_type","_val"];
	if equalTypes(_obj,"") then {
		_obj = noe_client_allPointers get _obj;
	};
	assert(!isNullReference(_obj));

	if (_type=="pos") exitWith {
		if (count _val == 4) then {
			_obj setPosWorld (_val select [0,3]);
		} else {
			_obj setPosAtl _val;
		};
	};

	if (_type=="dir") exitWith {
		if equalTypes(_dir,0) then {
			_obj setDir _dir;
		};
	};

};

//генерирует пакет который указывает на актуальность действия при коллбеке
decl(int(any[];float))
noe_client_generatePacketId = {
	params ["_chunkObject",["_lifetime",PACKET_LIFETIME]];

	private _packetId = noe_client_packetId;
	INC(noe_client_packetId);
	pushPacketId(_packetId);
	noe_client_packetsChunks set [str _packetId,chunk_getName(_chunkObject)];

	chunk_setLoadingState(_chunkObject,CHUNK_STATE_AWAIT_RESPONSE);

	//auto remove with error
	_remover = {
		params ["_id","_chunkObject","_timeout"];
		//traceformat("%1",chunk_getName(_chunkObject));
		if (popPacketId(_id)) then {
			chunk_setLoadingState(_chunkObject,CHUNK_STATE_NOT_LOADED);
			chunk_parseNameToPosAndType(chunk_getName(_chunkObject)) call noe_client_unsubscribeChunkListeningFull;
			errorformat("NOEngineClient::popPacketId() - Server responding timeout exception. Lifetime packet id %1 was %2 sec",_id arg _timeout);
		} else {
			//traceformat("Request done! %1",_id)
		};
	};
	invokeAfterDelayParams(_remover,_lifetime,[_packetId arg _chunkObject arg _lifetime]);

	_packetId
};

/*#ifdef DEBUG
	noe_client_debug_bytearr_data = ["123",-1,"456",-1];
	noe_client_debug_bytearrTest = {
		_s = []; _rs = [];
		[
			[noe_client_debug_bytearr_data,_s,_rs] call noe_client_byteArrToObjStruct,
			_s,
			_rs
		]
	};
#endif*/

//logging packet content on error
decl(any[])
noe_debug_packeterror = [];

//Конвертирует данные из массива байтов в структуры объектов
decl(any[](any[];any[];any[]))
noe_client_byteArrToObjStruct = {
	params ["_tokens","_struct","_remStruct"];

	FHEADER;

	//_struct = _this select 1;

	//private _tokens = _this select 0;

	//Декодирование пакета:
	/*
		Указатель (строка)
		флаги спавна (float)
		modelreference (string | int)
		pos.x
		pos.y
		pos.z
		dir
			(float)
			vec3
		vecu (vec3 | null)


	*/
	#define debug_calltraceOnErrorConvert

	#ifdef debug_calltraceOnErrorConvert
		inline_macro
		#define callwarn(macroname) warningformat("__DEBUG__::%1() - count tokens %2" + endl + "Data: %3",macroname arg count _tokens arg _tokens);
	#else
		#define callwarn(ma)
	#endif

	inline_macro
	#define tokenIndex _pos
	inline_macro
	#define moveNext() MOD(tokenIndex,+1); if (tokenIndex > (_lastIndex)) then { error("NOEngineClient::byteArrToObjStruct() - Out of range"); callwarn("next") RETURN(false);}
	inline_macro
	#define moveTo(val) MOD(tokenIndex,+val); if (tokenIndex > (_lastIndex)) then { error("NOEngineClient::byteArrToObjStruct() - Out of range"); callwarn("move") RETURN(false); }
	inline_macro
	#define getToken(ch) (_tokens select ch)
	inline_macro
	#define canMove(idx) (idx <= (count _tokens - 1) && idx >= 0)
	inline_macro
	#define getTokenSafe(idx) if canMove(idx) then {getToken(idx)} else {"0x0"}
	inline_macro
	#define getCurToken() getToken(tokenIndex)

	private _lastIndex = count _tokens - 1;
	private _strOne = "1"; private _strZero = "0";
	private _ptr = "";
	private _countAnims = 0;

	private _bufvar = ""; //свободная переменная для записи
	inline_macro
	#define isTrue(val) not_equals(val,_strZero)
	//trace("START");

	for "_pos" from 0 to _lastIndex do {
		if not_equalTypes(getCurToken(),"") then {
			errorformat("NOEngineClient::byteArrToObjStruct() - Convert error. Unexpected type %1, Prev %3; Next %2",typeName getCurToken() arg getTokenSafe(tokenIndex+1) arg getTokenSafe(tokenIndex-1));
			#ifdef DEBUG
			errorformat("NOEngineClient::byteArrToObjStruct() - Errored index %1. Packet copied to noe::debug::packeterror",_pos);
			noe_debug_packeterror = +_tokens;
			#endif

			RETURN(false);
		};
		// _nobject:params ["_ref","_isSimple","_model","_pos","_dir","_vec"];
		_ptr = getCurToken();
		_nobject = [_ptr];
		moveNext(); //from ref to flags

		_bufvar = getCurToken();
		if equals(_bufvar,-1) then {
			_remStruct pushBack _ptr;
			
			//ALL JUMPS COMMENTED AFTER 0.6.207
			//safety moving
			/*if (canMove(tokenIndex + 1)) then {
				moveNext()
			} else {
				break; //критический выход
			};*/
			//modvar(tokenIndex) + 1; //unsafe increment
			continue; //skip iteration
		};

		if not_equalTypes(_bufvar,0) then {
			errorformat("NOEngineClient::byteArrToObjStruct() - Wrong data type %1",typename _bufvar);
			RETURN(false);
		};

		transportFlagsToArray(_bufvar) params ["","",
			["_isSimple",_strOne],["_useWorldPos",_strZero],["_isVectorDir",_strZero],["_hasLight",_strZero],["_hasAnim",_strZero],["_hasRadio",_strZero]
		];
		
		//_nobject pushBack [_isSimple == _strOne,_useWorldPos == _strOne,_isVectorDir == _strOne,_hasLight == _strOne];
		_nobject pushBack isTrue(_isSimple);

		moveNext(); //from flags to object model
		_bufvar = getCurToken();
		if equalTypes(_bufvar,0) then {_bufvar = [_bufvar] call model_getAssoc};
		_nobject pushBack _bufvar;

		moveNext(); //from model to pos vec
		_vec3 = [];

		_vec3 pushBack getCurToken();  //x
		moveNext();

		_vec3 pushBack getCurToken(); //y
		moveNext();

		_vec3 pushBack getCurToken(); //z
		if isTrue(_useWorldPos) then {_vec3 pushBack true};
		_nobject pushBack _vec3;

		moveNext(); //from pos to direction

		if isTrue(_isVectorDir) then {

			_vec3 = [];

			_vec3 pushBack getCurToken();  //x
			moveNext();

			_vec3 pushBack getCurToken(); //y
			moveNext();

			_vec3 pushBack getCurToken(); //z
			_nobject pushBack _vec3;

		} else {
			_nobject pushBack getCurToken();
		};
		moveNext(); //from dir to vup

		if isNull(getCurToken()) then {
			_nobject pushBack [0,0,1];
		} else {
			_vec3 = [];

			_vec3 pushBack getCurToken();  //x
			moveNext();

			_vec3 pushBack getCurToken(); //y
			moveNext();

			_vec3 pushBack getCurToken(); //z
			_nobject pushBack _vec3;
		};
		if (canMove(tokenIndex + 1) && {isTrue(_hasLight) || isTrue(_hasAnim) || isTrue(_hasRadio)}) then {moveNext()}; // from vup to prob light

		//TODO REFRACTORING (переписать и сделать не таким громоздким)
		//_bufvar = getCurToken();
		
		if isTrue(_hasLight) then {
			_nobject pushBack getCurToken();
			if (canMove(tokenIndex + 1) && isTrue(_hasAnim)) then {moveNext()}; //from light to next
			
			if isTrue(_hasAnim) then {
				_countAnims = parseNumber _hasAnim;
				private _vec3Anm = [];
				
				for "_idxAnm" from 1 to _countAnims do {
					_bufvar = getCurToken();
					if not_equals(_bufvar,-1) then {_bufvar = [_bufvar] call anim_getAssoc};
					_vec3 = [_bufvar];
					moveNext(); //from anim name to anim phase
					
					_vec3 pushBack getCurToken();
					moveNext(); //from anim phase to anim speed
					
					_vec3 pushBack getCurToken();
					_vec3Anm append _vec3;
					if (_idxAnm < _countAnims) then {moveNext()}; //to next anim
				};
				_nobject pushBack _vec3Anm;
			};
			
		} else {
			_nobject pushBack 0; //no light
			
			if isTrue(_hasAnim) then {
				_countAnims = parseNumber _hasAnim;
				private _vec3Anm = [];
				
				for "_idxAnm" from 1 to _countAnims do {
					_bufvar = getCurToken();
					if not_equals(_bufvar,-1) then {_bufvar = [_bufvar] call anim_getAssoc};
					_vec3 = [_bufvar];
					moveNext(); //from anim name to anim phase
					
					_vec3 pushBack getCurToken();
					moveNext(); //from anim phase to anim speed
					
					_vec3 pushBack getCurToken();
					_vec3Anm append _vec3;
					if (_idxAnm < _countAnims) then {moveNext()}; //to next anim
				};
				_nobject pushBack _vec3Anm;
				
				//todo hasradio handling
			} else {
				_nobject append [null]; //no anim
				if isTrue(_hasRadio) then {
					private _fqid = getCurToken();
					
					//tokens: [string freq, float volume,float distance, uint radio type, prob [pos.x,..pos.z] | null]
					_vec3 = [_fqid];
					moveNext(); //from freq to vol
					_vec3 pushBack getCurToken();
					moveNext(); // from vol to distance
					_vec3 pushBack getCurToken();
					moveNext(); // from distance to radio type
					_bufvar = RADIO_TYPE_ENUM_TO_STRING(getCurToken());
					_vec3 pushBack _bufvar;
					moveNext(); //from radio type to prob pos
					_bufvar = getCurToken();
					if isNullVar(_bufvar) then {
						_vec3 pushBack [0,0,0];//add bias
					} else {
						// _bufvar = [_bufvar];
						// moveNext(); //from pos.x to pos.y
						// _bufvar pushBack getCurToken();
						// moveNext(); //from pos.y to pos.z
						// _bufvar pushBack getCurToken();
						// _vec3 pushBack _bufvar;//add bias
						_vec3 pushBack _bufvar;
					};
					// if (_fqid < 0) then {
					// 	_vec3 set [0,-_fqid]; //inverse frequency
					// 	moveNext(); //from bias to wave dist
					// 	_bufvar = [getCurToken()];
					// 	moveNext(); //from wave dist to radio type
					// 	_bufvar pushBack getCurToken();
					// 	_vec3 pushBack _bufvar; //add speak function
					// };
					
					_nobject pushBack _vec3;
				};
			};
		};


		//final add object
		//traceformat("Prepare object struct: %1",_nobject)
		_struct pushback [_ptr,_nobject];
	};
	
	#ifdef DEBUG_MESSAGE_NOE
	traceformat("CHUNK CONVERT: LOAD %1 BYTES; REM %2 BYTES",count _struct arg count _remStruct);
	#endif

	true;
};

//производит выписывание клиента из прослушивателей чанка
decl(void(vector2;int))
noe_client_unsubscribeChunkListening = {
	params ["_chunk","_type"];
	rpcSendToServer("unsubChunkListen",[_chunk arg _type arg clientOwner]);
};

decl(void(vector2;int))
noe_client_unsubscribeChunkListeningFull = {
	params ["_chunk","_type"];
	rpcSendToServer("unsubChunkListen",[_chunk arg _type arg clientOwner arg false]);
};

// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define noe_extended_log_reguister
#ifdef noe_extended_log_reguister
	#define noe_log(data,txt) traceformat(data,txt);
#else
	#define noe_log(data,txt)
#endif

//Данный файл служит для обновления или регистрации объектов в чанках

noe_registerObject = {
	params ["_chpos","_cht","_vis"];

	//serialize chunk position to key
	private _refarr_chpos = _chpos; //create clear reference
	_chpos = str _chpos;

	private _ch = getChunkStorage(_cht); //получаем хранилище чанков

	//Вносим объект в массив
	private _chdata = getChunk(_ch,_chpos);
	if isNullVar(_chdata) then {
		_chdata = allocChunk;
		registerChunk(_ch,_chpos,_chdata);
	};

	private _updTime = tickTime;
	private _ptr = getVar(_vis getvariable 'link',pointer);
	chunk_getObjectsData(_chdata) set [_ptr,_vis];
	_vis setVariable ["lastUpd",_updTime];
	chunk_setLastTicktimeUpdate(_chdata,_updTime);


	//В чанке кто-то есть! Ему надо отправить инфу об объекте
	if (!chunk_isEmptyOwnerList(_chdata)) then {
		private _packet = [_refarr_chpos select 0,_refarr_chpos select 1,_cht,_updTime];
		[_packet, _vis] call noe_serializeObjectInfoPacket;

		{
			//second send info
			rpcSendToClient(getVar(_x,id),"onupdob",_packet);
		} foreach chunk_getOwners(_chdata);
	};

	//request for update atmos chunk
	assert_str(!isNullReference(_vis),"Null object in noe::registerObject; ptr -> " + _ptr);
	private _chAtm = [(getposatl _vis)call atmos_chunkPosToId] call atmos_getChunkAtChIdUnsafe;
	if !isNullVar(_chAtm) then {
		_chAtm set ["flagUpdObj",true];
		private _refObj = pointerList get _ptr;
		if !isNullVar(_refObj) then {
			callFunc(_refObj,onUpdatePosition);
		};
	};

	//request update region
	[getposasl _vis] call ai_nav_requestUpdateRegion;
};

//выводим регистрацию объекта
noe_unregisterObject = {
	params ["_chpos","_cht","_ptr",["_deleteVisual",true]];

	private _chunkObject = [_chpos,_cht] call noe_getChunkObject;
	private _vis = chunk_getObjectsData(_chunkObject) get _ptr;
	chunk_getObjectsData(_chunkObject) deleteAt _ptr;

	//update timestamp
	private _updTime = tickTime;
	chunk_setLastTicktimeUpdate(_chunkObject,_updTime);

	//выгружаем у всех клиентов этот объект из чанка
	private _packet = [_chpos select 0,_chpos select 1,_cht,_updTime];
	[_packet, _ptr] call noe_prepareInfoToRemoveObject;

	chunk_setLastTicktimeDelete(_chunkObject,_updTime);

	//Безопасный контекст выгрузки у клиентов ВНУТРИ ЭТОГО ЧАНКА
	{
		rpcSendToClient(getVar(_x,id),"onupdob",_packet);
		true
	} count chunk_getOwners(_chunkObject);

	if (_deleteVisual) then {
		
		if isNullVar(_vis) exitWith {}; //already removed

		//request update region
		[getposasl _vis] call ai_nav_requestUpdateRegion;

		if !isNullObject(_vis getVariable vec2("srv_ngo_geom",objNull)) then {
			deleteVehicle (_vis getVariable "srv_ngo_geom"); //dispose ngo obj
		};
		private _probLight = _vis getVariable ["srv_slt_obj",null];
		if !isNullVar(_probLight) then {
			[_probLight] call slt_destr_impl;
		};
		deleteVehicle _vis;
	};
};

noe_unloadVisualObject = {
	params ["_visObj",["_cht",-1]];
	if (_cht == -1) then {
		_cht = callFunc(_visObj,getChunkType);
	};
	[
		[getPosATL getVar(_visObj,loc),_cht] call noe_posToChunk,
		_cht,
		getVar(_visObj,pointer),
		true //force delete visual
	] call noe_unregisterObject;

};

//загружает визуальный объект в мир (предмет, структуру или декорацию)
noe_loadVisualObject = {
	params ["_item","_posAtl",["_dir",random 360],["_vup",vec3(0,0,1)]];
	if callFunc(_item,isInWorld) exitWith {objnull};
	private _cht = callFunc(_item,getChunkType);
	if (_cht == -1) exitWith {objnull};

	private _visObj = callFuncParams(_item,InitModel,_posAtl arg _dir arg _vup);

	[[_posAtl,_cht] call noe_posToChunk,_cht,_visObj] call noe_registerObject;
	_visObj
};

//загружает визуалку ИТЕМА при выкладывании
noe_loadVisualObject_OnPutdown = {
	params ["_vObj","_posData"];
	_posData params ["_posAtl","_dir","_vec"];

	private _visObj = callFuncParams(_vObj,InitModel,_posAtl arg _dir arg _vec);
	//setVar(_vObj,loc,_posData);
	private _chunk = [_posAtl,CHUNK_TYPE_ITEM] call noe_posToChunk;


	[_chunk,CHUNK_TYPE_ITEM,_visObj] call noe_registerObject;
	_visObj
};

#define DROP_RADIUS 0.6

noe_visual_getRelRadiusPos = {
	params ["_posI",["_dirPos",random 360],["_dropRad",DROP_RADIUS]];
	[(_posI select 0) + (sin _dirPos) * _dropRad, (_posI select 1) + (cos _dirPos) * _dropRad, _posI select 2];
};

noe_loadVisualObject_OnDrop = {


	#define RAY_SIZE_Z 200

	// Если раскоментить, то будут стрелки на лучах с глобальными рефами
	//#define use_trace_ondrop

	params ["_vObj","_vMobOrPos",["_dropRad",DROP_RADIUS],["_goDir",random 360],["_isSafePutdown",false]];

	#ifdef use_trace_ondrop
		#define point(pos) arrow = "Sign_Arrow_F" createVehicle [0,0,0]; arrow pos;
		#define col(_r,_g,_b)
	#else
		#define point(pos)
		#define col(_r,_g,_b)
	#endif

	private _vMob = objNull;
	private _posI = [0,0,0];

	if (_vMobOrPos isEqualType []) then {
		_posI = (ATLToASL _vMobOrPos) vectorAdd [0,0,0.1];
	} else {
		_vMob = _vMobOrPos;
		_posI = (getPosASL _vMob) vectorAdd [0,0,0.1];
	};

	//private _dirPos = random 360;

	if (_isSafePutdown) then {
		if equalTypes(_vMobOrPos,[]) exitWith {
			errorformat("noe::loadVisualObject::OnDrop() - mob is not unit. Skip safepos condition for safeputdown %1",getVar(_vObj,pointer));
		};
		private _sel = ifcheck(equals(getVar(_vObj,slot),INV_HAND_R),"righthand","lefthand");
		_posI = AGLToASL(_vMobOrPos modelToWorld (_vMobOrPos selectionPosition _sel));
		_dropRad = clamp(_dropRad,0,0.05);
	};

	if (_dropRad > 0) then {
		_posI = [_posI,random 360,_dropRad] call noe_visual_getRelRadiusPos;
		//_posI = [(_posI select 0) + (sin _dirPos) * _dropRad, (_posI select 1) + (cos _dirPos) * _dropRad, _posI select 2];
	};

	point(setposasl _posI) col(1,0,0)
	point(setposasl (_posI vectorDiff [0 arg 0 arg RAY_SIZE_Z])) col(0,1,0)

	private _itsc = lineIntersectsSurfaces [_posI,_posI vectorDiff [0,0,RAY_SIZE_Z],_vMob,objNull,true,1,"VIEW","FIRE"];

	#ifdef use_trace_ondrop
		traceformat("PosI %1 %2",_posI arg _itsc);
	#endif

	private _posData = if ((count _itsc) == 0) then {
		#ifdef use_trace_ondrop
		    trace("NO FIND INTERSECTIONS");
		#endif
		[ASLToATL _posI,_goDir,[0,0,1]];
	} else {
		#ifdef use_trace_ondrop
		    trace("NO FIND INTERSECTIONS");
		#endif
		(_itsc select 0) params ["_pos","_vecup","_targ"];
		[ASLToATL _pos,_goDir,_vecup];
	};

	//_posData params ["_posAtl","_dir","_vec"];
	[_vObj,_posData] call noe_loadVisualObject_OnPutdown;

};

//регистрирует освещение на объекте. НЕ ИСПОЛЬЗОВАТЬ В ООП МЕТОДЕ initModel
noe_registerLightAtObject = {
	params ["_obj","_chunkType","_light",["_useUpdate",true]];

	_obj setvariable ["flags",(_obj getvariable "flags") + lightObj_true];
	_obj setvariable ["light",_light];
	[_obj,_light] call slt_create;
	[_obj] call noe_updateObjectByteArr;

	if (_useUpdate) then {
		_chpos = [getPosATL _obj,_chunkType] call noe_posToChunk;
		private _chunkObject = [_chpos,_chunkType] call noe_getChunkObject;

		//update timestamp
		private _updTime = tickTime;
		chunk_setLastTicktimeUpdate(_chunkObject,_updTime);
		_obj setVariable ["lastUpd",_updTime];

		private _packet = [_chpos select 0,_chpos select 1,_chunkType,_updTime];
		[_packet, _obj] call noe_serializeObjectInfoPacket;

		{
			rpcSendToClient(getVar(_x,id),"onupdob",_packet);
		} foreach chunk_getOwners(_chunkObject);
	};
};

//снимает регистрацию света
noe_unregisterLightAtObject = {
	params ["_obj","_chunkType",["_useUpdate",true]];
	_obj setvariable ["flags",(_obj getvariable "flags") - lightObj_true];
	_obj setvariable ["light",null];
	[_obj] call slt_destr;
	[_obj] call noe_updateObjectByteArr;

	if (_useUpdate) then {
		_chpos = [getPosATL _obj,_chunkType] call noe_posToChunk;
		private _chunkObject = [_chpos,_chunkType] call noe_getChunkObject;

		//update timestamp
		private _updTime = tickTime;
		chunk_setLastTicktimeUpdate(_chunkObject,_updTime);
		_obj setVariable ["lastUpd",_updTime];

		private _packet = [_chpos select 0,_chpos select 1,_chunkType,_updTime];
		[_packet, _obj] call noe_serializeObjectInfoPacket;

		{
			rpcSendToClient(getVar(_x,id),"onupdob",_packet);
		} foreach chunk_getOwners(_chunkObject);
	};
};

noe_syncLightAtObject = {
	params ["_obj","_light",["_updateByteArr",false]];
	if isNull(_obj getvariable "light") then { //fix if light is not register
		_obj setvariable ["flags",(_obj getvariable "flags") + lightObj_true];
	};
	_obj setvariable ["light",_light];
	
	//reload serverlight
	[_obj] call slt_destr;
	[_obj,_light] call slt_create;

	if (_updateByteArr) then {
		[_obj] call noe_updateObjectByteArr;
	};
};

// Обновляет информацию о радио. Небезопасный контекст. Возможно переполнение
noe_updateObjectRadio = {
	params ["_obj","_mode"];

	if (_mode) then {
		_obj setvariable ["flags",(_obj getvariable "flags") + radioObj_true];
	} else {
		_obj setvariable ["flags",(_obj getvariable "flags") - radioObj_true];
		_obj setVariable ["radio",null];
	};
};

//Реплицирует изменённое состояние объекта по сети
noe_replicateObject = {
	params ["_obj","_chunkType",["_doUpdateByteArr",false]];

	if not_equalTypes(_obj,objNUll) exitWith {
		errorformat("NOEngine::replicateObject() - Attempt replicate non visual object - %1",_obj);
	};

	// getting chunk position
	private _chpos = [getPosATL _obj,_chunkType] call noe_posToChunk;

	#ifdef DEBUG
	if (!_doUpdateByteArr) exitWith {
		errorformat("CANT UPDATE %1. Update byteArray must be enabled",_obj getVariable 'bytearr');
	};
	#endif

	//Согласно коду byteArray всегда будет обновляться
	if (_doUpdateByteArr) then {

		//checking if object placed in other chunk
		// Новый алгоритм Legacy 0.4.51 реализует синхронизацию и обновление позиций если чанк-владелец этого объекта изменился
		private _ba = (_obj getVariable "bytearr");
		private _ppos = vec2(vec2(_ba select 3,_ba select 4),_chunkType) call noe_posToChunk;

		//Объект перерегистрируется в другой позиции
		if not_equals(_chpos,_ppos) then {
			[_ppos,_chunkType,_ba select 0,false] call noe_unregisterObject;
			//TEST POST REMOVING
			//invokeAfterDelayParams(noe_unregisterObject,3,vec4(_ppos,_chunkType,_ba select 0,false))

			//сначала обновим байтмассив
			[_obj] call noe_updateObjectByteArr;

			//регистрируем объект по новой позиции
			[_chpos,_chunkType,_obj] call noe_registerObject;
		} else {

			//сначала обновим байтмассив
			[_obj] call noe_updateObjectByteArr;

			//синхронизация на текущей позиции

			// getting chunk object
			private _chunkObject = [_chpos,_chunkType] call noe_getChunkObject;

			//update timestamp
			private _updTime = tickTime;
			chunk_setLastTicktimeUpdate(_chunkObject,_updTime);
			_obj setVariable ["lastUpd",_updTime];

			private _packet = [_chpos select 0,_chpos select 1,_chunkType,_updTime];
			[_packet, _obj] call noe_serializeObjectInfoPacket;

			{
				rpcSendToClient(getVar(_x,id),"onupdob",_packet);
			} foreach chunk_getOwners(_chunkObject);
			
		};

	};


};

noe_replicateTransform = {
	params ["_obj","_chunkType",["_doUpdateByteArr",false]];
	setLastError("Not implemented - noe::replicateTransform");

	if not_equalTypes(_obj,objNUll) exitWith {
		errorformat("NOEngine::replicateTransform() - Attempt replicate non visual object - %1",_obj);
	};

	// getting chunk position
	private _chpos = [getPosATL _obj,_chunkType] call noe_posToChunk;

	#ifdef DEBUG
	if (!_doUpdateByteArr) exitWith {
		errorformat("CANT UPDATE %1. Update byteArray must be enabled",_obj getVariable 'bytearr');
	};
	#endif

	//Согласно коду byteArray всегда будет обновляться
	if (_doUpdateByteArr) then {

		//checking if object placed in other chunk
		// Новый алгоритм Legacy 0.4.51 реализует синхронизацию и обновление позиций если чанк-владелец этого объекта изменился
		private _ba = (_obj getVariable "bytearr");
		private _ppos = vec2(vec2(_ba select 3,_ba select 4),_chunkType) call noe_posToChunk;

		//Объект перерегистрируется в другой позиции
		if not_equals(_chpos,_ppos) then {
			[_ppos,_chunkType,_ba select 0,false] call noe_unregisterObject;
			//сначала обновим байтмассив
			[_obj] call noe_updateObjectByteArr;
			//регистрируем объект по новой позиции
			[_chpos,_chunkType,_obj] call noe_registerObject;
		} else {

			//сначала обновим байтмассив
			[_obj] call noe_updateObjectByteArr;

			//синхронизация на текущей позиции

			// getting chunk object
			private _chunkObject = [_chpos,_chunkType] call noe_getChunkObject;

			//update timestamp
			private _updTime = tickTime;
			chunk_setLastTicktimeUpdate(_chunkObject,_updTime);
			_obj setVariable ["lastUpd",_updTime];

			private _packet = [_chpos select 0,_chpos select 1,_chunkType,_updTime];
			private _bytearr = _obj getVariable "bytearr";
			_packet pushBack (_bytearr select 0);//ptr
			_packet pushBack (_obj getvariable ["wpos",false]);//worldpos
			_packet pushBack (_bytearr select 3);//posworld
			_packet pushBack (_bytearr select 4);//vdir
			_packet pushBack (vectorDirVisual _obj);//vup

			{
				rpcSendToClient(getVar(_x,id),"onupdtr",_packet);
			} foreach chunk_getOwners(_chunkObject);

			//request update region
			[getposasl _obj] call ai_nav_requestUpdateRegion;
		};

	};


};

//Сохраняет данные об объекте в специальном массиве
noe_updateObjectByteArr = {
	params ["_obj"];

	if (isNullVar(_obj) || {isNullReference(_obj)}) exitWith {
		errorformat("noe::updateObjectByteArr() - null ptr object %1 (%2) pos::%3",_obj arg this arg _pos);
	};

	private _itRef = _obj getvariable "link";
	//указатель
	private _dat = [getVar(_itRef,pointer)];
	//флаги
	_dat pushBack (_obj getvariable "flags");
	//ссылка на модель
	_dat pushBack ([getVar(_itRef,model)] call model_getAssoc); //создать ассоциации
	//позиция
	_dat append (if (_obj getvariable ["wpos",false]) then {getPosWorldVisual _obj} else {getPosATLVisual _obj});
	//направление
	_dat append (if (_obj getvariable ["vdir",false]) then {vectorDirVisual _obj} else {[getDirVisual _obj]});
	//вектор поворота
	private _vecuv = vectorUpVisual _obj;
	if equals(vec3(0,0,1),_vecuv) then {_vecuv = [null]};
	_dat append _vecuv;

	//light
	if ((_obj getvariable ["light",0]) > 0) then {
		_dat pushBack (_obj getvariable ["light",0]);
	};

	//anim
	if (_obj getvariable ["dyn",false]) then {
		_dat append getVar(_itRef,serializedAnim);
	};

	//radio
	if (count (_obj getVariable ["radio",[]]) > 1) then {
		_dat append (_obj getVariable ["radio",[null]])
	};

	_obj setvariable ["bytearr",_dat];
};


_noe_requestChunkLoad = {
	params ["_owner","_chunk", "_type", "_tick", "_id"];

	//быстрое получение клиента. Невомзожность получения отбросит пакет.
	__chunk_getClientSafe(_cli,_owner,"NOEngine::requestChunkLoad()");

	//получаем объект чанка
	_chObj = [_chunk,_type] call noe_getChunkObject;

	_cbPacket = [_id];

	//Генерим пакет
	[_chObj,_tick,_cbPacket,nullPtr] call noe_serializeChunkInfoToPacket;

	//Пересылаем пакет обратно клиенту
	rpcSendToClient(_owner,"onupdch",_cbPacket);

	//Добавляем владельца чанка
	chunk_getOwners(_chObj) pushBackUnique _cli;
	//вписываемся в список просмотра
	getVar(_cli,loadedChunks) set [str[_chunk,_type],0];
	//traceformat("RCHL-added chunk: %1; curcnt: %2",str vec2(_chunk,_type) arg count (getVar(_cli,loadedChunks)))

}; rpcAdd("requestChunkLoad",_noe_requestChunkLoad);

_reqDelUpdCh = {
	_owner = _this deleteAt 0;
	_xPos = _this deleteAt 0;
	_yPos = _this deleteAt 0;
	_type = _this deleteAt 0;

	//__chunk_getClientSafe(_cli,_owner,"NOEngine::reqDelUpdCh()");
	_chObj = [[_xPos,_yPos],_type] call noe_getChunkObject;
	_packet = [_xPos,_yPos,_type,chunk_getLastTicktimeUpdate(_chObj)];
	{
		_packet append [_x,-1];
	} count (_this - (keys chunk_getObjectsData(_chObj)));
	//В пакете есть информация об удалении
	if (count _packet > 4) then {
		rpcSendToClient(_owner,"onupdob",_packet);
	};

}; rpcAdd("reqDelUpdCh",_reqDelUpdCh);

_noe_unsubChunkListen = {
	params ["_chunk","_type","_owner",["_skipServerUnsub",true]];
	_chObj = [_chunk,_type] call noe_getChunkObject;
	_ownerList = chunk_getOwners(_chObj);
	_cli = ifcheck(equalTypes(_owner,nullPtr),_owner,_owner call cm_findClientById);

	_ownerList deleteAt (_ownerList find _cli);


	if (_skipServerUnsub) exitWith {};

	//Убираем у клиента загруженный чанк

	if equals(_cli,nullPtr) exitWith {
		errorformat("NOEngine::unsubChunkListen() - cant find client by id %1.",_owner);
	};

	_strChunk = str [_chunk,_type];
	getVar(_cli,loadedChunks) deleteAt _strChunk;
	//traceformat("RCHL-removed chunk: %1; curcnt: %2",_strChunk arg count (getVar(_cli,loadedChunks)))

}; rpcAdd("unsubChunkListen",_noe_unsubChunkListen);

_onStopListenNOE = {
	params ["_owner"];

	_cli = _owner call cm_findClientById;
	if equals(_cli,nullPtr) exitWith {
		errorformat("NOEngine::onStopListenNOE() - cant find client by id %1.",_owner);
	};

	callFunc(_cli,unsubAllChunks);
}; rpcAdd("onStopListenNOE",_onStopListenNOE);

noe_serializeChunkInfoToPacket = {
	params ["_chObj","_clientTick","_cbPacket"];


	private _serverTick = chunk_getLastTicktimeUpdate(_chObj);

	//generate header
	_cbPacket pushBack _serverTick;
	_cbPacket pushBack chunk_getLastTicktimeDelete(_chObj);

	{
		//traceformat("SERVOBJ %1; Client %2", _y getvariable "lastUpd" arg _clientTick)
		if ((_y getvariable "lastUpd") > _clientTick) then {
			_cbPacket append (_y getvariable "bytearr");
		};
	} foreach chunk_getObjectsData(_chObj);

};

//Сериализует в пакет информацию об объекте
noe_serializeObjectInfoPacket = {
	params ["_packet","_visObj"];

	_packet append (_visObj getVariable "bytearr");
};

//подготовка пакета объекта для удаления
noe_prepareInfoToRemoveObject = {
	params ["_packet","_ptr"];

	_packet pushBack _ptr;
	_packet pushBack -1; //less zero means need remove object
};

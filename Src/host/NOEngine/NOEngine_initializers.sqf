// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define objectInitializator(cht) \
call _initCode; \
private _visObj = callSelfParams(InitModel,_pos arg _dir arg _vec); \
_chpos = [_pos,cht] call noe_posToChunk;\
private _chdata = [_chpos,cht] call noe_getChunkObject; \
private _updTime = tickTime; \
chunk_getObjectsData(_chdata) set [getVar(_visObj getvariable 'link',pointer),_visObj]; \
_visObj setVariable ["lastUpd",_updTime]; \
chunk_setLastTicktimeUpdate(_chdata,_updTime); \

initItem = {
	params ["_class","_pos","_dir","_vec",["_initCode",{}]];
	
	private this = instantiate(_class);
	if isNullVar(this) exitWith {
		errorformat("initItem() - Cant create item %1. Class does not exists",_class);
		NIL
	};
	
	objectInitializator(CHUNK_TYPE_ITEM);
	
	this
};

initStruct = {
	params ["_class","_pos","_dir","_vec",["_initCode",{}]];
	
	private this = instantiate(_class);
	if isNullVar(this) exitWith {
		errorformat("initStruct() - Cant create structure %1. Class does not exists",_class);
		NIL
	};
	
	objectInitializator(CHUNK_TYPE_STRUCTURE);
	
	this
};

initDecor = {
	params ["_class","_pos","_dir","_vec",["_initCode",{}]];
	
	private this = instantiate(_class);
	if isNullVar(this) exitWith {
		errorformat("initDecor() - Cant create decoration %1. Class does not exists",_class);
		NIL
	};
	
	objectInitializator(CHUNK_TYPE_DECOR);
	
	this
};
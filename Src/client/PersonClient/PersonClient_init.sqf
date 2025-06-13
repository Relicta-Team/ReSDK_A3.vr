// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	PersonClient subsystem

	Используется для предпросмотра одежды\шапок
	Так же может использоваться для фотографий персонажей или осмотра в зеркале

*/

#include <..\..\host\engine.hpp>
#include <..\ClientRpc\clientRpc.hpp>
#include "..\..\host\PersonServ\personServ.hpp"

//extern (rpc) personCli_localMobRef

//рендер таргет камера
personCli_rttCamera = "camera" camCreate [0,0,0]; //камера для рендеринга
//источник освещения для камеры
personCli_rttLight = objNull;

/*
	Переменная рассылается сервером
	Вариант использования обработчика entityCreated рассматривался но возможно это вызовет куда большие проблемы нагрузки на клиент
*/
personCli_updateNeed = false;

//получает всех мобов
personCli_getAllMobs = {
	PERSONSERV_MOB_POS nearEntities 20;
};

//тред регулярного обновления и синхронизации видимости
personCli_onUpdate = {
	if (personCli_updateNeed) then {
		personCli_updateNeed = false;
		call personCli_syncLocalVisibility;
	};
};

//!not need (use personCli_localMobRef)
personCli_localMobObjCached = objNull; //кешированный объект локальной персоны

//получает локальную персону для клиента
personCli_getLocalMob = {
	if !isNullReference(personCli_localMobObjCached) exitWith {
		personCli_localMobObjCached
	};
	private _locid = ifcheck(isNull(personCli_localMobRef),objNull,personCli_localMobRef);

	private _m = objNull;
	{
		if equals(_locId,_x) exitWith {
			_m = _x;
		};
	} foreach (call personCli_getAllMobs);
	
	personCli_localMobObjCached = _m;
	
	_m
};

//синхронизация видимости. мы видим только свою локальную персону.
personCli_syncLocalVisibility = {
	private _locId = ifcheck(isNull(personCli_localMobRef),objNull,personCli_localMobRef);

	{
		_x hideObject (!equals(_locId,_x));
		false
	} count (call personCli_getAllMobs);
};

//установка опции локального клиента
personCli_setStat = {
	params ["_stateName",["_val",""]];
	//TODO  if val empty string reset stat to default (removeUniform/removeVest etc...)
	private _per = call personCli_getLocalMob;
	if equals(_stateName,"face") exitWith {
		if (_val == "") then {
			_per setFace ("WhiteHead_23_player");
		} else {
			_per setFace _val;
		};
	};
	if equals(_stateName,"cloth") exitWith {
		if (_val == "") then {
			removeUniform _per;
		} else {
			_per forceAddUniform _val;
		};
	};
	if equals(_stateName,"armor") exitWith {
		if (_val == "") then {
			removeVest _per;
		} else {
			_per addVest _val;
		};
	};
	if equals(_stateName,"backpack") exitWith {
		if (_val == "") then {
			removeBackpack _per;
		} else {
			_per addBackpack _val;
		};
	};
	if equals(_stateName,"mask") exitWith {
		if (_val == "") then {
			removeGoggles _per;
		} else {
		   _per addGoggles _val;
		};
	};
	if equals(_stateName,"helmet") exitWith {
		if (_val == "") then {
			removeHeadgear _per;
		} else {
		   _per addHeadgear _val;
		};
	};
};

//список доступных опций персоны для изменения
personCli_const_list_allSettings = [
	"face",
	"cloth",
	"armor",
	"backpack",
	"mask",
	"helmet"
];

//очищает инвентарь и лицо
personCli_clearInventory = {
	{
		[_x] call personCli_setStat
	} foreach personCli_const_list_allSettings;
};

//установка позиции камеры. _applyLightPos - синхронизировать ли позицию света
personCli_setCameraPos = {
	params ["_pos",["_applyLightPos",true]];
	personCli_rttCamera setposatl _pos;
	if (_applyLightPos) then {
		personCli_rttLight setposatl _pos;
	};
};

personCli_cloneCharVisualFromPlayer = {
	//todo implement (для осмотра себя в зеркале)
};

/*
	Подготовка камеры для рендеринга в виджете
	_fov - значение fov
	_specFlag - тип визуализации (одежда, броня, рюкзак и т.д.)
	_pureVisual - визуализация чистого персонажа. скрывает тело персонажа лицо. в случае если идёт визуализация одежды - она будет отображена
*/
personCli_prepCamera = {
	params [["_fov",0.16],["_specFlag","cloth"],["_pureVisual",true]];

	//clear inventory
	call personCli_clearInventory;

	//cleanup light
	if (!isNullReference(personCli_rttLight)) then {
		deleteVehicle personCli_rttLight;
	};

	private _per = call personCli_getLocalMob;
	personCli_rttCamera cameraEffect ["terminate", "back"];
	personCli_rttCamera cameraEffect ["INTERNAL", "BACK", "person_cli_rendertarget"];
	
	//relpos use head for mask/headgears, spine2/3 for backpacks/armors clothes
	private _cFlag = ["cloth","armor","backpack","mask","helmet"];
	private _cSelections = ["spine2","spine3","spine3","head","head"];
	private _cPos = [[0,6,0.0],[0,3,0.0],[0,3,0.0],[0,1,0.15],[0,1,0.15]];
	private _cPosTarget = [[0.1,0,0.0],[0,0,0.11],[0,0,0.11],[-0.05,0,0.11],[-0.05,0,0.11]];
	private _curSel = _cSelections select (_cFlag find _specFlag);
	private _curPos = _cPos select (_cFlag find _specFlag);
	private _curPosTarg = _cPosTarget select (_cFlag find _specFlag);

	private _campos = (_per modeltoworldvisual (_per selectionPosition _curSel));
	personCli_rttCamera setposatl (_campos vectoradd _curPos);
	personCli_rttCamera campreparetarget (_campos vectoradd _curPosTarg);
	personCli_rttCamera camSetFov _fov;
	personCli_rttCamera camcommitprepared 0;

	//recreate light and setup settings
	personCli_rttLight = "#lightpoint" createVehicleLocal [0,0,0];
	personCli_rttLight setposatl (getposatl personCli_rttCamera);

	private _distToPoint = ((_campos vectoradd _curPosTarg) distance (getposatl personCli_rttCamera)) + 2;

	//? how change light options in runtime? maybee need additional param (struct/array/map?)
	personCli_rttLight setLightColor [0.48,0.48,0.45];
	personCli_rttLight setLightAmbient [0.03,0.03,0.04];
	personCli_rttLight setLightIntensity 1000 *3; //получше видно с текущими настройками цвета
	personCli_rttLight setLightAttenuation [1,0,0,0,_distToPoint,_distToPoint + 3];

	if (_pureVisual) then {
		_per forceAddUniform "U_I_Protagonist_VR";
		for "_i" from 0 to 3 do {
			_per setobjectTexture [_i,""];
			_per setObjectMaterial [_i,""];
		};
	};
};

//установка текстуры рендерт таргета
personCli_setPictureRenderTarget = {
	params ["_pic"];
	_pic ctrlSetText "#(argb,512,512,1)r2t(person_cli_rendertarget,1)";
};

personCli_internal_threadHandle = startUpdate(personCli_onUpdate,0);
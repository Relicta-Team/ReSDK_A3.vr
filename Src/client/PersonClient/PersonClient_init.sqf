// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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

personCli_dummyObjFloor = objNull;

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

//получает локальную персону для клиента
personCli_getLocalMob = {
	personCli_localMobRef
};

personCli_getLocalObject = {
	private _per = call personCli_getLocalMob;
	if (isNullReference(_per)) exitWith {
		objNull
	};
	
	private _obj = _per getVariable ["_previewObject", objNull];
	if (isNullReference(_obj)) exitWith {
		objNull
	};
	
	_obj
};

//синхронизация видимости. мы видим только свою локальную персону.
personCli_syncLocalVisibility = {
	private _locId = ifcheck(isNull(personCli_localMobRef),objNull,personCli_localMobRef);

	{
		_x hideObject (!equals(_locId,_x));
		_x setPhysicsCollisionFlag false;
		false
	} count (call personCli_getAllMobs);
};

//установка опции локального клиента
personCli_setStat = {
	params ["_stateName",["_val",""]];
	
	private _per = call personCli_getLocalMob;

	if equals(_stateName,"obj") exitWith {
		private _position = getposatl _per vectoradd [0,0,1];
		if (_val != "") then {
			private _object = createSimpleObject [_val, _position, true];
			_object setposatl _position;
			_per setVariable ["_previewObject", _object];
		} 
	};
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

//очищает инвентарь, лицо и все объекты на сцене
personCli_clearInventory = {
	private _per = call personCli_getLocalMob;

	{
		[_x] call personCli_setStat
	} foreach personCli_const_list_allSettings;

	private _existingObj = _per getVariable ["_previewObject", objNull];

	//удаляем объект если он есть
	if (!isNullReference(_existingObj)) then {
		deleteVehicle _existingObj;
	};
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

//дистанция от камеры до цели (используется только для персонажных объектов (все кроме obj))
personCli_const_cPosList = [[0,6,0],[0,4,0],[0,3,0],[0,2.5,0],[0,2,0],[0,1,0]];
// таргет позиция камеры для персонажных объектов (все кроме obj)
personCli_const_cPosTargetList = [[0.1,0,-0.3],[0,0.05,-0.11],[0,-0.2,-0.05],[-0.05,-0.05,0.10],[-0.07,-0.1,0.1],[0,0,0]];
// флаги для определения типа визуализации
personCli_const_cFlag = ["cloth","armor","backpack","mask","helmet","obj"];
// кости персонажа для определения позиции визуализации
personCli_const_cSelections = ["spine2","spine3","spine3","head","head",null];

/*
	Подготовка камеры для рендеринга в виджете
	_fov - значение fov
	_specFlag - тип визуализации (одежда, броня, рюкзак и т.д.)
	_pureVisual - визуализация чистого персонажа. скрывает тело персонажа лицо. в случае если идёт визуализация одежды - она будет отображена
*/
personCli_prepCamera = {
	params [["_fov",0.16],["_specFlag","cloth"],["_pureVisual",true]];

	//здесь мы сбрасываем флаг на синхронизацию перед очисткой одежды
	refset(personCli_internal_refLock,true);

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
	private _cFlag = personCli_const_cFlag;
	private _cSelections = personCli_const_cSelections;
	private _cPos = personCli_const_cPosList;
	private _cPosTarget = personCli_const_cPosTargetList;
	private _curSel = _cSelections select (_cFlag find _specFlag);
	private _curPos = _cPos select (_cFlag find _specFlag);
	private _curPosTarg = _cPosTarget select (_cFlag find _specFlag);
	// Для объектов используем позицию персонажа +1 метр по вертикали. Для одежды используем позицию относительно конечностей
	private _campos = if not_equals(_specFlag,"obj") then {(_per modeltoworldvisual (_per selectionPosition _curSel))} else {
		getposatl _per vectorAdd [0,0,1]
	};
	personCli_rttCamera setposatl (_campos vectoradd _curPos);
	personCli_rttCamera campreparetarget (_campos vectoradd _curPosTarg);
	personCli_rttCamera camSetFov _fov;
	personCli_rttCamera camcommitprepared 0;

	//recreate light and setup settings
	personCli_rttLight = "#lightpoint" createVehicleLocal [0,0,0];
	personCli_rttLight setposatl (getposatl personCli_rttCamera);

	private _distToPoint = (_campos distance getposatl personCli_rttCamera) + 1.5;

	//? how change light options in runtime? maybee need additional param (struct/array/map?)
	personCli_rttLight setLightColor [0.48,0.48,0.45];
	//personCli_rttLight setLightAmbient [0.03,0.03,0.04];
	//personCli_rttLight setLightIntensity 1000 * 3; //получше видно с текущими настройками цвета

	personCli_rttLight setLightColor (getLightingAt cam_object select 2);
	personCli_rttLight setLightAmbient [1,1,1];
	
	personCli_rttLight setLightIntensity (((getLightingAt cam_object) select 3) * 2);
	personCli_rttLight setLightAttenuation [0,0,0,0,_distToPoint,_distToPoint + 3];

	if (_pureVisual) then {
		
		personCli_internal_refLock = refcreate(false);

		if (_specFlag != "cloth") then {
			_per forceAddUniform "U_I_Protagonist_VR";
			
			//!синхронизация текстур и материалов правильно отрабатывает только через какое-то время спустя
			//! В СИНХРОННОМ РЕЖИМЕ НЕ РАБОТАЕТ (либо так, либо с invokeAfterDelay...)
			startAsyncInvoke
			{
				params ["_per","_ref"];
				//выход если осмотр выполняется заново
				if (refget(_ref)) exitWith {true};
				if (uniform _per != "U_I_Protagonist_VR") exitWith {false};
				for "_i" from 0 to 3 do {
					_per setObjectTexture [_i,""];
					_per setObjectMaterial [_i,""];
				};
				equals(getObjectTextures _per,personCli_internal_const_listEmptyTexmat)
				&& equals(getObjectMaterials _per,personCli_internal_const_listEmptyTexmat)
			},{},[_per,personCli_internal_refLock],10
			endAsyncInvoke;
		};
	};
};

personCli_internal_refLock = refcreate(false);
personCli_internal_const_listEmptyTexmat = ["","","",""]; //пустой константный массив для сравнения

//установка текстуры рендерт таргета
personCli_setPictureRenderTarget = {
	params ["_pic"];
	_pic ctrlSetText "#(argb,512,512,1)r2t(person_cli_rendertarget,1)";
};

personCli_internal_threadHandle = startUpdate(personCli_onUpdate,0);

if isNullReference(personCli_dummyObjFloor) then {
	personCli_dummyObjFloor = "block_dirt" createVehicleLocal [0,0,0];
	personCli_dummyObjFloor setPosATL PERSONSERV_MOB_POS;
	personCli_dummyObjFloor setObjectTexture [0,""];
	personCli_dummyObjFloor setObjectMaterial [0,""];
};
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

zoneLocations_map_all = createHashMap;

/*
	Зоны предназначены для локализации сущностей
*/
editor_attribute("EffectClass" arg "type:zone")
class(ZoneBase) extends(IStructNonReplicated)
	#include <..\..\Interfaces\ITrigger.Interface>
	;if (!is3DEN) then {
		var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
	}  else {
		var(model,"VR_3DSelector_01_complete_F");
	};

	editor_attribute("EditorVisible" arg "type:float" arg "range:0:1000")
	editor_attribute("alias" arg "Distance")
	editor_attribute("Tooltip" arg "На каком расстоянии работает зона")
	var(tDistance,1);
	var(tDelay,0.1);
	var(tCallDelay,0); //0 потому что нам нужно проверить всех активировавших сущностей в цикле симуляции триггера

	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:255")
	editor_attribute("alias" arg "Name")
	editor_attribute("Tooltip" arg "Название зоны")
	var(zoneName,"");

	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:255")
	editor_attribute("alias" arg "TypeName")
	editor_attribute("Tooltip" arg "Системное название зоны")
	var(zoneTypename,"");

	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:512")
	editor_attribute("alias" arg "Ambients")
	editor_attribute("Tooltip" arg "Композиции эмбиента: Это сериализованный массив значений: _pathOrArray,_channel,_ctx") //"_pathOrArray","_chan","_ctx"
	var(zoneAmbients,"");

	editor_attribute("InternalImpl")
	var(name,null);
	editor_attribute("InternalImpl")
	var(desc,null);
	editor_attribute("InternalImpl")
	var(weight,null);
	editor_attribute("InternalImpl")
	var(model,null);
	editor_attribute("InternalImpl")
	var(weight,null);

	func(constructor)
	{
		objParams();
		if (equals(getSelf(zoneTypename),"") || equals(getSelf(zoneName),"")) exitwith {
			callSelfAfter(__errorDispose,2);
		};
		callSelfAfter(_initZone,2);
	};

	func(_initZone)
	{
		objParams();
		callSelfParams(setTriggerEnalbe,true);
		zoneLocations_map_all set [getSelf(zoneTypename),this];
	};

	func(__errorDispose)
	{
		objParams();
		errorformat("Cant initialize zone; Name %1; TypeName %2",getSelf(zoneName) arg getSelf(zoneTypename));
		delete(this);
	};

	var(mobs,[]); //сущности которые были хотя-бы раз в этой локации
	var(currentMobs,[]); //сущности которые находятся в этой зоне в данный момент

	func(onTriggerActivated)
	{
		objParams_1(_usr);

		//активация зоны сущностью
	};

	func(onEnterZone)
	{
		objParams_1(_usr);
		private _oldLoc = getVar(_usr,location);
		if !isNullReference(_oldLoc) then {
			callFuncParams(_oldLoc,onLeaveZone,_usr);
		};
		getSelf(mobs) pushBackUnique _usr;
		getSelf(currentMobs) pushBackUnique _usr;
		setVar(_usr,location,this);
	};

	func(onLeaveZone)
	{
		objParams_1(_usr);
		private _cm = getSelf(currentMobs);
		_cm deleteAt (_cm find _usr);
		setVar(_usr,location,nullPtr);
	};

endclass
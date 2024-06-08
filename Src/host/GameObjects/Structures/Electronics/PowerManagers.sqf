// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

class(ElectronicDevice) extends(IStruct)
	var(name,"Электронное устройство");
	var(material,"MatSynt");

	#include "..\..\Interfaces\ElectronicDevice.Interface"

endclass

class(BaseElectronicDeviceLighting) extends(ILightibleStruct)
	var(name,"Источник света");
	var(material,"MatSynt");

	#include "..\..\Interfaces\ElectronicDevice.Interface"

	editor_attribute("InternalImpl");
	var(lightIsEnabled,true);
endclass

class(ElectronicDeviceLighting) extends(BaseElectronicDeviceLighting)

	var(lampObj,nullPtr);

	func(lightSetMode) {
		objParams_1(_mode);
		if (getSelf(isLampBroken) && _mode) exitWith {};
		super();
	};

	func(constructor)
	{
		objParams();
		//TODO make lamp
	};

	//todo rewrite code...
	var(isLampBroken,false);

	func(onBulletAct) //вызывается при попадании пули в цель
	{
		objParams_6(_dam,_type,_sel,_usr,_dist,_throwed);
		super();
		callSelf(handleLampDestroy);
	};

	func(handleLampDestroy)
	{
		objParams();
		if getSelf(isLampBroken) exitWith {};
		setSelf(isLampBroken,true);
		callSelfParams(lightSetMode,false);
	};

endclass

class(ElectronicDeviceNode) extends(ElectronicDevice)
	proto_func(onChangeEnable);

	var(name,"Узел");

	var(edIsNode,true);

	editor_attribute("EditorVisible" arg "custom_provider:edConnected") editor_attribute("Tooltip" arg "Что подключено к этому источнику")
	editor_attribute("alias" arg "Подключено:")
	var_array(edConnected);
	var(edNodeReqPower,0);

	var(edIsEnabled,false);
	var(edIsUsePower,false);

	func(addConnection) {
		objParams_1(_obj);

		getSelf(edConnected) pushBackUnique _obj;
		setVar(_obj,edOwner,this);
		modSelf(edNodeReqPower,+ getVar(_obj,edReqPower));

		//включаем подачу энергии
		if getVar(this,edIsUsePower) then {
			callFuncParams(_obj,setUsePower,true);
		};
	};

	func(removeConnection) {
		objParams_1(_obj);

		private _connectedList = getSelf(edConnected);
		private _ind = _connectedList find _obj;
		if (_ind == -1) exitWith {false};

		_connectedList deleteAt _ind;

		setVar(_obj,edOwner,nullPtr);

		modSelf(edNodeReqPower, - getVar(_obj,edReqPower));
		
		//отключаем подачу энергии на источнике
		if getVar(_obj,edIsUsePower) then {
			callFuncParams(_obj,setUsePower,false);
		};	
		
		true //return if success added
	};

endclass


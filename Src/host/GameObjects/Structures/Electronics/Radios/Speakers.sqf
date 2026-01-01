// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\GameConstants.hpp>
#include <..\..\..\..\NOEngine\NOEngine.hpp>



// "relicta_models\models\interier\speaker.p3d" station sound
//"ml\ml_object_new\model_05\speeker.p3d" transmither

class(IStructRadioEDLogic) extends(IStructRadio)

	func(constructor)
	{
		objParams();
		//! нужно поправить генератор карт
		callSelfAfter(__onRadioLoaded,0.9);
	};

	//быстрый фикс для синхронизации байт-данных
	func(__onRadioLoaded)
	{
		objParams();
		private _vObj = getSelf(loc);
		if isNullReference(_vObj) exitWith {};
		if getSelf(radioIsEnabled) then {
			_vObj setVariable ["radio",callSelf(getRadioData)];
			[_vObj] call noe_updateObjectByteArr; //обновляем байт массив
		};
	};

	func(radioSetMode)
	{
		objParams_1(_mode);
		
		private _isEnabled = getSelf(radioIsEnabled);
		if (_isEnabled == _mode) exitWith {
			warningformat("Instance of %1 already setted on %2",callSelf(getClassName) arg _mode);
			false;
		};

		private _vObj = getSelf(loc);
		
		setSelf(radioIsEnabled,_mode);
		
		if (!_mode) then {
			//_vObj setVariable ["radio",null];
			//_vObj setvariable ["flags",0.1];
			[_vObj,false] call noe_updateObjectRadio;
		} else {
			_vObj setVariable ["radio",callSelf(getRadioData)];
			[_vObj,true] call noe_updateObjectRadio;
		};
		
		[_vObj,CHUNK_TYPE_STRUCTURE,true] call noe_replicateObject;

		true		
	};

	func(onChangeEnable) {
		objParams();
		
		if (getSelf(edIsUsePower)) then {
			callSelfParams(radioSetMode,getSelf(edIsEnabled));
		};
		
		callSelfParams(playSound, "electronics\click" arg getRandomPitch arg 7);
	};

	func(onChangeUsePower) {
		objParams();
		private _rEnabled = getSelf(radioIsEnabled);
		if (!getSelf(edIsUsePower) || !getSelf(edIsEnabled)) exitWith {
			if (_rEnabled) then {
				callSelfParams(radioSetMode,false);
			};
		};
		if (getSelf(edIsUsePower) && getSelf(edIsEnabled)) exitWith {
			if (!_rEnabled) then {
				callSelfParams(radioSetMode,true);
			};
		};
	};
	
endclass

class(Intercom) extends(IStructRadioEDLogic)
	var(edNodeReqPower,5);
	var(radioSettings,[10 arg "someencoding" arg 1 arg 10 arg null arg -1]);
	var(radioType,RADIO_TYPE_INTERCOM);

	var(name,"Интерком");
	var(model,"ml\ml_object_new\model_05\speeker.p3d");
	var(material,"MatMetal");
	getterconst_func(getCoefAutoWeight,10);
	var(dr,2);
endclass

class(IntercomOld) extends(Intercom)
	var(model,"ml\ml_object_new\shabbat\metrophone.p3d");
endclass

class(StationSpeaker) extends(IStructRadioEDLogic)
	var(edNodeReqPower,15);
	var(radioSettings,[10 arg "someencoding" arg 1 arg 30 arg null arg -1]);
	var(radioType,RADIO_TYPE_LOUDSPEAKER);

	var(name,"Динамик");
	var(model,"relicta_models\models\interier\speaker.p3d");
	var(material,"MatMetal");
	getterconst_func(getCoefAutoWeight,80);
	var(dr,2);
endclass
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>
#include <..\GameConstants.hpp>
#include <..\..\NOEngine\NOEngine_SharedTransportLevel.hpp>
#include <..\..\PointerSystem\pointers.hpp>
#include <..\..\ServerRpc\serverRpc.hpp>
#include <..\..\text.hpp>
#include <..\..\NOEngine\NOEngine.hpp>


editor_attribute("InterfaceClass") editor_attribute("HiddenClass")
class(StructureBasicCategory) extends(IStruct) endclass

//Пока что IStruct можно создавать (пока нет общих объектов)
//editor_attribute("InterfaceClass")
editor_attribute("ColorClass" arg "D1A319")
class(IStruct) extends(IDestructible)

	getter_func(getAbstractName,"Структура");

	getterconst_func(getChunkType,CHUNK_TYPE_STRUCTURE);
	getter_func(isStruct,true);

	getter_func(canApplyDamage,true);

	editor_attribute("EditorVisible" arg "custom_provider:model") editor_attribute("Tooltip" arg "Модель структуры")
	var(model,"a3\structures_f_epa\items\food\canteen_f.p3d");
	
	var(loc,objNull);

	func(destructor)
	{
		objParams();
		if callSelf(isInWorld) then {
			callSelf(unloadModel);
		};
	};

	//TODO remove in next version
	// func(getDescFor) {
	// 	objParams_1(_usr);

	// 	#define PIC_PREP <img size='0.8' image='%2'/>

	// 	private _rand = pick ["Ну а это %1" arg "А это %1" arg "Это %1" arg "Да это же %1" arg "Вот это %1"];
	// 	private _postrand = pick ["!" arg "." arg "..." arg ", вроде..."]; //очень странные дела с пикингом через препроцессор

	// 	private _icon = getSelf(icon);

	// 	private _desc = callSelf(getDesc);
	// 	if (_desc != stringEmpty) then {_desc = sbr + _desc;};

	// 	_icon = if isNullVar(_icon) then {stringEmpty} else {format["<img size='0.8' image='%1'/> ",_icon]};

	// 	//collect germ info to ru text with GERM_COUNT_TO_NAME()
	// 	private _germText = GERM_COUNT_TO_NAME(getSelf(germs));
	// 	if (_germText != "") then {
	// 		modvar(_desc) + sbr + _germText;
	// 	};

	// 	#ifdef EDITOR
	// 		modvar(_desc) + sbr + callSelf(getObjectHealth_Editor);
	// 	#endif

	// 	format[_rand + _postrand,_icon + callSelf(getName)] + _desc
	// };


	func(InitModel)
	{
		objParams_3(_pos,_dir,_vec);

		_vObj = createMesh([getSelf(model) arg [0 arg 0 arg 0] arg true]);
		#ifdef NOE_DEBUG_HIDE_SERVER_OBJECT
		_vobj hideObject true;
		#endif
		_headerT = simpleObj_true;

		if (count _pos == 4) then {
			_vObj setPosWorld (_pos select [0,3]);
			_vObj setvariable ["wpos",true];
			MOD(_headerT,+wposObj_true);
		} else {
			_vObj setPosAtl _pos;
			MOD(_headerT,+wposObj_false);
		};
		if equalTypes(_dir,0) then {
			_vObj setDir _dir;
			_vObj setVectorUp _vec;
			MOD(_headerT,+vDirObj_false);
		} else {
			_vObj setVectorDirAndUp [_dir,_vec];
			_vObj setvariable ["vdir",true];
			MOD(_headerT,+vDirObj_true);
		};

		//mapping objects
		setSelf(loc,_vObj);
		_vObj setVariable ["link",this];
		//проверяем ngo
		[_vObj,getSelf(model)] call noe_server_ngo_check;

		//хедер
		_vObj setvariable ["flags",_headerT];

		//генерируем данные объекта
		[_vObj] call noe_updateObjectByteArr;

		_vObj
	};

	//called at user entered in chunk where placed this object
	func(onEnterArea)
	{
		objParams_1(_usr);
	};

	//called at user exited from chunk where placed this object
	func(onLeaveArea)
	{
		objParams_1(_usr);
	};

endclass


class(ILightibleStruct) extends(IStruct)
	editor_attribute("EditorVisible" arg "custom_provider:scriptedlight")
	var(light,-1);
	editor_attribute("EditorVisible" arg "type:bool") editor_attribute("Tooltip" arg "Включен ли источник света структуры")
	var(lightIsEnabled,true);
	getter_func(canLight,true);

	func(InitModel)
	{
		objParams_3(_pos,_dir,_vec);

		_vObj = createMesh([getSelf(model) arg [0 arg 0 arg 0] arg true]);
		#ifdef NOE_DEBUG_HIDE_SERVER_OBJECT
		_vobj hideObject true;
		#endif
		_headerT = simpleObj_true;

		if (count _pos == 4) then {
			_vObj setPosWorld (_pos select [0,3]);
			_vObj setvariable ["wpos",true];
			MOD(_headerT,+wposObj_true);
		} else {
			_vObj setPosAtl _pos;
			MOD(_headerT,+wposObj_false);
		};
		if equalTypes(_dir,0) then {
			_vObj setDir _dir;
			_vObj setVectorUp _vec;
			MOD(_headerT,+vDirObj_false);
		} else {
			_vObj setVectorDirAndUp [_dir,_vec];
			_vObj setvariable ["vdir",true];
			MOD(_headerT,+vDirObj_true);
		};

		if getSelf(lightIsEnabled) then {
			_vObj setVariable ["light",getSelf(light)];
			MOD(_headerT,+lightObj_true);
			//create serverside light
			[_vObj,getSelf(light)] call slt_create;
		};

		//mapping objects
		setSelf(loc,_vObj);
		_vObj setVariable ["link",this];
		//проверяем ngo
		[_vObj,getSelf(model)] call noe_server_ngo_check;

		//хедер
		_vObj setvariable ["flags",_headerT];

		[_vObj] call noe_updateObjectByteArr;

		_vObj
	};

	func(lightSetMode)
	{
		objParams_1(_mode);

		private _isEnabled = getSelf(lightIsEnabled);
		if (_isEnabled == _mode) exitWith {
			warningformat("Instance of %1 already setted on %2",callSelf(getClassName) arg _mode);
			false;
		};

		private _vObj = getSelf(loc);

		//fixed after 0.8.84
		if equalTypes(_vObj,objNULL) then {

			if (_mode) then {
				[_vObj,CHUNK_TYPE_STRUCTURE,getSelf(light)] call noe_registerLightAtObject;
			} else {
				[_vObj,CHUNK_TYPE_STRUCTURE] call noe_unregisterLightAtObject;
			};
		};

		setSelf(lightIsEnabled,_mode);

		true
	};

	func(lightSetType)
	{
		objParams_1(_lt);
		
		setSelf(light,_lt);
		if getSelf(lightIsEnabled) then {
			private _vObj = getSelf(loc);
			if !isNullReference(_vObj) then {
				[_vObj,_lt,false] call noe_syncLightAtObject;
			};
			callSelf(replicateObject);
		};
	};

endclass


//Динамические объекты (поддерживают анимации, создаются только по классу)
class(DynamicStruct) extends(IStruct)

	//Переменная anmCount должна быть в строке обязательно (отвечает за количество проходов по карте анимаций)
	//не может быть меньше 1 и больше 9
	getter_func(anmCount,animObj_count(1));

	func(InitModel)
	{
		objParams_3(_pos,_dir,_vec);

		_vObj = getSelf(model) createVehicleLocal [0,0,0];
		#ifdef NOE_DEBUG_HIDE_SERVER_OBJECT
		_vobj hideObject true;
		#endif
		_headerT = simpleObj_false;

		if (count _pos == 4) then {
			_vObj setPosWorld (_pos select [0,3]);
			_vObj setvariable ["wpos",true];
			MOD(_headerT,+wposObj_true);
		} else {
			_vObj setPosAtl _pos;
			MOD(_headerT,+wposObj_false);
		};
		if equalTypes(_dir,0) then {
			_vObj setDir _dir;
			_vObj setVectorUp _vec;
			MOD(_headerT,+vDirObj_false);
		} else {
			_vObj setVectorDirAndUp [_dir,_vec];
			_vObj setvariable ["vdir",true];
			MOD(_headerT,+vDirObj_true);
		};

		//animate src
		MOD(_headerT,+ callSelf(anmCount));

		//mapping objects
		setSelf(loc,_vObj);
		_vObj setVariable ["link",this];
		//проверяем ngo
		[_vObj,getSelf(model)] call noe_server_ngo_check;

		//хедер
		_vObj setvariable ["flags",_headerT];

		//Динамика
		_vObj setvariable ["dyn",true];

		//генерируем данные объекта
		[_vObj] call noe_updateObjectByteArr;

		_vObj
	};
endclass


class(IStructRadio) extends(ElectronicDeviceNode)

	#include "..\Interfaces\IRadio.Interface"

	getterconst_func(isRadio,true);
	var(radioIsEnabled,true);
	var(radioType,RADIO_TYPE_WALKIETALKIE);
	var(edIsEnabled,true);

	var(radioSettings,[10 arg "someencoding" arg 1 arg 5 arg null arg -1]);

	func(InitModel)
	{
		objParams_3(_pos,_dir,_vec);

		_vObj = createMesh([getSelf(model) arg [0 arg 0 arg 0] arg true]);
		#ifdef NOE_DEBUG_HIDE_SERVER_OBJECT
		_vobj hideObject true;
		#endif
		_headerT = simpleObj_true;

		if (count _pos == 4) then {
			_vObj setPosWorld (_pos select [0,3]);
			_vObj setvariable ["wpos",true];
			MOD(_headerT,+wposObj_true);
		} else {
			_vObj setPosAtl _pos;
			MOD(_headerT,+wposObj_false);
		};
		if equalTypes(_dir,0) then {
			_vObj setDir _dir;
			_vObj setVectorUp _vec;
			MOD(_headerT,+vDirObj_false);
		} else {
			_vObj setVectorDirAndUp [_dir,_vec];
			_vObj setvariable ["vdir",true];
			MOD(_headerT,+vDirObj_true);
		};

		if getSelf(radioIsEnabled) then {
			_vObj setVariable ["radio",callSelf(getRadioData)];
			MOD(_headerT,+radioObj_true);
		};

		//mapping objects
		setSelf(loc,_vObj);
		_vObj setVariable ["link",this];
		//проверяем ngo
		[_vObj,getSelf(model)] call noe_server_ngo_check;

		//хедер
		_vObj setvariable ["flags",_headerT];

		[_vObj] call noe_updateObjectByteArr;

		_vObj
	};
endclass

editor_attribute("HiddenClass")
class(IStructNonReplicated) extends(IStruct)
	var(__nonrep_flag,false);
	getter_func(canApplyDamage,false);
	func(initModel)
	{
		objParams_3(_pos,_dir,_vec);
		if !getSelf(__nonrep_flag) then {
			setSelf(__nonrep_flag,true);
			callSelfAfter(__attemptDisableReplicate,3);
		};
		super();
	};

	//попытка дерегистрации объекта
	func(__attemptDisableReplicate)
	{
		objParams();
		if callSelf(isInWorld) then {
			callSelf(__disableReplicate);
		} else {
			errorformat("Cant disable replicate for object %1 <%2>; Retry in 3 sec...",getSelf(pointer) arg callSelf(getClassName));
			callSelfAfter(__attemptDisableReplicate,3);
		};
	};

	//процедура выведения объекта из реплицируемых
	func(__disableReplicate)
	{
		objParams();

		//!очень хардкоженное логическое объёбывание системы чанков
		getSelf(loc) setvariable ["lastUpd",-1];
	};
endclass

//Отладочный класс материалов
class(Struct_DebugMaterial__) extends(IStruct)
	editor_attribute("EditorVisible" arg "type:string")
	var(material,"MatStone");
	var(model,"csa_constr\csa_obj\plita_3x3.p3d");

	func(constructor)
	{
		objParams();
		callSelfAfter(__loadMaterial,2);
	};

	func(__loadMaterial)
	{
		objParams();
		private _m = getSelf(material);
		if isNullVar(_m) exitWith {};
		if equalTypes(_m,"") then {
			_m = _m call mat_getByClass;
		};
		if isNullReference(_m) exitWith {};
		setSelf(material,_m);

		setSelf(name,getVar(_m,name));
	};
endclass

class(Struct_SPISpecialObject) extends(IStruct)
	editor_attribute("InternalImpl") var(name,"");
	editor_attribute("InternalImpl") var(desc,"");
	editor_attribute("InternalImpl") var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
	getterconst_func(disableVisual,true);
	func(constructor)
	{
		objParams();
		if callSelf(disableVisual) then {
			if (sp_debug_doNotHideDebugObjects) exitwith {};
			setSelf(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
		};
	};
endclass

class(Struct_SPTrigger) extends(Struct_SPISpecialObject)

	var(model,"a3\structures_f_orange\vr\helpers\sign_sphere100cm_geometry_f.p3d");

	editor_attribute("EditorVisible" arg "type:string")
	var(triggerName,"");

	editor_attribute("EditorVisible" arg "type:float")
	var(triggerDistance,0);
	
	func(constructor)
	{
		objParams();
	};
endclass

class(Struct_SPZoneTrigger) extends(Struct_SPTrigger)

	func(__editor_renderbbx)
	{
		params ["_convfunc"];
		private _xv = ("sizeX" call _convfunc)/2;
		private _yv = ("sizeY" call _convfunc)/2;
		private _zv = ("sizeZ" call _convfunc)/2;
		[
			[-_xv,-_yv,-_zv],[_xv,_yv,_zv]
		]
	};

	editor_attribute("EditorVisible" arg "type:float")
	var(sizeX,1);

	editor_attribute("EditorVisible" arg "type:float")
	var(sizeY,1);

	editor_attribute("EditorVisible" arg "type:float")
	var(sizeZ,1);

	editor_attribute("InternalImpl") var(triggerDistance,0);

	func(isInsideTrigger)
	{
		objParams_1(_usrPos);
		private _myLoc = getSelf(loc);
		_usrPos inArea [
			getposatl _myLoc,getSelf(sizeX)/2,getSelf(sizeY)/2,getdir _myLoc,true,getSelf(sizeZ)/2
		]
	};
endclass

class(Struct_SPPoint) extends(Struct_SPISpecialObject)
	var(model,"a3\structures_f_bootcamp\vr\helpers\vr_groundicon_01_f.p3d");

	editor_attribute("EditorVisible" arg "type:string")
	var(pointName,"");

	func(constructor)
	{
		objParams();
		sp_gc_map_pointList set [getSelf(pointName),this];
	};
endclass

class(Struct_SPInvisibleWall) extends(Struct_SPISpecialObject)
	var(model,"ca\misc3\invisiblebarrier.p3d");
	getterconst_func(disableVisual,false);
endclass


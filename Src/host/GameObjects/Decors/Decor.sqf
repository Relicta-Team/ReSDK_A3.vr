// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include <..\..\PointerSystem\pointers.hpp>
#include <..\..\NOEngine\NOEngine.hpp>
#include <..\..\NOEngine\NOEngine_SharedTransportLevel.hpp>

oop_internal_decor_makeUnicalName = {
	#ifdef EDITOR
	if is3DEN exitwith {"СЛУЧАЙНОЕ ИМЯ"};
	#endif
	if prob(50) exitWith {
		(pick ["Часть","Кусочек","Частица","Малая часть","Декорация"])+" Сети"
	};
	pick ["Мир","Сеть","Окружение","Материя","Подземный мир","Ничего"]
};

editor_attribute("InterfaceClass")
editor_attribute("ColorClass" arg "3353BD")
//Тип декорации чаще всего является общим объектом. Нужен для стен, полов и прочих глобальных объектов.
class(Decor) extends(IDestructible)
	var(name,call oop_internal_decor_makeUnicalName);

	getterconst_func(getChunkType,CHUNK_TYPE_DECOR);
	getter_func(isDecor,true);
	editor_attribute("EditorVisible" arg "custom_provider:model") editor_attribute("Tooltip" arg "Модель декорации")
	var(model,"a3\structures_f\dominants\wip\wip_ruins_f.p3d");
	var(loc,objNull);

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


	func(destructor)
	{
		objParams();
		if callSelf(isInWorld) then {
			callSelf(unloadModel);
		};
	};

endclass

editor_attribute("InterfaceClass") editor_attribute("HiddenClass")
class(DecorBasicCategory) extends(Decor) endclass

editor_attribute("InterfaceClass")
class(BigConstructions) extends(DecorBasicCategory) endclass
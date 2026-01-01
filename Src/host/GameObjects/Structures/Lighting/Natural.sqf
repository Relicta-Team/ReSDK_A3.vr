// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>
#include <..\..\..\text.hpp>


class(TorchHolder) extends(IStruct)
	var(name,"Держатель для факела");
	var(model,"a3\structures_f_enoch\walls\net\netfence_03_m_pole_f.p3d");
	var(material,"MatBeton");
	var(dr,2);
	getter_func(canApplyDamage,false);//TODO revert on fixed destroying holders
	var(torch,nullPtr); //привязанный факел как итем
	var(attachedTorch,nullPtr); //структура привязанного факела

	getter_func(attachPos,vec3(-0.08,0.07,1.58));
	getter_func(transformData,vec3(0,58,0));
	getter_func(getAttachedItemName,"Torch");
	getter_func(holderNameStr,"TorchAsStruct");

	editor_attribute("EditorVisible" arg "type:bool") 
	editor_attribute("alias" arg "Держатель включен")
	editor_attribute("Tooltip" arg "Будет ли включен источник света (работает только если это charged вариант)")
	var(preinit@__enableChanged,true);

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		private _classWith = callFunc(_with,getClassName);
		private _attName = callSelf(getAttachedItemName);
		if (_classWith != _attName && _classWith != (_attName+"Disabled")) exitWith {};
		if !isNullObject(getSelf(torch)) exitWith {};

		callFuncParams(_usr,removeItem,_with arg this);

		callSelfParams(setTorchOnHolder,_with);
	};
	
	//устанавливает позицию визуальной модели
	func(__allocateModel)
	{
		objParams_1(_torchGO);
		private _holder = getSelf(loc);

		private _attachPos = callSelf(attachPos);
		private _transfDat = callSelf(transformData);

		_torchGO attachTo [_holder,_attachPos];
		[_torchGO,_transfDat] call BIS_fnc_setObjectRotation;
		_torchGO attachTo [_holder,_attachPos];

		/*_torchGO attachTo [_holder,[-0.08,0.07,1.58]];
		[_torchGO,[0,58,0]] call BIS_fnc_setObjectRotation;
		_torchGO attachTo [_holder,[-0.08,0.07,1.58]];*/
		detach _torchGO;
	};

	func(setTorchOnHolder)
	{
		objParams_1(_torch);
		//выгружаем визуалку

		private _temptorchGO = createSimpleObject[getVar(_torch,model),[0,0,0],true];

		callSelfParams(__allocateModel,_temptorchGO);

		private _fire = if getVar(_torch,lightIsEnabled) then {"Fire"} else {""};

		//создаём факел структурой
		private _torchStruct = [callSelf(holderNameStr)+_fire,getPosWorld _temptorchGO + [true],vectorDirVisual _temptorchGO,false,vectorUpVisual _temptorchGO] call createStructure;

		setVar(_torchStruct,holder,this);
		setSelf(attachedTorch,_torchStruct);

		deleteVehicle _temptorchGO;

		setSelf(torch,_torch);
		setVar(_torch,__static_disableCanIgnite,true); //tempvar

	};

	//убирает торч из холдера
	func(removeTorchFromHolder)
	{
		objParams_1(_usr);

		private _hld = getSelf(attachedTorch);
		setSelf(attachedTorch,nullPtr);

		[_hld] call deleteStructure;
			
		private _itm = getSelf(torch);
		setVar(_itm,__static_disableCanIgnite,null);
		setSelf(torch,nullPtr);

		callFuncParams(_usr,addItem,_itm);
	};

endclass

//Факел с уже зарегистрированным торчем на нём
class(TorchHolderCharged) extends(TorchHolder)
	func(constructor)
	{
		objParams();
		invokeAfterDelayParams(getSelfFunc(__initChargedHolder),1,this);
	};

	func(__initChargedHolder)
	{
		objParams();

		private _tor = new(Torch);
		if !getSelf(preinit@__enableChanged) then {
			setVar(_tor,lightIsEnabled,false);
		};
		setVar(_tor,loc,this);
		setVar(_tor,slot,-1);
		callSelfParams(setTorchOnHolder,_tor);
	};

endclass

class(LampKeroseneHolderCharged) extends(LampKeroseneHolder)
	var(model,"a3\structures_f\walls\net_fence_pole_f.p3d");

	func(constructor)
	{
		objParams();
		invokeAfterDelayParams(getSelfFunc(__initChargedHolder),1,this);
	};

	func(__initChargedHolder)
	{
		objParams();

		private _tor = new(LampKerosene);
		if !getSelf(preinit@__enableChanged) then {
			setVar(_tor,lightIsEnabled,false);
		};
		setVar(_tor,loc,this);
		setVar(_tor,slot,-1);
		callSelfParams(setTorchOnHolder,_tor);
	};
endclass

class(LampKeroseneHolder) extends(TorchHolder)
	var(name,"Длинная железная палка");
	var(model,"a3\structures_f\walls\net_fence_pole_f.p3d");
	var(material,"MatMetal");
	getter_func(getAttachedItemName,"LampKerosene");
	getter_func(holderNameStr,"LampKeroseneAsStruct");
	getter_func(attachPos,vec3(0.2,0,0.85));
	getter_func(transformData,vec3(0,0,0));

	func(getDescFor)
	{
		objParams_1(_usr);
		//_usr предварительно понимается как переменная, созданная при verb-action
		if isNullVar(_usr) then {
			callSuper(TorchHolder,getDescFor)
		} else {

			//Ой плохим копипастом я занимаюсь...
			private _dir = getSelf(loc) getRelDir getVar(_usr,owner);

			_dir = _dir - 90;

			private _isFront = if (_dir > 315 || _dir <= 45) then {sbr + "Ты наблюдаешь у конца этой железной палки отверстие. Такие палки повсеместно используются для держания керосиновых ламп"} else {""};

			callSuper(TorchHolder,getDescFor) + _isFront;
		};

	};

endclass

//специальный декоративный факел
editor_attribute("HiddenClass")
editor_attribute("Deprecated" arg "Требуется рефакторинг системы держателей")
class(TorchAsStruct) extends(Campfire)
	var(tDistance,0.001);
	var(name,null);
	var(desc,"Хорошо закреплённый в специальном держателе для факела. Ходят слухи, что на таких держателях факелы никогда не затухают от пещерных ветров.");
	var(model,"relicta_models\models\weapons\melee\torch.p3d");
	var(material,"MatWood");
	getter_func(canApplyDamage,false); //TODO revert on fixed destroying holders
	var(holder,nullPtr); //привязан к холдеру
	var(light,"SLIGHT_LEGACY_FIRE" call lightSys_getConfigIdByName);
	getter_func(isFireLight,true);
	getter_func(canIgniteArea,false); //holders cannot ignite any
	var(lightIsEnabled,false);
	
	func(onUpdate)
	{
		updateParams();
		_hld = getSelf(holder);
		_torch = getVar(_hld,torch);
		if !isNullReference(_torch) then {
			if getVar(_torch,lightIsEnabled) then {
				modVar(_torch,fuelLeft, + 1);
			};
		};
	};
	
	func(getName)
	{
		objParams();
		private _h = getSelf(holder);
		if isNullObject(_h) exitWith {"Что-то чудесное"};
		private _itm = getVar(_h,torch);
		if isNullObject(_itm) exitWith {"Штуковинка"};
		callFunc(_itm,getName)
	};	

	func(onClick)
	{
		objParams_1(_usr);
		private _holder = getSelf(holder);
		if (!isNullObject(_holder) && callFunc(_usr,isEmptyActiveHand)) then {
			callFuncParams(_holder,removeTorchFromHolder,_usr);
		};
	};

	func(lightSetMode)
	{
		objParams_1(_mode);
		if (callSuper(Campfire,lightSetMode)) then {
			private _hld = getSelf(holder);
			if !isNullObject(_hld) then {
				callFuncParams(getVar(_hld,torch),lightSetMode,_mode);
			};
		};
	};

endclass

class(LampKeroseneAsStruct) extends(TorchAsStruct)
	var(model,"ml_shabut\exoduss\keroslampa.p3d");
	var(material,"MatGlass");
	var(light,"SLIGHT_LEGACY_LAMP_KEROSENE" call lightSys_getConfigIdByName);
	var(name,null);
	var(desc,"");
endclass

class(TorchAsStructFire) extends(TorchAsStruct)
	var(lightIsEnabled,true);
endclass

class(LampKeroseneAsStructFire) extends(LampKeroseneAsStruct)
	var(lightIsEnabled,true);
endclass

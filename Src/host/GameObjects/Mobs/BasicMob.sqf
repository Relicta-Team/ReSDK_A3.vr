// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\GameConstants.hpp"
#include "..\..\PointerSystem\pointers.hpp"
#include "..\..\ServerRpc\serverRpc.hpp"
#include "..\..\text.hpp"

#include <..\..\SpecialActions\SpecialActions.hpp>
#include <..\..\Networking\Network.hpp>
#include <..\..\bitflags.hpp>
#include <..\..\GURPS\gurps.hpp>
#include <..\..\ClientManager\ClientController.hpp>

#include "..\..\ServerInteraction\ServerInteraction_ThrowModes.sqf"
//public enum header
#include <Mob_combat_attdam_enum.hpp>

//системный макрос эмуляции
#define emulate_mp_in_sp


//базовая сущность
//Содержит основные методы для манипуляции персонажем (подключение, отключение, трансформация и т.д.)
editor_attribute("HiddenClass" arg "allChild")
class(BasicMob) extends(GameObject)
	"
		name:Базовый моб
		desc:Базовый моб, от которого унаследованы абсолютно все игровые сущности (персонажи).
		path:Игровые объекты.Сущности
	" node_class

	getterconst_func(isMob,true);

	
	var(Naming,naming_default); //система склонения имён
	

	var(gender,gender_male); // половая принадлежность. Получать значения поля только с маленьких букв
	var(name,"Существо");
	func(getNameFor) {objParams_1(_usr); callFunc(this,getName)}; //метод с помощью которого можно узнать имя цели или не узнать
	
	"
		name:Возраст
		desc:Возраст сущности
		prop:all
		return:int:Возраст
		defval:18
	" node_var
	#ifdef EDITOR
	var(age,randInt(15,90));
	#else
	var_num(age);
	#endif
	
	getter_func(isInWorld,true);//always in world

	//some getters
	"
		name:Это ребенок
		desc:Возвращает @[bool ИСТИНУ], если сущность является ребенком
		type:get
		lockoverride:1
		return:bool:Это ребенок
	" node_met
	getter_func(isChild,getSelf(age)<=18);
	"
		name:Это мужчина
		desc:Возвращает @[bool ИСТИНУ], если сущность является мужчиной
		type:get
		lockoverride:1
		return:bool:Это мужчина
	" node_met
	getter_func(isMale,equals(getSelf(gender),gender_male));
	"
		name:Это женщина
		desc:Возвращает @[bool ИСТИНУ], если сущность является женщиной
		type:get
		lockoverride:1
		return:bool:Это женщина
	" node_met
	getter_func(isFemale,equals(getSelf(gender),gender_female));

	var_obj(owner); // к кому привязан виртуальный моб
	var(client,nullPtr); //клиент который играет этим мобом (-> gm::spawnClientToRole())
	var(playerClients,[]); //клиенты которые играли за эту сущность
	var(visionBlock,0); //закрытые глаза, бессознанка, всё это влияет на эту переменную. Всё что больше 0 вызовет черный экран на клиенте

	//Получает последнего активного клиента, который заходил за сущность
	"
		name:Последний клиент моба
		desc:Получает последнего клиента, который играл или играет в данный момент за моба.
		type:get
		lockoverride:1
		return:ServerClient:Клиент сущности, либо null ссылка, если за сущность ещё никто не заходил.
	" node_met
	func(getLastPlayerClient)
	{
		objParams();
		private _list = getSelf(playerClients);
		if array_isempty(_list) exitWith {nullPtr};
		array_selectlast(_list);
	};
	
	var(tasks,[]);

	"
		name:Добавить задачу
		desc:Добавляет персонажу новую задачу. Возвращает результат добавления задачи. Если она была добавлена для персонажа - возвращает @[bool ИСТИНУ].
		type:method
		lockoverride:1
		in:TaskBase:Задача:Добавляемая задача для персонажа
		return:bool:Была ли задача успешно добавлена.
	" node_met
	func(addTask)
	{
		objParams_1(_v);

		if isNullReference(_v) exitWith {
			setLastError("Task reference is null");
			errorformat("Cant add task object %1 for %2 <%3>",_v arg getSelf(pointer) arg callSelf(getClassName));
			false
		};
		if (callFunc(_v,getClassName)=="TaskBase") exitWith {
			setLastError("Задача должна быть наследником от TaskBase");
			false
		};
		if !isTypeOf(_v,TaskBase) exitWith {
			assert_str(false,format vec2("Invalid task type %1 for mob %2",callFunc(_v,getClassName) arg this));
			false;
		};
		
		getSelf(tasks) pushBack _v;
		callFuncParams(_v,onRegisterInTarget,this);
		
		true
	};

	// Новая функция регистрации задачи
	func(registerTask)
	{
		objParams_1(_tObj);
	};

region(roles management)
	//! tasks already defined in Mob
	//var_array(tasks); //задачи для человека
	"
		name:Базовая роль
		desc:Базовая роль персонажа, с которой он появился в мире. Тут хранится объект роли, которую выбрал игрок при входе, либо получил в результате успешной проверки на полного антагониста. Базовая роль не меняется до самого конца раунда.
		prop:get
		classprop:0
		return:ScriptedRole:Базовая роль моба
		restr:ScriptedRole
	" node_var
	var(basicRole,nullPtr); //объект роли человека, выдаваемой при старте
	"
		name:Текущая роль
		desc:Текущая роль моба. Можно переназначить с помощью узла ""Установить роль мобу"". Если вы ни разу не изменяли роль моба, то значение текущей роли эквиваленто базовой роли.
		prop:get
		classprop:0
		return:ScriptedRole:Текущая роль моба
		restr:ScriptedRole
	" node_var
	var(role,nullPtr); //текущая роль. возможно переназначать персонажей на другие роли
	
	var(location,nullPtr); //местоположение (тип ZoneBase)

	//Вызывается 1 раз при инициализации моба на роли
	func(onInitRole)
	{
		objParams_1(_roleObj);

		setSelf(basicRole,_roleObj);
		setSelf(role,_roleObj);

		getVar(_roleObj,mobs) pushBack this;
		getVar(_roleObj,basicMobs) pushBack this;
	};

	//Устанавливает новую текущую роль персонажу
	"
		name:Установить роль мобу
		desc:Устанавливает новую роль для моба.
		type:method
		lockoverride:1
		in:classname:Роль:Новая роль моба
			opt:def=ScriptedRole
	" node_met
	func(setToRole)
	{
		objParams_1(_roleObj);
		private _baseRO = _roleObj;
		if equalTypes(_roleObj,"") then {
			_roleObj = _roleObj call gm_getRoleObject;
		};
		if isNullReference(_roleObj) exitWith {
			errorformat("Cant change role for mob ptr %1: basic value %1",getSelf(pointer) arg _baseRO);
		};

		//get old current mob and remove them
		private _oldRole = getVar(getSelf(role),mobs);
		_oldRole deleteAt (_oldRole find this);

		//add to new
		setSelf(role,_roleObj);
		getVar(_roleObj,mobs) pushBack this;
	};

region(ctor and dtor)
	
	func(constructor)
	{
		objParams();
		callSelfParams(startUpdateMethod,"onUpdate" arg "handleUpdate");
	};
	
	func(destructor)
	{
		objParams();
		callSelfParams(stopUpdateMethod, "handleUpdate");
	};
	
	
	//Функция удаления моба (важно! нельзя вызывать удаление напрямую через delete())
	editor_attribute("InternalImpl")
	func(Destroy)
	{
		objParams();
		if !isNull(getSelf(__destroyMark__)) exitWith {
			errorformat("%1::Destroy() - destroy process for %2 already started",callSelf(getClassName) arg getSelf(pointer))
		};
		
		//системная отметка удаления объекта
		setSelf(__destroyMark__,tickTime);
		
		if callSelf(isPlayer) then {
			//сначала вернуть клиента в лобби
			[this,"LobbyAndDestroy"] call cm_switchToMob;
		} else {
			callSelf(__destroyImpl);
		};
	};
	
	editor_attribute("InternalImpl")
	func(__destroyImpl)
	{
		objParams();
		private _owner = getSelf(owner);
		if !isNullReference(_owner) then {
			[_owner,true] call cm_unregisterMobInGame;
		};
		delete(this);
	};

region(Interaction control)
	//main logic for clicking objects
	func(clickTarget) {objParams_1(_targ);};
	//usr - кто применил действие. _with - объект интеракции
	//Тут достпен флаг __DRAG_EXTERNAL_FLAG__ означающий что это перетаскивание
	func(onInteractWith) {objParams_2(_with,_usr);};
	
	func(onClick) {objParams_1(_usr);};
	
	func(mainAction) {objParams_1(_targ);};
	
	func(extraAction) {objParams_1(_targ);};

region(Common)
	var(handleUpdate,-1);
	func(onUpdate)
	{
		updateParams();
	};
	
	func(canSeeObject)
	{
		objParams_1(_obj);
		true
	};

region(raycast)
	var(__lastinteractdata__,vec4(vec3(0,0,0),vec3(0,0,0),0,vec2(vec3(0,0,0),vec3(0,0,0))));
	func(saveLastInteract)
	{
		objParams_5(_raypos,_pos,_targ,_vec,_normal);

		private _dist = _raypos distance _pos;//TODO remove: callSelfParams(getSectorDistTo,callFunc(_targ,getModelPosition));
		setSelf(__lastinteractdata__,[_raypos arg _pos arg _dist arg _vec arg _targ arg _normal]);
	};

	getter_func(getLastInteractStartPos,getSelf(__lastinteractdata__) select 0);
	getter_func(getLastInteractEndPos,getSelf(__lastinteractdata__) select 1); //конечная точка пересечения
	getter_func(getLastInteractDistance,getSelf(__lastinteractdata__) select 2); //дистанция от начаьной до конечной точки
	getter_func(getLastInteractVector,getSelf(__lastinteractdata__) select 3); //направление
	getter_func(getLastInteractTarget,getSelf(__lastinteractdata__) select 4);
	getter_func(getLastInteractNormal,getSelf(__lastinteractdata__) select 5);

	func(__setLastInteractDistance)
	{
		objParams_1(_dist);
		getSelf(__lastinteractdata__) set [2,_dist];
	};
	func(__setLastInteractTarget)
	{
		objParams_1(_target);
		getSelf(__lastinteractdata__) set [4,_target];
	};
	func(__setLastInteractPosStartEnd)
	{
		objParams_1(_pos);
		getSelf(__lastinteractdata__) set [0,_pos];
		getSelf(__lastinteractdata__) set [1,_pos];
	};

	#define __debug_getinteractiontarget_spheres__
	#ifdef __debug_getinteractiontarget_spheres__
	debug_internal_getinteractiontarget_spheres = [];
	#endif

	func(canInteractWithSavedObject)
	{
		objParams_2(_weapmodule,_item);
		private _dist = getVar(_weapmodule,reach);
		if isNullVar(_dist) then {
			_dist = 0;
		};
		private _distToNormal = callSelf(getLastInteractStartPos) distance callSelf(getLastInteractEndPos);

		traceformat("reach %1, dist %2",_dist arg _distToNormal);
		_distToNormal <= _dist
	};

	//функция каста до цели
	func(getInteractionTarget)
	{
		objParams_2(_weapmodule,_item);

		{
			deleteVehicle _x;
		} foreach debug_internal_getinteractiontarget_spheres;

		private _dist = getVar(_weapmodule,reach);
		if isNullVar(_dist) then {
			_dist = 0;
		};
		#define INTERACT_DIST_DEFAULT 1.1
		private _listSel = [["spine3",vec3(0,INTERACT_DIST_DEFAULT + _dist,0)]]; //1.35 standard interaction distance with hand
		private _stance = callSelf(getStance);

		if (_stance >= STANCE_MIDDLE) then {
			_listSel pushBack ["pelvis",vec3(0,INTERACT_DIST_DEFAULT + _dist,0)];
		};
		if (_stance == STANCE_UP) then {
			_listSel pushBack ["pelvis",vec3(0,INTERACT_DIST_DEFAULT + _dist,-0.3)];
		};
		private _unit = getSelf(owner);
		private _sel = null; private _sel2 = null;
		/*private _doForwardOffset = {
			params ["_pos","_dir","_defdir","_dist"];
			_pos vectorAdd [
				sin (_defdir+_dir) * _dist,
				cos (_defdir+_dir) * _dist,
				0
			]
		};*/

		traceformat("DIST %1; list %2",_dist arg _listSel)
		private _retObj = objNUll;
		//private _anglesize = 45; // TODO optional angle size
		//si_getIntersectData -> return["_obj","_pos","_norm"];
		{
			_x params ["_strsel","_offset"];
			_sel = _unit modelToWorld ((_unit selectionPosition _strsel));
			_sel2 = _unit modelToWorld ((_unit selectionPosition _strsel)vectorAdd _offset);

			#ifdef __debug_getinteractiontarget_spheres__
			_s1 = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
			_si setposatl _sel;
			debug_internal_getinteractiontarget_spheres pushBack _s1;
			_s2 = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
			_s2 setposatl _sel2;
			debug_internal_getinteractiontarget_spheres pushBack _s2;
			#endif

			_retObj = ([_sel,_sel2,_unit] call si_getIntersectData) select 0;
			if !isNullReference(_retObj) exitWith {};
			true
		} count _listSel;

		if !isNullReference(_retObj) then {
			_retObj = [_retObj] call si_handleObjectReturnCheckVirtual;
		};
		_retObj
	};

	//Серверная генерация и установка точки взаимодействия
	func(generateLastInteractOnServer)
	{
		objParams();
		private _unit = getSelf(owner);
		private _oldPos = AGLToASL(_unit modelToWorldVisual ((_unit selectionPosition "head")vectoradd[-0.06,0.1,0.0889]));
		private _cameraVector = getCameraViewDirection _unit;
		private _offsetVector = [0,0.06,0.01];
		private _dir = [0,0,0] getdir (eyeDirection _unit);
		private _pitch = (_cameraVector select 2) * 90;
		private _vuz = cos _pitch;
		private _renderVec = [ [(sin _dir) * _vuz,(cos _dir) * _vuz,sin _pitch], [0,0,_vuz] ];
		private _renderPos = ASLToATL((_oldPos) vectorAdd [
			((_offsetVector select 0) * cos _dir) + ((_offsetVector select 1) * sin _dir),
		   	(((_offsetVector select 1) * cos _dir) - (_offsetVector select 0) * sin _dir),
		   	_offsetVector select 2
			]);

		private _bias = _renderPos distance2d (eyePos _unit); //temporary solution
		traceformat("[server generated] - render interact obj %1 with bias %2",vec4(_renderPos,_renderVec,false,_bias) call si_rayCast arg _bias)
		private _ignore = ifcheck(getSelf(isCombatModeEnable),_unit,objNull);
		private _pos = [];
		private _normal = [];
		private _target = [_renderPos,_renderVec,true,_bias,_pos,_ignore,_normal] call si_rayCast;
		//сериализация последнего объекта
		callSelfParams(saveLastInteract,_renderPos arg _pos arg _target arg _renderVec arg _normal);
	};
	
region(Self net display and message box)
	//Общий объект сетевого дисплея
	editor_attribute("InternalImpl") autoref var(_internalND,newParams(SystemMessageBoxND,this));

	autoref var(openedNDisplay,nullPtr); // ссылка на открытый объект INetDisplay
	getter_func(isOpenedNDisplay,!isNullReference(getSelf(openedNDisplay)));
	func(closeOpenedNetDisplay)
	{
		objParams();
		if callSelf(isOpenedNDisplay) then {
			callFuncParams(getSelf(openedNDisplay),closeNDisplayServer,this);
		};
	};
	
	//В режиме листбокса _value подставляется в значение
	func(ShowMessageBox)
	{
		objParams_5(_name,_data,_eventHandler,_probTarget,_eventOnClose);
		if (_name != "Text" && isNullVar(_eventHandler)) exitWith {
			errorformat("Error on show message box: Event handler cannot be empty on mode %1; Data was: %2",_name arg _data);
			false
		};
		callSelfParams(setMessageBoxContext,_data);
		callSelfParams(SetMessageBoxEvent,_eventHandler);
		callFuncParams(getVar(this,_internalND),Show,_name arg _probTarget arg _eventOnClose);
	};
	func(CloseMessageBox)
	{
		objParams();
		if callSelf(isOpenedNDisplay) then {
			if equals(getVar(this,_internalND),getSelf(openedNDisplay)) then {
				callSelf(closeOpenedNetDisplay);
			};
		};
	};
	func(UpdateMessageBox)
	{
		objParams();
		callFunc(getVar(this,_internalND),updateNDisplay);
	};
	func(setMessageBoxContext)
	{
		objParams_1(_context);
		setVar(getVar(this,_internalND),bufferedCtx,_context);
	};
	func(SetMessageBoxEvent)
	{
		objParams_1(_event);
		setVar(getVar(this,_internalND),event_inputHandler,_event);
	};

region(Actions subsystem)
	
	var(__listactions,[]);
	
	func(loadActions)
	{
		objParams_1(_refverbs);
		if isNullVar(_refverbs) then {
			_refverbs = getSelf(__listactions);
		};
		#ifdef EDITOR_OR_SP_MODE
		_refverbs = array_copy(_refverbs);
		#endif

		callSelfParams(sendInfo,"loadEmotes" arg _refverbs);
	};

	func(hasAction)
	{
		objParams_2(_vnameOrSysname,_isSystem);
		if !isNullVar(_isSystem) then {
			if (_isSystem) then {_vnameOrSysname = ":" + _vnameOrSysname};
		};
		private _lacts = getSelf(__listactions);
		private _idx = -1;
		{
			_idx = _x findif {_vnameOrSysname in _x};
			if (_idx!=-1) exitWith {};
		} foreach _lacts;
		_idx != -1
	};

	//updateEmoteCat _cat, _list
	
	//Добавить действие
	//example: callSelfParams(addAction,"Жрун" arg "Принюхаться" arg "eater_sniff");
	func(addAction)
	{
		objParams_3(_cat,_vname,_systemName);
		private _lacts = getSelf(__listactions);

		private _idx = _lacts findif {(_x select 0)==_cat};

		if (_idx == -1) then {
			_idx = getSelf(__listactions) pushBack [_cat,format["%1:%2",_vname,_systemName]];
		} else {
			(getSelf(__listactions) select _idx) pushBack (format["%1:%2",_vname,_systemName]);
		};

		//send copy of array
		private _list = array_copy(getSelf(__listactions) select _idx);
		_list deleteAt 0;

		callSelfParams(sendInfo,"updateEmoteCat" arg vec2(_cat,_list));
	};

	func(playAction)
	{
		objParams_1(_act);
		[this,_act] call ie_action_call;
	};

	//Удалить действие
	func(removeAction)
	{
		params['this',"_vname",["_catname",""]];
		private _refact = getSelf(__listactions);
		if (_catname != "") then {
			private _idx = _refact findif {(_x select 0) == _catname};
			if (_idx != -1) then {
				private _idxAct = (_refact select _idx)findif{_vname in _x};
				if (_idxAct != -1) then {
					(_refact select _idx) deleteAt _idxAct;

					private _list = array_copy(getSelf(__listactions) select _idx);
					private _cat = _list deleteAt 0;
					callSelfParams(sendInfo,"updateEmoteCat" arg vec2(_cat,_list));
				};
			};
		} else {
			private _idxCat = -1;
			private _idx = -1;
			{
				_idxCat = _forEachIndex;
				_idx = _x findif {_vname in _x};
				if (_idx!=-1) exitWith {};
			} foreach _refact;
			if (_idx!=-1) then {
				(_refact select _idxCat) deleteAt _idx;
				if (count (_refact select _idxCat) == 1) then {
					private _cat = (_refact deleteAt _idxCat) select 0;
					callSelfParams(sendInfo,"updateEmoteCat" arg vec2(_cat,[]));
				} else {
					private _list = array_copy(getSelf(__listactions) select _idx);
					private _cat = _list deleteAt 0;
					callSelfParams(sendInfo,"updateEmoteCat" arg vec2(_cat,_list));
				};
			};
		};
	};

region(Initial position)
	
	//initial pos - это позиция подключения моба. чаще всего она используется при репликации стартовой позиции моба
	var(_initialPos,vec3(0,0,0));
	func(setInitialPos)
	{
		objParams_1(_pos);
		setSelf(_initialPos,_pos);
	};
	func(getInitialPos)
	{
		objParams();
		getSelf(_initialPos)
	};

region(Connect control events)
	
	//эта функция должна быть вызвана один раз для привязки виртуального моба к армовскому персонажу
	func(initAsActor)
	{
		objParams_1(_linked);

		setSelf(owner,_linked);
		setVar(_linked,link,this);

		//_linked allowDamage false; problems locality
		_linked objectAddEventHandler ["Local",{
			params ["_entity", "_isLocal"];

			this = _entity getVariable 'link';
			if (_isLocal) then {
				_entity allowDamage false;

			} else {
				[_entity,false] remoteExecCall ["allowDamage",owner _entity];
				if (((getposatl _entity) select 2) < 2) exitWith {}; //if unit dropped the
				callSelfParams(setInitialPos,getposatl _entity);
			};
			callSelfParams(onChangeLocality,_isLocal);
			//errorformat("CHANGE LOCALITY %1:%2 %3",_entity arg _isLocal arg callSelf(getInitialPos));
		}];

		//and disable damage after adding event
		private _isLocal = local _linked;
		if (_isLocal) then {
			_linked allowDamage false
		} else {
			[_linked,false] remoteExecCall ["allowDamage",owner _linked];
			callSelfParams(setInitialPos,getposatl _linked);
		};

		callSelfParams(onChangeLocality,_isLocal);

		_linked enableStamina false;

		//Отключаем у моба кручение при дисконекте
		_linked disableAI "MOVE";
		_linked disableAI "TARGET";
		_linked disableAI "AUTOTARGET";
		_linked disableAI "FSM";
		//todo switchaction "DOWN" (чтобы моб лежал)
		
		//init voice
		callSelfParams(applyVoiceType,null);

		if callSelf(enabledAtmosReaction) then {
			callSelfParams(setAtmosModeReaction,true);
		};
	};
	
	// Событие вызывается при изменении локальности клиента. (параметр true означает что владение мобом передано серверу)
	func(onChangeLocality)
	{
		objParams_1(_isServerOwner);
	};

	// Подключен ли к актору какой-нибудь игрок
	"
		name:Это игрок
		desc:Возвращает @[bool ИСТИНУ], если за сущность подключен какой-либо клиент (игрок)
		type:get
		lockoverride:1
		return:bool:Подключен ли к мобу клиент
	" node_met
	getter_func(isPlayer,isPlayer getSelf(owner));
	//Вызывется при подключении клиента к мобу
	func(onConnected)
	{
		objParams();
		
		//установка имени для войса
		netSyncObjVar(getSelf(owner),"rv_name",getVar(getSelf(client),name));

		//загрузка действий (левое меню)
		callSelfParams(loadActions,null);
		//хандлер подключения
		callSelfParams(sendInfo, "onPrepareClient" arg [callSelf(getInitialPos) arg getSelf(visionBlock)]);
		
		callSelfParams(localEffectUpdate,"GenericAmbSound");

	};
	// Вызывается при отключении клиента от моба
	func(onDisconnected)
	{
		objParams();
		
		//reset voip name
		netSyncObjVar(getSelf(owner),"rv_name",null);
		
		//removing all localEffects
		callSelf(localEffectClearAll);

		setSelf(client,nullPtr);
		
		// close net display if client dropped connection
		callSelf(closeOpenedNetDisplay);
		//release building preview if exist
		callSelf(releaseBuildingPreview);

		callSelf(dropAllItemsInHands);

		if not_equals(getSelf(__curRegion),"") then {
			[getSelf(__curRegion),-1] call ai_modifyRegionRefCount;
		};
	};

region(Mob location info: position; direction; speed)
	
	"
		name:Установить позицию моба
		desc:Устанавливает позицию моба, незамедлительно телепортируя его на новую позицию. Если моб был схвачен, то он освобождается.
		type:method
		lockoverride:1
		in:vector3:Позиция:Новая позиция, на которую будет телепортирована сущность
	" node_met
	func(setPos)
	{
		objParams_1(_pos);
		private _mob = getSelf(owner);
		if equals(_mob,objNull) exitWith {
			errorformat("Cant set mob pos %1, because owner mob is null reference",_pos);
		};

		//_mob setPosAtl _pos;
		[this,_pos,callSelf(getDir)] call teleportMobToPoint;
	};

	func(setPosServer)
	{
		objParams_1(_pos);
		private _mob = getSelf(owner);
		assert(!isNullReference(_mob));
		_mob setPosAtl _pos;
	};

	func(getPos)
	{
		objParams();
		private _mob = getSelf(owner);
		if equals(_mob,objNull) exitWith {
			errorformat("Cant get mob pos %1, because owner mob is null reference. Returns vector.zero",this);
			[0,0,0]
		};
		getPosATL _mob
	};

	"
		name:Моб касается земли
		namelib:Моб касается поверхности (стоит на земле)
		desc:Возвращает true, если моб находится на земле. Если он падает - возваращет ложь. Этот узел не гарантирует точность возвращаемых данных, так как при десинхронизации клиента возможны рывки сущности, при которых узел возвращает ложь.
		type:get
		lockoverride:1
		return:bool:Моб стоит на земле
	" node_met
	getter_func(isTouchingGround,isTouchingGround getSelf(owner));

	"
		name:Установить направление моба
		desc:Устанавливает направление моба. Если моб был схвачен или сидит на стуле - узел не выполнит никаких действий.
		type:method
		lockoverride:1
		in:float:Направление:Направление в градусах от 0 до 360
	" node_met
	func(setDir)
	{
		objParams_1(_dir);
		private _mob = getSelf(owner);
		if equals(_mob,objNull) exitWith {
			errorformat("Cant set mob dir %1, because owner mob is null reference",_pos);
		};
		[_mob,"setDir",[_mob,_dir]] call repl_doLocal;
	};

	func(getDir)
	{
		objParams();
		private _mob = getSelf(owner);
		if equals(_mob,objNull) exitWith {
			errorformat("Cant get mob dir %1, because owner mob is null reference",this);
		};
		getDir _mob
	};

	"
		name:Скорость моба
		desc:Получает абсолютную скорость движения моба.
		type:get
		lockoverride:1
		return:float:Скорость моба. Если моб стоит на месте, то возвращает 0
	" node_met
	func(getRealSpeed)
	{
		objParams();
		abs speed getSelf(owner)
	};

	"
		name:Направление игрового объекта к мобу
		desc:Данный узел возвращает направление между мобом и целью. Моб может находится перед целью, за ней, слева и справа от цели. " + 
		"Например, если целью будет другой моб и вызывающий находится за ним, то возвращается направление 'Сзади'.
		type:method
		lockoverride:1
		in:GameObject:Объект-цель:Объект, рядом с которым стоит вызывающий.
		return:enum.DirectionSide:Направление вызывающего моба к цели.
	" node_met
	//где стоти this по отношению к цели (this спереди _target, this за спиной у target) (к this _target повернут лицом, спиной...)
	func(getDirTo)
	{
		objParams_1(_target);

		private _obj = if (!isTypeOf(_target,Mob)) then {callFunc(_target,getBasicLoc)} else {getVar(_target,owner)};

		private _dir = _obj getRelDir getSelf(owner);

		if (_dir > 315 || _dir <= 45) exitWith {DIR_FRONT};
		if (_dir > 45 && _dir <= 135) exitWith {DIR_RIGHT};
		if (_dir > 135 && _dir <= 225) exitWith {DIR_BACK};
		if (_dir > 225 && _dir <= 315) exitWith {DIR_LEFT};
		DIR_FRONT
	};

	//inverted variant of getDirTo
	func(getDirFrom)
	{
		objParams_1(_target);
		private _obj = if (!isTypeOf(_target,Mob)) then {callFunc(_target,getBasicLoc)} else {getVar(_target,owner)};

		private _dir = getSelf(owner) getRelDir _obj;

		if (_dir > 315 || _dir <= 45) exitWith {DIR_FRONT};
		if (_dir > 45 && _dir <= 135) exitWith {DIR_RIGHT};
		if (_dir > 135 && _dir <= 225) exitWith {DIR_BACK};
		if (_dir > 225 && _dir <= 315) exitWith {DIR_LEFT};
		DIR_FRONT
	};

	//Где предмет относительно меня
	"
		name:Направление моба к игровому объекту
		desc:Данный узел возвращает направление между целью и мобом. Цель может находится перед мобом, за его спиной, слева и справа от него. "+
		"Например, если цель другой моб, находящийся за вызывающим, то возвращается направление 'Сзади'.
		type:method
		lockoverride:1
		in:GameObject:Объект-цель:Объект, который находится в стороне от вызывающего.
		return:enum.DirectionSide:Направление цели к вызывающему мобу.
	" node_met
	func(getDirectionTo)
	{
		objParams_1(_target);
		private _dir = getSelf(owner) getRelDir callFunc(_target,getBasicLoc);
		if (_dir > 315 || _dir <= 45) exitWith {DIR_FRONT};
		if (_dir > 45 && _dir <= 135) exitWith {DIR_RIGHT};
		if (_dir > 135 && _dir <= 225) exitWith {DIR_BACK};
		if (_dir > 225 && _dir <= 315) exitWith {DIR_LEFT};
		errorformat("Unknown dir data %1",_dir);
		DIR_FRONT
	};

	//already implemented in GameObject::getDistanceTo
	// "
	// 	name:Расстояние от моба до цели
	// 	desc:Получает расстояние от вызывающего моба до цели в метрах. Целью может быть любой игровой объект, включа сущностей. "+
	// 	"В случае с расстоянием до сущности за конечную точку берется торс сущности. При проверке расстояния до игровых объектов берется центр модели, который помечается значком в редакторе ReEditor.
	// 	type:method
	// 	lockoverride:1
	// 	in:GameObject:Объект-цель:Объект, до которого измеряется расстояние
	// 	return:float:Расстояние в метрах
	// " node_met
	func(getDistanceTo)
	{
		objParams_1(_target);
		getSelf(owner) distance callFunc(_target,getBasicLoc)
	};

	"
		name:Положение моба
		desc:Получает положение (стройку) моба. Например, стоя, лежа и т.д.
		type:get
		lockoverride:1
		return:enum.EntityStance:Положение моба
	" node_met
	func(getStance)
	{
		objParams();
		private _stance = stance getSelf(owner);
		if (_stance == "STAND") exitWith {STANCE_UP};
		if (_stance == "CROUCH") exitWith {STANCE_MIDDLE};
		if (_stance == "PRONE") exitWith {STANCE_DOWN};
		if (_stance == "UNDEFINED") exitWith {STANCE_UP};
		errorformat("Cant find stance enum %1. Returns Stance.Up by default",_stance);
		STANCE_UP
	};

	#define __animget_impl__() (getSelf(owner) call anim_getUnitAnim)
	//Идёт ли медленным шагом
	"
		name:Моб идёт шагом
		desc:Проверяет, идёт ли моб шагом. Если идёт - возвращает истину. При беге и остановке на месте - возвращает ложь.
		type:get
		lockoverride:1
		return:bool:Сущность двигается медленным шагом
	" node_met
	func(isWalking)
	{
		objParams();
		//wlks
		"wlks" in __animget_impl__()
	};
	//бежит ли
	"
		name:Моб бежит
		desc:Проверяет, бежит ли моб. Если бежит - возвращает истину. При шаге и остановке на месте - возвращает ложь.
		type:get
		lockoverride:1
		return:bool:Сущность бежит
	" node_met
	func(isRunning)
	{
		objParams();
		//tacs, runs
		private _anm = __animget_impl__();
		"tacs" in _anm || "runs" in _anm
	};
	"
		name:Моб спринтует
		desc:Проверяет, спринтует ли моб. Спринт - это быстрый бег с зажатым модификаторм спринта (по умолчанию клавиша shift). Если спринтуер - возвращает истину, во всех остальных случаях возвращает ложь.
		type:get
		lockoverride:1
		return:bool:Сущность в спринте
	" node_met
	//на шифте
	func(isSprinting)
	{
		objParams();
		//evas
		private _anm = __animget_impl__();
		"evas" in _anm || "sprs" in _anm /*для лежачего спринта*/
	};

	"
		name:Режим движения моба
		desc:Возвращает режим движения моба.
		type:get
		lockoverride:1
		return:enum.EntitySpeedMode
	" node_met
	func(getSpeedMode)
	{
		objParams();
		if callSelf(isSprinting) exitWith {SPEED_MODE_SPRINT};
		if callSelf(isWalking) exitWith {SPEED_MODE_WALK};
		if callSelf(isRunning) exitWith {SPEED_MODE_RUN};
		SPEED_MODE_STOP
	};
	getter_func(getAnimation,tolower __animget_impl__());
	
	
region(Network sender)
	//отправка сообщения с обработкой на клиенте
	func(sendInfo)
	{
		objParams_2(_mes,_data);
		private _own = getSelf(owner);
		if equals(_own,objNull) exitWith {};
		rpcSendToObject(_own,_mes,_data);
	};

	//негарантированная отправка данных клиенту. обработки нет.
	// Используется для синхронизации клиентом статистических собственных данных
	// Например: стамина, постэффекты, флаги и тд...
	func(fastSendInfo)
	{
		objParams_2(_varname,_data);

		private _own = getSelf(owner);
		if equals(_own,objNull) exitWith {};

		#ifdef emulate_mp_in_sp
			if (not_equals(_own,player) && !isMultiplayer) exitWith {};
		#endif

		_own = owner _own;
		if (_own == 2) exitWith {}; //сервер не должен получать обновления стамины

		netSendVar(_varname,_data,_own)
	};

region(SMD data sync)

	//Запрос на принудительное обновление smd данных
	func(requestSMDUpdate)
	{
		objParams();
		private _mob = getSelf(owner);
		private _prevVal = _mob getVariable ["__smd_lastUpdate",0];
		private _curTick = tickTime;
		if equals(_prevVal,_curTick) then {
			_curTick = _curTick + rand(-5,5);
		};

		_mob setVariable ["__smd_lastUpdate",_curTick,true];
	};

	#define __data_light_slot__ [[INV_BACKPACK,null], [INV_ARMOR,null], [INV_HEAD,null], [INV_BACK,null],[INV_CLOTH,null],[INV_FACE,null],[INV_HAND_R,null],[INV_HAND_L,null],[INV_BELT,null]]
	var(__lightSlots,createHashMapFromArray __data_light_slot__);

	//Производит синхронизацию переменной моба
	func(syncSmdSlot)
	{
		objParams_1(_slotId);
		//#define __debug_mob_sync_smdslot____
		private _lt = getSelf(__lightSlots);

		private _item = callSelfParams(getItemInSlot,_slotId);

		if equals(_item,nullPtr) exitWith {
			#ifdef __debug_mob_sync_smdslot____
			warningformat("SYNC SLOT %1 -> ITEM EMPTY",_slotId arg _item);
			#endif
			[_lt get _slotId] call slt_destr_impl;
			_lt set [_slotId,null];
			netSyncObjVar(getSelf(owner),"smd_s"+str _slotId,0);
		};

		//work with nan in model var
		private _smdInfo = if (callFunc(_item,getClassName)=="SystemHandItem" && {getVar(_item,mode)=="twohand"}) then {
			_item = getVar(_item,object);
			["#TH#",[callFunc(_item,getTwoHandAnim),callFunc(_item,getTwoHandCombAnim)]];
		} else {
			if ((_slotId in [INV_HAND_R,INV_HAND_L]) && {callSelfParams(isHoldedTwoHands,_item)}) then {
				[getVar(_item,model),[callFunc(_item,getTwoHandAnim),callFunc(_item,getTwoHandCombAnim)]];
			} else {
				[getVar(_item,model),[callFunc(_item,getHandAnim),callFunc(_item,getCombAnim)]];
			};
		};

		private _cfgLight = if callFunc(_item,canLight) then {
			if getVar(_item,lightIsEnabled) then {
				[getVar(_item,light)]
			} else {
				[-1]
			}
		} else {
			[-1]
		};

		//unreg slt if exists
		if !isNull(_lt get _slotId) then {
			[_lt get _slotId] call slt_destr_impl;
			_lt set [_slotId,null];
		};

		//register light at unit
		if ((_cfgLight select 0) > -1) then {
			_lt set [_slotId,
				[
					getSelf(owner),
					_cfgLight select 0,
					false,
					["spine3","spine3","head","rightshoulder","spine3","face","lefthand","righthand","pelvis"] select _slotId
				] call slt_create
			];
		};

		if callFunc(_item,isRadio) then {
			if getVar(_item,radioIsEnabled) then {
				_cfgLight pushBack callFunc(_item,getRadioDataForInventory)
			} else {
				_cfgLight pushBack -1;
			};
		};

		//[INV_BACKPACK, INV_ARMOR, INV_HEAD, INV_BACK,INV_CLOTH,INV_FACE,INV_HAND_R,INV_HAND_L,INV_BELT]
		//private _selection = ["spine3","spine3","head","rightshoulder","spine3","face","lefthand","righthand","pelvis"] select _slotId;

		_smdInfo append _cfgLight;
		#ifdef __debug_mob_sync_smdslot____
		warningformat("SYNC SLOT %1 -> ITEM %2 (data:%3)",_slotId arg _item arg _smdInfo);
		#endif
		netSyncObjVar(getSelf(owner),"smd_s"+str _slotId,_smdInfo);
	};

	func(syncSmdVar)
	{
		objParams_2(_var,_val);
		netSyncObjVar(getSelf(owner),"smd_"+_var,_val);
	};
	
	//обрабатывает и получает статус частей тела для рендеринга на персонаже
	func(getBodyPartStatusArray)
	{
		objParams();
		[true,true,true,true]
	};
	
	func(syncBodyParts)
	{
		objParams();
		
		private _list = callSelf(getBodyPartStatusArray);
		netSyncObjVar(getSelf(owner),"smd_bodyParts",_list);

		if (!callSelf(isPlayer)) then {
			// sync anim if not playable mob
			private _isBodyPartsChanged = true;
			[getSelf(owner)] call anim_syncAnim;
		};
	};

region(lighting helper)

	var(__lastClientLighting,0);

	//Получает уровень освещённости сущности
	"
		name:Уровень освещённости моба
		desc:Возвращает уровень освещённости моба на стороне сервера. Чем больше источников света попадает на моба, тем больше это значение и тем лучше его видно.
		type:get
		lockoverride:1
		return:enum.LightMode:Уровень освещённости
	" node_met
	func(getLighting)
	{
		objParams();
		
		if (callSelf(isPlayer) 
			#ifndef EDITOR
				&& getSelf(isStealthEnabled)
			#else
				&& (getSelf(isStealthEnabled) || !isNullVar(__MOB_SETPRESTEALTH_FLAG_EDITOR__))
			#endif
		) then {
			getSelf(__lastClientLighting)
		} else {
			round linearConversion [10,60,(getLightingAt getSelf(owner)) select 3,0,4,true]
		};
		/*private _lum = parseNumber(((getLightingAt getSelf(owner)) select 3)toFixed 3);
		private _val = (_lum / 300) max 0 min 1;
		if (_val == 0) exitWith {LIGHT_NO};//0
		if (_val > 0 && _val <= 0.3) exitWith {LIGHT_LOW};//1
		if (_val > 0.3 && _val <= 0.5) exitWith {LIGHT_MEDIUM};//2
		if (_val > 0.5 && _val <= 0.8) exitWith {LIGHT_LARGE};//3
		LIGHT_FULL//4
		*/
	};

region(Visual states)
	var(__visualStates,[]); //массив визуальных состояний
	//Добавить визуальный статус
	func(addVisualState)
	{
		objParams_2(_state,_ctxParams);
		if isNullVar(_ctxParams) then {
			getSelf(__visualStates) pushBack _state;
		} else {
			getSelf(__visualStates) pushBack [_state,_ctxParams];
		};

		#ifdef EDITOR_OR_SP_MODE
			callSelfParams(syncSmdVar,"visualStates" arg array_copy(getSelf(__visualStates)));
		#else
			callSelfParams(syncSmdVar,"visualStates" arg getSelf(__visualStates));
		#endif
	};
	//Удалить визуальный статус
	func(removeVisualState)
	{
		objParams_1(_state);
		private _states = getSelf(__visualStates);
		_states deleteAt (_states findif {ifcheck(equalTypes(_x,[]),equals(_x select 0,_state),equals(_x,_state))});

		#ifdef EDITOR_OR_SP_MODE
			callSelfParams(syncSmdVar,"visualStates" arg array_copy(getSelf(__visualStates)));
		#else
			callSelfParams(syncSmdVar,"visualStates" arg getSelf(__visualStates));
		#endif

	};
	
	func(hasVisualState)
	{
		objParams_1(_state);
		(getSelf(__visualStates) findif {ifcheck(equalTypes(_x,[]),equals(_x select 0,_state),equals(_x,_state))})!=-1
	};
	
	func(updateVisualState)
	{
		objParams_3(_state,_eventState,_onCreate);
		
		if callSelfParams(hasVisualState,_state) then {
			
			private _states = getSelf(__visualStates);
			private _idx = _states findif {ifcheck(equalTypes(_x,[]),equals(_x select 0,_state),equals(_x,_state))};
			if (_idx == -1) exitWith {
				errorformat("updateVisualState() - visual state not exists: %1",_state);
			};
			_states set [_idx,(_states select _idx) call _eventState];
			
			#ifdef EDITOR_OR_SP_MODE
				callSelfParams(syncSmdVar,"visualStates" arg array_copy(getSelf(__visualStates)));
			#else
				callSelfParams(syncSmdVar,"visualStates" arg getSelf(__visualStates));
			#endif
			
		} else {
			callSelfParams(addVisualState,_state arg _onCreate);
		};
	};

region(Messaging and chat managers)
	
	"
		name:Установить имена моба
		desc:Устанавливает первое и второе имя моба. Генерирует имена во всех склонениях.
		type:method
		lockoverride:1
		in:string:Первое имя:Первое имя моба.
		in:string:Второе имя:Второе имя моба. Чаще всего представлено в виде фамилии.
			opt:require=-1
	" node_met
	func(generateNaming)
	{
		objParams_2(_f,_s);
		setSelf(name,_f);
		[this,_f,_s] call naming_generateName;
	};

	"
		name:Первое имя моба
		namelib:Первое имя моба (Имя)
		desc:Получает первое имя моба. В большинстве случаев первым именем является имя персонажа.
		type:get
		lockoverride:1
		return:string:Имя
	" node_met
	func(getFirstName)
	{
		objParams();
		private _arr = (callSelfParams(getNameEx,"кто") splitString " ");
		private _el = _arr select 0;
		if isNullVar(_el) exitwith {""};
		_el
	};

	"
		name:Второе имя моба
		namelib:Второе имя моба (Фамилия)
		desc:Получает второе имя моба. В большинстве случаев вторым именем является фамилия или кличка персонажа.
		type:get
		lockoverride:1
		return:string:Второе имя (фамилия)
	" node_met
	func(getSecondName)
	{
		objParams();
		private _arr = (callSelfParams(getNameEx,"кто") splitString " ");
		if (count _arr < 2) exitWith {""};
		private _el = _arr select [1,count _arr];
		_el joinString " "
	};
	
	//Получает актуальное имя персонажа со склонением
	"
		name:Полное имя моба в склонении
		desc:Получает вариацию имени и фамилии моба в указанном склонении
		type:method
		lockoverride:1
		in:enum.NamingDeclension:Склонение:Требуемое склонение для полного имени
		return:string:Полное имя в указанном склонении
	" node_met
	func(getNameEx)
	{
		objParams_1(_sklon);
		if isNullVar(_sklon) then {_sklon = "кто"};
		private _namingObj = getSelf(Naming);
		if equalTypes(_sklon,0) then {
			_sklon = callFuncParams(_namingObj,enumNamingToText,_sklon);
		};
		private _skCtx = getVarReflect(_namingObj,_sklon);
		if (isNullVar(_skCtx)) exitWith {"Ошибочка"};
		_skCtx
	};

	"
		name:Первое имя моба в склонении
		namelib:Первое имя моба в склонении (Имя)
		desc:Получает вариацию первого имени моба в указанном склонении.
		type:method
		lockoverride:1
		in:enum.NamingDeclension:Склонение:Требуемое склонение для имени.
		return:string:Имя в указанном склонении.
	" node_met
	func(getFirstNameEx)
	{
		objParams_1(_sk);
		private _arr = (callSelfParams(getNameEx,_sk) splitString " ");
		private _el = _arr select 0;
		if isNullVar(_el) exitwith {""};
		_el
	};

	"
		name:Второе имя моба в склонении
		namelib:Второе имя моба в склонении (Фамилия)
		desc:Получает вариацию второго имени (фамилии) моба в указанном склонении.
		type:method
		lockoverride:1
		in:enum.NamingDeclension:Склонение:Требуемое склонение для фамилии.
		return:string:Фамилия в указанном склонении.
	" node_met
	func(getSecondNameEx)
	{
		objParams_1(_sk);
		private _arr = (callSelfParams(getNameEx,_sk) splitString " ");
		if (count _arr < 2) exitWith {""};
		private _el = _arr select [1,count _arr];
		_el joinString " "
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		""
	};

	func(examine)
	{
		objParams_1(_target);

		private _text = callFuncParams(_target,getDescFor,this);
		if (_text == "") exitWith {};
		callSelfParams(sendInfo,"chatPrint" arg vec2(_text,"info"));
	};

	getter_func(isFirstJoin,!isNull(getSelf(__firstLoginMesPool)));
	var_array(__firstLoginMesPool); //пул чистится после первого подключения
	//Добавляет сообщение, которое будет вызвано 1 раз при первом подключении клиента к мобу
	func(addFirstJoinMessage)
	{
		objParams_1(_text);
		getSelf(__firstLoginMesPool) pushBack _text;
		/*if callSelf(isPlayer) then {
			callSelfParams(localSay,_text arg "");
		} else {
			getSelf(__firstLoginMesPool) pushBack _text;
		};*/
	};
	func(printFirstJoinMessage)
	{
		objParams();
		callSelfParams(ShowMessageBox,"Text" arg getSelf(__firstLoginMesPool) joinString sbr);
	};

	"
		name:Локальное сообщение мобу
		desc:Отправляет мобу-игроку в чат переданный текст. Другие игроки не увидят это сообщение.
		type:method
		lockoverride:1
		in:string:Сообщение:Текст сообщения.
		in:enum.ChatMessageChannel:Тип:Тип сообщения.
	" node_met
	func(_localSayWrapper)
	{
		assert_str(count _this > 2,"Param count error");
		private _ch = _this select 2;
		assert_str(!isNullVar(_ch),"Channel param cannot be null");
		assert_str(equalTypes(_ch,0),"Channel param type error. Must be integer - not " + typename _ch);
		assert_str(inRange(_ch,0,count go_internal_chatMesMap - 1),"Channel index out of range: " + str _ch);
		_this set [2,go_internal_chatMesMap select _ch];
		
		private this = _this select 0;
		_this call getSelfFunc(localSay)
	};
	
	func(localSay)
	{
		objParams_2(_text,_channel);
		if !callSelf(isPlayer) exitWith {};
		rpcSendToObject(getSelf(owner),"chatPrint",[_text arg _channel]);
	};
	
	func(worldSay)
	{
		params ['this',"_text","_channel",["_dist",DISTANCE_WORLDSAY]];

		private _nearMobs = getSelf(owner) nearEntities _dist;

		{
			if (isPlayer _x) then {
				if callFuncParams(_x getVariable vec2("link",nullPtr),canSeeObject,this) then {
					rpcSendToObject(_x,"chatPrint", [_text arg _channel]);
				};
			};
		} foreach _nearMobs;
	};

	//действие от лица персонажа.
	"
		name:Эмоут от моба
		desc:Отправляет эмоут сообщение от лица вызывающего моба. К сообщению в начало текста автоматически добавляется полное имя моба в именительном падеже.
		type:method
		lockoverride:1
		in:string:Сообщение:Текст эмоута.
	" node_met
	func(meSay)
	{
		objParams_1(_mes);
		forceUnicode 1;
		//add space if not starts with
		if (_mes select [0,1] != " ") then {
			_mes = " " + _mes;
		};
		callSelfParams(worldSay,callSelfParams(getNameEx,"кто") + _mes arg "act");
	};


	//Регистрация знания персонажей
	func(addToKnown)
	{
		objParams_1(_m);
		if !isTypeOf(_m,Mob) exitWith {};
		getSelf(knownMobsList) pushBackUnique _m;
	};
	func(removeFromKnown)
	{
		objParams_1(_m);
		if !isTypeOf(_m,Mob) exitWith {};
		getSelf(knownMobsList) deleteAt (getSelf(knownMobsList) find _m);
	};

	/*
		Система знания имён.
		я не знаю реального имени если:
			- не знаю персонажа
			- его лицо скрыто
				- если роль мне известна то по одежде определяем
		если он одет в ролевую одежду, то:
			- я знаю имя его роли

		Новое:

		для видимости сообщения учитываются правила:
			- видно в любом случае пока что...

		для того чтобы определить будет ли видно имя, роль или общее название персонажа
		нужно учитывать факторы:
			- видимость лица
			- запомнен
			- знание роли
	*/

	//Получает известное имя цели для этого персонажа
	func(getKnownName)
	{
		params ['this',"_targ",["_sklon",""]];
		""
	};
	func(isKnownTarget)
	{
		objParams_1(_targ);
		if equals(_targ,this) exitWith {true};
		_targ in getSelf(knownMobsList);
	};
	/*
		печатает сообщение
		строка принимается в формате с примером:
		"[src.кто] пожал руку [targ.кому]."

	*/
	func(visibleSay)
	{
		params ['this',"_mes","_chan",["_optTarget",nullPtr],["_dist",DISTANCE_WORLDSAY],["_optItem",nullPtr]];
		forceUnicode 1;
		private _srcRealName = "";
		private _srcHiddenName = "";
		private _srcRoleName = "";
		if ([_mes,"\[src(\.(кто|кого|кому|вин|кем|ком))?\]/i"] call regex_isMatch) then {

			(([_mes,"\[src(\.(кто|кого|кому|вин|кем|ком))?\]/i"] call regex_getFirstMatch)
				splitString"[.]")
				params ["",["_sklon","кто"]];

			_mes = [_mes,"\[src(\.(кто|кого|кому|вин|кем|ком))?\]/i","%1"] call regex_replace;

			_srcRealName = callFuncParams(this,getNameEx,_sklon);
			_srcHiddenName = getVarReflect(getSelf(gender),_sklon);

		};
		private _targRealName = "";
		private _targHiddenName = "";
		private _targRoleName = "";
		if ([_mes,"\[targ(\.(кто|кого|кому|вин|кем|ком))?\]/i"] call regex_isMatch) then {
			(([_mes,"\[targ(\.(кто|кого|кому|вин|кем|ком))?\]/i"] call regex_getFirstMatch)
				splitString"[.]")
				params ["",["_sklon","кто"]];

			_mes = [_mes,"\[targ(\.(кто|кого|кому|вин|кем|ком))?\]/i","%2"] call regex_replace;

			_targRealName = callFuncParams(_optTarget,getNameEx,_sklon);
			_targHiddenName = getVarReflect(getVar(_optTarget,gender),_sklon);
		};

		if isNullReference(_optTarget) then {_optTarget = this}; //редирект на локального игрока

		//самый быстрый алгоритм без лишних вызовов
		private _nearMobs = getSelf(owner) nearEntities _dist;

		//Игроку отсылаем сообщение

		//caller and target name
		private _cname = _srcRealName;
		private _tname = if callSelfParams(isKnownTarget,_optTarget) then {_targRealName} else {_targHiddenName};
		private _text = format[_mes,_cname,_tname];
		//rpcSendToObject(_x,"chatPrint", [_text arg _chan]);
		{
			//проверка по дистанции:
			_refMob = _x getVariable "LINK";
			//TODO: переработать. если я смотрю на чела то он при || вместо && видит моё сообщение
			if (callFuncParams(_refMob,canSeeObject,this) || callFuncParams(_refMob,canSeeObject,_optTarget)) then {

				//Правка выше решается так: если _refMob==_optTarget && !canSeeObject.this -> skip

				//Получение имён
				_cname = if callFuncParams(_refMob,isKnownTarget,this) then {
					_srcRealName
				} else {
					_srcHiddenName
				};
				_tname = if callFuncParams(_refMob,isKnownTarget,_optTarget) then {
					_targRealName
				} else {
					_targHiddenName
				};

				rpcSendToObject(_x,"chatPrint", [format vec3(_mes,_cname,_tname) arg _chan]);
			};

			true;
		} count (_nearMobs/* - [getSelf(owner)]*/);
	};

	//проигрывает мысль персонажа
	"
		name:Мысль мобу
		desc:Отправляет вызывающему мобу в чат локальное сообщение категории перечисления ""Мысли"".
		type:method
		lockoverride:1
		in:string:Сообщение:Текст мысли.
	" node_met
	func(mindSay)
	{
		objParams_1(_mes);
		callSelfParams(localSay,_mes arg "mind");
	};

	func(addCamShake)
	{
		objParams_4(_pwrPos,_pwrDir,_freq,_dur);
		callSelfParams(sendInfo,"camshake" arg [_pwrPos arg _pwrDir arg _freq arg _dur]);
	};

region(Animator)

	_anim = {
		(_this select 0) switchmove (_this select 1)
	}; rpcAdd("switchMove",_anim);
	
	_anim = {
		(_this select 0) switchmove (_this select 1);
		(_this select 0) playMoveNow (_this select 1); //fix force switchmove for fuckedup animations configs
	}; rpcAdd("switchMove_force",_anim);

	_anim = {
		(_this select 0) switchmove (_this select 1)
	}; rpcAdd("switchAction",_anim);

	//Плавная смена анимации
	_anim = {
		(_this select 0) playMove (_this select 1)
	}; rpcAdd("playMove",_anim);

	//установить мимику
	_anim = {
		(_this select 0) setMimic (_this select 1)
	}; rpcAdd("setMimic",_anim);

	func(applyGlobalAnim)
	{
		objParams_2(_method,_type);

		private _mob = getSelf(owner);

		//changed after 0.4.75
		if (_method == "switchmove" || _method == "switchmove_force") then {
			
			//На сервере тоже вызываем метод
			rpcCall(_method,[_mob arg _type]);

			{
				rpcSendToObject(_x,_method,[_mob arg _type]);

			} foreach allPlayers;
			
			//Отладочная информация. Будет убрано после отлова ошибки синхронизации
			["[applyGlobalAnim]: local - %1 (player=%6); Count: %2; Serversync: %3; Owner: %4; State %5;",
				local _mob,
				count allPlayers,
				animationState _mob == _type,
				owner _mob,
				_type,
				isPlayer _mob
			] call logInfo;

			// //Тестовое исправление синхронизации по сети
			// //вызов события только на локальном контексте
			// //Если функционал правильно работает, то можно убрать фикс от 0.4.75
			// if (isPlayer _mob) then {
			// 	rpcSendToObject(_mob,_method,[_mob arg _type]);
			// } else {
			// 	rpcCall(_method,[_mob arg _type]);
			// };			

		} else {

			if (isPlayer _mob) then {
				rpcSendToObject(_mob,_method,[_mob arg _type]);
			} else {
				rpcCall(_method,[_mob arg _type]);
			};
		};

	};

	//Вызывается при изменении скорости анимации
	func(onChangeAnimCoef)
	{
		objParams();
		//0.5-10 -> 0.5-1.4
		private _move = callSelf(getMove) ;
		//bonuses
		private _encumBon = [getSelf(curEncumbranceLevel)] call gurps_encumLevelToMoveModifier;
		_move = _move * _encumBon;
		

		//private _anmCoeff = getSelf(animCoef);
		private _curSpeed = linearConversion[0.1,10,_move,0.5,1.4,true];

		callSelfParams(setAnimSpeedCoef,_curSpeed);

	};

	func(setAnimSpeedCoef)
	{
		objParams_1(_val);
		#ifdef EDITOR_OR_SP_MODE
		if !callSelf(isPlayer) exitWith {};
		#endif
		callSelfParams(syncSmdVar,"animSpeed" arg _val);
	};

	//установка кастомной анимации для частей тела, например для связки
	//Если параметр _ani null то состояние будет сброшено в дефолт
	func(setCustomAnimState)
	{
		objParams_3(_ani,_blen,_prfx);
		
		private _list = [];

		//reset settings
		if isNullVar(_ani) then {
			_list = 0;
		} else {
			_list pushBack _ani;
			if !isNullVar(_blen) then {
				_list pushBack _blen;
			};
			if !isNullVar(_prfx) then {
				_list pushBack _prfx;
			};
		};

		netSyncObjVar(getSelf(owner),"smd_custAnm",_list);

		if (!callSelf(isPlayer)) then {
			[getSelf(owner)] call anim_syncAnim;
		};
	};
	
region(Face and voice helpers)

	"
		name:Лицо моба
		desc:Получает имя конфигурации лица моба (конфиг из Платформы).
		type:get
		lockoverride:1
		return:string:Лицо моба
	" node_met
	getter_func(getMobFace,getSelf(face));

	var(face,""); //no face by default

	//Устанавливает лицо персонажу как smd переменную
	"
		name:Установить лицо мобу
		desc:Устанавливает лицо мобу и синхронизирует его между остальными игроками.
		type:method
		lockoverride:1
		in:string:Лицо:Имя конфигурации лица моба (см. узел 'Лицо моба')
	" node_met
	func(setMobFace)
	{
		objParams_1(_face);
		
		if (_face != "") then {
			private _hasNoHeadPostfix = "_nohead" in _face;
			
			if !(_face call facesys_hasFace) then {
				errorformat("%1::setMobFace() - Face %2 does not exists. Random reselect processed...",callSelf(getClassName) arg _face);
				_face = pick faces_list_man;
				if (_hasNoHeadPostfix) then {
					modvar(_face) + "_nohead";				
				};
			};
		};

		setSelf(face,_face);
		
		callSelfParams(syncSmdVar,"face" arg _face);
	};

	func(setMobFaceAnim)
	{
		objParams_1(_anim);

		setSelf(faceAnim,_anim);

		callSelfParams(syncSmdVar,"faceAnim" arg _anim);
	};

	func(syncMobFaceAnim)
	{
		objParams();
		if callSelf(isActive) then {
			callSelfParams(setMobFaceAnim,DEFAULT_MIMIC);
		} else {
			callSelfParams(setMobFaceAnim,UNC_MIMIC);
		};
	};
	
	var(voiceType,"human");
	var(__originVoiceType,null); //системное для updateVoiceType
	
	// (re)initialization of voice charachter
	func(applyVoiceType)
	{
		objParams_1(_vt);
		private _isInit = isNullVar(_vt);
		if (_isInit) then {
			_vt = getSelf(voiceType);
			setSelf(__originVoiceType,_vt);
		}; //null equals first initialization
		private _owner = getSelf(owner);
		
		//network optimization
		if (_vt == (_owner getvariable ["vs_vt","-"])) exitWith {};
		
		if (!_isInit) then {
			if ("_block" in _vt) then {
				callSelfParams(mindSay,"Я больше не могу говорить...");
			} else {
				callSelfParams(mindSay,"Теперь я могу разговаривать!");
			};
		};

		setSelf(voiceType,_vt);
		_owner setVariable ["vs_vt",_vt,true];
	};

	func(updateVoiceType)
	{
		objParams_1(_vt);
		
		//reset to origin
		if isNullVar(_vt) then {
			callSelfParams(applyVoiceType,getSelf(__originVoiceType));
		} else {
			callSelfParams(applyVoiceType,_vt);
		};
	};

region(Sound helpers)
	//Проигрывает объект звука
	func(playSoundData)
	{
		objParams_2(_soundParams,_dist);
		_soundParams params ["_path",["_pMin",0.5],["_pMax",2]];
		private _pith = getRandomPitchInRange(_pMin,_pMax);

		if !isNullVar(_dist) then {
			callSelfParams(playSound,args3(_path,_pith,_dist));
		} else {
			callSelfParams(playSound,args2(_path,_pith));
		};

	};

	"
		name:Проиграть локальный звук мобу
		desc:Воспроизводит звук у клиента, играющего за вызывающего моба. Другие игроки не услышат этот звук.
		type:method
		lockoverride:1
		in:string:Путь:Путь до файла звука, например: ""fire\\torch_on""
		in:float:Тон:Тон звука. 2 - максимальный возможный, 0.5 - минимальный возможный
			opt:def=1
		in:float:Дистанция:Дистанция в метрах, на которой будет слышно звук.
			opt:def=50
		in:float:Громкость:Громкость звука. Не рекомендуется менять это значение
			opt:def=1
		in:auto:Источник:Источник звука. Если не указан, то звук воспроизведется из позиции вызывающего моба.
			opt:require=0:typeget=value;@type:allowtypes=GameObject^|vector3
	" node_met
	func(playSoundLocal)
	{
		params ['this',"_path",["_pitch",1],["_maxDist",50],["_vol",1],"_atPos"];
		private _source = if(!isNullVar(_atPos)) then {
			if equalTypes(_atPos,nullPtr) then {
				callFunc(_atPos,getBasicLoc)
			} else {
				_atPos
			};
		} else {
			callSelf(getBasicLoc)
		};

		private _data = [_path arg _source arg _vol arg _pitch arg _maxDist];
		callSelfParams(sendInfo,"sl_p" arg _data);
	};
	
	func(playMusic)
	{
		params ['this',"_pathOrArray","_chan","_ctx"];
		private _client = getSelf(client);
		if isNullReference(_client) exitWith {};
		callFuncParams(_client,playMusic, _pathOrArray arg _chan arg _ctx);
	};
	func(pauseMusic)
	{
		params ['this',"_chan",["_smooth",false]];
		private _client = getSelf(client);
		if isNullReference(_client) exitWith {};
		callFuncParams(_client,pauseMusic, _chan arg _smooth);
	};
	func(stopMusic)
	{
		params ['this',"_chan"];
		private _client = getSelf(client);
		if isNullReference(_client) exitWith {};
		callFuncParams(_client,stopMusic, _chan);
	};

	//вызов ServerClient::playSound() для воспроизведения локальных системных ui-звуков
	func(playSoundUI)
	{
		params['this',"_path",["_pitch",1],["_vol",1],"_isEffect"];
		private _client = getSelf(client);
		if isNullReference(_client) exitWith {};
		callFuncParams(_client,playSound,_path arg _pitch arg _vol arg _isEffect);
	};
	
region(Progress helpers)
	
	//progress subsystem
	var(progressData,vec3(nullPtr,"",nullPtr)); //ref target, method call, optional item
	
	/*
		lambda-like progress extension with context passing
		Usage:
		
		private _number = 123;
		private _bool = false;
		_code = {
			/// called after 3 seconds
			assert(_number == 123);
			assert(!_bool);
		};
		callSelfParams(doAfter,_code arg 3 arg ["_number" arg "_bool"]);
	*/
	func(doAfter)
	{
		params ['this',"_code__","_callAfter","_context",["_checkType",-1]];
		
		if equalTypes(_context,"") then {
			_context = [_context];
		};
		private _ctxSignature = _context joinString "+";
		if (!(_ctxSignature in mob_static_assign_signatures)) then {
			private _builder = [];
			{
				_builder pushBack (format["_ctxVals set [%1,%2];",_foreachindex,_x]);
			} foreach _context;
			mob_static_savectx_signatures set [_ctxSignature,compile (_builder joinString endl)];
		};

		//fill values
		private _ctxVals = [];
		0 call (mob_static_savectx_signatures get _ctxSignature);
		
		setSelf(___doafter_code,_code__);  //[array<keys>,array<values>]
		setSelf(__doafter_context,[_context arg _ctxVals]);
		callSelfParams(startSelfProgress,"__doAfter_completed" arg _callAfter arg _checkType);
	};
	//transfer context
	var(___doafter_code,null);
	var(__doafter_context,null);
	
	func(__doAfter_completed)
	{
		objParams();
		private _da_ctx__ = getSelf(__doafter_context);
		setSelf(__doafter_context,null);
		if isNullVar(_da_ctx__) exitWith {
			this call (getSelf(___doafter_code));
			setSelf(___doafter_code,null);
		};
		
		private _vars = _da_ctx__ select 0;
		private _assignSignature = _vars joinString "+";
		private _vals = _da_ctx__ select 1;
		if !(_assignSignature in mob_static_assign_signatures) then {
			private _str = [];
			{
				_str pushBack (format["%1 = _this select %2;",_x,_foreachindex]);
			} foreach _vars;
			mob_static_assign_signatures set [_assignSignature,compile (_str joinString endl)];
		};
		//setup context vars
		private _vars;
		_vals call (mob_static_assign_signatures get _assignSignature);

		this call (getSelf(___doafter_code));
		setSelf(___doafter_code,null);
	};
	//caching doAfter context
	mob_static_savectx_signatures = createhashMap;
	mob_static_assign_signatures = createhashMap;

	//faster equivalent
	func(startSelfProgress)
	{
		params ['this',"_met","_callAfter",["_checkType",-1]];
		callSelfParams(startProgress,this arg "caller."+_met arg _callAfter arg _checkType)
	};

	//use: callSelfParams(startProgress,_t arg "target.methodImpl" arg 3)
	//TODO async check on server if non-player
	func(startProgress)
	{
		params ['this',"_target","_method","_callAfter",["_checkType",-1],["_optItem",nullPtr]];
		
		if callSelf(isProgressProcess) then {
			callSelfParams(stopProgress,true);
		};

		private _tokens = _method splitString ".";
		if (count _tokens != 2) exitWith {
			_method = "target." + _method;
		};
		if !isNullReference(_optItem) then {
			//asyncInvoke(c_condit,c_state,args,timeout,c_tim)
			startAsyncInvoke
				{
					params ['this',"_optItem","_lastLoc","_lastSlot"];
					if (isNullReference(_optItem) || isNullReference(this)) exitWith {true};
					if !callSelf(isProgressProcess) exitWith {true}; //защита от дубликации прогрессов
					if (not_equals(getVar(_optItem,loc),_lastLoc) || not_equals(getVar(_optItem,slot),_lastSlot)) exitWith {true};
					false
				},
				{
					callSelfParams(stopProgress,true);
				},
				[this,_optItem,getVar(_optItem,loc),getVar(_optItem,slot)],
				_callAfter
			endAsyncInvoke
		} else {
			//Предмет должен находится в одной позиции для прогресса
			if callFunc(_target,isItem) then {
				startAsyncInvoke
					{
						params ['this',"_target","_lastLoc","_lastSlot"];
						if isNullReference(_target) exitWith {true};
						if !callSelf(isProgressProcess) exitWith {true};
						if (not_equals(getVar(_target,loc),_lastLoc) || not_equals(getVar(_target,slot),_lastSlot)) exitWith {true};
						false
					},
					{
						callSelfParams(stopProgress,true);
					},
					[this,_target,getVar(_target,loc),getVar(_target,slot)],
					_callAfter
				endAsyncInvoke
			};
		};
		//params ["_ptrPlayer","_target","_checkType","_duration"];
		/*
		0 - dropped on moving, rotation or click client
		1 - dropped on moving or click client
		2 - dropped on moving
		*/
		if (_checkType <= -1) then {
			if !isNullReference(_optItem) exitWith {_checkType = INTERACT_PROGRESS_TYPE_FULL};
			if equals(this,_target) exitWith {_checkType = INTERACT_PROGRESS_TYPE_MEDIUM};
			_checkType = INTERACT_PROGRESS_TYPE_LAZY;
		};
		if !isNullVar(__F_PR) then {
			setSelf(progressData,vec4(_target,_method,_optItem,true));
		} else {
			setSelf(progressData,vec3(_target,_method,_optItem));
		};
		if callSelf(isPlayer) then {
			callSelfParams(sendInfo,"startProg" arg vec4(getSelf(pointer),ifcheck(callFunc(_target,isMob),getVar(_target,owner),getVar(_target,pointer)),_checkType,_callAfter));
		} else {
			callSelfAfter(successProgress,_callAfter);
		};
	};

	getter_func(isProgressProcess,(getSelf(progressData) select 1) != "");

	func(stopProgress)
	{
		objParams_1(_sendClient);
		if !callSelf(isProgressProcess) exitWith {};
		setSelf(progressData,vec3(nullPtr,"",nullPtr));
		if (_sendClient) then {
			callSelfParams(sendInfo,"cnclprg");
		};
	};

	func(successProgress)
	{
		objParams();
		if !callSelf(isProgressProcess) exitWith {};
		getSelf(progressData) params ["_targ","_method","_optItem","__F_PR_SUCCESS"];
		callSelfParams(stopProgress,false);
		private _tokens = _method splitString ".";
		if (count _tokens != 2) exitWith {
			errorformat("Mob::successProgress() - Wrong method signature (%1)",_method);
		};
		_tokens params ["_callTarget","_refMethod"];
		traceformat("RETDATA: %1; %2; %3; %4;",_tokens arg _targ arg _method arg _optItem);
		if (_callTarget == "caller") exitWith {
			if equals(this,_targ) then {
				if isNullReference(_optItem) then {
					callSelfReflect(_refMethod);
				} else {
					callSelfReflectParams(_refMethod,_optItem);
				};
			} else {
				callSelfReflectParams(_refMethod,_targ arg _optItem);
			};
		};
		if (_callTarget == "target") exitWith {
			if isNullReference(_optItem) then {
				callFuncReflectParams(_targ,_refMethod,this);
			} else {
				callFuncReflectParams(_targ,_refMethod,this arg _optItem);
			};
		};
		if (_callTarget == "item") exitWith {
			if isNullReference(_optItem) exitWith {};
			callFuncReflectParams(_optItem,_refMethod,_targ arg this);
		};
		errorformat("Mob::successProgress() - Unknown call category: %1",_callTarget);
	};

region(Extended progress subsystem)
	/*
		Для этой подсистемы используется соглашение об именованиях методов [name]Progress ->
		func(testProgress)
		{
			objParams();
			_someval = 1;
			if callSelf(isSuccessContextProgress) then {
				/// calling progress action
			} else {
				///launch progress
				callSelfParams(startSelfContextProgress,this arg "caller.testProgress" arg 3 arg INTERACT_PROGRESS_TYPE_MEDIUM);
			};
		};
	*/
	getter_func(startSelfContextProgress,private __F_PR = true; callSelfParams(startSelfProgress,_this));
	getter_func(startContextProgress,private __F_PR = true; callSelfParams(startProgress,_this));
	getter_func(isSuccessContextProgress,!isNullVar(__F_PR_SUCCESS));

region(Local effects)
	var(__lcfmap,createHashMap);
	func(localEffectUpdate)
	{
		objParams_2(_name,_context);
		_name = tolower _name;
		getSelf(__lcfmap) set [_name,_context];
		callSelfParams(sendInfo,"lcfupd" arg [_name arg _context]);
	};

	func(localEffectRemove)
	{
		objParams_1(_name);
		_name = tolower _name;
		getSelf(__lcfmap) deleteAt 0;
		callSelfParams(sendInfo,"lcfrem" arg _name);
	};

	func(localEffectClearAll)
	{
		objParams();
		private _map = getSelf(__lcfmap);
		{
			_map deleteAt _x;
		} foreach (keys _map);
		callSelfParams(sendInfo,"lcfclr");
	};

	func(localEffectSyncAll)
	{
		objParams();
		{
			callSelfParams(sendInfo,"lcfupd" arg [_x arg _y]);
		} foreach getSelf(__lcfmap);
	};

	func(localEffectExists)
	{
		objParams_1(_name);
		(tolower _name) in getSelf(__lcfmap)
	};

region(banned combat setting)

	getter_func(isFailCombat,false);

	func(applyFailCombat)
	{
		objParams();
		private _parts = [getSelf(bodyParts) get BP_INDEX_ARM_R];
		_parts pushBack (getSelf(bodyParts) get BP_INDEX_ARM_L);
		_parts pushBack (getSelf(bodyParts) get BP_INDEX_LEG_R);
		_parts pushBack (getSelf(bodyParts) get BP_INDEX_LEG_L);
		private _existsParts = [];
		{
			if isNullVar(_x) then {continue};
			if isNullReference(_x) then {continue};
			_existsParts pushBack _x;
		} foreach _parts;

		if (prob(40) && (count _existsParts > 0)) then {
			private _limb = pick _existsParts;
			callSelfParams(lossLimb, getVar(_limb,bodyPartIndex));
		} else {
			callSelf(KnockDown);
			private _timer = randInt(5,10);
			#ifdef EDITOR
			_timer = 1;
			#endif
			callSelfParams(Stun,_timer arg true arg true);
			callSelfParams(adjustPain,BP_INDEX_TORSO arg randInt(200,500));
		};
	};

region(Step sounds component)

	func(handleStepSounds)
	{
		objParams_1(_obj);
		private _matObj = getVar(_obj,material);
		private _defaultReturn = {
			callSelfParams(sendInfo,"os_gs" arg vec2(getVar(_obj,pointer),-1));
		};

		if (isNullVar(_matObj) || {not_equalTypes(_matObj,nullPtr)}) exitWith _defaultReturn;
		if isNullReference(_matObj) exitWith _defaultReturn;

		private _kStep = callFunc(_matObj,getStepDataKey);
		callSelfParams(sendInfo,"os_gs" arg vec2(getVar(_obj,pointer),_kStep));
	};

	var(__enabledStepSoundSys,false);
	
	getter_func(isStepSoundSystemEnabled,getSelf(__enabledStepSoundSys));

	func(setStepSoundSystem)
	{
		objParams_1(_mode);
		if equals(callSelf(isStepSoundSystemEnabled),_mode) exitWith {false};
		if (_mode) then {
			assert_str(!isNullReference(getSelf(owner)),"Mob::setStepSoundSystem() - owner must be not null");
		};
		setSelf(__enabledStepSoundSys,_mode);
	};

region(Atmos subsystem)

	getterconst_func(enabledAtmosReaction,false);
	autoref var_handle(__atmosHandle);

	//timeout react
	var(__lastChunkReactStep,0);
	var(__lastChunkReactBody,0);
	var(__lastFireDamage,0);

	func(setAtmosModeReaction)
	{
		objParams_1(_mode);
		private _curMode = getSelf(__atmosHandle)!=-1;
		if (_mode==_curMode) exitWith {false};
		if (_mode) then {
			callSelfParams(startUpdateMethod,"onAtmosUpdate" arg "__atmosHandle" arg TIME_ATMOS_MAIN_HANDLER_UPDATE);
		} else {
			callSelfParams(stopUpdateMethod,"__atmosHandle");
		};
		true
	};

	func(onAtmosUpdate)
	{
		updateParams();
		private _o = getSelf(owner);
		if isNullReference(_o) exitWith {};
		private _hpos = (
			_o modelToWorldVisual (_o selectionPosition "spine3")
		) call atmos_chunkPosToId;
		private _lpos = (getposatl _o) call atmos_chunkPosToId;
		
		//handle breathing
		if (tickTime >= getSelf(__lastChunkReactBody)) then {
			setSelf(__lastChunkReactBody,tickTime+TIME_ATMOS_DELAY_REACT_BODY);
			_chHd = [_hpos] call atmos_getChunkAtChIdUnsafe;
			if !isNullVar(_chHd) then {
				_chHd call ["onMobContactBody",[this]];
			};
		};

		//legs check
		if (tickTime >= getSelf(__lastChunkReactStep)) then {
			setSelf(__lastChunkReactStep,tickTime+TIME_ATMOS_DELAY_REACT_LEGS);
			
			if equals(_hpos,_lpos) exitWith {};// exit, because already contacted on body (STANCE_MIDDLE)
			
			_chLg = [_lpos] call atmos_getChunkAtChIdUnsafe;
			if !isNullVar(_chLg) then {
				_chLg call ["onMobContactTurf",[this]];
			};
		};
	};

region(previef functionality)
	getter_func(isInBuildingPreviewMode,!isNull(getSelf(___cachedCraftBuildPreview)));

	func(releaseBuildingPreview)
	{
		objParams();
		if !callSelf(isInBuildingPreviewMode) exitWith {};
		
		//send preview build end
		callSelfParams(sendInfo,"craft_endPrevFromServer" arg [false]);

		[this,false] call csys_onCraftEndPreview;
	};

region(ai system)
	var(__aiagent,null);
	getter_func(isAIAgent,!isNull(getSelf(__aiagent)));
	var(__curRegion,""); // текущий регион в котором находится сущность

endclass
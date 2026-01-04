// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
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


#define __performace_attacklog

#ifdef __performace_attacklog
	#define _perf_print() logformat("[PERF::ATTACK]: - %1 sec ========================",tickTime - __log_perf);
#else
	#define __perf_print()
#endif

#define logmob(funcname,text) (["<server> mob::" + #funcname + "    ",text,"#0111"] call stdoutPrint)
#define rp_log(text,fmt) (["<server::Roleplay> ",text,fmt,"#0111"] call stdoutPrint)

//медленное бросание
//#define debug_throw_slow

//Эмуляторы критов
//#define emulate_critAttack
//#define emulate_critFailAttack

//delays
//сколько длится шок
#define DELAY_SHOCK 3
//число делится на bs. Чем меньше значение, тем меньше задержка
#define MOD_DELAY_ATTACK 10

#ifndef EDITOR
	#undef debug_throw_slow
#endif

//индексы скиллов
#include <MobSkills_idx.hpp>

class(MobWoman) extends(Mob)
	"
		name:Игровой женский персонаж
		desc:Игровая сущность, которым могут управлять клиенты.
		path:Игровые объекты.Сущности
	" node_class

	var(defaultUniform,"max_femaleBasicBody");
	var(gender,gender_female);
	getter_func(getRetchSounds,["mob\female_retch1" arg "mob\female_retch2" arg "mob\female_retch3"]); //подавиться
	getter_func(getPainSounds,["mob\female_pain1" arg "mob\female_pain2"]); //боль
	getter_func(getMoanSounds,["mob\female_moan1" arg "mob\female_moan2" arg "mob\female_moan3"]); //слабая боль
	getter_func(getScreamSounds,["mob\fear_woman1" arg "mob\fear_woman2" arg "mob\fear_woman3"]); //крикушки
	getter_func(getTortureScreamSounds,["mob\female_torture_scream1"]);

endclass

class(Mob) extends(BasicMob)

	"
		name:Игровой персонаж
		desc:Игровая сущность, которым могут управлять клиенты.
		path:Игровые объекты.Сущности
	" node_class

	#include "Mob_Combat.sqf"
	#include "Mob_Events.sqf"
	#include "Mob_Interact.sqf"
	#include "Mob_Inventory.sqf"
	#include "Mob_Life.sqf"
	#include "Mob_Skills.sqf"
	#include "Mob_WoundSystem.sqf"
	#include "Mob_Tasks.sqf"
	#include "Mob_Emotes.sqf"
	#include "Mob_Communication.sqf"

	verbList("transitem undress standupfromchair showOrgans",BasicMob);

	var_str(face); //лицо
	var_str(faceAnim); //текущая лицевая анимация

	var(specialAction,SPECIAL_ACTION_NO); //особое действие (пинать, кусать)
	"
		name:Активная рука
		namelib:Активная рука (активный слот)
		desc:Текущая активная рука, которой персонаж будет производить действия.
		prop:get
		return:enum.InventorySlot
	" node_var
	var(activeHand,INV_HAND_L); //индекс активной руки
	"
		name:Основная рука
		desc:Текущая основная рука персонажа (левша или правша).
		prop:get
		return:enum.InventorySlot
	" node_var
	var(mainHand,INV_HAND_L); //индекс ОСНОВНОЙ РУКИ

	var(connectedTo,nullPtr); //к чему приаттачен моб в данный момент (кровать, стул)
	"
		name:Привязан к объекту
		desc:Возвращает @[bool ИСТИНУ], если сущность присоединена к объекту (сидит на стуле, лежит на кровати)
		type:get
		lockoverride:1
		return:bool
	" node_met
	getter_func(isConnected,not_equals(getSelf(connectedTo),nullPtr)); //подключен ли к чему-либо
	
	// Высокоуровневые абстракции лежит ли персонаж на кровати или сидит на стуле
	//сидит на чем то
	// Пока оставляю в комментарии так как тут дополнительно нужен псевдоним безопасного получения объекта на котором сидит/лежит персонаж
	// func(isSitting)
	// {
	// 	objParams();
	// 	private _conObj = getSelf(connectedTo);
	// 	if isNullReference(_conObj) exitwith {false};
	// 	callFunc(_conObj,isSeat) && {!isTypeOf(_conObj,BedBase)}
	// };
	// //лежит на кровати
	// func(isLying)
	// {
	// 	objParams();
	// 	private _conObj = getSelf(connectedTo);
	// 	if isNullReference(_conObj) exitwith {false};
	// 	callFunc(_conObj,isSeat) && {isTypeOf(_conObj,BedBase)}
	// };


	//объект наручников
	var(handcuffObject,nullPtr);
	//связана ли сущность
	"
		name:Связан
		desc:Возвращает @[bool ИСТИНУ], если руки сущности скованы веревкой, наручниками или подобным предметом.
		type:get
		lockoverride:1
		return:bool
	" node_met
	getter_func(isHandcuffed,!isNullReference(getSelf(handcuffObject)));

	func(disconnectFromSeat)
	{
		objParams();
		if callSelf(isConnected) then {
			callFuncParams(getSelf(connectedTo),seatDisconnect,this);
		};
	};

	var(handleFallingUpdate,-1);

	var(openedContainer,nullPtr);
	getter_func(hasOpenedContainer,not_equals(getSelf(openedContainer),nullPtr));

	// TODO known system
	var_array(knownMobsList); //список указателей которых знает этот персонаж
	//данные для рукопожатия
	var(lastHandshakeTarget,nullPtr);
	var(lastHandshakeTime,0);
	
	//Объект сетевого дисплея для раздевания
	editor_attribute("InternalImpl") autoref var(_internalEquipmentND,newParams(SystemInternalND,this));

	editor_attribute("InternalImpl") autoref var(_internalDynamicND,newParams(SystemInternalDynamicND,this));

	func(constructor)
	{
		objParams();

		callSelf(_makeSlots);
		callSelf(_makeBodyParts);

		setVar(getSelf(damageInfo),loc,this);
	};

	func(destructor)
	{
		objParams();

		if (getSelf(handleFallingUpdate) != -1) then {
			callSelfParams(stopUpdateMethod, "handleFallingUpdate");
		};

		callSelf(_onDelete_bodyParts);
		callSelf(_onDelete_Inventory);
		delete(getSelf(reagents));
		
		{delete(_x)} foreach getSelf(__allStatusEffects);
	};

	//установить владельца. Вызывается только один раз
	func(initAsActor)
	{
		objParams_1(_linked);
		super();
		
		callSelfParams(setStepSoundSystem,true);//step system

		#ifdef TEXTCHAT
			callSelf(initializeVoice);
		#endif
	};

	// Инициализация активной руки как основной руки
	// (Client::charSettings) mainhand rule: 0 left, 1 right
	func(initMainHand)
	{
		objParams_1(_enumval);
		private _handIdx = if (_enumval == 0) then {INV_HAND_L} else {INV_HAND_R};
		setSelf(activeHand,_handIdx);
		setSelf(mainHand,_handIdx);
	};

	// Событие вызывается при изменении локальности клиента. (параметр true означает что владение мобом передано серверу)
	func(onChangeLocality)
	{
		objParams_1(_isServerOwner);

		if (_isServerOwner) then {
			
			callSelfParams(startUpdateMethod, "handle_falling" arg "handleFallingUpdate" arg 0);

			//в редакторе все в сознании
#ifndef EDITOR_OR_SP_MODE
			callSelfParams(setCombatMode,false);

			callSelfParams(setSleep,true);
#endif

		} else {
			callSelfParams(stopUpdateMethod,"handleFallingUpdate");

			//callSelfParams(setSleep,false);
		};

		//останавливаем прогрессы данного юнита
		callSelfParams(stopProgress,true);
		//Выходим из стелса
		callSelfParams(setStealth,false);

		//Выключаем коллизию глобально
		/*private _unit = getSelf(owner);
		{
			//[_unit, _x] remoteExecCall ["disableCollisionWith", 0];
			[_unit,"collisionOff",[_unit,_x]] call repl_doLocal;
		} foreach cm_allInGameMobs;*/
	};
	

	
region(Connect control events)
	//допускается ли включение постпроцесса для человека при подклюении
	getter_func(canEnableHumanPostprocessOnConnection,true);

	//Вызывется при подключении клиента к мобу
	//человеческий персонаж полностью переопределяет логику подключения
	func(onConnected)
	{
		objParams();

		//Обновляем максимальную стамину
		callSelfParams(fastSendInfo,"cd_stamina_max" arg getSelf(staminaMax));

		//Обновляем состояние бессознанки
		callSelfParams(fastSendInfo,"cd_isUnconscious" arg callSelf(isUnconscious));

		callSelfParams(fastSendInfo,"hud_thirst" arg getSelf(thirst));
		callSelfParams(fastSendInfo,"hud_hunger" arg getSelf(hunger));
		callSelfParams(fastSendInfo,"hud_encumb" arg getSelf(curEncumbranceLevel));
		callSelfParams(fastSendInfo,"hud_oxy" arg getSelf(oxygen));
		callSelfParams(fastSendInfo,"hud_pee" arg getSelf(urine));
		callSelfParams(fastSendInfo,"hud_poo" arg getSelf(feces));
		callSelfParams(fastSendInfo,"hud_sleep" arg ifcheck(callSelf(isSleep),1,0));
		callSelfParams(fastSendInfo,"hud_tox" arg getSelf(toxin));
		callSelfParams(fastSendInfo,"hud_holdbreath" arg ifcheck(getSelf(isHoldedBreath),1,0));
		
		//Синхронизация этих действий вызывается тут: callSelfParams(onChangeAttackType,"sync");
		//send common
		#define _s(name) getSelf(name)
		private _skills = [
			_s(st),
			_s(iq),
			_s(dx),
			_s(ht),

			_s(fp),
			_s(will),
			_s(per),
			_s(hp)
		];
		callSelfParams(fastSendInfo,"cd_skills" arg _skills);
		/*		
		callSelfParams(fastSendInfo,"cd_curSelection" arg getSelf(curTargZone));
		callSelfParams(fastSendInfo,"cd_specialAction" arg getSelf(specialAction));
		//send combat
		callSelfParams(fastSendInfo,"cd_curDefType" arg getSelf(curDefType));
		callSelfParams(fastSendInfo,"cd_curCombatStyle" arg getSelf(curCombatStyle));
		callSelfParams(fastSendInfo,"cd_curAttackType" arg getSelf(curAttackType));*/
		
		//callSelf(syncBodyParts);

		callSelf(onSyncBones);
		callSelf(onSyncPain);
		callSelf(recalcBloodLoss);

		netSyncObjVar(getSelf(owner),"rv_name",getVar(getSelf(client),name));
		
		callSelfParams(loadActions,null);

		//хандлер звуков шагов
		callSelfParams(fastSendInfo,"os_steps_canUseRequests" arg callSelf(isStepSoundSystemEnabled));

		callSelfParams(onChangeAttackType,"sync"); //синхронизируем основные статистики

		callSelfParams(sendInfo, "onPrepareClient" arg
			[
				callSelf(getInitialPos) arg
				getSelf(visionBlock)
			]);

		callSelfParams(syncSlotInfoList, INV_LIST_ALL);
		callSelf(syncGermsVisual);
		callSelfParams(syncSmdVar,"face" arg getSelf(face));
		
		if callSelf(canEnableHumanPostprocessOnConnection) then {
			callSelfParams(localEffectUpdate,"HumanPostprocess");
		};

		callSelfParams(playMusic,"!ambient" arg "MUSIC_CHANNEL_AMBIENT" arg "stdlist");

		callSelfParams(localEffectUpdate,"GenericAmbSound");

		if array_exists(getVar(getSelf(client),lockedSettings),"run") then {
			callSelfParams(sendInfo,"spr_sync" arg []);
		};
		
		//anti strafe
		callSelfParams(sendInfo, "strafeLock" arg [true]);
	};

	// Вызывается при отключении клиента от моба
	func(onDisconnected)
	{
		objParams();
		super();
		if callSelf(hasOpenedContainer) then {
			callFuncParams(getSelf(openedContainer),onContainerClose,this);
		};

		callSelfParams(setCustomActionState,CUSTOM_ANIM_ACTION_NONE arg true);
		
		callSelfParams(sendInfo, "strafeLock" arg [false]);
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		#define PIC_PREP <img size='0.8' image='%2'/>

		private _isSelf = equals(this,_usr);
		private _rand = ifcheck(_isSelf,pick vec3("Меня зовут %1","Моё имя %1","Я - %1"),pick(["Ну а это %1" arg "А это %1" arg "Это %1" arg "Да это же %1" arg "Вот это %1"]));
		private _postrand = pick ["!" arg "." arg "..." arg ", вроде..."]; //очень странные дела с пикингом через препроцессор
		private _medMes = "";
		private _commonInfo = "";
		private _age = getSelf(age);

		private _baseDesc = callSelf(getDesc);
		if (!isNullVar(_baseDesc) && {_baseDesc != ""}) then {
			modvar(_commonInfo) + sbr + _baseDesc;
		};

		if (
		#ifdef EDITOR
		true
		#else
		!callFuncParams(getSelf(gender),isMiddleAge,_age)
		#endif
		|| _isSelf) then {
			if (_isSelf) then {
				modvar(_commonInfo) + sbr + "Мне " + ([_age,["год","года","лет"],true] call toNumeralString)+".";
			} else {
				modvar(_commonInfo) + sbr + getVar(getSelf(gender),он) + " " + callFuncParams(getSelf(gender),getAgeText,_age) + ".";
			};
		};

		// if !isNullReference(getVar(this,role)) then {
		// 	modvar(_commonInfo) + sbr + format["%1 %2.",ifcheck(_isSelf,"Я",getVar(getSelf(gender),он)),getVar(getSelf(role),name)];
		// };

		
		if (
			(callSelf(isHandcuffed) && !_isSelf)
		) then {
			modvar(_commonInfo) + sbr + getVar(getSelf(gender),его) + " руки связаны.";
		};

		if (callSelfParams(getDistanceTo,_usr) < 5) then {
			_medMes = callSelfParams(getMedicalExamineInfoFor,_usr);
		};

		if isTypeOf(_usr,MobObserver) then {
			_medMes = _medMes + sbr + format[
				"<t size='1.4' color='#A600A6'>Владельцы: %1</t>",
				getSelf(playerClients) apply {
					format["%1%4    регистрация: %2%4    игр:%3)",getVar(_x,name),getVar(_x,firstJoin),getVar(_x,playedRounds),sbr]
				} joinString ("-"+sgt+""+sbr)
			];
		};

		format[_rand + _postrand,callSelfParams(getNameEx,"кто")] + _commonInfo + _medMes;
	};
	
	func(mindSay)
	{
		objParams_1(_mes);
		if !callSelf(isActive) exitWith {};
		super();
	};

endclass

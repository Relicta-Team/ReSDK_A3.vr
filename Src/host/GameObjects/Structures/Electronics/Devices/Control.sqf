// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\..\text.hpp>
#include <..\..\..\GameConstants.hpp>
#include <..\..\..\..\ServerRpc\serverRpc.hpp>
#include <..\..\..\..\PointerSystem\pointers.hpp>

#include <HeadControlPanel.hpp>


class(HeadControlPanel) extends(ElectronicDevice)
	var(name,"Панель управления");
	var(model,"ml\ml_object_new\ml_object_2\l01_props\l01_props_jail_panel.p3d");
	var(material,"MatMetal");
	getterconst_func(getCoefAutoWeight,10);
	var(dr,4);

	#include "..\..\..\Interfaces\INetDisplay.Interface"
	var(ndName,"HeadConsole");
	var(ndInteractDistance,2);//INTERACT_DISTANCE

	//see more info in netdisplay_headconsole
	var(dispMode,MODE_MENU);
	var(dispModeCached,MODE_MENU); //кешированное состояние выключенного дисплея
	var(statusAlarm,false); //true if alarm
	var(edIsEnabled,true);

	var(lastActivity,0);
	var(poolSpeakers,[]);
	func(addSpeaker)
	{
		objParams_1(_sp);
		getSelf(poolSpeakers) pushBackUnique _sp;
	};

	func(checkActivity)
	{
		objParams_1(_usr);
		if (tickTime >= getSelf(lastActivity)) exitWith {true};

		private _text = format["Это старое оборудование. Нужно %1 подождать.",[ceil(getSelf(lastActivity) - tickTime),["секунду","секунды","секунд"],true] call toNumeralString];
		callFuncParams(_usr,localSay,_text arg "error");

		false
	};

	func(updateActivity)
	{
		objParams_1(_newtime);
		setSelf(lastActivity,tickTime+_newtime);
	};

	func(onChangeEnergyStateHCP)
	{
		objParams_1(_mode);

		if (_mode) then {
			callSelfParams(setDispMode,getSelf(dispModeCached));
			setSelf(dispModeCached,MODE_NOPOWER);
		} else {
			setSelf(dispModeCached,getSelf(dispMode));
			callSelfParams(setDispMode,MODE_NOPOWER);
		};
	};

	func(onChangeUsePower) {
		objParams();
		callSuper(ElectronicDevice,onChangeUsePower);
		callSelfParams(onChangeEnergyStateHCP,getSelf(edIsUsePower));
	};

	//Уведомление всем станционникам
	func(printNotification)
	{
		objParams_2(_t,_c);
		private _nearMobs = [];
		{
			{
				_nearMobs pushBackUnique _x;
			} foreach callFuncParams(_x,getNearMobs,40 arg false);
		} foreach getSelf(poolSpeakers);

		{
			callFuncParams(_x,localSay,_t arg _c);
		} foreach _nearMobs;
	};

	func(playNotifSound)
	{
		objParams_2(_path,_pitch);

		if isNullVar(_pitch) then {
			_pitch = getRandomPitch;
		};
		if equals(_pitch,"bell") then {
			_pitch = rand(1.15,1.3);
		};

		{
			if (getVar(_x,edIsUsePower) && getVar(_x,edIsEnabled)) then {
				callFuncParams(_x,playSound,_path arg _pitch arg 100);
			};
		} foreach getSelf(poolSpeakers);
	};

	func(getNDInfo) {
		objParams();
		private _canHead = (count getVar("RHead" call gm_getRoleObject,mobs))==0;
		private _data = [
			getSelf(dispMode),_canHead
		];
		if !isNullVar(__internal_headmode) then {
			_data = [true,getSelf(dispMode),_canHead];
		};
		callSelfParams(ND_UpdateDisplayModeData,_data);

		_data
	};

	//Получает массив значений в соответствии с указанным режимом
	func(ND_UpdateDisplayModeData)
	{
		objParams_1(_data);
		private _mode = getSelf(dispMode);

		//Главное меню. Просто на клиенте подгружаются кнопки
		if (_mode == MODE_MENU) exitWith {
			_data pushBack getSelf(statusAlarm);
			_data pushBack getSelf(statusEscape);
		};
		// asign to role
		if (_mode == MODE_ASSIGNROLE) exitWith {
			//load rolelist,load all clients

			//all clients with names and roles
			private _ldata = [];
			private _heads = getVar("RHead" call gm_getRoleObject,basicMobs);
			{
				#ifndef EDITOR
				if !array_exists(_heads,_x) then {
				#endif
					_ldata pushBack [
					format["(%1) %2 (%3)%4",
						getVar(getVar(_x,gender),пол),
						callFuncParams(_x,getNameEx,"кто"),
						(str getVar(_x,age))+([getVar(_x,age),[" год"," года"," лет"]] call toNumeralString),
						ifcheck(isNullReference(getVar(_x,role)),"",": "+getVar(getVar(_x,role),name))
					]
					,getVar(_x,pointer)];
				#ifndef EDITOR
				};
				#endif
			} foreach (call gm_getStationRoleList);
			_data pushBack _ldata;

			//allowed roles
			//на которые можно назначить
			private _roles = (getAllObjectsTypeOf(IRStationRole))+(["RTail"]);
			private _cls = "";
			_ldata = [];
			{
				_cls = _x;
				if (_cls != "RHead") then {
					_ldata pushBack [_cls,getVar(_cls call gm_getRoleObject,name)];
				};
			} foreach _roles;
			_data pushBack _ldata;
		};
		// выгнать из листа жителей
		if (_mode == MODE_EXILE) exitWith {
			//загружаем всех прописанных имя, указатель

			private _heads = getVar("RHead" call gm_getRoleObject,basicMobs);
			//all clients with names and roles
			private _ldata = [];
			{
				#ifndef EDITOR
				if !array_exists(_heads,_x) then {
				#endif
					_ldata pushBack
					[
					format["(%1) %2 (%3)%4",
						getVar(getVar(_x,gender),пол),
						callFuncParams(_x,getNameEx,"кто"),
						(str getVar(_x,age))+([getVar(_x,age),[" год"," года"," лет"]] call toNumeralString),
						ifcheck(isNullReference(getVar(_x,role)),"",": "+getVar(getVar(_x,role),name))
					]
					,getVar(_x,pointer)];
				#ifndef EDITOR
				};
				#endif
			} foreach (call gm_getStationRoleList);
			_data pushBack _ldata;
		};
		//окно указа
		if (_mode == MODE_DECREE) exitWith {

		};
	};

	func(setDispMode)
	{
		objParams_1(_mode);
		if (_mode == getSelf(dispMode)) exitWith {
			warningformat("HeadControlPanel::setDispMode() - already setted on mode %1",_mode);
		};

		setSelf(dispMode,_mode);
		callSelf(updateNDisplay);
	};

	func(changeAlarmMode)
	{
		objParams();
		private _newStatus = !getSelf(statusAlarm);
		if (_newStatus) then {
			private _text = "<t color='#BA2A04'><t size='1.6'>Объявляется общая тревога.</t>"+sbr+" Всем жителям незамедлительно закрыться в своих жилищах. Ополчению просьба вооружиться и пройти на главную площадь.</t>";
			callSelfParams(printNotification,_text arg "event");


			callSelfParams(playNotifSound,"electronics\alarm" arg rand(0.9,1.2));
		} else {
			private _text = format["<t color='#FF7400'>%1%3<t size='1.6'>%2</t></t>",
				"Храбрый Голова объявляет об окончании тревоги. Всем вернуться к своим рабочим местам.",
				pick["Славься Голова!","Слава мудрому правителю!","Указ Головы!"],
				sbr
			];
			callSelfParams(printNotification,_text arg "event");
			callSelfParams(playNotifSound,"UNCATEGORIZED\bell_toll" arg "bell");
		};
		setSelf(statusAlarm,_newStatus);

		if (getSelf(dispMode) == MODE_MENU) then {
			callSelf(updateNDisplay);
		};
	};

	func(onHandleNDInput) {
		objParams_2(_usr,_inp);

		private _mode = getSelf(dispMode);

		_inp params ["_userMode","_userInput","_optData"];

		//Клиент не успел синхронизировать состояние режима дисплея. отбрасываем запрос.
		if not_equals(_mode,_userMode) exitWith {};

		#define checkMode(m__) if (_mode == m__) exitWith
		#define compareInput(t__) if (_userInput == t__) exitWith
		#define compareInputAndJump(t__,newmode__) if (_userInput == t__) exitWith {callSelfParams(setDispMode,newmode__)}

		#define compareInputAndUseOptData(t__) if (_userInput == t__) exitWith
		#define optData _optData

		#define throwExceptionWithData() errorformat("HeadControlPanel::onHandleNDInput() - Unhandled input: %1 (mode: %2, optdat: %3) at line %4",_userInput arg _userMode arg _optData arg __LINE__)

		checkMode(MODE_NOPOWER) {

		};
		checkMode(MODE_MENU) {
			//действия для: переходов в меню
			compareInputAndJump(MENU_BUTTON_TOASSIGNROLE,MODE_ASSIGNROLE);
			compareInputAndJump(MENU_BUTTON_TOEXILE,MODE_EXILE);
			compareInputAndJump(MENU_BUTTON_TODECREE,MODE_DECREE);
			compareInput(MENU_BUTTON_ALARM) {
				if !callSelfParams(checkActivity,_usr) exitWith {};

				callSelf(changeAlarmMode);

				callSelfParams(updateActivity,5);
			};
			compareInput(MENU_BUTTON_ESCAPE) {
				if !callSelfParams(checkActivity,_usr) exitWith {};
				if getSelf(escapeIsDone) exitWith {
					callFuncParams(_usr,localSay,"Кнопка светит красным цветом. При её нажатии ничего не происходит." arg "mind");
				};

				callSelf(changeEscapeMode);

				callSelfParams(updateActivity,10);
			};
			compareInput(MENU_BUTTON_RETIRE) {
				if !callSelfParams(checkActivity,_usr) exitWith {};

				private _roleUsr = getVar(_usr,role);
				if (callFunc(_roleUsr,getClassName) != "RHead") exitWith {};

				callFuncParams(_usr,setToRole,"RTramp" call gm_getRoleObject);

				private _text = format["<t color='#FF7400'>%1%2<t size='1.6'>%3</t></t>",
						pick[
							"С гордостью наш Голова принял решение покинуть свой пост.",
							"Взвесив все за и против Голова принимает решение уйти в отставку.",
							"Голова устал и решил уйти."
						],
					sbr,
					"Верхнее руковоство созывается в зал совета для избрания нового правителя."
				];
				callSelfParams(playNotifSound,"UNCATEGORIZED\bell_toll" arg "bell");
				callSelfParams(printNotification,_text arg "event");
				//callSelfParams(closeNDisplayServer,_usr);
				callSelf(closeNDisplayForAllMobs);
				//callSelf(updateNDisplay);

				callSelfParams(updateActivity,5);
			};
			compareInput(MENU_BUTTON_SETHEAD) {
				if !callSelfParams(checkActivity,_usr) exitWith {};

				private _roleUsr = getVar(_usr,role);
				if (callFunc(_roleUsr,getClassName) == "RHead") exitWith {
					//callSelfParams(closeNDisplayServer,_usr);
					callSelf(closeNDisplayForAllMobs);
				};

				callFuncParams(_usr,setToRole,"RHead" call gm_getRoleObject);
				//callSelfParams(closeNDisplayServer,_usr);
				callSelf(closeNDisplayForAllMobs);

				private _text = format["<t color='#FF7400'>%1 - %2!%4<t size='1.6'>%3</t></t>",
						pick[
							"Приветствуем и восхваляем нового Голову",
							"Грязноямском теперь заправляет новый Голова",
							"В Грязноямске новый правитель"
						],
					callFuncParams(_usr,getNameEx,"кто"),
					pick["Славься новый Голова!","Слава изновленному правителю!","Да здравствует новый Голова!"],
					sbr
				];
				callSelfParams(playNotifSound,"UNCATEGORIZED\bell_toll" arg "bell");
				callSelfParams(printNotification,_text arg "event");

				callSelfParams(updateActivity,5);
			};

			throwExceptionWithData();
		};
		checkMode(MODE_ASSIGNROLE) {
			compareInputAndJump(BUTTON_GENERIC_BACK,MODE_MENU);
			compareInputAndUseOptData(ASSIGNROLE_DOASSIGN) {
				optData params ["_ptr","_role"];

				if !callSelfParams(checkActivity,_usr) exitWith {};

				private _mObj = pointer_get(_ptr);
				if !pointer_isValidResult(_mObj) exitWith {errorformat("HeadControlPanel::onHandleNDInput() - Mob object has no exists virtual object - %1",_ptr)};

				_robj = _role call gm_getRoleObject;
				if isNullReference(_robj) exitWith {}; //no such role object

				private _oldRoleName = getVar(getVar(_mObj,role),name);

				callFuncParams(_mObj,setToRole,_robj);
				private _text = if (_role != "RTail") then {
					format["<t color='#FF7400'>%2 %1 на должность '%3'!%5<t size='1.6'>%4</t></t>",
						callFuncParams(_mObj,getNameEx,"кого"),
						pick["Великий наш правитель только что поставил","Только что Голова назначил","С этого момента Голова назначает"],
						getVar(_robj,name),
						pick["Славься Голова!","Слава мудрому правителю!","Указ Головы!"],
						sbr
					]
				} else {
					format["<t color='#FF7400'>%2 %1 с должности '%3'!%5<t size='1.6'>%4</t></t>",
						callFuncParams(_mObj,getNameEx,"кого"),
						pick["Великий наш правитель только что снял","Только что Голова уволил","С этого момента Голова снимает"],
						_oldRoleName,
						pick["Славься Голова!","Слава мудрому правителю!","Указ Головы!"],
						sbr
					]
				};
				callSelfParams(playNotifSound,"UNCATEGORIZED\bell_toll" arg "bell");
				callSelfParams(printNotification,_text arg "event");
				callSelf(updateNDisplay);

				callSelfParams(updateActivity,10);
			};

			throwExceptionWithData();
		};
		checkMode(MODE_EXILE) {
			compareInputAndJump(BUTTON_GENERIC_BACK,MODE_MENU);

			compareInputAndUseOptData(EXILE_DOEXILE) {

				if !callSelfParams(checkActivity,_usr) exitWith {};

				private _mObj = pointer_get(optData);
				if !pointer_isValidResult(_mObj) exitWith {errorformat("HeadControlPanel::onHandleNDInput() - Mob object has no exists virtual object - %1",optData)};


				_robj = "RTramp" call gm_getRoleObject;
				if isNullReference(_robj) exitWith {};

				private _pretext = pick["%1 с позором изгоняется из Грязноямска","С презрением %1 выписан из поселения","Отныне %1 больше не является жителем Грязноямска"];
				_pretext = format[_pretext,callFuncParams(_mObj,getNameEx,"кто")];
				private _text = format["<t color='#FF7400'>%1!%2<t size='1.6'>%3</t></t>",
					_pretext,
					sbr,
					pick["Славься Голова!","Слава мудрому правителю!","Указ Головы!"]
				];
				callSelfParams(playNotifSound,"UNCATEGORIZED\bell_toll" arg "bell");
				callSelfParams(printNotification,_text arg "event");

				if ("ExileBanDirtpitAspect" call gm_isAspectSetup) then {
					callFuncParams(gm_currentAspect,addExiledMob,_mObj);
				};

				private _listRef = call gm_getStationRoleList;
				_listRef deleteAt (_listRef find _mObj);
				callFuncParams(_mObj,setToRole,_robj);

				callSelf(updateNDisplay);

				callSelfParams(updateActivity,10);
			};

			throwExceptionWithData();
		};
		checkMode(MODE_DECREE) {
			compareInputAndJump(BUTTON_GENERIC_BACK,MODE_MENU);
			compareInputAndUseOptData(DECREE_DODECREE) {
				if !callSelfParams(checkActivity,_usr) exitWith {};

				private _text = format["<t color='#FF7400'><t size='1.6'>%1</t>%3%2</t>",
					pick["Мудрый Голова издал указ!","Наш великий Голова издал новый указ!","Новый указ Головы!"],
					optData,
					sbr
				];
				callSelfParams(printNotification,_text arg "event");
				callSelfParams(playNotifSound,"UNCATEGORIZED\bell_toll" arg "bell");

				callSelfParams(updateActivity,10);
			};

			throwExceptionWithData();
		};

	};
	getter_func(getMainActionName,"Управлять");
	func(onMainAction)
	{
		objParams_1(_usr);

		if isTypeOf(_usr,GMPreyMobEater) exitwith {};

		private _robj = getVar(_usr,role);
		private __internal_headmode = null;
		if !isNullReference(_robj) then {
			if (callFunc(_robj,getClassName) == "RHead") then {
				__internal_headmode = true;
			};
		};
		callSelfParams(openNDisplay,_usr);
	};

	//побег
	var(statusEscape,false); //запущен ли процесс
	var(escapeIsDone,false); //разблокированы ли ворота
	var(escapeTimeLeft,0);
	#ifdef EDITOR
	getterconst_func(escapeTimeout,60*1);
	#else
	getterconst_func(escapeTimeout,60*3);
	#endif

	func(changeEscapeMode)
	{
		objParams();

		if getSelf(escapeIsDone) exitWith {};

		private _newStatus = !getSelf(statusEscape);
		if (_newStatus) then {
			private _tesc = "Автоматическая система блокировки врат будет снята через " + ([round(callSelf(escapeTimeout)/60),["минута","минуты","минут"],true] call toNumeralString) +".";
			private _text = "<t color='#BA2A04'><t size='1.6'>Запущен протокол ""Расход"".</t>"+sbr+" Работникам администрации, церкви и ополчению просьба пройти в покои Головы для подготовки к отбытию. "+_tesc+"</t>";
			callSelfParams(printNotification,_text arg "event");


			callSelfParams(playNotifSound,"electronics\alarm" arg rand(0.9,1.2));

			setSelf(escapeTimeLeft,callSelf(escapeTimeout));
		} else {
			private _text = format["<t color='#FF7400'>%1%3<t size='1.6'>%2</t></t>",
				"Протокол ""Расход"" отозван. Всем вернуться к своим рабочим обязанностям.",
				pick["Славься Голова!","Слава мудрому правителю!","Указ Головы!"],
				sbr
			];
			callSelfParams(printNotification,_text arg "event");
			callSelfParams(playNotifSound,"UNCATEGORIZED\bell_toll" arg "bell");
		};
		setSelf(statusEscape,_newStatus);

		if (getSelf(dispMode) == MODE_MENU) then {
			callSelf(updateNDisplay);
		};
	};

	func(escapeUpdate)
	{
		updateParams();

		if getSelf(escapeIsDone) exitWith {};

		if getSelf(statusEscape) then {
			modSelf(escapeTimeLeft, - 1);

			if (getSelf(escapeTimeLeft) <= 0) exitWith {
				setSelf(escapeIsDone,true);
				setSelf(statusEscape,false);

				private _gate = "gate_escape" call getObjectByRef;
				if isNullReference(_gate) exitwith {};
				
				callFunc(_gate,onActivate);

				private _tesc = "Врата разблокированы.";
				private _text = "<t color='#BA2A04' size='1.7'>"+_tesc+"</t>";
				callSelfParams(printNotification,_text arg "event");
			};

			if (getSelf(escapeTimeLeft)%20 == 0) then {
				callSelfParams(playNotifSound,"electronics\alarm" arg 0.96);
			};
			if ((getSelf(escapeTimeLeft)%60) == 0) then {
				private _tesc = "Автоматическая система блокировки врат будет снята через " + ([round(getSelf(escapeTimeLeft)/60),["минута","минуты","минут"],true] call toNumeralString) +".";
				private _text = "<t color='#BA2A04' size='1.6'>"+_tesc+"</t>";
				callSelfParams(printNotification,_text arg "event");
			};
		};
	};
	autoref var(__escapeHandle,-1);

	func(constructor)
	{
		objParams();
		callSelfParams(startUpdateMethod,"escapeUpdate" arg "__escapeHandle" arg 1);
	};

endclass




class(RegistrationPanel) extends(ElectronicDevice)
	getter_func(getName,"Кроводверь");
	getter_func(getDesc,"На передней панели выцарапано 'Немного свежей крови и ты часть Грязноямска!'.");
	var(model,"ml\ml_object_new\model_24\svetofor.p3d");
	var(material,"MatMetal");

	var(edIsEnabled,true);
	var(timeout,0);
	var(receiverObj,nullPtr);

	func(setReceiverObj)
	{
		objParams_1(_obj);
		if !isTypeOf(_obj,RegistratorPanelReceiver) exitWith {
			errorformat("Wrong object type on regis receiver - %1",callFunc(_obj,getClassName));
		};

		setSelf(receiverObj,_obj);
		setVar(_obj,regpan,this);
	};

	func(sendInfoToSource)
	{
		objParams_1(_usr);
		callFuncParams(getSelf(receiverObj),handleNewCitizen,_usr);
	};
	getter_func(getMainActionName,"Засунуть руку");
	func(onMainAction)
	{
		objParams_1(_usr);

		if (tickTime >= getSelf(timeout) && getSelf(edIsEnabled)) then {

			private _bpIdx = ifcheck(getVar(_usr,activehand) == INV_HAND_R,BP_INDEX_ARM_R,BP_INDEX_ARM_L);

			if !callFuncParams(_usr,hasPart,_bpIdx) exitWith {
				callFuncParams(_usr,localSay,"Руку поменять-бы..." arg "error");
			};

			//Станционнику отрубаем руку
			if (
				_usr in (call gm_getStationRoleList) || isTypeOf(_usr,GMPreyMobEater)
				//isTypeOf(getVar(_usr,role),IRStationRole) || isTypeOf(_usr,GMPreyMobEater)
				) exitWith {

				callFuncParams(_usr,lossLimb, _bpIdx);
				callFuncParams(_usr,meSay,"тянет палец"+comma+" но " + tolower callSelf(getName) + " затягивает всю руку с чудовищной силой и отрывает её.");
				setSelf(timeout,tickTime + 3);
			};

			callFuncParams(_usr,meSay,"засовывает палец в " + tolower callSelf(getName) + " и звучит едва слышимый щелчок!");
			setSelf(timeout,tickTime + 3);
			callSelfParams(sendInfoToSource,_usr);
		} else {
			callFuncParams(_usr,localSay,"Дверца не открывается. Что-то не так." arg "error");
		};
	};



endclass


class(RegistratorPanelReceiver) extends(ElectronicDevice)
	getter_func(getName,"Бумагодавилка");
	getter_func(getDesc,"Бюрократия - наше всё!");
	var(model,"a3\structures_f\ind\windpowerplant\powergenerator_f.p3d");
	var(material,"MatMetal");
	var(edIsEnabled,true);

	var_array(bufferPapers);
	var(regpan,nullPtr);

	func(getDescFor)
	{
		objParams_1(_usr);

		callSuper(ElectronicDevice,getDescFor) + (if(count getSelf(bufferPapers) > 0)then {
			sbr+format["Там ещё осталось %1",[count getSelf(bufferPapers),["бумага","бумаги","бумаг"],true] call toNumeralString];
		} else {""});
	};

	func(handleNewCitizen)
	{
		objParams_1(_usr);
		private _t = pick["интересные","непонятные","интригующие","смелые","забавные"];
		callSelfParams(worldSay,callSelf(getName) + " издаёт "+_t+" звуки." arg "act");
		callSelfParams(playSound,"electronics\console_output" arg getRandomPitchInRange(0.8,1.4));

		private _idoc = new(IdenityDocsInternal);
		callFuncParams(_idoc,makeRegList,_usr);
		getSelf(bufferPapers) pushBack _idoc;
		setVar(_idoc,loc,this);

		_id = getVar(_idoc,regId);
		_idoc = new(IdentityDocs);
		callFuncParams(_idoc,makeRegList,_usr arg _id);
		getSelf(bufferPapers) pushBack _idoc;
		setVar(_idoc,loc,this);
	};

	func(changeActivityMode)
	{
		objParams_2(_mode,_whocalled);
		if (getSelf(edIsEnabled) == _mode) exitWith {};

		callSelfParams(setEnable,_mode);
		callFuncParams(getSelf(regpan),setEnable,_mode);

		if (_mode) then {
			callFuncParams(_whocalled,localSay,"Система регистрации включена." arg "info");
		} else {
			callFuncParams(_whocalled,localSay,"Система регистрации отключена." arg "info");
		};
	};
	getter_func(getMainActionName,ifcheck(getSelf(edIsEnabled),"Выключить","Включить"));
	func(onMainAction)
	{
		objParams_1(_usr);

		callSelfParams(changeActivityMode,!getSelf(edIsEnabled) arg _usr);
	};

	func(onClick)
	{
		objParams_1(_usr);
		if (count getSelf(bufferPapers) == 0)exitWith{};

		private _it = array_remlast(getSelf(bufferPapers));
		if !callFuncParams(_it,moveItem,_usr) then {
			getSelf(bufferPapers) pushBack _it;
		};
	};

endclass

class(RegistrationPaperArchive) extends(IStruct)
	getter_func(getName,"Архив");
	getter_func(getDesc,"Сюда попадают все личные дела новоприбывших в поселение.");
	var(model,"ml_shabut\exoduss\archive_tube.p3d");
	var(material,"MatWood");

	var(headconsole,nullPtr);

	func(setHeadConsole)
	{
		objParams_1(_con);
		setSelf(headconsole,_con);
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);

		if !isTypeOf(_with,IdenityDocsInternal) exitWith {
			callFuncParams(_usr,localSay, "Это для регистрационных бланков." arg "error");
		};

		private _mob = getVar(_with,srcMob);
		private _regCli = getVar(_with,clientRef);

		(call gm_getStationRoleList)pushBackUnique(
			_mob
		);

		[_regCli] call dsm_accounts_handleRegisterArriveInCity;

		private _m = format["укладывает %1 в архив, регистрируя нового поселенца.",callSelf(getName)];
		callFuncParams(_usr,meSay,_m);

		delete(_with);

		callFunc(getSelf(headconsole),updateNDisplay);
	};

endclass


class(IdentityDocs) extends(Paper)
	var(name,"Документы ");
	var(desc,"Удостоверение личности");
	getter_func(canWrite,false);
	var(model,"a3\structures_f\items\documents\file1_f.p3d");

	func(makeRegList)
	{
		objParams_2(_m,_id);

		private _txt = format[
		"<t color='#000000' font='RobotoCondensedLight'><t align='center'>Удостоверение личности %5.%2%2</t>Имя: %1%2Пол: %3%2Возраст: %4</t>",
			callFuncParams(_m,getNameEx,"кто"),
			sbr,
			getVar(getVar(_m,gender),пол_целиком),
			[getVar(_m,age),["год","года","лет"],true] call toNumeralString,
			_id
		];
		setSelf(content,_txt);

		modVar(this,name, + callFuncParams(_m,getNameEx,"кто"));
	};

endclass

class(IdenityDocsInternal) extends(Paper)
	getter_func(canWrite,false);
	var(name,"Лист регистрации ");

	var(srcMob,nullPtr);
	var(clientRef,nullPtr);

	var(regId,randInt(1,10000));

	//генератор реги
	func(makeRegList)
	{
		objParams_1(_m);

		modSelf(regId, + 1);
		setSelf(srcMob,_m);
		setSelf(clientRef,callFunc(_m,getLastPlayerClient));

		private _txt = format[
		"<t color='#000000' font='RobotoCondensedLight'><t align='center'>Бланк регистрации %5%2Для помещения в архив.%2%2</t>Имя: %1%2Пол: %3%2Возраст: %4</t>",
			callFuncParams(_m,getNameEx,"кто"),
			sbr,
			getVar(getVar(_m,gender),пол_целиком),
			[getVar(_m,age),["год","года","лет"],true] call toNumeralString,
			getSelf(regId)
		];
		setSelf(content,_txt);
		modSelf(name, + str getSelf(regId));
	};

endclass


class(RegisterRingerRedButton) extends(RedButton_Activator)
	var(nextActivation,0);
	func(onMainAction)
	{
		objParams_1(_usr);
		if (tickTime >= getSelf(nextActivation)) then {
			setSelf(nextActivation,tickTime + 50 + randInt(1,5));
			//проиграть звук в зоне
			//всем вахтерам кто далеко от кнопки и isActive - проиграть сообщение в чате "Пора работать"
		};
	};
endclass
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>
#include <..\..\..\text.hpp>


//#define testcase_buy
//#define testcase_buyaccept
	//#define testcase_buyaccept_throwerror_lowmoney
//#define testcase_sell
//#define testcase_priceget
//#define LOG_TRADE

class(IDeliveryPipeInternal) extends(ElectronicDevice)
	var(edIsEnabled,true);
	var(edReqPower,1);
	#include "..\..\Interfaces\IContainer.Interface"

	var(maxSize,ITEM_SIZE_BIG);
	var(countSlots,DEFAULT_LARGEBOX_STORAGE);
endclass

class(CampfireCreator) extends(Item)
	var(name,"Набор для костра");
	var(desc,"Собранный местными умельцами"+comma+" набор для разведения костра");
	var(material,"MatWood");
	var(weight,gramm(600));
	var(size,ITEM_SIZE_MEDIUM);
	getter_func(getMainActionName,"Собрать");
	func(onMainAction)
	{
		objParams_1(_usr);
		if !callSelf(isInWorld) exitWith {
			callFuncParams(_usr,localSay,"Надо на земле собирать" arg "error");
		};
		private _pos = callSelf(getModelPosition);
		["CampfireDisabled",_pos,null,false] call createStructure;

		delete(this);
	};

endclass

class(DeliveryPipe) extends(IDeliveryPipeInternal)

	
	func(canAdd)
	{
		objParams_1(_item);
		if !isNullVar(__GLOBAL_FLAG_CAN_BUY_UNLIM_SIZE_CONTAINER__) exitWith {true};
		super();
	};

	var(name,"Труба доставки");
	var(model,"ca\structures_e\misc\misc_construction\misc_concoutlet_ep1.p3d");
	var(material,"MatBeton");
	var(dr,3);
	var(maxSize,ITEM_SIZE_BIG);
	var(countSlots,DEFAULT_LARGEBOX_STORAGE);

	//Заказы: ключ - номер заказа, знач vec2:Type,Count
	var(generatedOrders,hashMapNew);
	//ссылки на бумагу. проверяются при каждом парсинге. ключ - номер заказа, знач - ссылка на бумагу
	var(generatedPapers,hashMapNew);

	var(sendedItems,hashMapNew);

	//Модификатор цены от размера. Чем меньше значение тем больше рубится цена.
	// Прим: для итемов ITEM_SIZE_TINY цена будет 0.909091 звяка за штуку
	getterconst_func(sellPriceModifier,1.1);

	//кнопка отправки
	var(senderButton,nullPtr);
	//Отправленные предметы. Структура:
	/*
		0 - reqorname - задача которая будет выполнена
		1 - в какую отметку времени будет выполнено
		2 - зарезервированные метаданные.
	*/
	var_array(requestedTasks);

	var(lastActivationTime,0);
	func(onActivate)
	{
		objParams();

		if (tickTime < getSelf(lastActivationTime)) exitWith {};
		callSelf(onSend);
		setSelf(lastActivationTime,tickTime + 2);
	};


	func(playAct)
	{
		objParams();
		//['this',"_path",["_pitch",1],["_maxDist",50],["_vol",1]];
		callSelfParams(playSound,"electronics\air_fill" arg rand(0.7,1.6) arg 15 arg 1);

		private _m = pick ["сосёт что-то.","фыркает и блыкает.","шипит.","работает с воздухом."];
		callSelfParams(worldSay,callSelf(getName) + " " + _m arg "info");

	};


	autoref var(handleUpdate,-1);
	func(constructor)
	{
		objParams();
		callSelfParams(startUpdateMethod, "onUpdate" arg "handleUpdate" arg 1);
	};

	func(onUpdate)
	{
		updateParams();
		_qdel = false;
		_list = getSelf(requestedTasks);
		{
			_x params ["_reqname","_timestamp","_metadata"];

			//Пропуск итерации по причине бесконечного цикла??
			if isNullVar(_timestamp) then {
				continue;
			};

			if (tickTime >= _timestamp) then {
				callSelfParams(onTaskSuccess,_reqname arg _metadata);
				_qdel = true;
				_list set [_forEachIndex,objNUll];
			};

		} forEach _list;

		if (_qdel) then {
			setSelf(requestedTasks,_list - [objNUll]);
		};
	};

	/*func(getDescFor)
	{
		objParams_1(_usr);
		callSuper(SContainer,getDescFor) +sbr+ callSelf(getTasksText);
	};*/

	//Формирует текст
	func(getTasksText)
	{
		objParams();
		private _t = "";
		private _ttext = "";
		private _tList = [];
		{
			_x params ["_ttype","_time"];
			if isNullVar(_time) then {continue};

			_ttext = (0 call {
				if (_ttype in ["trade_block","trade_penalty"]) exitWith {"Служебное уведомление"};
				if (_ttype == "buy_req") exitWith {"Запрос покупки"};
				if (_ttype == "buy_accept") exitWith {"Поставка"};
				if (_ttype == "money_change") exitWith {"Обмен валюты"};
				if (_ttype == "sell_getprice") exitWith {"Запрос стоимости"};
				if (_ttype == "sell_accept") exitWith {"Выплата средств"};
				if (_ttype == "sell_cancel") exitWith {"Возврат товаров"};

				if (_ttype == "c_buy") exitWith {"Поставка"};
				if (_ttype == "c_addmon") exitWith {"Внесение звяков на счёт"};

				"(неизвестно)"
			});

			_tList pushBack format["%1 - осталось %2",_ttext,[round(_time - tickTime),vec3("секунду","секунды","секунд"),true] call toNumeralString];
		} foreach getSelf(requestedTasks);

		if (count _tList > 0) exitWith {
			"В пути:" +sbr+(_tList joinString sbr);
		};
		"В ближайшее время ничего не поступит.";
	};

	func(addTask)
	{
		objParams_3(_tasktype,_metadata,_invokeAfter);
		#ifdef DEBUG
		_invokeAfter = ifcheck(_invokeAfter<=0,null,2);
		#endif
		getSelf(requestedTasks) pushBack [_tasktype,ifcheck(_invokeAfter<=0,null,tickTime+_invokeAfter),_metadata];
	};

	func(onTaskSuccess)
	{
		objParams_2(_taskType,_metadata);

		if (_taskType != "c_addmon") then {
			//Системные заказы не дрочат трубу
			if (_taskType == "c_buy" && {({(_x select 0)=="CALLCODE"}count _metadata)==(count _metadata)}) exitWith {};
			callSelf(playAct);
		};

		#ifdef LOG_TRADE
		warningformat("TASK SUCCESS %1; META: %2",_taskType arg _metadata);
		warningformat("S1:%1 S2:%2 S3:%3",getSelf(generatedOrders) arg getSelf(generatedPapers) arg getSelf(sendedItems));
		#endif

		if (_taskType == "buy_req") exitWith {
			_metadata params ["_orderId","_paperName","_text"];

			private _paper = callSelfParams(createItemInContainer,"Paper" arg null arg null arg [vec3("var","content",_text) arg vec3("var","name",_paperName)]);
			getSelf(generatedPapers) set vec2(_orderId,_paper);

		};
		if (_taskType == "trade_penalty") exitWith {
			callSelfParams(createItemInContainer,"Paper" arg null arg null arg [vec3("var","content",callSelfParams(getPointLessText,_metadata)) arg vec3("var","name","Выговор")]);
		};
		if (_taskType == "trade_block") exitWith {
			callSelfParams(createItemInContainer,"Paper" arg null arg null arg [vec3("var","content",callSelf(getBlockText)) arg vec3("var","name","Уведомление")]);
		};
		if (_taskType == "money_change") exitWith {
			_metadata params ["_isBigMon","_count"];
			if (_isBigMon) then {
				if (_count > 0) then {
					private _brCnt = floor(_count / 10);
					private _zvCnt = _count % 10;

					if (_brCnt > 0) then {

						if (_brCnt < 10) then {
							callSelfParams(createItemInContainer,"Bryak" arg 1 arg null arg [vec3("func","initCount",_brCnt)]);
						} else {
							private _brStack = floor(_brCnt / 10);
							private _brLeft = _brCnt % 10;
							callSelfParams(createItemInContainer,"Bryak" arg _brStack arg null arg [vec3("func","initCount",10)]);
							if (_brLeft > 0) then {
								callSelfParams(createItemInContainer,"Bryak" arg 1 arg null arg [vec3("func","initCount",_brLeft)]);
							};
						};
					};
					if (_zvCnt > 0) then {
						callSelfParams(createItemInContainer,"Zvak" arg 1 arg null arg [vec3("func","initCount",_zvCnt)]);
					};
				};
			} else {
				//полных стаков
				private _zvCntStacks = _count / 10;
				private _zvLast = _count % 10;
				if (_zvCntStacks > 0) then {
					callSelfParams(createItemInContainer,"Zvak" arg _zvCntStacks arg null arg [vec3("func","initCount",10)]);
				};
				if (_zvLast > 0) then {
					callSelfParams(createItemInContainer,"Zvak" arg 1 arg null arg [vec3("func","initCount",_zvLast)]);
				};
			};
		};
		if (_taskType == "buy_accept") exitWith {

			_metadata params ["_orderId","_changeMoney"];

			//внутренняя функция уменьшения количества на складе
			private _modifWarehouse = {
				params ["_typeInput","_countDel"];
				{
					//[#typename,randInt(lowprice,maxprice),ctg,randInt(countslow,countsmax),[ #typename ,"name",true,"getName"] call oop_getFieldBaseValue]
					_y params ["_type","_price","_cat","_amounts"];
					if (_typeInput == _type) exitWith {
						_y set [3,(_amounts - _countDel) max 0];
					};
				} foreach getSelf(dataStorage);
			};

			{
				_x params ["_type","_count"];
				[_type arg _count] call _modifWarehouse;
				callSelfParams(createItemInContainer,_type arg _count);
			} foreach (getSelf(generatedOrders) get _orderId);

			#ifdef LOG_TRADE
			warningformat("change moneys %1",_changeMoney);
			#endif

			//сдача
			if (_changeMoney > 0) then {
				private _brCnt = floor(_changeMoney / 10);
				private _zvCnt = _changeMoney % 10;

				if (_brCnt > 0) then {

					if (_brCnt < 10) then {
						callSelfParams(createItemInContainer,"Bryak" arg 1 arg null arg [vec3("func","initCount",_brCnt)]);
					} else {
						private _brStack = floor(_brCnt / 10);
						private _brLeft = _brCnt % 10;
						callSelfParams(createItemInContainer,"Bryak" arg _brStack arg null arg [vec3("func","initCount",10)]);
						if (_brLeft > 0) then {
							callSelfParams(createItemInContainer,"Bryak" arg 1 arg null arg [vec3("func","initCount",_brLeft)]);
						};
					};
				};
				if (_zvCnt > 0) then {
					callSelfParams(createItemInContainer,"Zvak" arg 1 arg null arg [vec3("func","initCount",_zvCnt)]);
				};
			};

			//После подтверждения покупки удаляем бумагу
			delete(getSelf(generatedPapers) getOrDefault vec2(_orderId,nullPtr));

			getSelf(generatedPapers) deleteAt _orderId;
			getSelf(generatedOrders) deleteAt _orderId;

			//удаление предметов из листа
			if (_orderId in getSelf(sendedItems)) then {
				{
					delete(_x);
				} foreach (getSelf(sendedItems) get _orderId);
				getSelf(sendedItems) deleteAt _orderId;
			};
		};
		if (_taskType == "sell_getprice") exitWith {
			_metadata params ["_orderId","_price"];

			_text = format["<t color='#000000' font='RobotoCondensedLight'>Запрос на продажу по заказу %1 рассмотрен.%3%3Итого: %2 %4</t>",_orderId,_price,sbr,[_price,["звяк","звяка","звяков"]] call toNumeralString];
			_paperName = format["Бланк продажи '%1'",_orderId];
			callSelfParams(createItemInContainer,"Paper" arg null arg null arg [vec3("var","content",_text) arg vec3("var","name",_paperName)]);
		};
		if (_taskType == "sell_accept") exitWith {
			_metadata params ["_orderId","_price"];

			private _brCnt = floor(_price / 10);
			private _zvCnt = _price % 10;

			if (_brCnt > 0) then {

				if (_brCnt < 10) then {
					callSelfParams(createItemInContainer,"Bryak" arg 1 arg null arg [vec3("func","initCount",_brCnt)]);
				} else {
					private _brStack = floor(_brCnt / 10);
					private _brLeft = _brCnt % 10;
					callSelfParams(createItemInContainer,"Bryak" arg _brStack arg null arg [vec3("func","initCount",10)]);
					if (_brLeft > 0) then {
						callSelfParams(createItemInContainer,"Bryak" arg 1 arg null arg [vec3("func","initCount",_brLeft)]);
					};
				};
			};
			if (_zvCnt > 0) then {
				callSelfParams(createItemInContainer,"Zvak" arg 1 arg null arg [vec3("func","initCount",_zvCnt)]);
			};

			delete(getSelf(generatedPapers) getOrDefault vec2(_orderId,nullPtr));

			getSelf(generatedPapers) deleteAt _orderId;
			getSelf(generatedOrders) deleteAt _orderId;

			if (_orderId in getSelf(sendedItems)) then {
				{
					delete(_x);
				} foreach (getSelf(sendedItems) get _orderId);
				getSelf(sendedItems) deleteAt _orderId;
			};
		};

		//#define sell_cancel_extended_logging
		if (_taskType == "sell_cancel") exitWith {
			private _orderId = _metadata;

			#ifndef LOG_TRADE
				#undef sell_cancel_extended_logging
			#endif

			#ifdef sell_cancel_extended_logging
			errorformat("1- cancel selling: order: %4; S1:%1 S2:%2 S3:%3",getSelf(generatedOrders) arg getSelf(generatedPapers) arg getSelf(sendedItems) arg _orderId);
			#endif

			delete(getSelf(generatedPapers) getOrDefault vec2(_orderId,nullPtr));

			#ifdef sell_cancel_extended_logging
			errorformat("2 - cancel selling: S1:%1 S2:%2 S3:%3",getSelf(generatedOrders) arg getSelf(generatedPapers) arg getSelf(sendedItems));
			#endif

			getSelf(generatedPapers) deleteAt _orderId;
			getSelf(generatedOrders) deleteAt _orderId;

			#ifdef sell_cancel_extended_logging
			errorformat("3 - cancel selling: S1:%1 S2:%2 S3:%3",getSelf(generatedOrders) arg getSelf(generatedPapers) arg getSelf(sendedItems));
			#endif

			if (_orderId in getSelf(sendedItems)) then {
				#ifdef sell_cancel_extended_logging
				errorformat("4 - cancel selling: S1:%1 S2:%2 S3:%3",getSelf(generatedOrders) arg getSelf(generatedPapers) arg getSelf(sendedItems));
				#endif

				{
					callSelfParams(addItem,_x);
				} foreach (getSelf(sendedItems) get _orderId);
				getSelf(sendedItems) deleteAt _orderId;

				#ifdef sell_cancel_extended_logging
				errorformat("PRE_FINAL - cancel selling: S1:%1 S2:%2 S3:%3",getSelf(generatedOrders) arg getSelf(generatedPapers) arg getSelf(sendedItems));
				#endif
			};

			#ifdef sell_cancel_extended_logging
			errorformat("ON_END - cancel selling: S1:%1 S2:%2 S3:%3",getSelf(generatedOrders) arg getSelf(generatedPapers) arg getSelf(sendedItems));
			#endif
		};

		// -------------- NEW VARS -------------------

		if (_taskType == "c_buy") exitWith {
			private __GLOBAL_FLAG_CAN_BUY_UNLIM_SIZE_CONTAINER__ = true;
			{
				_x params ["_type","_count"];
				if (_type == "CALLCODE") then {
					0 call _count;
				} else {
					callSelfParams(createItemInContainer,_type arg _count);
				};

			} foreach _metadata;
		};
		if (_taskType == "c_addmon") exitWith {
			modVar(getSelf(console),money,+ _metadata);
			callFuncParams(getSelf(console),playSound,"electronics\console_success" arg getRandomPitchInRange(0.9,1.1));
		};

		errorformat("DeliveryPipe::onTaskSuccess() - param error taskType: %1; Metadata: %2",_taskType arg _metadata);
	};

	/*
		Пример запроса:
			Прошу закупить:
			Сигареты - 2 шт
			Бинты - 5 шт
			Соль - 1 шт

		Товары:
			бумага (брикет)
			ручка
			батарейка
			кусачки
			отвертка

			факел
			свеча
			лампа
			сигарета
			набор для костра
			спички

		Боевое
			меч
			боевой нож
		Мед
			бинт

		Пищевое:
			Сигареты
			Мука
			Соль
			Сахар
			Перец
	*/
	#define item_data(typename,lowprice,maxprice,ctg,countslow,countsmax) [#typename,randInt(lowprice,maxprice),ctg,randInt(countslow,countsmax),[ #typename ,"name",true,"getName"] call oop_getFieldBaseValue]
	#define rx_pat(txt) (txt + "\ *\-\ *\d{1,3}[ ]*(шт(ук|уки)?\.?)?")
	//
	/*var(dataStorage,hashMapNewArgs [
		vec2(rx_pat("((С|с)топ[а-я]*\ *)?(Б|б)ума[а-я]*"),item_data(PaperHolder,2,7,"Основные",10,40)) arg
		vec2(rx_pat("(Р|р)учк[а-я]*"),item_data(PenBlack,5,12,"Основные",5,20)) arg
		vec2(rx_pat("(Б|б)атар[а-я]*"),item_data(SmallBattery,10,20,"Основные",2,10)) arg
		vec2(rx_pat("(К|к)усач[а-я]*"),item_data(WireCutters,6,14,"Основные",5,10)) arg
		vec2(rx_pat("(О|о)тв[её]рт[а-я]*"),item_data(Screwdriver,6,14,"Основные",5,10)) arg

		vec2(rx_pat("(Ф|ф)акел[а-я]*"),item_data(TorchDisabled,8,16,"Свет",6,10)) arg
		vec2(rx_pat("(С|с)веч[а-я]*"),item_data(CandleDisabled,2,6,"Свет",18,30)) arg
		vec2(rx_pat("(Л|л)амп[а-я]*"),item_data(LampKeroseneDisabled,10,14,"Свет",6,10)) arg
		vec2(rx_pat("(К|к)остр[а-я]*"),item_data(CampfireCreator,3,8,"Свет",16,26)) arg
		vec2(rx_pat("(С|с)пич[а-я]*"),item_data(MatchBox,1,3,"Свет",10,30)) arg

		vec2(rx_pat("(Л|л)ом[а-я]*"),item_data(Crowbar,5,10,"Инструменты",3,10)) arg

		vec2(rx_pat("(М|м)еч[а-я]*"),item_data(ShortSword,20,40,"Оружие",2,6)) arg
		vec2(rx_pat("(Н|н)ож[а-я]*"),item_data(CombatKnife,15,25,"Оружие",3,7)) arg

		vec2(rx_pat("(Б|б)инт[а-я]*"),item_data(Bandage,6,12,"Медицина",20,40)) arg

		vec2(rx_pat("(С|с)игар[а-я]*"),item_data(Sigarette,6,10,"Припасы",15,30)) arg
		vec2(rx_pat("(М|м)ук[а-я]*"),item_data(Muka,4,7,"Припасы",20,50)) arg
		vec2(rx_pat("(С|с)ол(ь|и|ей)"),item_data(SaltShaker,8,10,"Припасы",10,20)) arg
		vec2(rx_pat("(С|с)ахар[а-я]*"),item_data(SugarShaker,10,16,"Припасы",5,20)) arg
		vec2(rx_pat("(П|п)ер(ца|цу|ец)"),item_data(PepperShaker,8,10,"Припасы",5,20))
	]);*/

	//const val
	func(getTextForMerchant)
	{
		objParams();
		//(З|з)аказ|(К|к)упи|(П|п)окуп|(П|п)риобре
		private _txt = "<t color='#000000' font='RobotoCondensedLight'>Здравствуйте %1!"+sbr+"Мы очень рады продолжению нашего сотрудничества и надеемся, что оно принесёт много звяков нам и городу, при котором вы располагаетесь. " +sbr;
		modvar(_txt) + sbr+sbr+"На всякий случай напомним Вам правила подачи бланков заказов. Каждый бланк заполняется вручную, ручкой или другим пишушим инструментом. ";
		modvar(_txt) + "При формировании бланка вы должны обязательно написать, что хотите сделать заказ (прим. Прошу заказать:, Хочу приобрести:, Закупите пожалуйста:). ";
		modvar(_txt) + "Предложение должно обязательно заканчиваться двоеточием. Сам текст запроса не имеет значения, главное чтобы было понятно - вы хотите купить что-то. ";
		modvar(_txt) + sbr+"Далее со следующей строки укажите необходимые товары. Форма заполнения: 'товар - количество шт.'. (прим. Ножи - 2 шт., Сигарет - 10 штук.) ";
		modvar(_txt) + "Каждый новый товар пишется на новой строке. Обязательно укажите количество по форме - додумывать, сколько именно вам нужно, мы за Вас не будем. ";
		modvar(_txt) + "Если форма заполнена не по правилам - она не будет обработана и заказ не будет сформирован. ";
		modvar(_txt) + "После отправки запроса мы формируем заказ на бумаге, в котором указано наличие на складах и итоговая стоимость. ";
		modvar(_txt) + "Если Вас всё устраивает - высылаете обратно заказ, сумму к оплате и товары. Мы не будем возвращать товары, не указанные в листе заказа. ";

		modvar(_txt) +sbr+sbr+"<t align='center'>Нарушения и санкции:</t>"+sbr+"Во избежании нарушений в работе тоговой системы, попыток обмана и введения в заблуждение мы вводим внутреннюю выговоров для каждой тоговой точки. На данный момент для Вам может быть вынесено "+str getSelf(points)+" выговора. ";
		modvar(_txt) + "За каждое нарушение мы будем высылать Вам уведомительное письмо вплоть до момента полного прекращения торговли. ";
		modvar(_txt)+sbr+"За что можно получить снижение репутации:"+sbr;
		modvar(_txt)+"<t color='#E40045'>    - Количество звяков, меньше чем указано в листе заказа при покупке."+sbr;
		modvar(_txt)+"    - Количество товаров отличается от указанных в листе заказа при покупке."+sbr;
		modvar(_txt)+"    - Отправка товаров и предметов без листа заказа, либо с несколькими их экземплярами."+sbr;
		modvar(_txt)+"    - Отправка запроса на получение стоимости без товаров."+sbr;
		modvar(_txt)+"    - Неверный номер заказа при продаже, её подтверждении или отмене.</t>"+sbr;

		modvar(_txt)+sbr+sbr+"<t align='center'>Продажа товаров:</t>"+sbr+
		"С недавнего времени мы начали принимать товары на продажу. Для продажи Вы должны заполнить форму на бумаге по следующему образцу:"+sbr
		// (стоим|цен)
		+sbr+sbr+'«Прошу предоставить стоимость присланных товаров на продажу.»'+sbr+sbr+
		"После заполнения формы вы отправляете её вместе с товарами, которые Вы хотите продать. "+
		"Мы проверим товары и пришлём вам бумагу с номером запроса и стоимостью. "+
		"Если цена Вас устраивает - отправляете этот запрос обратно нам."+
		"Мы сразу высылаем указанную сумму, однако предупреждаем, что уже проданные товары возврату не подлежат. "+
		"Если цена не устраивает, то отправьте запрос на бумаге по форме:"
		// (отмен|отозв).*\d\d\d\d-....
		+sbr+sbr+'«Здравствуйте, хочу отменить продажу. Номер заказа 1234-АБВГ.»'+sbr+sbr
		//+sbr+sbr+"<t align='center'>Запрос товаров на складе:</t>"
		;
		/*+sbr+"Мы предоставляем возможность получения информации об остатках на наших складах. Для получения отчета заполните бумагу по форме:"+
		+sbr+sbr+"Прошу предоставить информацию об остатках на складе."+sbr+sbr+
		"Сбор информации занимает время, поэтому на этот момент все передачи товаров приостанавливаются а новые заказы не будут обработаны. "+
		"И мы высылаем вам список";*/


		modvar(_txt)+sbr+sbr+"Не разочаруете нас и соблюдайте общие правила."+
		sbr+sbr+"С уважением, "+sbr+"Старший торговый представитель"+sbr+(pick naming_list_ManFirstName)+" "+(pick naming_list_ManSecondName)+"!";

		modvar(_txt)+"</t>";
		_txt
	};

	/*func(createMerchantHello)
	{
		objParams_3(_pos,_usr,_infopos);
		forceUnicode 1;
		private _txt = format[callSelf(getTextForMerchant),callFuncParams(_usr,getNameEx,"кто")];
		private _p = ["Paper",_pos,null,false] call createItemInWorld;
		setVar(_p,name,"Приветственное письмо");
		setVar(_p,content,_txt);
		setVar(_p,canWrite,false);

		_p = ["Paper",_infopos,null,false] call createItemInWorld;
		_txt = "<t color='#000000' font='RobotoCondensedLight'>";
		modvar(_txt) + "<t align='center'>Сегодня в ассортименте:</t>";
		{
			//typename,lowprice,maxprice,ctg,countslow,countsmax
			_y params ["_type","_price","_ctg","_count"];
			modvar(_txt) + sbr + format["   %1 - %2",[_type,"name",true,"getName"] call oop_getFieldBaseValue,[_price,["звяк","звяка","звяков"],true] call toNumeralString];
		} foreach getSelf(dataStorage);
		modvar(_txt) + "</t>";
		setVar(_p,name,"Список товаров");
		setVar(_p,content,_txt);
		setVar(_p,canWrite,false);
	};*/

	//3 очков по тексту. когда 0 торговля прекращается
	//var(points,3);

	//Получить текст при уменьшении очков
	/*func(getPointLessText)
	{
		objParams_1(_pts);
		"<t color='#000000' font='RobotoCondensedLight'>Здравствуйте. Вами был нарушено одно или несколько правил. Мы вынуждены сделать Вам выговор."+
		format["Если вы получите ещё %1 %3 - торговля с вашей точкой будет немедленно прервана.%2Всего наилучшего!</t>",_pts,sbr,[_pts,["выговор","выговора","выговоров"]] call toNumeralString];
	};*/

	/*func(getBlockText)
	{
		objParams();
		"<t color='#000000' font='RobotoCondensedLight'>" +
		"В соответсвии с уставом Торгового объединения, с момента написания этого письма Вы отстранены от работы торговым наместником Грязноямска."+sbr+
		"Ваша подпись более не действительна при подтверждении торговых передач."+sbr+sbr+
		"Уведомляем, что к поселению выслан новый наместник в сопровождении Комиссии. Подготовьте рабочее место к передаче до момента их прибытия."+
		"</t>"
	};*/

	//Отправка товаров
	/*func(onSend)
	{
		objParams();

		callSelf(playAct);

		//checking null papers
		{
			if isNullReference(_y) then {
				getSelf(generatedOrders) deleteAt _x;
				getSelf(generatedPapers) deleteAt _x;
				{
					delete(_x); //удаляем итемы потому что бумага проебалась?
				} forEach (getSelf(sendedItems) get _x);
				getSelf(sendedItems) deleteAt _x;
			};
		} foreach +getSelf(generatedPapers);

		if (getSelf(points) <= 0) exitWith {
			{
				delete(_x);
			} foreach array_copy(getSelf(content));
		};



		private _items = + getSelf(content);
		private _hasReq = 0; //Имеет ли успешные действия
		private _pointsLeft = 0;
		private _lastType = "";
		private _lastOrderId = "";
		private _countedMoneys = 0;
		private _needMoney = 0;
		{
			if (isTypeOf(_x,Money)) then {
				modvar(_countedMoneys) + (getVar(_x,stackCount) * ifcheck(isTypeOf(_x,Bryak),10,1));
			};
			if isTypeOf(_x,Paper) then {
				private _ref = refcreate(vec4("","","",""));
				if callSelfParams(parsePaper,_x arg _ref) then {

					refget(_ref) params ["_type","_text","_paperName","_orderId"];

					//Если уже есть какие-то бумаги с обработанным текстом - наказываем очко...
					if (_hasReq > 0) exitWith {
						INC(_pointsLeft);
						#ifdef LOG_TRADE
						errorformat("PENALTY - request duplicate %1 as <%2>",_hasReq arg _lastType);
						#endif
					};

					_lastType = _type;
					_lastOrderId = _orderId;

					call {
						//запрос покупки
						if (_type == "buy") exitWith {
							if callSelfParams(removeItem,_x arg nullPtr) then {
								delete(_x);
							};
							private _meta = [_orderId,_paperName,_text];
							callSelfParams(addTask,"buy_req" arg _meta arg randInt(30,60));

							_hasReq = 1;
						};
						//Подтверждение покупки
						if (_type == "buyaccept") exitWith {
							//breakpoint(_type);
							//breakpoint(_orderId);
							//breakpoint(getSelf(generatedOrders) get _orderId);
							//private _meta = _orderId;
							_needMoney = _paperName;
							//callSelfParams(addTask,"buy_accept" arg _meta arg randInt(130,170));

							_hasReq = 2;
						};
						if (_type == "changemon") exitWith {
							private _isBigMon = _paperName;

							private _itemsList = _items - [_x];

							//Удаляем бумагу запроса.
							delete(_x);
							private _fullAm = 0;
							{
								if isNullReference(_x) then {continue};
								if isTypeOf(_x,Money) then {
									modvar(_fullAm) + (getVar(_x,stackCount) * ifcheck(isTypeOf(_x,Bryak),10,1));
								};
							} foreach _itemsList;

							if (_fullAm > 0) then {
								private _meta = [_isBigMon,_fullAm];
								callSelfParams(addTask,"money_change" arg _meta arg randInt(10,30));
							};

							_hasReq = 5;
						};
						//запрос цены на продажу
						if (_type == "price") exitWith {

							private _itemsList = _items - [_x];

							//Удаляем бумагу запроса.
							delete(_x);

							private _pr = 0;
							private _modif = callSelf(sellPriceModifier);

							if (count _itemsList == 0) exitWith {
								//товаров нет. репорт!

								INC(_pointsLeft);
								#ifdef LOG_TRADE
								error("PENALTY - no such items at getting price");
								#endif
							};

							{
								if isNullReference(_x) then {continue};
								#ifdef LOG_TRADE
								errorformat("check item %1 - size %2; real price %3",_x arg getVar(_x,size) arg (getVar(_x,size)/_modif));
								#endif
								modvar(_pr) + (getVar(_x,size)/_modif);
							} forEach _itemsList;

							#ifdef LOG_TRADE
							warningformat("D1 %1 D2 %2 D3 %3",_itemsList arg _modif arg floor _pr);
							#endif

							private _meta = [_orderId,floor _pr];

							callSelfParams(addTask,"sell_getprice" arg _meta arg randInt(30,60));

							_hasReq = 3;
						};
						if (_type == "sell") exitWith {

							//Удаляем бумагу продажи.
							delete(_x);

							private _meta = [_orderId,_paperName];
							if (_orderId in getSelf(sendedItems)) then {
								//указатель тут не уменьшается потом что проверка в "Выговор за подделку"
								callSelfParams(addTask,"sell_accept" arg _meta arg randInt(20,40));
							};

							_hasReq = 6;
						};
						//отмена продажи с возвратом
						if (_type == "cancel") exitWith {

							//Удаляем бумагу продажи.
							delete(_x);

							private _meta = _orderId;
							//защита от пидорства. нечего обратно отправить
							if (_orderId in getSelf(sendedItems)) then {
								callSelfParams(addTask,"sell_cancel" arg _meta arg randInt(20,40));
							};

							_hasReq = 4;
						};
						//неизвестный контент?!
					};




					//callSelfParams(createItemInContainer,"Paper" arg null arg null arg [vec3("var","content",callSelf(getTextForMerchant))]);
				};
			};
		} foreach _items;

		#ifdef LOG_TRADE
		warningformat("LAST TYPE %1, ORDER %2, COUNTET MONEY %3 -> need %4",_lastType arg _lastOrderId arg _countedMoneys arg _needMoney);
		warningformat("S1:%1 S2:%2 S3:%3",getSelf(generatedOrders) arg getSelf(generatedPapers) arg getSelf(sendedItems));
		warningformat("points %1",_pointsLeft);
		#endif

		//Выговор за подделку
		//подделка может быть при
		if (!(_lastOrderId in getSelf(generatedPapers)) && (_lastType == "buyaccept")) then {
			INC(_pointsLeft);
			#ifdef LOG_TRADE
			errorformat("PENALTY - unknown order %1 at type %2",_lastOrderId arg _lastType);
			#endif
		};
		if (!(_lastOrderId in getSelf(sendedItems)) && (_lastType in ["cancel","sell"])) then {
			INC(_pointsLeft);
			#ifdef LOG_TRADE
			errorformat("PENALTY - unknown order for second pass %1 at type %2",_lastOrderId arg _lastType);
			#endif
		};

		if (_lastType == "buyaccept") then {
			private _meta = _lastOrderId;
			if (_countedMoneys < _needMoney) exitWith {
				INC(_pointsLeft);
				#ifdef LOG_TRADE
				error("PENALTY - money too low...");
				#endif
			};
			if (_pointsLeft == 0) then {
				callSelfParams(addTask,"buy_accept" arg [_meta arg _countedMoneys - _needMoney] arg randInt(30,60));
			};
		};

		if (_pointsLeft > 0) then {
			modSelf(points,- _pointsLeft);
			if (getSelf(points) <= 0) then {
				callSelfParams(addTask,"trade_block" arg getSelf(points) arg randInt(10,60));
			} else {
				callSelfParams(addTask,"trade_penalty" arg getSelf(points) arg randInt(10,60));
			};
		};

		private _remall = {
			params ["_orderId","_type"];
			//errorformat("COND %1 -> content: %2",_this arg getSelf(content));

			//Подтверждение покупки
			if (_type == "buyaccept" || _orderId == "" || _type == "" || _type == "changemon") exitWith {
				//Подчищаем всё...
				{
					delete(_x);
				} foreach +getSelf(content);
			};

			//С доп защитой от подмены стека
			if (_orderId != "" && _type != "sell" && _type != "cancel") then {
				#ifdef LOG_TRADE
				errorformat("OVERRIDE VALUE ID %1 with %2",_orderId arg getSelf(content));
				#endif
				getSelf(sendedItems) set [_orderId,array_copy(getSelf(content))];
			};

			{
				callSelfParams(removeItem,_x arg objNUll);
			} foreach array_copy(getSelf(content));
		};

		//Удаляем всё...
		[_lastOrderId,_lastType] call _remall;
	};*/


	/*bcond___ = false;
	func(onClick)
	{
		objParams_1(_usr);
		if (!bcond___) then {
			#ifdef testcase_buy
			pointerList get '109' setVariable ["content","<t color='#000000'>купить:<br/>бумаг - 3 шт.<br/></t>"];
			#endif
			#ifdef testcase_buyaccept_throwerror_lowmoney
			__testcase_buyaccept_throwerror_lowmoney = true;
			#endif
			#ifdef testcase_buyaccept
				_id = "1234-АБВГ";
				_t = "<t color='#000000' font='RobotoCondensedLight'>Заказ сформирован."+sbr+" Номер: " + _id + sbr+sbr+"текст............. Итого: 2 зв.";
				pointerList get '109' setVariable ["content",_t];
				getSelf(generatedPapers) set [_id,pointerList get '109'];
				getSelf(generatedOrders) set [_id,[["PaperHolder",3],["ShortSword",2]]];

				if isNullVar(__testcase_buyaccept_throwerror_lowmoney) then {
					callSelfParams(createItemInContainer,"Zvak" arg 2);
				};
			#endif
			#ifdef testcase_sell

			pointerList get '109' setVariable ["content","<t color='#000000'>Я хочу узнать цену отправленных товаров<br/>Пришлите в кратчайшие сроки!</t>"];

			callSelfParams(createItemInContainer,"Bandage" arg 5);
			callSelfParams(createItemInContainer,"CombatKnife" arg 2);
			callSelfParams(createItemInContainer,"Sigarette" arg 3);
			#endif
			#ifdef testcase_priceget
			pointerList get '109' setVariable ["content","<t color='#000000'>Я хочу узнать цену отправленных товаров<br/>Пришлите в кратчайшие сроки!</t>"];
			callSelfParams(createItemInContainer,"CaveAxe" arg 1);
			#endif
		};
		callSelf(onSend);
	};*/

	/*func(parsePaper)
	{
		objParams_2(_paper,_outtext);
		private _txt = callFunc(_paper,getContent);
		forceUnicode 0;
		if (_txt == "") exitWith {false};

		private _lets = ["а","б","в","г","д","е","ж","и","к","л","м","н","о","п","р","с","т","ф","х","ц","ч","ш","э","ю","я",
		"0","1","2","3","4","5","6","7","8","9"];

		private _orderId = toUpper format["%1%2%3%4-%5%6%7%8",randInt(0,9),randInt(0,9),randInt(0,9),randInt(0,9),pick _lets,pick _lets,pick _lets,pick _lets];

		_txt = sanitizeHTML(_txt);
		breakpoint(_txt);

		if ([_txt,"Заказ сформирован.*Номер: \d\d\d\d-...."] call regex_isMatch) exitWith {
			private _reqid = [_txt,"Заказ сформирован.*Номер: \d\d\d\d-...."] call regex_getFirstMatch;
			_reqid = [_reqid,"\d\d\d\d-...."] call regex_getFirstMatch;
			private _needMoney = [_txt,"Итого: \d{1,3} зв\."] call regex_getFirstMatch;
			_needMoney = [_needMoney,"\d{1,3}"] call regex_getFirstMatch;
			_needMoney = parseNumber _needMoney;

			//breakpoint("REQ>>>>> " + _reqid);
			refset(_outtext,["buyaccept" arg null arg _needMoney arg _reqid]);

			true
		};

		if ([_txt,"(((Р|р)азмен)|(П|п)оменя).*(\ +на\ +)?(бр|зв)як.*"] call regex_isMatch) exitWith {

			private _t = [_txt,"(\ +на\ +)?(бр|зв)як"] call regex_getFirstMatch;
			private _isBigMon = "бряк" in _t;
			refset(_outtext,["changemon" arg null arg _isBigMon arg _orderId]);

			true
		};
		//подтверждение продажи
		if ([_txt,"Запрос на продажу по заказу \d\d\d\d-.... рассмотрен.*Итого: \d{1,3} звяк"] call regex_isMatch) exitWith {
			private _reqid = [_txt,"Запрос на продажу по заказу \d\d\d\d-.... рассмотрен.*Итого: \d{1,3} звяк"] call regex_getFirstMatch;
			private _price = [_reqid,"Итого: \d{1,3} звяк"] call regex_getFirstMatch;
			_price = parseNumber ([_price,"\d{1,3}"] call regex_getFirstMatch);
			_reqid = [_reqid,"\d\d\d\d-...."] call regex_getFirstMatch;


			refset(_outtext,["sell" arg null arg _price arg _reqid]);

			true
		};
		//отмена продажи
		if ([_txt,"(отмен|отозв).*\d\d\d\d-...."] call regex_isMatch) exitWith {
			private _reqid = [_txt,"(отмен|отозв).*\d\d\d\d-...."] call regex_getFirstMatch;
			_reqid = [_reqid,"\d\d\d\d-...."] call regex_getFirstMatch;

			refset(_outtext,["cancel" arg null arg null arg toUpper _reqid]);

			true
		};

		//Парсинг запроса цены только после ответки
		//запрос стоимости на продажу
		if ([_txt,"(сумм|продаж|цен|стоим)"] call regex_isMatch) exitWith {

			refset(_outtext,["price" arg null arg null arg _orderId]);

			true
		};

		//Закупить парсим раньше чем парсинг номера заказа
		//Просьба закупить
		if ([_txt,"^([а-яА-Я ,.?!]*((З|з)аказ|(К|к)упи|(П|п)окуп|(П|п)риобре)[а-яА-Я ,.?!]*:)"] call regex_isMatch) exitWith {
			//breakpoint("catch 2");

			private _buyText = "<t color='#000000' font='RobotoCondensedLight'>Заказ сформирован." +sbr;

			_buyText = _buyText + "Номер: " + _orderId;
			private _buyList = [];
			private _tpart = "";
			private _amount = 0;
			private _allprice = 0;
			{
				//breakpoint("PAT:	" + _x);
				//[#typename,randInt(lowprice,maxprice),ctg,randInt(countslow,countsmax),[ #typename ,"name",true,"getName"] call oop_getFieldBaseValue]
				_y params ["_typename","_price","_categ","_counts","_name"];
				//Нашли товар. Находим и количество
				if (vec2(_txt,_x) call regex_isMatch) then {
					//breakpoint(true);
					_tpart = [_txt,_x] call regex_getFirstMatch;
					_tpart = [_tpart,"\d{1,3}[ ]*(шт(ук|уки)?\.?)?"] call regex_getFirstMatch;
					if (_tpart != "") then {
						//breakpoint(_tpart);
						_amount = floor parseNumber _tpart;
						//breakpoint(_amount);
						if (_amount <= 0) exitWith {
							//предлагаем штраф за мемы...

						};

						//на складе кончилось такое
						if (_counts <= 0) exitWith {
							_buyText = _buyText + sbr + format["Товара '%1' нет на складе.",_name];
						};
						//Больше чем на складе
						if (_amount > _counts) exitWith {
							_buyText = _buyText + sbr + format["Товара '%1' на складе: %2, затребовано: %3. Измените количество.",_name,_counts,_amount]
						};

						MOD(_allprice, + (_amount * _price));
						_buyText = _buyText + sbr + format["Товар '%1' - цена %2, всего %3 зв. за %4 шт",_name,_price,_amount * _price,_amount];

						_buyList pushBack vec2(_typename,_amount);
					};
				};
			} foreach getSelf(dataStorage);

			_buyText = _buyText + sbr + sbr + format["Итого: %1 зв.",_allprice];

			_buyText = _buyText + "</t>";

			//if (_allprice == 0) exitWith {false}; //false чтобы не удалять штуку

			//traceformat("bt %1",_buyText);
			refset(_outtext,["buy" arg _buyText arg format["Заказ '%1'" arg _orderId] arg _orderId]);

			//make order
			getSelf(generatedOrders) set [_orderId,_buyList];

			true
		};

		false

	};*/


	var(console,nullPtr);

endclass

class(PrinterMerchantConsole) extends(ElectronicDevice)
	var(name,"Печатник");
	var(desc,"Используется для печати заказов");

	func(getDescFor)
	{
		objParams_1(_usr);
		super() + (if (count getSelf(papers) > 0) then {sbr + format["Загружено %1 бумаги",[count getSelf(papers),["лист","листа","листов"],true]call toNumeralString]} else {""})
	};

	var(model,"CBRNContainer_01_closed_olive_F");
	var(material,"MatSynt");
	var(dr,3);
	var(papers,[]);
	var(maxPaperCount,20);
	var(edIsEnabled,true);

	var(printed,[]);

	func(canMoveInItem)
	{
		objParams_1(_item);
		(count getSelf(papers)) < getSelf(maxPaperCount)
	};

	func(onMoveInItem)
	{
		objParams_1(_item);
		getSelf(papers) pushBack _item;
		setVar(_item,loc,this);
	};

	func(canMoveOutItem)
	{
		objParams_1(_item);
		count getSelf(printed) > 0
	};

	func(onMoveOutItem)
	{
		objParams_1(_item);

	};

	func(onClick)
	{
		objParams_1(_usr);
		if (count getSelf(printed) > 0) exitWith {
			private _itm = getSelf(printed) deleteAt 0;
			callFuncParams(_itm,moveItem,_usr);
		};
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if (callFunc(_with,getClassName) == "Paper") then {
			if (count getVar(_with,content) > 0) exitWith {
				callFuncParams(_usr,localSay,"Нужна чистая бумага." arg "error");
			};
			callFuncParams(_with,moveItem,this);
		};
	};

	var(console,nullPtr);

	func(linkToConsole)
	{
		objParams_1(_console);
		setSelf(console,_console);
		setVar(_console,printer,this);
	};

endclass

#include <MerchantConsole.hpp>


class(MerchantConsole) extends(ElectronicDevice)
	var(name,"Клавишник");
	var(model,"ml\ml_object_new\model_14_10\panelka.p3d");
	var(printer,nullPtr);
	var(edIsEnabled,true);
	#include "..\..\Interfaces\INetDisplay.Interface"

	var(ndName,"MerchantConsole");
	var(material,"MatSynt");
	var(ndInteractDistance,INTERACT_DISTANCE);
	getter_func(getMainActionName,"Заказать");
	func(onMainAction)
	{
		objParams_1(_usr);
		callSelfParams(openNDisplay,_usr);
	};

	var(dispMode,MC_MODE_MAINMENU); //in main menu, possible cats: menu,disabled,incat
	
	

	var(curCat,MC_CAT_CLOTH);

	//TODO remove this macros, replace with methods
	#define regConsole \
	___s = []; \
	___s resize (MC_CATSYS_LAST_INDEX+1); \
	_global_merchantconsole_tradelist = ___s apply {[]}; \
	_global_merchantconsole_catnames = [];

	#define endRegConsole var_exprval(tradelist,_global_merchantconsole_tradelist); \
	var_exprval(tradecats,_global_merchantconsole_catnames);

	#define regCat(cat,namestr) _global_merchantconsole_catnames pushBack [cat,namestr];

	#define regItem(cat,typename_std,typename_compiled,minprice,maxprice,mincount,maxcount) _ctbuf = _global_merchantconsole_tradelist select cat; \
	_ctbuf pushBack ["",typename_std,{typename_compiled},randInt(minprice,maxprice),randInt(mincount,maxcount),0];

	#define regEnergyCount(cat,strname,__code,price,count__) _ctbuf = _global_merchantconsole_tradelist select cat; \
	_ctbuf pushBack [strname,"<NULLOBJ>",__code,price,count__,0];

	#define regItemDef(cat,typename,minpr,maxpr,minc,maxc) regItem(cat,typename,typename,minpr,maxpr,minc,maxc)
	#define regItemCustomName(cat,name,typename,minpr,maxpr,minc,maxc) _ctbuf = _global_merchantconsole_tradelist select cat; \
	_ctbuf pushBack [name,typename,{typename},randInt(minpr,maxpr),randInt(minc,maxc),0];

	regConsole;

	regCat(MC_CAT_CLOTH,"Экипировка")
	regCat(MC_CAT_WEAPONS,"Оружие")
	regCat(MC_CAT_AMMO,"Боеприпасы")
	regCat(MC_CAT_LIGHT,"Свет")
	regCat(MC_CAT_FOOD,"Пища")
	regCat(MC_CAT_MEDICAL,"Медицина")
	regCat(MC_CAT_OTHER,"Прочее")
	regCat(MC_CAT_CONTAINERS,"Контейнеры")
	regCat(MC_CAT_MONEY,"Валюта");
	regCat(MC_CAT_ENEGRY,"Энергия");

	regItem(MC_CAT_CLOTH,"BalaclavaMask",pick vec2("BalaclavaMask","BalaclavaMask2"),2,4,2,7)
	regItem(MC_CAT_CLOTH,"BrownBandannaMask",pick vec2("BrownBandannaMask","BlackBandannaMask"),1,2,2,7)
	regItemDef(MC_CAT_CLOTH,"WorkerCap",3,5,3,6)
	regItemDef(MC_CAT_CLOTH,"HatOldUshanka",3,6,3,5)
	regItemDef(MC_CAT_CLOTH,"WoolCoat",8,12,5,7)
	regItem(MC_CAT_CLOTH,"CitizenCloth1","CitizenCloth"+str randInt(1,22),2,4,3,10)

	regItemDef(MC_CAT_OTHER,"PaperHolder",7,11,2,7)
	regItemDef(MC_CAT_OTHER,"PenBlack",2,5,5,12)
	regItemDef(MC_CAT_OTHER,"SmallBattery",2,6,4,20)
	regItemDef(MC_CAT_OTHER,"WireCutters",6,14,5,10)
	regItemDef(MC_CAT_OTHER,"Screwdriver",6,14,5,10)
	regItemDef(MC_CAT_OTHER,"Crowbar",5,10,3,10)
	regItemDef(MC_CAT_OTHER,"Lockpick",3,6,5,20)
	regItemDef(MC_CAT_OTHER,"BrushCleaner",2,5,4,15)

	regItemDef(MC_CAT_OTHER,"WoodenDebris3",4,6,20,50)
	regItemDef(MC_CAT_OTHER,"WoodenDebris7",3,3,10,30)
	regItemDef(MC_CAT_OTHER,"WoodenDebris6",2,2,10,30)

	regItemDef(MC_CAT_OTHER,"Pickaxe",5,8,5,15)
	regItemDef(MC_CAT_OTHER,"WorkingAxe",5,8,5,15)
	regItemDef(MC_CAT_OTHER,"Sledgehammer",5,8,5,15)
	regItemDef(MC_CAT_OTHER,"Hammer",3,6,5,15)
	regItemDef(MC_CAT_OTHER,"Sledgehammer1",4,7,5,15)

	regItemDef(MC_CAT_OTHER,"Rag",1,3,10,30)

	regItemDef(MC_CAT_LIGHT,"TorchDisabled",3,5,5,10)
	regItemDef(MC_CAT_LIGHT,"CandleDisabled",1,3,10,20)
	regItemDef(MC_CAT_LIGHT,"LampKeroseneDisabled",8,12,3,8)
	regItemDef(MC_CAT_LIGHT,"CampfireCreator",5,8,3,8)
	regItemDef(MC_CAT_LIGHT,"MatchBox",1,2,4,6)

	regItemDef(MC_CAT_WEAPONS,"Baton",12,18,3,6)
	regItemDef(MC_CAT_WEAPONS,"ShortSword",25,45,1,5)
	regItemDef(MC_CAT_WEAPONS,"CombatKnife",15,25,3,5)
	regItemDef(MC_CAT_WEAPONS,"PistolPBM",40,60,1,3)
	regItemDef(MC_CAT_WEAPONS,"ShotgunMini",30,50,1,3)
	regItemDef(MC_CAT_WEAPONS,"DBShotgun",30,40,1,7)
	regItemDef(MC_CAT_WEAPONS,"Shotgun",60,90,1,2)
	regItemDef(MC_CAT_WEAPONS,"Trap",10,15,1,4)

	regItemCustomName(MC_CAT_AMMO,"Патроны для ПБМ","AmmoBoxPBM",16*1,16*2,1,7)
	regItemCustomName(MC_CAT_AMMO,"Патроны для ПБМ (нелетальные)","AmmoBoxPBMNonLethal",16,25,1,10)
	regItemCustomName(MC_CAT_AMMO,"Магазин ПБМ","MagazinePBM",20,27,1,8)
	regItemCustomName(MC_CAT_AMMO,"Патроны для Крохи","AmmoBoxShotgunMini",20,40,1,10)
	regItemCustomName(MC_CAT_AMMO,"Патроны для дробовика","AmmoBoxShotgun",25,45,1,8)
	regItemCustomName(MC_CAT_AMMO,"Патроны для дробовика (нелетальные)","AmmoBoxShotgunNonLethal",18,27,1,15)

	regItemDef(MC_CAT_MEDICAL,"Syringe",4,8,5,15)
	regItemDef(MC_CAT_MEDICAL,"Bandage",6,10,15,25)
	regItemDef(MC_CAT_MEDICAL,"NeedleWithThreads",2,8,4,10)
	regItemDef(MC_CAT_MEDICAL,"PainkillerBox",10,20,2,10)
	regItemDef(MC_CAT_MEDICAL,"CetalinBox",15,25,2,10)
	regItemDef(MC_CAT_MEDICAL,"KoradizinBox",20,30,2,10)
	regItemDef(MC_CAT_MEDICAL,"LiqDemitolin",30,40,1,5)
	regItemDef(MC_CAT_MEDICAL,"LiqTovimin",15,25,1,6)
	regItemDef(MC_CAT_MEDICAL,"SurgicalExpander",8,20,1,5)
	regItemDef(MC_CAT_MEDICAL,"SurgeryScalpel",8,20,1,5)
	regItemDef(MC_CAT_MEDICAL,"SurgicalSaw",8,20,1,5)
	regItemDef(MC_CAT_MEDICAL,"Forceps",5,15,1,5)


	regItemDef(MC_CAT_FOOD,"SigaretteDisabled",1,2,15,30)
	regItemDef(MC_CAT_FOOD,"Muka",4,7,15,25)
	regItemDef(MC_CAT_FOOD,"SaltShaker",4,7,15,25)
	regItemDef(MC_CAT_FOOD,"SugarShaker",4,7,15,25)
	regItemDef(MC_CAT_FOOD,"PepperShaker",4,7,15,25)
	regItemDef(MC_CAT_FOOD,"Meat",5,10,5,10)
	regItemDef(MC_CAT_FOOD,"Egg",3,8,8,17)

	regItemDef(MC_CAT_CONTAINERS,"CoinBag",3,5,5,7)
	regItemDef(MC_CAT_CONTAINERS,"LeatherBackpackBrown",8,12,3,7)
	regItemDef(MC_CAT_CONTAINERS,"LeatherBackpackBlack",8,12,3,7)
	regItemDef(MC_CAT_CONTAINERS,"BigLeatherBackpackBrown",10,14,2,5)
	regItemDef(MC_CAT_CONTAINERS,"BigLeatherBackpackBlack",10,14,2,5)
	regItemDef(MC_CAT_CONTAINERS,"Satchel",8,12,3,7)

	regItemDef(MC_CAT_CONTAINERS,"Briefcase",10,15,1,8)
	regItemDef(MC_CAT_CONTAINERS,"Suitcase",10,15,1,8)
	regItemDef(MC_CAT_CONTAINERS,"SteelBrownContainer",10,15,1,8)
	regItemDef(MC_CAT_CONTAINERS,"ShuttleBag",9,12,1,2)
	regItem(MC_CAT_CONTAINERS,"FabricBagBig1","FabricBagBig"+str randInt(1,2),10,15,3,8)

	regItemDef(MC_CAT_MONEY,"Zvak",1,1,400,600)
	regItemDef(MC_CAT_MONEY,"Bryak",10,10,200,400)

	//regEnergyCount(cat,strname,data,price,count__)
	_randEnergyPricePerMin = randInt(3,8);
	#define regEnProvider(__GENERATED_TIME__) { \
		private _gen = ["PowerGenerator",[3827.37,3728.61,17.0241],4,false] call getGameObjectOnPosition; \
		if !isNullReference(_gen) then { \
			modVar(_gen,gettedEnergy,+ randInt(3000,3600)*60* __GENERATED_TIME__); \
		}; \
	}

	regEnergyCount(MC_CAT_ENEGRY,"Энергия (10 минут)",regEnProvider(10),_randEnergyPricePerMin * 10,randInt(0,10));
	regEnergyCount(MC_CAT_ENEGRY,"Энергия (30 минут)",regEnProvider(30),_randEnergyPricePerMin * 30,randInt(0,5));
	regEnergyCount(MC_CAT_ENEGRY,"Энергия (1 час)",regEnProvider(60),_randEnergyPricePerMin * 60,randInt(0,2));

	endRegConsole;

	func(getNDInfo)
	{
		objParams();
		private _dmode = getSelf(dispMode);
		private _data = [_dmode];
		if equals(_dmode,MC_MODE_SELECTCAT) exitWith {
			_data append getSelf(tradecats);
			_data
		};
		if equals(_dmode,MC_MODE_CATLIST) exitWith {
			private _reqCart = getSelf(requestCart);
			private _refList = getSelf(tradelist) select getSelf(curCat);
			{
				_x params ["_name","_typeName","_typeCode","_price","_count","_requested"];
				if (_name == "") then {
					_name = [_typeName,"name",true,"getName"] call oop_getFieldBaseValue;
					_refList select _forEachIndex set [0,_name];
				};
				if (_requested > 0) then {
					_data pushBack [_name,_price,_count,_requested];
				} else {
					_data pushBack [_name,_price,_count];
				};
			} foreach _refList;
			_data
		};
		if equals(_dmode,MC_MODE_PRINT) exitWith {
			if (count getSelf(requestCart) == 0) exitWith {
				_data pushBack -999;
				_data
			};
			private _buf = [];
			private _price = 0;
			private _tradelist = getSelf(tradelist);
			{
				_x params ["__ct","__itm"];
				(_tradelist select __ct select __itm) params ["_name","","","_priceOneItm","","_req"];
				modvar(_price) + (_priceOneItm * _req);
				_buf pushBack [_name,_req];

			} foreach getSelf(requestCart);
			_data pushBack _price;
			_data append _buf;
			/*for "_i" from 1 to 100 do {
				_data pushBack ["ITM_"+str _i,randInt(1,100)];
			};*/
			_data
		};
		if equals(_dmode,MC_MODE_GETSTATUS) exitWith {
			_data pushBack getSelf(money);
			_data pushBack callFunc(getSelf(pipe),getTasksText);
			_data
		};
		_data
	};

	var(requestCart,[]); //item-> categ,idx,
	var(maxRequestCount,10); //сколько позиций может быть в заказе

	var(money,randInt(5,30));

	var(pipe,nullPtr);
	func(linkPipe)
	{
		objParams_1(_pipe);
		setSelf(pipe,_pipe);
		setVar(_pipe,console,this);
	};

	func(addTask)
	{
		objParams_3(_tasktype,_metadata,_invokeAfter);
		if isNullReference(getSelf(pipe)) exitWith {};
		callFuncParams(getSelf(pipe),addTask,_tasktype arg _metadata arg _invokeAfter);
	};

	func(handleNDInput)
	{
		objParams_2(_usr,_inp);

		private _mode = getSelf(dispMode);

		_inp params ["_userMode","_userInput","_optData"];

		//Клиент не успел синхронизировать состояние режима дисплея. отбрасываем запрос.
		if not_equals(_mode,_userMode) exitWith {
			#ifdef DEBUG
			errorformat("%1::handleNDInput() - mode equality %2",callSelf(getClassName) arg _mode);
			#endif
		};

		#define checkMode(m__) if (_mode == m__) exitWith
		#define compareInput(t__) if (_userInput == t__) exitWith
		checkMode(MC_MODE_MAINMENU) {
			compareInput(MC_MAIN_SWITCHMODE) {callSelfParams(setEnable,false)};
			compareInput(MC_MAIN_TOTRADE) {
				callSelfParams(setDispMode,MC_MODE_SELECTCAT);
			};
			compareInput(MC_MAIN_PRINT) {
				callSelfParams(setDispMode,MC_MODE_PRINT)
			};
			compareInput(MC_MAIN_GETSTATUS) {
				callSelfParams(setDispMode,MC_MODE_GETSTATUS)
			};
			compareInput(MC_MAIN_CHANGEMON) {
				private _pipe = getSelf(pipe);

				private _cls = "";
				private _mon = 0;
				{
					_cls = callFunc(_x,getClassName);
					if (_cls == "Zvak" || _cls == "Bryak") then {
						modvar(_mon) + getVar(_x,stackCount) * ifcheck(_cls=="Bryak",10,1);
						delete(_x);
					};
				} foreach (+getVar(_pipe,content));
				//breakpoint(_mon)
				if (_mon > 0) then {
					callSelfParams(addTask,"c_addmon" arg _mon arg randInt(10,30));
					callFunc(getSelf(pipe),playAct);
				} else {
					callFuncParams(_usr,localSay,"В трубе доставки нет звяков и бряков." arg "error");
				};
			};
		};
		checkMode(MC_MODE_DISABLED) {
			compareInput(MC_MAIN_SWITCHMODE) {
				if (!getSelf(edIsUsePower)) exitWith {
					callFuncParams(_usr,localSay,"Нет энергии." arg "error");
				};
				callSelfParams(setEnable,true);
			};
		};
		checkMode(MC_MODE_SELECTCAT) {
			compareInput(MC_GENERIC_BACK) {
				callSelfParams(setDispMode,MC_MODE_MAINMENU);
			};
			setSelf(curCat,_userInput);
			callSelfParams(setDispMode,MC_MODE_CATLIST);
		};
		checkMode(MC_MODE_CATLIST) {
			compareInput(MC_GENERIC_BACK) {
				callSelfParams(setDispMode,MC_MODE_SELECTCAT);
			};
			compareInput(MC_CATLIST_INC) {
				private _cart = getSelf(requestCart);
				private _categ = getSelf(curCat);

				private _idx = _cart findif {equals(_x select 0,_categ) && equals(_x select 1,_optData)};
				if (_idx == -1 && count _cart >= getSelf(maxRequestCount)) exitWith {
					callFuncParams(_usr,localSay,"Слишком много заказано..." arg "error");
				};
				//struct: _categ,_optdata,count
				private _struct = if (_idx == -1) then {
					private _structInternal = [_categ,_optData];
					_cart pushBack _structInternal;
					_structInternal;
				} else {
					_cart select _idx;
				};

				private _itemInfo = getSelf(tradelist) select _categ select _optData;
				_itemInfo params ["_name","_typeName","_typeCode","_price","_count","_req"];
				_itemInfo set [5,_req+1];

				callSelf(updateNDisplay);
			};
			compareInput(MC_CATLIST_DEC) {
				private _cart = getSelf(requestCart);
				private _categ = getSelf(curCat);

				private _idx = _cart findif {equals(_x select 0,_categ) && equals(_x select 1,_optData)};
				if (_idx == -1) exitWith {};

				private _itemInfo = getSelf(tradelist) select _categ select _optData;
				if (_itemInfo select 5 == 1) then {
					_cart deleteAt _idx;
				};
				_itemInfo set [5,(_itemInfo select 5)-1];

				callSelf(updateNDisplay);
			};
		};
		checkMode(MC_MODE_PRINT) {
			compareInput(MC_GENERIC_BACK) {callSelfParams(setDispMode,MC_MODE_MAINMENU)};
			compareInput(MC_PRINT_CLEAR) {
				private _itemInfo = null;
				{
					_itemInfo = getSelf(tradelist) select (_x select 0) select (_x select 1);
					_itemInfo set [5,0];
				} foreach getSelf(requestCart);
				setSelf(requestCart,[]);
				callSelf(updateNDisplay);
			};
			compareInput(MC_PRINT_DO) {
				private _fullPrice = 0;
				private _itemInfo = null;
				{
					_itemInfo = getSelf(tradelist) select (_x select 0) select (_x select 1);
					_itemInfo params ["_name","_typeName","_typeCode","_price","_count","_req"];
					//_itemInfo set [4,(_count-(_req*_price))max 0];
					modvar(_fullPrice) + (_req*_price);
					//_itemInfo set [5,0];
				} foreach getSelf(requestCart);

				if (getSelf(money) < _fullPrice) exitWith {
					callFuncParams(_usr,localSay,"Недостаточно звяков." arg "error");
				};

				private _meta = [];
				{
					_itemInfo = getSelf(tradelist) select (_x select 0) select (_x select 1);
					_itemInfo params ["_name","_typeName","_typeCode","_price","_count","_req"];
					if (_typeName == "<NULLOBJ>") then {
						_meta pushBack ["CALLCODE",_typeCode];
					} else {
						_meta pushBack [call _typeCode,_req];
					};

					_itemInfo set [4,(_count-(_req*_price))max 0];
					_itemInfo set [5,0];
				} foreach getSelf(requestCart);

				modSelf(money, - _fullPrice);
				setSelf(requestCart,[]);
				callSelf(updateNDisplay);

				callSelfParams(addTask,"c_buy" arg _meta arg randInt(30,40));
			};
		};
		checkMode(MC_MAIN_GETSTATUS) {
			compareInput(MC_GENERIC_BACK) {callSelfParams(setDispMode,MC_MODE_MAINMENU)};
		};

	};

	var(dispModeCached,MC_MODE_MAINMENU);
	func(onChangeEnergyState)
	{
		objParams_1(_mode);

		if (_mode) then {
			callSelfParams(setDispMode,getSelf(dispModeCached));
			setSelf(dispModeCached,MC_MODE_DISABLED);
		} else {
			setSelf(dispModeCached,getSelf(dispMode));
			callSelfParams(setDispMode,MC_MODE_DISABLED);
		};
	};

	func(onChangeUsePower) {
		objParams();
		super();
		private __changeprot = true;
		callSelfParams(onChangeEnergyState,getSelf(edIsUsePower));
	};

	func(onChangeEnable)
	{
		objParams();
		super();
		private __changeprot = true;
		callSelfParams(setDispMode,ifcheck(getSelf(edIsEnabled),MC_MODE_MAINMENU,MC_MODE_DISABLED));
	};

	func(setDispMode)
	{
		objParams_1(_mode);
		if (_mode == getSelf(dispMode)) exitWith {};

		setSelf(dispMode,_mode);
		if isNullVar(__changeprot) then {
			callSelfParams(playSound,"electronics\console_input"+str randInt(1,3) arg getRandomPitchInRange(0.9,1.2));
		};
		callSelf(updateNDisplay);
	};

endclass


class(MerchantConsoleOkopovo) extends(MerchantConsole)
	
	var(money,0);
	
	editor_attribute("EditorVisible" arg "type:string") editor_attribute("Tooltip" arg "Тип трубы")
	var(pipeside,"GameObject");
	func(onMainAction)
	{
		objParams_1(_usr);
		private _brole = getVar(_usr,basicRole);
		if (!isTypeStringOf(_brole,getSelf(pipeside))) then {
			private _m = pick["Не положено!","Мне нельзя туда лезть","Это не для меня стоит.","Лучше не трогать..."];
			callFuncParams(_usr,localSay,_m arg "error");
		} else {
			super();
		};
	};
	
	regConsole

	regCat(MC_CAT_CLOTH,"Снаряжение")
	regCat(MC_CAT_WEAPONS,"Оружие")
	regCat(MC_CAT_AMMO,"Боеприпасы")
	regCat(MC_CAT_LIGHT,"Свет")
	regCat(MC_CAT_MEDICAL,"Медицина")
	regCat(MC_CAT_FOOD,"Припасы")
	regCat(MC_CAT_OTHER,"Инструменты")
	regCat(MC_CAT_CONTAINERS,"Контейнеры")

	regItem(MC_CAT_CLOTH,"BalaclavaMask",pick vec2("BalaclavaMask","BalaclavaMask2"),4,6,2,7)
	regItem(MC_CAT_CLOTH,"BrownBandannaMask",pick vec2("BrownBandannaMask","BlackBandannaMask"),4,6,2,7)
	regItemDef(MC_CAT_CLOTH,"ArmorLite",15,15,50,100)
	regItemDef(MC_CAT_CLOTH,"ArmorMedium",30,30,50,100)
	regItemDef(MC_CAT_CLOTH,"ArmorHeavy",40,40,50,100)
	regItemCustomName(MC_CAT_CLOTH,"Ушанка","HatOldUshanka",1,1,50,100)
	regItemDef(MC_CAT_CLOTH,"CombatHat",15,15,50,100)

	regItemDef(MC_CAT_OTHER,"RopeItem",5,5,10,20)
	regItemDef(MC_CAT_OTHER,"PaperHolder",2,2,5,10)
	regItemDef(MC_CAT_OTHER,"PenBlack",1,1,5,10)
	regItemDef(MC_CAT_OTHER,"Shovel",8,8,5,10)
	regItemDef(MC_CAT_OTHER,"BrushCleaner",2,2,5,10)
	regItemDef(MC_CAT_OTHER,"FryingPan",3,3,5,10)

	regItemDef(MC_CAT_LIGHT,"SmallBattery",5,5,10,50)
	regItemDef(MC_CAT_LIGHT,"Flashlight",3,3,10,30)
	regItemDef(MC_CAT_LIGHT,"TorchDisabled",4,4,10,30)
	regItemDef(MC_CAT_LIGHT,"CandleDisabled",2,2,10,30)
	regItemDef(MC_CAT_LIGHT,"LampKeroseneDisabled",8,8,10,30)
	regItemDef(MC_CAT_LIGHT,"CampfireCreator",5,5,10,30)
	regItemDef(MC_CAT_LIGHT,"MatchBox",1,1,5,10)

	regItemDef(MC_CAT_WEAPONS,"ShortSword",40,40,5,10)
	regItemDef(MC_CAT_WEAPONS,"CombatKnife",5,5,10,50)
	regItemDef(MC_CAT_WEAPONS,"PistolPBM",10,10,25,50)
	regItemDef(MC_CAT_WEAPONS,"Shotgun",25,25,10,30)
	regItemDef(MC_CAT_WEAPONS,"RifleAuto",50,50,10,30)
	regItemDef(MC_CAT_WEAPONS,"RifleFinisher",20,20,50,100)
	regItemDef(MC_CAT_WEAPONS,"Trap",5,5,50,100)

	regItemCustomName(MC_CAT_AMMO,"Патроны для ПБМ","AmmoBoxPBM",5,5,50,100)
	regItemCustomName(MC_CAT_AMMO,"Магазин ПБМ","MagazinePBM",2,2,50,100)
	regItemCustomName(MC_CAT_AMMO,"Патроны для дробовика","AmmoBoxShotgun",6,6,50,100)
	regItemCustomName(MC_CAT_AMMO,"Патроны для винтовки","AmmoBoxRifle",7,7,50,100)
	regItemCustomName(MC_CAT_AMMO,"Магазин Товарища","MagazineAuto",5,5,50,100)
	regItemCustomName(MC_CAT_AMMO,"Магазин Навертыша","MagazineFinisher",5,5,50,100)

	regItemDef(MC_CAT_MEDICAL,"Syringe",2,2,1,10)
	regItemDef(MC_CAT_MEDICAL,"Bandage",3,3,50,100)
	regItemDef(MC_CAT_MEDICAL,"NeedleWithThreads",3,3,1,30)
	regItemDef(MC_CAT_MEDICAL,"PainkillerBox",5,5,1,30)
	regItemDef(MC_CAT_MEDICAL,"CetalinBox",3,3,1,30)
	regItemDef(MC_CAT_MEDICAL,"KoradizinBox",8,8,1,30)
	regItemDef(MC_CAT_MEDICAL,"LiqDemitolin",7,7,1,30)
	regItemDef(MC_CAT_MEDICAL,"LiqTovimin",10,10,1,30)
	regItemDef(MC_CAT_MEDICAL,"SurgicalExpander",10,10,1,10)
	regItemDef(MC_CAT_MEDICAL,"SurgeryScalpel",3,3,1,10)
	regItemDef(MC_CAT_MEDICAL,"SurgicalSaw",7,7,1,10)
	regItemDef(MC_CAT_MEDICAL,"Forceps",5,5,1,10)


	regItemDef(MC_CAT_FOOD,"SigaretteDisabled",1,1,50,100)
	regItemDef(MC_CAT_FOOD,"Muka",4,7,15,25)
	regItemDef(MC_CAT_FOOD,"SaltShaker",4,7,15,25)
	regItemDef(MC_CAT_FOOD,"SugarShaker",4,7,15,25)
	regItemDef(MC_CAT_FOOD,"PepperShaker",4,7,15,25)
	regItemDef(MC_CAT_FOOD,"Meat",5,10,5,10)
	regItemDef(MC_CAT_FOOD,"Egg",3,8,8,17)
	regItemDef(MC_CAT_FOOD,"SpirtBottle",4,7,1,20)
	regItemDef(MC_CAT_FOOD,"MilkBottle",15,20,1,15)

	regItemDef(MC_CAT_CONTAINERS,"SmallBackpack",25,25,1,10)
	regItemDef(MC_CAT_CONTAINERS,"FabricBagBig1",15,15,1,10)
	regItemDef(MC_CAT_CONTAINERS,"ShuttleBag",10,10,1,5)
	regItemDef(MC_CAT_CONTAINERS,"MedicalBag",7,7,1,5)
	regItemDef(MC_CAT_CONTAINERS,"SteelMedicalBox",5,5,1,5)
	regItemDef(MC_CAT_CONTAINERS,"SteelBrownContainer",5,5,1,5)

	endRegConsole;

endclass
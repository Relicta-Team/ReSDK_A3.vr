// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\GameConstants.hpp"
#include <..\..\..\..\client\Interactions\interact.hpp>

//#define EXPERIMENTAL_STACK_CHANGE_MODEL

//Любой предмет который можно стакать
class(Stack) extends(Item)

	/*
	public class DeclensionGenerator
    {
        /// <summary>
        /// Возвращает слова в падеже, зависимом от заданного числа
        /// </summary>
        /// <param name="number">Число от которого зависит выбранное слово</param>
        /// <param name="nominativ">Именительный падеж слова. Например "день"</param>
        /// <param name="genetiv">Родительный падеж слова. Например "дня"</param>
        /// <param name="plural">Множественное число слова. Например "дней"</param>
        /// <returns></returns>
        public static string Generate(int number, string nominativ, string genetiv, string plural) {
            var titles = new[] {nominativ, genetiv, plural};
            var cases = new[] {2, 0, 1, 1, 1, 2};
            return titles[number % 100 > 4 && number % 100 < 20 ? 2 : cases[(number % 10 < 5) ? number % 10 : 5]];
        }
    }
	*/

	getterconst_func(stackNames,vec3("Штучка","Штучки","Штучек"));//множественное название

	getterconst_func(isStack,true);
	var_str(stackName); //множественное количество
	var_num(stackMaxAmount); //максимальное количество
	var(stackCount,1); //количество предметов в стаке

	#ifdef EXPERIMENTAL_STACK_CHANGE_MODEL
	getterconst_func(getMultiModel,"a3\structures_f_epa\items\food\canteen_f.p3d");
	var_str(singleModel);
	#endif

	#include "..\..\Interfaces\INetDisplay.Interface"
	var(ndName,"TransferStack");
	var(ndInteractDistance,INTERACT_DISTANCE);

	func(getNDInfo) {
		objParams();

		[callSelf(getStackNameCase),getSelf(stackCount),getSelf(stackMaxAmount)]
	};

	func(onHandleNDInput) {
		objParams_2(_usr,_inp);

		_inp params ["_count"];

		callSelfParams(destackItem,_count arg _usr);
	};

	func(onChangeLoc)
	{
		objParams();
		callSelf(closeNDisplayForAllMobs);
	};

	func(constructor)
	{
		objParams();
		#ifdef EXPERIMENTAL_STACK_CHANGE_MODEL
		setSelf(singleModel,getSelf(model));
		#endif

		callSelf(recalculateStackWeight);
	};

	//производит перерасчёт веса стака
	func(recalculateStackWeight)
	{
		objParams();
		callSelf(onWeightChanged);
		#ifdef EXPERIMENTAL_STACK_CHANGE_MODEL
		if (getSelf(stackCount) > 1) then {
			setSelf(model,callSelf(getMultiModel));
		} else {
			setSelf(model,getSelf(singleModel));
		};
		#endif
	};

	func(getName)
	{
		objParams();
		if (getSelf(stackCount) == 1) exitWith {getSelf(name)};
		getSelf(stackName);
	};

	//получает числительное название
	func(getStackNameCase)
	{
		objParams();
		private _cases = [2, 0, 1, 1, 1, 2];
		private _number = getSelf(stackCount);
		private _idx = if (_number % 100 > 4 && _number % 100 < 20) then {2} else {
			_cases select (if(_number % 10 < 5)then{_number % 10} else {5})
		};
		callSelf(stackNames) select (_idx)
		//return titles[number % 100 > 4 && number % 100 < 20 ? 2 : cases[(number % 10 < 5) ? number % 10 : 5]];
	};

	func(onStack) {objParams_1(_usr);}; //событие при стаке (например проиграть звук)
	func(onDestack) {objParams_1(_usr);}; //событие при дестаке
	
	func(canStack) //количественная провера на вместимость стака
	{
		objParams();
		if (getSelf(stackCount) < getSelf(stackMaxAmount)) exitWith {true};
		false
	};

	func(canDestack) //количественная провера на вместимость стака
	{
		objParams();
		if (getSelf(stackCount) == 1) exitWith {false};
		true
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		private _text = callSuper(Item,getDescFor);

		if (getSelf(stackCount) == 1) exitWith {_text};

		private _mes = ["Тут кстати %1 %2","А тут между прочим %1 %2","Да тут целых %1 %2","Здесь %1 %2","Всего %1 %2","Целых %1 %2","Тут аж %1 %2"];

		_text + "<br/>" + format[pick(_mes),getSelf(stackCount),callSelf(getStackNameCase)]
	};

	func(getWeight)
	{
		objParams();
		super() * getSelf(stackCount)
	};

	func(removeFromStack)
	{
		objParams_1(_count);

		private _classname = callSelf(getClassName);
		_newItem = instantiate(_classname);

		setSelf(stackCount,getSelf(stackCount) - _count);
		setVar(_newItem,stackCount,_count);

		callSelf(onWeightChanged);

		_newItem
	};

	func(initCount)
	{
		objParams_1(_count);
		_count = clamp(_count,1,getSelf(stackMaxAmount));
		setSelf(stackCount,_count);
		callSelf(onWeightChanged);
	};

	func(addToStack)
	{
		objParams_1(_added);

		setSelf(stackCount,getSelf(stackCount) + getVar(_added,stackCount));

		callSelf(onWeightChanged);

		delete(_added);

		//testvar = _added;
	};

	func(canAddToStack)
	{
		objParams_1(_fromItem);

		if (callSelf(getClassName) != callFunc(_fromItem,getClassName)) exitWith {false};

		private _countFrom = getVar(_fromItem,stackCount);
		if (getSelf(stackCount) + _countFrom > getSelf(stackMaxAmount)) exitWith {false};

		true
	};

	func(getReasonForCantStack)
	{
		objParams_1(_fromItem);
		if (callSelf(getClassName) != callFunc(_fromItem,getClassName)) exitWith {selectRandom ["Предметы-то разные.","Не стоит смешивать то, что не должно быть смешано...","Разные вещи - путаница выйдет.","НЕ МЕШАЕМ БЛЯТЬ!"]};
		private _countFrom = getVar(_fromItem,stackCount);
		if (getSelf(stackCount) + _countFrom > getSelf(stackMaxAmount)) exitWith {selectRandom ["Слишком много.","Многовато будет."]};

		"А черт его знает почему не получилось."
	};

	func(stackItem)
	{
		objParams_2(_item,_usr);
		if !callSelfParams(canAddToStack,_item) exitWith {
			callFuncParams(_usr,localSay,callSelfParams(getReasonForCantStack,_item) arg "error");
		};

		private _oldLoc = getVar(_item,loc);
		if equals(_oldLoc,_usr) then {
			callFuncParams(_usr,removeItem,_item);
			callSelfParams(addToStack,_item);
		} else {
			callSelfParams(addToStack,_item);
		};

		callSelfParams(onStack,_usr);
	};

	func(destackItem)
	{
		objParams_2(_count,_usr);

		if !callSelf(canDestack) exitWith {
			callFuncParams(_usr,localSay,"Разделить не получится..." arg "error");
		};
		if !callFunc(_usr,isEmptyActiveHand) exitWith {
			callFuncParams(_usr,localSay,"Активная рука не пустая" arg "error");
		};

		private _newItem = callSelfParams(removeFromStack,_count);

		callFuncParams(_usr,addItem,_newItem); //adding in active hand

		callSelfParams(onDestack,_usr);

		if (getSelf(stackCount) == 1) then {
			callSelf(closeNDisplayForAllMobs);
		} else {
			callSelfParams(closeNDisplayServer,_usr);
			callSelf(updateNDisplay);
		};
	};
	
	func(onItemClick)
	{
		objParams_1(_usr);
		if (getSelf(stackCount) > 1) then {
			callSelfParams(destackItem,1 arg _usr);
		} else {
			//можно добавлять логику
		};
	};

	func(destackItemToLoc)
	{
		objParams_3(_count,_newLoc,_usr);
		if !callSelf(canDestack) exitWith {};
		private _newItem = callSelfParams(removeFromStack,_count);

		if !callFuncParams(_newLoc,canMoveInItem,_newItem) exitWith {
			//fail move
			callSelfParams(addToStack,_newItem);
		};

		callFuncParams(_newLoc,onMoveInItem,_newItem);

		//success move
		callSelfParams(onDestack,_usr);

		if (getSelf(stackCount) == 1) then {
			callSelf(closeNDisplayForAllMobs);
		} else {
			callSelfParams(closeNDisplayServer,_usr);
			callSelf(updateNDisplay);
		};

	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);

		if (callFunc(_with,isStack)) then {
			callSelfParams(stackItem,_with arg _usr);
		};
	};
	getter_func(canUseMainAction,getSelf(stackCount)>1 && super());
	getter_func(getMainActionName,"Разделить");
	func(onMainAction)
	{
		objParams_1(_usr);


		private _stackCount = getSelf(stackCount);

		if (_stackCount == 2) exitWith {
			callSelfParams(destackItem,1 arg _usr);
		};
		if (_stackCount > 2) then {
			if callSelf(isInWorld) then {
				callSelfParams(openNDisplay,_usr);
			} else {
				callSelfParams(openNDisplayInternal,_usr arg getVar(_usr,owner))
			};
		};

	};

endclass

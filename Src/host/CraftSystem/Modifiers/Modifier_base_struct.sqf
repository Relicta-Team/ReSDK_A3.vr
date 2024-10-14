// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
#include "..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"

/*

	Интерфейс модификатора скрафченного предмета.
	Это базовый тип от которого унаследованы все модификаторы

	Модификаторы создаются при определении крафтов и сразу хранятся в списках

	Для определения нового модификаторы делаем следующее:
		1. Заводим новый тип CraftModifier::YOUR_MODIFIER_NAME (наследник CraftModifierAbstract)
		2. Реализуем 2 функции onApply и onParameter. onParameter допускает использование setParseError
		3. Реализуем createModifierContext , который будет собирать необходимую инфу с ингредиентов
*/
struct(CraftModifierAbstract)
	def(name) ""; //internal modifier name, constant

	def(hasParams) true //by default modifier has params

	def(_paramDict) null
	def(__raised) false
	def(_lastError) "Unknown error"

	def(setParseError)
	{
		params ["_msg",["_addPrefixName",true]];
		self setv(__raised,true);
		if (_addPrefixName) then {
			_msg = format["(%1) - %2",self getv(name),_msg];
		};
		self setv(_lastError,_msg);
	}

	// Обработчик параметров при регистрации модификатора на рецепте
	def(onParameter)
	{
		params ["_paramName","_paramValue"];
		false
	}

	/* 
		Захват контекста с ингредиентов до их удаления
		В контекст попадает: 
		- is_interact Общий для всех
		 
		 - Для интерактивных крафтов внутри дикта ingredients из 2 упорядоченных:( hand_item, target)
		 
		 - Для обычных внутри дикта массив ingredients
		
		_capturedCtx не должен изменяться. Возвращаться должен новый набор данных, который будет предоставлен в onApply._ctx
		возврат null не допускается. Любое not-nill значение
	*/
	def(createModifierContext)
	{
		params ["_capturedCtx"];
		0
	}

	// Применение модификатора
	def(onApply)
	{
		params ["_itm","_usr","_ctx"];
	}

	def(init)
	{
		params ["_pdct"];

		self setv(name,struct_typename(self) splitString ":" select 1);

		self setv(_paramDict,_pdct);
		self callv(_parseParameters);
	}

	def(_parseParameters)
	{
		private _ready = true;
		if (self getv(hasParams)) then {
			{
				self callp(onParameter,_x arg _y);
				if (self getv(__raised)) exitWith {
					_ready = false;
				};
			} foreach (self getv(_paramDict));
		};

		_ready
	}


endstruct

/*
	set_name
	
	Описание: Изменяет название создаваемого предмета
	Параметры:
		value - (строка) новое название.
*/
struct(CraftModifier::set_name) base(CraftModifierAbstract)
	
	def(new_name) "";

	def(onParameter)
	{
		params ["_name","_val"];
		if (_name == "value") exitWith {
			self setv(new_name,_val);
		};

		self callp(setParseError,"Unknown parameter: %1",_name);
	}

	def(onApply)
	{
		params ["_itm","_usr","_ctx"];

		if (self getv(name)!="") then {
			setVar(_itm,name,self getv(new_name));
		};
	}
endstruct


//-------------------------------------------
//-------------------------------------------
//-------------------------------------------
//-------------------------------------------
//-------------------------------------------

// failed handler

/* 
	Обработчик провалов крафта
	Создается при попытке крафта
	Вызывается если не удалось создать по причинам:
	- нехватка навыка

	Чтобы определить хандлер провала имя должно быть следующего вида:
	Craft_FailedHandler::default где default это название обработчика
*/
struct(Craft_FailedHandler)
	
	// получает контекст для обработки провала.
	// это нужно для того, чтобы можно было получить информацию по предметам до их непосредственного уничтожения
	//_ingredientsCopy - это CraftRecipeComponent|CraftRecipeInteractorComponent
	def(captureContext)
	{
		params ["_recipe","_usr","_ingredientsCopy"];
	}

	// поймали провал крафта
	//ctx это контекст крафта
	def(onCatched)
	{
		params ["_recipe","_ctx"];
	}

	//конструктор вызывается при создании этого объекта (непосредственно перед крафтом)
	def(init)
	{
		params ["_dictInfo"];
	}
endstruct

/*
	Стандартный хандлер провала
	failed_handler:
		handler_type: default
		
		# --- game object type ---
		class: Item
		
		# --- count gameobjects ---
		# by default 1
		count:
			min: 1
			max: 2
		# or
		count: 1
*/
struct(Craft_FailedHandler::default)
	
	def(fail_type) "Item";
	def(fail_count) null; //CraftDynamicCountRange__

	def(init)
	{
		params ["_dictInfo"];
		self setv(fail_type,_dictInfo getOrDefault vec2("class","Item"));
		private _count = _dictInfo getOrDefault vec2("count",null);
		if !isNullVar(_count) then {
			self setv(fail_count,struct_newp(CraftDynamicCountRange__,_count));
		} else {
			self setv(fail_count,struct_newp(CraftDynamicCountRange__,1));
		};
	}

	def(onCatched)
	{
		params ["_recipe","_ctx"];

		private _ccpy = _ctx get "components_copy";
		private _pos = _ctx get "position";

		private _maxDistanceRange = 0.05;
		private _allHP = 0;
		private _ctrItms = 0;

		//delete all ingredients
		{
			//exclude optionals
			if (_x getv(optional)) then {continue};

			{
				_x params ["_itm","_real"];

				if ((getVar(_itm,getPos) distance _pos) > _maxDistanceRange) then {
					_maxDistanceRange = getVar(_itm,getPos) distance _pos;
				};

				if (getVar(_itm,hp) > 0) then {
					modvar(_allHP) + getVar(_itm,hp);
					INC(_ctrItms);
				};

				[_itm] call deleteGameObject;
			} foreach (_x getv(_foundItems));
		} foreach _ccpy;
		
		//creating fail items
		private _type = self getv(fail_type);
		assert(_type);
		private _createCount = self getv(fail_count) callv(getValue);

		private _perDebrisHP = floor(_allHP / _ctrItms);

		for "_i" from 1 to _createCount do {
			private _realPos = [_pos,_maxDistanceRange] call randomRadius;
			private _newObj = [_type,_realPos] call createGameObjectInWorld;
			setVar(_newObj,hp,_perDebrisHP + randInt(-4,2));
			setVar(_newObj,ht,randInt(1,4));
		};

		private _m = format["пытается сделать %1%2",self getv(name),
			pick[
				", но всё запарывает.",
				", но ничего не получается.",
				" и всё портит.",
				" и проваливает попытку."
			]
		];
		callFuncParams(_ctx get "user",meSay,_m);
	}
endstruct
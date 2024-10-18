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
		Допускается использование тегов:
			{TAG:name} для названия
*/
struct(CraftModifier::set_name) base(CraftModifierAbstract)
	
	def(new_name) ""; //before preprocessed

	def(createModifierContext)
	{
		params ["_capturedCtx"];
		private _ingr = _capturedCtx get "ingredients";
		private _map = createHashMap;
		private _allTagsRefs = createhashMap; //ссылки по тегам
		{
			if not_equals(_x getv(metaTag),"") then {
				private _objList = _x callv(getObjects);
				if (count _objList > 0) then {
					_allTagsRefs set [_x getv(metaTag),_objList select 0];
				};
			};	
		} foreach _ingr;

		//создаем карту имён
		{
			_map set [_x+":name",getVar(_y,name)];
		} foreach _allTagsRefs;

		_map
	}

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
			private _newName = [self getv(new_name),_ctx] call csys_format;
			setVar(_itm,name,_newName);
		};
	}
endstruct

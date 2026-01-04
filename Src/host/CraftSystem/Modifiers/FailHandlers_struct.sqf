// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
#include "..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"

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
	
	def(position) null; //внешняя установочная позиция расположения результата

	// получает контекст для обработки провала.
	// это нужно для того, чтобы можно было получить информацию по предметам до их непосредственного уничтожения
	//_ingredientsCopy - это CraftRecipeComponent|CraftRecipeInteractorComponent
	def(captureContext)
	{
		params ["_recipe","_usr","_ingredientsCopy"];
	}

	// поймали провал крафта
	//ctx это контекст крафта
	//! Должен возвращать массив созданных предметов (при наличии)
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

	def(perDebrisHPPrec) 1 //one precent
	def(maxDistanceRange) 0.05 //допустимая дистанция рандомного размещения

	def(itmsToDelete) []

	def(captureContext)
	{
		params ["_recipe","_usr","_ingredientsCopy"];
		private _delitms = [];
		private _ccpy = _ingredientsCopy;

		private _maxDistanceRange = 0.05;
		private _allHP = 0;
		private _ctrItms = 0;
		private _pos = self getv(position);

		//delete all ingredients
		{
			//exclude optionals
			private _curIngredient = _x;
			if (_curIngredient getv(optional)) then {continue};
			if !(_curIngredient getv(destroy)) then {continue};

			{
				private _itm = _x;
				
				assert(!isNullVar(_itm));
				assert(!isNullReference(_itm));

				if ((getVar(_itm,getPos) distance _pos) > _maxDistanceRange) then {
					_maxDistanceRange = getVar(_itm,getPos) distance _pos;
				};

				if (getVar(_itm,hp) > 0) then {
					modvar(_allHP) + getVar(_itm,hp);
					INC(_ctrItms);
				};

				
				_delitms pushBack _itm;
			} foreach (_curIngredient callv(getObjects));
		} foreach _ccpy;

		self setv(maxDistanceRange,_maxDistanceRange);
		self setv(itmsToDelete,_delitms);
		
		if (_ctrItms == 0) exitWith {};

		private _perDebrisHPPrec = floor(_allHP / _ctrItms);
		
		self setv(perDebrisHPPrec,_perDebrisHPPrec);

	}

	def(onCatched)
	{
		params ["_recipe","_ctx"];

		//delete items before
		{
			[_x] call deleteGameObject;
		} foreach (self getv(itmsToDelete));

		private _pos = _ctx get "position";

		//creating fail items
		private _type = self getv(fail_type);
		assert(_type);
		private _createCount = self getv(fail_count) callv(getValue);

		
		private _created = [];
		for "_i" from 1 to _createCount do {
			private _realPos = [_pos,self getv(maxDistanceRange)] call randomRadius;
			private _newObj = [_type,_realPos] call createGameObjectInWorld;
			_created pushBack _newObj;
			//setVar(_newObj,hp,_perDebrisHP + randInt(-4,2));
			setVar(_newObj,ht,randInt(1,4));
			private _perDebrisHP = self getv(perDebrisHPPrec);
			callFuncParams(_newObj,setHPCurrentPrecentage,_perDebrisHP + randInt(-2,2));
		};
		private _nameCreated = "что-то";
		private _probName = _recipe getv(name);
		if (!isNullVar(_probName) && {not_equals(_probName,"")}) then {
			_nameCreated = _probName;
		};
		private _m = format["пытается сделать %1%2",_nameCreated,
			pick[
				", но всё запарывает.",
				", но ничего не получается.",
				" и всё портит.",
				" и проваливает попытку."
			]
		];
		callFuncParams(_ctx get "user",meSay,_m);

		_created
	}
endstruct
// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\..\struct.hpp"
#include "..\..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"

/*
	BA - Brain Action - обязательный префикс для всех действий
	Базовое действие для ИИ-системы

	Этот файл загружается из загрузчика структур
*/
struct(BABase)
	def(name) ""; //базовое имя действия

	def(baseScore) 0; //базовая стоимость действия

	//модификатор, добавляемый к базовой стоимости действия
	def(getScore) {
		params ["_agent","_mob"];
		0
	}

	//выполняет действие пока возможно
	def(execute) {
		params ["_agent","_mob"];
	}

	def(_lastScore) 0; //последняя оценка пишется сюда
	
	def(init)
	{
		if ((self getv(name)) == "") then {
			private _name = struct_typename(self);
			_name = _name select [2];
			self setv(name,_name);
		};
	}

	def(str) {
		format["%1 (score: %2)",self getv(name),self getv(_lastScore)]
	}
endstruct


/*
	BHV - Behavior - обязательный префикс для всех поведений
	Поведение - это группа действий, которые выполняются в определенной последовательности
	Поведение может быть составлено из нескольких действий и других поведений
	

*/
struct(BHVBase) //Behavior Base - обязательный префикс для всех поведений
	def(name) ""; //базовое имя поведения

	def(sensorUpdateDelay) 0.1; //задержка обновления сенсоров
	def(sensorNextUpdate) 0; //время следующего обновления сенсоров

	def(updateDelay) 0.1; //частота обновления поведения
	def(nextUpdate) 0; //время следующего обновления поведения

	def(actions) []; //строковый массив типов действий, которые есть в данном поведении

	def(init)
	{
		if ((self getv(name)) == "") then {
			private _name = struct_typename(self);
			_name = _name select [3];
			self setv(name,_name);
		};
	}

	def(_possibleActions) []; //массив возможных действий (сгенерированный список)

	//генерирует список объектов возможных действий
	def(generateActions)
	{
		params ["_agent"];
		private _actsList = [];
		{
			private _aName = _x;
			_possibleActions pushBack ([_aName] call struct_alloc);
		} foreach (self getv(actions));
		self setv(_possibleActions,_actsList);
	}
endstruct
// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Craft Object System
	Это система создания объектов из рецептов через меню или по условиям через обработчик системы
	Это чем-то похоже на подход Entity System но в очень ограниченном виде

	Компонент позволяет реализовать такие системы как:
		- готовка на сковороде у любых источников огня
		- запекание в печи
		- ковка
		- перегонка самогона
		и т.д.

	Системы делятся на следующие:
		- Internal - работают с объектами в виртуальных пулах
		- WorldProcessor - работают с объектами в мире

*/

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
#include "..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"

struct(SystemControllerCrafts)
	def_null(_components)
	def(systemType) ""

	def(init)
	{
		params ["_stype"];

		self setv(_components,[])
	}

	def(addProcessor)
	{
		params ["_o"];
		(self getv(_components)) pushBack _o;
	}
endstruct

// basic type 
struct(BaseCraftSystem)
	def(systemType) "" //string representation of system type, must be defined with user

	def(src) nullPtr //source game object
	def(usr) nullPtr //user last activator or world objects last owner

	def(canUpdate) { true } //отвечает за то будет ли обрабатываться цикл симуляции
	
	def(init)
	{
		params ["_src"];
		assert_str(not_equals(self getv(systemType),""),format vec2("%1 - systemType must be defined",struct_typename(self)));
		self setv(src,_src);

		if (self callv(canUpdate)) then {
			private _ctrl = [self getv(systemType)] call csys_getSystemController;
			_ctrl callp(addProcessor,self);
		};
	}

	//main processor
	def(process)
	{

	}

endstruct

struct(BaseInternalCraftSystem) base(BaseCraftSystem)

endstruct

struct(BaseWorldProcessorCraftSystem) base(BaseCraftSystem)

endstruct
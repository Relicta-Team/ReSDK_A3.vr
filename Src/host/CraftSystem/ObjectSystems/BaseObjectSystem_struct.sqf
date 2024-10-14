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

//контроллер систем
struct(SystemControllerCrafts)
	def_null(_components) //содержит списки обновляемых систем
	def(systemType) ""

	def(str)
	{
		format["Controller_%1 %2",self getv(systemType),(self getv(_components)) apply {str _x}];
	}

	def(init)
	{
		params ["_stype"];
		self setv(systemType,_stype);
		self setv(_components,[])
	}
	//добавление процессора системы в контроллер
	def(addProcessor)
	{
		params ["_o"];
		(self getv(_components)) pushBack _o;
	}

	def(update)
	{
		{
			_x callv(process);
			false
		} count (self getv(_components));
	}

endstruct

/*
	Сериализатор трансформации игрового объекта.
	Нужен для быстрой\удобной валидации внутри систем
	
	private _itm = ["Item",[0,0,0]] call createGameObjectInWorld;
	private _stObj = struct_newp(CraftSerializedTransform,_itm);

	assert(_stObj callv(isValid));

	callFuncParams(_itm,setPos, vec3(100,100,0));
	assert(_stObj callv(isValid)); //throws error

*/
struct(CraftSerializedTransform)
	def(_origObject) nullPtr

	def(_useWorldObject) false

	def(_lastLoc) objNull
	def(_lastPos) null

	def(init)
	{
		params ["_obj"];
		self setv(_origObject,_obj);
		self callv(updateTransform);
		
	}

	def(updateTransform)
	{
		private _obj = self getv(_origObject);
		
		self setv(_useWorldObject,callFunc(_obj,isInWorld));
		self setv(_lastLoc,getVar(_obj,loc));
		if (self getv(_useWorldObject)) then {
			self setv(_lastPos,callFunc(_obj,getPos));
		} else {
			self setv(_lastLoc,null);
		};
	}

	def(isValid)
	{
		private _obj = self getv(_origObject);
		call {
			//check null
			if isNullReference(_obj) exitWith {false};
			//check last loc
			if not_equals(getVar(_obj,loc),self getv(_lastLoc)) exitWith {false};

			if (self getv(_useWorldObject)) then {
				equals(callFunc(_obj,getPos),self getv(_lastPos))
			} else {
				true //non-world object, position doesn't change
			};
		}
	}

endstruct


// basic type 
struct(BaseCraftSystem)
	def(systemType) "" //string representation of system type, must be defined with user

	def(src) nullPtr //source game object
	def(usr) nullPtr //user last activator or world objects last owner

	def(_ingredients) [] //here writes ingredient list

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

	//main processor handler. called each second
	def(process) {}

	//get possible recipes based on ingredients
	def(_getRecipes)
	{
		params ["_objList"];
		private _recipes = [];
		private _cls = null;
		private _myClassname = struct_typename(self);
		private _validateSysSpec = null;
		{
			_cls = tolower callFunc(_x,getClassName);
			if (_cls in csys_map_allSystemCrafts) then {
				//only unique returns
				{
					_validateSysSpec = _x getv(systemSpecific);
					traceformat("Validate recipe %2 is %1",_validateSysSpec arg _myClassname)
					if (_validateSysSpec==_myClassname) then {
						_recipes pushBackUnique _x;
					};

					;false
				} count (csys_map_allSystemCrafts get _cls);
			};
		} foreach _objList;
		
		_recipes
	}
	
	def(toString)
	{
		format["CraftSystem::%1(%2)",struct_typename(self),self getv(systemType)];
	}

	def(str)
	{
		self callv(toString)
	}

endstruct

/* 
	Основной интерфейс для внутренних систем
	Внутренние системы выполняются по нажатию пользователя
*/
struct(BaseInternalCraftSystem) base(BaseCraftSystem)
	
	def(toString)
	{
		format["InternalSystem::%1(%2)",struct_typename(self),self getv(systemType)];
	}

	def(canUpdate) { false }

	//called on user perform action
	def(onActivate)
	{
		params ["_usr"];
		self setv(usr,_usr);
	}

	//called on adding ingredient
	def(addIngredient)
	{
		params ["_ingr"];
		(self getv(_ingredients)) pushBack _ingr;
	}

	//require user implementation
	def(canAddIngredient)
	{
		params ["_ingr"];
		false
	}
	
	def(process)
	{

	}
endstruct

struct(BaseWorldProcessorCraftSystem) base(BaseCraftSystem)
	
	def(toString)
	{
		format["WorldProc::%1(%2)",struct_typename(self),self getv(systemType)];
	}
	
	
	//life cycle
	def(process) {}


	//utility functions

	//get near objects
	def(getObjects)
	{
		params ["_type",["_distance",5]];
		[_type,callFunc(self getv(src),getPos),_distance,true,true] call getGameObjectOnPosition;
	}

	def(isInWorld) { callFunc(self getv(src),isInWorld) }

endstruct
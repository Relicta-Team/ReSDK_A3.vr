// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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

	//исключение из контроллера (например, при удалении объекта)
	def(removeProcessor)
	{
		params ["_o"];
		[self getv(_components),_o] call arrayDeleteItem;
	}

	def(update)
	{
		_tUpd = tickTime;
		{
			if (_x getv(isActiveUpdate)) then {
				_x callv(process);
			} else {
				if (_tUpd >= (_x getv(__nextWeakUpdate))) then {
					_x callv(process);
					_x setv(__nextWeakUpdate,tickTime + (_x getv(weakUpdateDelay)));
				};
			};
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

	def(_options) null

	def(init)
	{
		params ["_obj","_optionFields"];
		self setv(_origObject,_obj);
		if !isNullVar(_optionFields) then {
			private _dict = _optionFields createHashMapFromArray [];
			self setv(_options,_dict);
		};
		self callv(updateTransform);
	}

	def(str)
	{
		private _opts = self getv(_options);
		_opts = if isNullVar(_opts) then {"opt_no"} else {_opts};
		format["TransValid(%1+%2)[%3]",self getv(_origObject),_opts,self callv(isValid)];
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
		//update options
		if !isNull(self getv(_options)) then {
			private _options = self getv(_options);
			{
				_options set [_x,getVarReflect(_obj,_x)];
			} foreach (_options);
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

			if (self getv(_useWorldObject) && {not_equals(callFunc(_obj,getPos),self getv(_lastPos))}) exitWith {false};
			
			private _valid = true;
			if !isNull(self getv(_options)) then {
				{
					if not_equals(_y,getVarReflect(_obj,_x)) exitWith {
						_valid = false;
					};
				} foreach (self getv(_options));
			};
			// all checks passed
			_valid //non-world object, position doesn't change
		}
	}

endstruct


// basic type 
struct(BaseCraftSystem)
	def(systemType) "" //string representation of system type, must be defined with user

	def(src) nullPtr //source game object
	def(usr) nullPtr //user last activator or world objects last owner

	def(canUpdate) { true } //отвечает за то будет ли обрабатываться цикл симуляции

	//стадия активного обновления
	def(isActiveUpdate) false
	//частота инактивного обновления
	def(weakUpdateDelay) 5

	def(__nextWeakUpdate) 0

	def(init)
	{
		params ["_src","_paramDict"];
		assert_str(not_equals(self getv(systemType),""),format vec2("%1 - systemType must be defined",struct_typename(self)));
		self setv(src,_src);

		if (self callv(canUpdate)) then {
			private _ctrl = [self getv(systemType)] call csys_getSystemController;
			_ctrl callp(addProcessor,self);
		};
	}

	def(releaseComponent)
	{
		private _ctrl = [self getv(systemType)] call csys_getSystemController;
		_ctrl callp(removeProcessor,self);
	}

	//main processor handler. called each second
	def(process) {}

	def_null(failHandler)
	def_null(craftContext)
	def_null(craftRecipe)

	//захват контекста при успешном крафте
	def(captureCraft)
	{
		params ["_recipe","_craftCtx","_failHndl"];
		self setv(craftRecipe,_recipe);
		self setv(craftContext,_craftCtx);
		self setv(failHandler,_failHndl);
	}

	//called on craft processed (jump to onCrafted or onFail). This method can be overrided but not needed
	def(processCraft)
	{
		private _ctx = self getv(craftContext);
		private _result = if (_ctx get "can_craft_by_skills" || isNull(self getv(failHandler))) then {
			self callv(onCrafted);
		} else {
			self callv(onFail);
		};
		self setv(failHandler,null);
		self setv(craftRecipe,null);
		self setv(craftContext,null);

		self callv(postCrafted);
		_result
	}

	//always called after processCraft
	def(postCrafted)
	{

	}

	//called on successful craft
	def(onCrafted)
	{
		//for get context use field craftContext
		//for get result use craftRecipe
		self getv(craftRecipe) getv(result) callp(onCrafted,self getv(craftContext))
	}

	//called on fail handler catched
	def(onFail)
	{
		//for get context use field craftContext
		self getv(failHandler) callp(onCatched,self arg self getv(craftContext))
	}

	//доп описание для пользователя
	def(getDescFor)
	{
		params ["_usr"];
		""
	}

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
					//traceformat("Validate recipe %2 is %1",_validateSysSpec arg _myClassname)
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

	def(getResultBasePosition)
	{
		setLastError("Result base position not defined");
		[0,0,0]
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

	
	def(_ingredients) [] //here writes ingredient list as gameobjects
	def(_results) [] //resultlist

	def(init)
	{
		self setv(_ingredients,[]);
		self setv(_results,[]);
	}

	//called on user perform action (E pressing)
	def(onActivate)
	{
		params ["_usr"];
		self callv(process);
	}

	//move functions
	def(canMoveInItem)
	{
		params ["_itm"];
		self callp(canAddIngredient,_itm)
	}

	def(canMoveOutItem)
	{
		params ["_itm"];
		self callp(canRemoveIngredient,_itm)
	}

	def(onMoveInItem)
	{
		params ["_itm"];
		self callp(addIngredient,_itm)
	}

	def(onMoveOutItem)
	{
		params ["_itm"];
		self callp(removeIngredient,_itm)
	}

	//called on adding ingredient
	def(addIngredient)
	{
		params ["_ingr"];
		(self getv(_ingredients)) pushBack _ingr;
		setVar(_ingr,loc,self getv(src));
	}

	def(removeIngredient)
	{
		params ["_ingr"];
		[self getv(_ingredients),_ingr] call arrayDeleteItem;
	}

	// require user implementation
	def(canAddIngredient)
	{
		params ["_ingr"];
		false
	}

	def(canRemoveIngredient)
	{
		params ["_ingr"];
		_ingr in (self getv(_ingredients));
	}

	// called on LMB with item
	def(moveIngredient)
	{
		params ["_ingr","_usr"];
		if isNullReference(_ingr) exitWith {};
		assert(isTypeOf(_ingr,Item));
		callFuncParams(_ingr,moveItem,self getv(src));
	}

	def(getObjects) {array_copy(self getv(_ingredients))}
	
	// main processor
	def(process)
	{

	}

	def(postCrafted)
	{
		self setv(_ingredients,(self getv(_ingredients)) - [nullPtr]);
	}

	
endstruct

struct(BaseWorldProcessorCraftSystem) base(BaseCraftSystem)
	
	def(toString)
	{
		format["WorldProc::%1(%2)",struct_typename(self),self getv(systemType)];
	}
	
	def(getResultBasePosition)
	{
		params ["_leftComponents"];
		private _allPoses = [];
		//use components and calculate tempobject pos
		{
			{
				_allPoses pushBack callFunc(_x,getPos);
			} foreach (_x callv(getObjects));
		} foreach _leftComponents;
		//create temp cooking
		private _midPos = [_allPoses] call getPosListCenter;
		if equals(_midPos,vec3(0,0,0)) then {_midPos = callFunc(self getv(src),getPos)};

		_midPos
	}
	
	//life cycle
	def(process) {}

	//utility functions

	//получает позицию отсчета для объектов
	def(getObjects_getCollectPos)
	{
		callFunc(self getv(src),getPos)
	}
	//get near objects
	def(getObjects)
	{
		params ["_type",["_distance",5],["_excludeSelf",true],["_sortByNear",true]];
		private _pos = self callv(getObjects_getCollectPos);
		private _oList = [_type,_pos,_distance,true,true] call getGameObjectOnPosition;
		if (_excludeSelf) then {
			[_oList,self getv(src)] call arrayDeleteItem;
		};
		if (_sortByNear) then {
			//sort by distance, removing source
			_oList = [_oList,{callFunc(_x,getPos) distance _pos}] call sortBy;	
		};
		_oList
	}

	def(isInWorld) { callFunc(self getv(src),isInWorld) }

endstruct
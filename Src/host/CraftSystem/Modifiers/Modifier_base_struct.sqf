// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
	def(name__) ""; //internal modifier name, constant

	def(hasParams) true //by default modifier has params

	def(_paramDict) null
	def(__raised) false
	def(_lastError) "Unknown error"

	def(setParseError)
	{
		params ["_msg",["_addPrefixName",true]];
		self setv(__raised,true);
		if (_addPrefixName) then {
			_msg = format["(%1) - %2",self getv(name__),_msg];
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
		В контекст обработчика попадает: 
		- is_interact Общий для всех
		- ingredients (массив структур копий ингредиентов):
			- Для интерактивных крафтов внутри дикта ingredients из 2 упорядоченных:( hand_item, target)
			- Для обычных внутри дикта массив
		- user - ссылка на юзера-крафтера
		- result_count - количество сколько выйдет предметов.

		_capturedCtx не должен изменяться. Возвращаться должен новый набор данных, который будет предоставлен в onApply._ctx
		возврат null не допускается. Любое not-nill значение
	*/
	def(createModifierContext)
	{
		params ["_capturedCtx"];
		self callp(processCollectTagsFromObjects,_capturedCtx);
	}

	// Применение модификатора, _craftContext предоставляет контекст крафта (бросок навыка, позиции и т.д.)
	def(onApply)
	{
		params ["_itm","_usr","_ctx","_craftContext"];
	}

	def(init)
	{
		params ["_pdct"];

		self setv(name__,struct_typename(self) splitString ":" select 1);
		
		if not_equals(_pdct,"GETMODINFO") then {
			self setv(_paramDict,_pdct);
			self callv(_parseParameters);
		};

	}

	def(str)
	{
		"CMod:" + (self getv(name__))
	}

	def(debugMessage)
	{
		#ifdef EDITOR
		private _msg = _this call formatLazy;
		logformat("[%1] %2",text str (self) arg _msg);
		#endif
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

			//validate required params
			if (_ready) then {
				{
					if !(_x in (self getv(_paramDict))) exitWith {
						self callp(setParseError,"Param must be defined: " + _x);
						_ready = false;
					};
				} foreach (self getv(required_fields));
			};
		};

		_ready
	}

	//получает карту доступных настроек этого модификатора
	def(getModifierDict)
	{
		private _dictRet = createhashMap;
		private _thisModName = self getv(name__);
		#define mmap createHashMapFromArray
		_dictRet set ["if",mmap [
			["type","object"],
			["properties",mmap [vec2("name",mmap [vec2("const",_thisModName)])]]
		]];
		_mmThen = mmap [];
		_mmThen set ["additionalProperties",false];
		_mmThen set ["required",self getv(required_fields)];
			_mmtprop = mmap [];
			private _desc = self getv(description);
			if (_desc!="")then {_desc = _desc + "\n\n"};
			modvar(_desc) + "Доступные параметры: " + ((self getv(allowed_params) apply {_x select 0}) joinString ", ");
			
			_mmtprop set ["name",mmap[
				["description",format["Выбран модификатор '%1' (%2)\n%3",self getv(title),_thisModName,_desc]]
			]];
			{
				_x params ["_name","_dictvals"];
				private _mmPropInt = mmap [];
				{
					if equalTypes("",_x) then {
						private _idx = _x find ":";
						if (_idx != -1) then {
							_mmPropInt set [_x select [0,_idx],_x select [_idx +1,count _x]];
						};
					} else {
						_mmPropInt set _x;
					};
				} foreach _dictvals;
				_mmtprop set [_name,_mmPropInt];
			} foreach (self getv(allowed_params));


			_mmThen set ["properties",_mmtprop];
		_dictRet set ["then",_mmThen];

		_dictRet
	}


	def(title) "Общее название модификатора"
	def(description) "Описание модификатора"
	def(required_fields) [] //какие поля нужны
	//какие параметры доступны должны быть имена полей. это словарь
	/*
		def(allowed_params) [
			["name",[
				"type:string",
				"title:Название модификатора",
				"description:Описание",
				["examples",[1,2,3]]
			]]
		]
	*/
	def(allowed_params) []

	def(addParam)
	{
		params ["_name","_val","_allowTypes"];
		if !isNullVar(_allowTypes) then {
			if not_equalTypes(_allowTypes,[]) then {
				_allowTypes = [_allowTypes];
			};
		};
		if (!isNullVar(_allowTypes) && {!(_val isEqualTypeAny _allowTypes)}) exitWith {
			self callp(setParseError,format vec3("Param %1 type missmatch %2",_name,typename _val))
		};
		if !(_name in self) exitWith {
			self callp(setParseError,format vec2("Param %1 not found",_name))
		};

		self set [_name,_val];
	}

	//сбор информации о тегах
	def(collectTagInfo)
	{
		params ["_tagMap","_tagName","_objects"];
		
	}

	def(processCollectTagsFromObjects)
	{
		params ["_capturedCtx"];
		private _ingrList = _capturedCtx get "ingredients";
		private _map = createHashMap;
		private _allTagsRefs = createhashMap; //ссылки по тегам
		{
			if not_equals(_x getv(metaTag),"") then {
				private _objList = _x callv(getObjects);
				//traceformat("Object enum %1 is %2",_foreachIndex arg _objList)
				if (count _objList > 0) then {
					_allTagsRefs set [_x getv(metaTag),_objList];
				};
			};	
		} foreach _ingrList;

		//создаем карту имён
		{
			self callp(collectTagInfo,_map arg _x arg _y)
		} foreach _allTagsRefs;

		traceformat("Captured context for %3: %1 from refs: %2",_map arg _allTagsRefs arg self getv(name__));
		
		_map
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
	
	def(title) "Изменение названия"
	def(description) "Изменяет название создаваемого предмета"
	def(required_fields) ["value"]
	def(allowed_params) [
		["value",[
			"type:string",
			"title:Новое название",
			"description:Новое название предмета. Допускается использование тегов, например {TAG:name} для установки названия от предмета с тегом TAG",
			["examples",[
				"Предмет",
				"Предмет из {TAGGED_INGREDIENT.name.lower}"
			]]
		]]
	]

	def(new_name) ""; //before preprocessed

	def(createModifierContext)
	{
		params ["_capturedCtx"];
		
		private _map = self callp(processCollectTagsFromObjects,_capturedCtx);		

		_map
	}

	def(collectTagInfo)
	{
		params ["_tagMap","_tagName","_objects"];
		_tagMap set [_tagName + ":name",getVar(_objects select 0,name)];
	}
	

	def(onParameter)
	{
		params ["_name","_val"];
		if (_name == "value") exitWith {
			self setv(new_name,_val);
		};

		self callp(setParseError,"Unknown parameter: %1" arg _name);
	}

	def(onApply)
	{
		params ["_itm","_usr","_ctx","_craftContext"];
		
		//add basename
		_ctx set ["basename", callFuncParams(_newObj,getNameFor,_usr)];

		if (self getv(new_name)!="") then {
			private _newName = [self getv(new_name),_ctx] call csys_format;
			setVar(_itm,name,_newName);

			self callp(debugMessage,"Update name %1 to %2" arg _itm arg _newName);
		};
	}
endstruct


// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\struct.hpp>

#define LOOT_COMPARE_BY_NAME 'name'
#define LOOT_COMPARE_BY_REGEX 'regex'
#define LOOT_COMPARE_BY_TYPEOF 'typeof'

#define LOOT_COMPARE_MODE_MAP 'map'
#define LOOT_COMPARE_MODE_GAMEMODE 'gamemode'

//объект конфигурации лута
struct(LootTempate)
	def_null(items) //list of items
	def_null(type) //loot typename
	def_null(name) //loot name

	def(path) ""; //config location

	def(__hasErrorOnCreate) false;
	def(allowMaps) ["ALL"]
	def(allowModes) ["ALL"]

	def(init)
	{
		params ["_type","_path","_cfgData"];

		self setv(type,_type);
		self setv(path,_path);

		private _allowedKeys = [
			"type",
			"interface",
			"inherit",
			"name",
			"allowmaps",
			"allowgamemodes",
			"items"
		];
		private _name = _cfgData get "name";
		if !isNullVar(_name) then {self setv(name,_name)};
		private _alm = _cfgData getOrDefault ["allowmaps",[]];
		private _alg = _cfgData getOrDefault ["allowgamemodes",[]];
		private _items = _cfgData getOrDefault ["items",[]];

		/*===================================
			Map and gamemode restrictions
		===================================*/

		private _allowMaps = [];
		private _allowModes = [];

		private _cmode = LOOT_COMPARE_MODE_MAP;
		{
			
			if equalTypes(_x,"") then {
				_allowMaps pushBack struct_newp(LootRestrictionType,LOOT_COMPARE_BY_NAME arg _cmode arg _x);
				continue;
			};

			warningformat("Unknown compare value %1 in %2",_x arg _path);
		} foreach _alm;

		_cmode = LOOT_COMPARE_MODE_GAMEMODE;
		{
			if equalTypes(_x,"") then {
				_allowModes pushBack struct_newp(LootRestrictionType,LOOT_COMPARE_BY_NAME arg _cmode arg _x);
				continue;
			};
			warningformat("Unknown compare value %1 in %2",_x arg _path);
		} foreach _alg;

		self setv(allowMaps,_allowMaps);
		self setv(allowModes,_allowModes);

		/*===================================
					Items work
		===================================*/
		private _itemList = [];
		{
			_itemList pushBack struct_newp(LootItemTemplate,_x arg _y);
		} foreach _items;
		self setv(items,_itemList);

		/*===================================
					Post validation
		===================================*/

		{_cfgData deleteAt _x; true} count _allowedKeys;

		{
			errorformat("LootTemplate::init() - Unknown config %1 key '%2' in %3",_type arg _x arg _path);
			self setv(__hasErrorOnCreate,true);
		} foreach _cfgData;

	}

	def(checkLootSpawnRestriction)
	{
		params ["_modeName"];
		
		private _mapname = [_modeName,"",true,"getMapName"] call oop_getFieldBaseValue;
		private _canUse = false;
		
		{
			if (self callp(compareTo,_mapname)) exitWith {
				_canUse = true;
			};
		} foreach (self getv(allowMaps));

		if (!_canUse) exitWith {false};
		_canUse = false;
		{
			if (self callp(compareTo,_modeName)) exitWith {
				_canUse = true;
			};
		} foreach (self getv(allowModes));

		_canUse
	}

	def(processSpawnLoot)
	{
		params ["_obj"];
		if !callFunc(_obj,isContainer) exitWith {
			false
		};
		
		private _items = self getv(items);
		{
			private _name = _x getv(name);
			private _attrMethods = [];
			if (_name!="") then {
				_attrMethods pushBack ["name",_name];
			};

			//spawn by native method
			callFuncParams(_obj,createItemInContainer,_x getv(itemType) arg _x callv(getRandomCount) arg _x getv(probability) arg _attrMethods);


			// if prob(_x getv(probability)) then {
			// 	for "_i" from 0 to (_x callv(getRandomCount)) do {
					
			// 	};
			// };
		} foreach array_shuffle(_items); //

		true
	}

endstruct

//структура ограничения спавна лута
struct(LootRestrictionType)
	def(compareType) LOOT_COMPARE_BY_NAME
	def(compareMode) LOOT_COMPARE_MODE_MAP
	def(value) ""
	
	def(init)
	{
		params ["_ct","_cm","_val"];
		self setv(compareType,_ct);
		self setv(compareMode,_cm);
		self setv(value,_val);
	}

	def(compareTo)
	{
		params ["_with"];
		private _ctype = self getv(compareType);
		if (_ctype == LOOT_COMPARE_BY_NAME) exitWith {
			_with == self getv(value)
		};
		if (_ctype == LOOT_COMPARE_BY_REGEX) exitWith {
			[_with,self getv(value)] call regexi_isMatch
		};
		if (_ctype == LOOT_COMPARE_BY_TYPEOF) exitWith {
			isTypeNameStringOf(self getv(value),_with)
		};
		setLastError("Unknown compare type: " + str _ctype);
	}
endstruct

//объект настроек спавна предмета в луте
struct(LootItemTemplate)

	def(probability) 100
	def(countMin) 1
	def(countMax) 1
	def(getRandomCount) { rand(self getv(countMin),self getv(countMax))	}
	def(isRangeBasedCount) {(self getv(countMin)) == (self getv(countMax))}
	def(itemType) "Item"

	def(name) ""; //in current version can only update name of created item

	def(init)
	{
		params ["_type","_cfgData"];
		self setv(itemType,_type);
		private _probName = _cfgData get "name";
		if !isNullVar(_probName) then {self setv(name,_probName)};

		self setv(probability,_cfgData getOrDefault vec2("prob",100));
		private _counter = _cfgData get "count";
		if !isNullVar(_counter) then {
			if equalTypes(_counter,0) exitWith {
				self setv(countMin,_counter);
				self setv(countMax,_counter);
			};
			if (equalTypes(_counter,[]) && {count _counter == 2}) then {
				self setv(countMin,_counter select 0);
				self setv(counterMax,_counter select 1);
			};
			setLastError(format vec2("Cannot define count value %1 in %2",_counter arg _path));
		};
	}



	def(str)
	{
		private _rangeText = ifcheck(self callv(isRangeBasedCount),format vec3("(%1-%2)",self getv(countMin),self getv(countMax)),self getv(countMin));
		format["%1::%2 %3 %4%5",struct_typename(self),self getv(itemType),_rangeText,self getv(prob),"%"];
	}

endstruct
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

	def(isInterface) false
	def(inherit) ""
	def_null(childs);

	def(path) ""; //config location

	def(__hasErrorOnCreate) false;
	def_null(allowMaps)
	def_null(allowModes)

	def(init)
	{
		params ["_type","_path","_cfgData"];
		
		self setv(childs,[]);

		self setv(type,_type);
		self setv(path,_path);


		private _allowedKeys = [
			"type",
			"interface",
			"inherit",
			"name",
			"maps",
			"gamemodes",
			"items"
		];
		private _name = _cfgData get "name";
		if !isNullVar(_name) then {self setv(name,_name)};
		private _alm = _cfgData getOrDefault ["maps",[]];
		private _alg = _cfgData getOrDefault ["gamemodes",[]];
		private _items = _cfgData getOrDefault ["items",[]];

		self setv(isInterface, _cfgData getOrDefault vec2("interface",false));
		self setv(inherit, _cfgData getOrDefault vec2("inherit",""));
		if (_type == "BaseLoot") then {
			self setv(inherit,null);
		};

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
			private _mode = (keys _x) select 0;
			if (equals(_mode,LOOT_COMPARE_BY_REGEX) 
				|| {equals(_mode,LOOT_COMPARE_BY_TYPEOF)
				|| equals(_mode,LOOT_COMPARE_BY_NAME)
			}) then {
				private _val = (_x get _mode);
				_allowMaps pushBack struct_newp(LootRestrictionType,_mode arg _cmode arg _val);
				continue;
			};

			warningformat("Unknown compare maps value %1 in %2",_x arg _path);
		} foreach _alm;

		_cmode = LOOT_COMPARE_MODE_GAMEMODE;
		{
			if equalTypes(_x,"") then {
				_allowModes pushBack struct_newp(LootRestrictionType,LOOT_COMPARE_BY_NAME arg _cmode arg _x);
				continue;
			};
			private _mode = (keys _x) select 0;
			if (equals(_mode,LOOT_COMPARE_BY_REGEX)
				|| {equals(_mode,LOOT_COMPARE_BY_TYPEOF)
				|| equals(_mode,LOOT_COMPARE_BY_NAME)
			}) then {
				private _val = (_x get _mode);
				_allowModes pushBack struct_newp(LootRestrictionType,_mode arg _cmode arg _val);
				continue;
			};

			warningformat("Unknown compare maps value %1 in %2",_x arg _path);
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
			errorformat("Cannot spawn loot %1 in %2 - it is not container",self getv(type) arg _obj);
			false
		};
		
		private _items = self getv(items);
		{
			private _name = _x getv(name);
			private _attrMethods = [];
			if (_name!="") then {
				_attrMethods pushBack ["var","name",_name];
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

	def(str)
	{
		format["%1::%2",struct_typename(self),self getv(type)]
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

		if (_ct == LOOT_COMPARE_MODE_MAP && {
			_cm == LOOT_COMPARE_BY_TYPEOF
		}) then {
			_cm = LOOT_COMPARE_BY_NAME;
		};

		self setv(compareType,_ct);
		self setv(compareMode,_cm);
		self setv(value,_val);
	}

	def(compareTo)
	{
		params ["_with"];
		private _ctype = self getv(compareType);
		
		private _res = call {
			if (_ctype == LOOT_COMPARE_BY_NAME) exitWith {
				_with == self getv(value)
			};
			if (_ctype == LOOT_COMPARE_BY_REGEX) exitWith {
				[_with,self getv(value)] call regex_isMatch
			};
			if (_ctype == LOOT_COMPARE_BY_TYPEOF) exitWith {
				isTypeNameStringOf(self getv(value),_with)
			};
			null
		};
		if !isNullVar(_res) then {
			_res
		} else {
			setLastError("Unknown compare type: " + str _ctype);
			false
		};
	}

	def(str)
	{
		format["%1(%2:%3)",struct_typename(self),self getv(compareMode),self getv(compareType)]
	}
endstruct

//объект настроек спавна предмета в луте
struct(LootItemTemplate)

	def(probability) 100
	def(countMin) 1
	def(countMax) 1
	def(getRandomCount) { randInt(self getv(countMin),self getv(countMax))	}
	def(isRangeBasedCount) {(self getv(countMin)) != (self getv(countMax))}
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
			if (equalTypes(_counter,[]) && {count _counter == 2}) exitWith {
				self setv(countMin,_counter select 0);
				self setv(countMax,_counter select 1);
			};
			setLastError(format vec2("Cannot define count value %1 in %2",_counter arg _path));
		};
	}



	def(str)
	{
		private _rangeText = ifcheck(self callv(isRangeBasedCount),format vec3("(%1-%2)",self getv(countMin),self getv(countMax)),self getv(countMin));
		format["%1::%2 %3 %4%5",struct_typename(self),self getv(itemType),_rangeText,self getv(probability),"%"];
	}

endstruct
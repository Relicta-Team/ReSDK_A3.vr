// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
struct(LootTemplate)
	def_null(items) //list of items
	def_null(type) //loot typename
	def(name) "" //loot name
	def(tag) ""; //loot tag

	def_null(health) //LootTemplate_RangedValue
	def_null(quality) //LootTemplate_RangedValue

	def_null(pass_count) //LootTemplate_RangedValue

	def(path) ""; //config location

	def(__hasErrorOnCreate) false;
	def_null(allowMaps)
	def_null(allowModes)

	def(init)
	{
		params ["_type","_path","_cfgData"];

		private __GLOBAL_FLAG_CURRENT_LOOT__ = self;

		self setv(type,_type);
		self setv(path,_path);


		private _allowedKeys = [
			"type",
			"tag",
			"health",
			"quality",
			"pass_count",
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
		
		private _tag = _cfgData get "tag";
		if !isNullVar(_tag) then {
			self setv(tag,_tag);
			if !(_tag in loot_mapTemplates) then {
				loot_mapTemplates set [_tag,[]];
			};
			(loot_mapTemplates get _tag) pushBack self;
		};

		self setv(health,struct_newp(LootTemplate_RangedValue,_cfgData getOrDefault ["health" arg 100] arg true));
		self setv(quality,struct_newp(LootTemplate_RangedValue,_cfgData getOrDefault ["quality" arg 50] arg true));

		self setv(pass_count,struct_newp(LootTemplate_RangedValue,_cfgData getOrDefault ["pass_count" arg 1]));

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
		
		//handle item extensions
		private _itAppender = createHashMap;
		private _toRemoveKeys = [];
		private _itAppenderRegexPattern = "\(\s*\d+\s*\-\s*\d+\s*\)";
		{
			if ([_x,_itAppenderRegexPattern] call regex_isMatch) then {
				private _repl = [_x,_itAppenderRegexPattern] call regex_getFirstMatch;
				private _numbers = _repl splitString "()- ";
				if (count _numbers != 2) exitWith {
					setLastError("Counter pattern error (wrong pattern): " + (str self));
				};

				private _min = parseNumberSafe(_numbers select 0);
				private _max = parseNumberSafe(_numbers select 1);
				if (_min > _max) then {
					swap_lvars(_min,_max);
				};
				
				private _origName = [_x,_repl,"%1"] call stringReplace;
				private _newName = null;
				for "_i" from _min to _max do {
					_newName = format[_origName,_i];
					_itAppender set [_newName,_y];
				};

				_toRemoveKeys pushBack _x;
			};

			if (_y getOrDefault ["all_types_of",false]) then {
				private _itemData = _y;
				_itemData deleteAt "all_types_of";
				{
					_itAppender set [_x,_itemData];
				} foreach (getAllObjectsTypeOfStr(_x));

				_toRemoveKeys pushBack _x;
			};

		} foreach _items;

		// update item collection
		if (count _toRemoveKeys > 0 || {count _itAppender > 0}) then {
			{
				_items deleteAt _x;
			} foreach _toRemoveKeys;

			{
				_items set [_x,_y];
			} foreach _itAppender;
		};
		
		// main item list handler
		private _itemList = [];
		{
			_itemList pushBack struct_newp(LootItemTemplate,_x arg _y arg self);
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
		params ["_obj",["_onlyPreview",false]];
		private _result = true;
		call {
			if (!_onlyPreview) then {
				if !callFunc(_obj,isContainer) exitWith {
					errorformat("Cannot spawn loot %1 in %2 - it is not container",self getv(type) arg _obj);
					_result = false;
				};
			};

			if isNull(self getv(items)) exitWith {_result = false};

			private _it = null;
			private _name = null;
			private _attrMethods = null;
			private _itClass = null;
			private _objItm = nullPtr;
			
			if (_onlyPreview) then {
				loot_internal_editor_previewBuffer pushBack (format["Шаблон: %1",self]);
			};

			for "_i" from 1 to (self getv(pass_count) callv(getValue)) do {
				(self callv(_generateWeightLists)) params ["_its","_wts"];
				_it = _its selectRandomWeighted _wts;
				if isNullVar(_it) then {continue};

				if (_onlyPreview) then {
					loot_internal_editor_previewBuffer pushBack (format["  <t color='#3C1EA1'>Проход %1:</t> выпал %2",_i,(_it)]);
				} else {
					traceformat("Loot spawn at %1; pick %2 -> %3",_obj arg _its arg _it);
				};

				_name = _it getv(name);
				_itClass = _it getv(itemType);
				_attrMethods = [];
				if (_name!="") then {
					_attrMethods pushBack ["var","name",_name];
				};

				//set hp and quality
				_qualObj = _it getv(quality);
				_healthObj = _it getv(health);

				//спавн по количеству
				for "_lti" from 1 to (_it getv(count) callv(getValue)) do {
					if (_onlyPreview) then {
						loot_internal_editor_previewBuffer pushBack (format["    <t color='#D1114B'>%1:</t> <t color='#D1114B'>%2</t>",_lti,_itClass]);
						loot_internal_editor_previewBuffer pushBack (format["    Атрибуты: %1",_attrMethods apply {((_x select [0,2]) joinString ".") + " = " + (_x select 2)}]);
						
						if !isNullVar(_qualObj) then {
							private _htItm = getFieldBaseValue(_itClass,"ht");
							private _htPrec = _qualObj callv(getValue);
							private _qual = floor linearConversion [0,100,_htPrec,1,_htItm * 2,true];
							loot_internal_editor_previewBuffer pushBack (format["    HT (Quality): %1, prec: %2%3",_qual,_htPrec,"%"]);
						};

						if !isNullVar(_healthObj) then {
							private _hpMax = getFieldBaseValue(_itClass,"hpMax");
							private _hpMin = _hpMax * -5;
							private _hpPick = _healthObj callv(getValue);
							private _hp = floor linearConversion [100,0,_hpPick,_hpMax,_hpMin,true];
							loot_internal_editor_previewBuffer pushBack (format["    HP (Health): non-rtt, prec: %2%3",_hp,_hpPick,"%"]);
						};

						continue;
					};
					
					_objItm = callFuncParams(_obj,createItemInContainer,_itClass arg 1 arg null arg _attrMethods);
					assert(!isNullVar(_objItm));
					assert(equalTypes(_objItm,nullPtr));

					if isNullReference(_objItm) then {
						#ifdef EDITOR
						if (!is3den && !loot_internal_catchedError) then {
							loot_internal_catchedError = true;
							if (["Не удалось создать предмет %1 в %2. (не вместилось по размеру или нет места)."+endl+
							"Нажмите 'Да' чтобы телепортироваться к проблемному контейнеру."+endl+endl+
							"Это сообщение будет подавлено при возникновении следующей ошибки",_itClass,callFunc(_obj,getClassName)] call messageBoxRet) then {
								startAsyncInvoke
								{
									private _own = player getvariable "link" getvariable "owner";
									!isNullVar(_own) && {!isNullReference(_own)}
								},
								{
									player setposatl (callFunc(_this select 0,getPos))
								},
								[_obj],
								30,
								{
									["Timeout on teleport to error container (LootTemplate)"] call messageBox
								}
								endAsyncInvoke
							};
						};
						#endif
						continue;
					};

					//set hp and quality
					if !isNullVar(_qualObj) then {
						private _htItm = getVar(_objItm,ht);
						private _qual = floor linearConversion [0,100,_qualObj callv(getValue),1,_htItm * 2,true];
						setVar(_objItm,ht,_qual);
					};

					if !isNullVar(_healthObj) then {
						private _hpMax = getVar(_objItm,hpMax);
						private _hpMin = _hpMax * -5;
						private _hp = floor linearConversion [100,0,_healthObj callv(getValue),_hpMax,_hpMin,true];
						setVar(_objItm,hp,_hp);
					};
					
				};
			};
		};
		_result
	}

	def(_generateWeightLists)
	{
		private _items = [];
		private _weights = [];
		private _curProb = null;
		{
			_curProb = _x getv(probability) callv(getValue); //get generated value in precentage 0-100
			_items pushBack _x;
			_weights pushBack (_curProb/100);
		} foreach (self getv(items));
		[_items,_weights]
	}

	def(str)
	{
		private _postname = "";
		if (self getv(name) != "") then {
			_postname = format[" (%1)",self getv(name)];
		};
		format["%1::%2",struct_typename(self),self getv(type),_postname]
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

	def_null(probability) //LootTemplate_RangedValue
	def_null(count) //LootTemplate_RangedValue

	def_null(health) //LootTemplate_RangedValue
	def_null(quality) //LootTemplate_RangedValue
	
	def(itemType) "Item"

	def(name) ""; //in current version can only update name of created item

	def(init)
	{
		params ["_type","_cfgData","_sourceTemplate"];

		if !isImplementClass(_type) then {
			private _errorMessage = format[
				"Classname %1 not found %4%4Config: %2%4File path: '%3'%4",
				_type,
				_sourceTemplate getv(type),
				_sourceTemplate getv(path),
				endl
			];
			setLastError(_errorMessage);
		};

		private _srcHp = _sourceTemplate getv(health);
		private _srcQuality = _sourceTemplate getv(quality);

		self setv(itemType,_type);
		private _probName = _cfgData get "name";
		if !isNullVar(_probName) then {self setv(name,_probName)};

		private _prob = _cfgData getOrDefault vec2("prob",100);
		self setv(probability,struct_newp(LootTemplate_RangedValue,_prob arg true));
		
		private _counter = _cfgData getOrDefault ["count",1];
		self setv(count,struct_newp(LootTemplate_RangedValue,_counter arg false));

		if !isNullVar(_srcHp) then {
			self setv(health,_srcHp);
		};

		if !isNullVar(_srcQuality) then {
			self setv(quality,_srcQuality);
		};
	}



	def(str)
	{
		format["%1::%2 (cnt:%3 prec:%4)",struct_typename(self),self getv(itemType),text str (self getv(count)),text str (self getv(probability))];
	}

endstruct

//this class must be used only for Loot structs
struct(LootTemplate_RangedValue)
	
	def(isRangeBased) false;
	def(minValue) 0
	def(maxValue) 0

	def(getValue) { ifcheck(self getv(isRangeBased),randInt(self getv(minValue),self getv(maxValue)),self getv(minValue)) }
	
	def(str)
	{
		if !(self getv(isRangeBased)) then {
			format["%1",self getv(minValue)]
		} else {
			format["%1-%2",self getv(minValue),self getv(maxValue)]
		}
	}

	def(init)
	{
		params ["_val",["_canPrecent",false]];

		assert(!isNullVar(_val));

		private _precStrToInt = {
			if equalTypes(_this,0) exitWith {_this};
			if equalTypes(_this,"") exitWith {
				if (!_canPrecent) exitWith {
					errorformat("RangedValue::init() - Cannot convert value %1 to int - precents is not allowed",_this);
					0
				};
				parseNumberSafe(_this)
			};
			errorformat("RangedValue::init() - Cannot convert value %1 to int",_this);
			0
		};

		if (equalTypes(_val,0) || equalTypes(_val,"")) then {
			self setv(minValue,_val call _precStrToInt);
			self setv(maxValue,self getv(minValue));
		} else {
			private _min = _val getOrDefault ["min",0];
			private _max = _val getOrDefault ["max",1];
			self setv(minValue,_min call _precStrToInt);
			self setv(maxValue,_max call _precStrToInt);
			self setv(isRangeBased,true);
			if !isNullVar(__GLOBAL_FLAG_CURRENT_LOOT__) then {
				if ((self getv(minValue)) > (self getv(maxValue))) then {
					__GLOBAL_FLAG_CURRENT_LOOT__ setv(__hasErrorOnCreate,true);
					errorformat("RangedValue::init() - Min value %1 is bigger than max value %2 in template %3",self getv(minValue) arg self getv(maxValue) arg __GLOBAL_FLAG_CURRENT_LOOT__);
				};
			};
		};
	}
endstruct
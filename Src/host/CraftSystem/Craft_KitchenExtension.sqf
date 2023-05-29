// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


kitext_map = createHashMap;

kitext_addRecipe = {
	params ["_cat","_result","_objListNeed"];
	_cat = toLower _cat;
	if (!(_cat in kitext_map)) then {
		kitext_map set [_cat,[]];
	};
	_list = (kitext_map get _cat);
	_list pushBack [_objListNeed,_result];
};


kitext_findResult = {
	params ["_cat","_listItems","_doREM"];
	
	private _tnlstimts = _listItems apply {callFunc(_x,getClassName)};
	private _rez = "";
	
	{
		_x params ["_objListNeed","_result"];
		
		if ({_x in _tnlstimts} count _objListNeed) == (count _objListNeed) exitWith {
			_rez = _result;
			/*if (_doREM) then {
				for "_i" from (count _listItems) - 1 to 0 do {
					if (callFunc(_listItems select _i,getClassName) in _objListNeed) then {
						_listItems deleteAt _i;
						
					};	
				};	
			};	*/
		};
		
	} foreach (kitext_map getOrDefault [_cat,[]]);
	
	_rez
};

kitext_process = {
	params ["_cat","_src", //категория и источник
		"_deleg_itemsget", //делегат сбора ссылок на предметы в лист
		"_deleg_doAction", //делегат успешного нахождения 
		"_deleg_notFoundResult", //делегат ненахождения результата
		["_doRemFinded",false] //удаление найденных по-умолчанию (ПОКА НЕ РЕАЗИОВАНО)
	];
	
	private _listItems = _src call _deleg_itemsget;
	private _result = [_cat,_listItems,_doRemFinded] call kitext_findResult;
	
	//custom action without create new item
	if isNullVar(_result) exitWith {
		[_src,null] call _deleg_doAction;
	};
	
	if (_result != "") then {
		private _item = instantiate(_result);
		if isNullVar(_item) exitWith {
			errorformat("kitext::process() - internal runtime error: type %1 does not exists",_result);
		};
		[_src,_item] call _deleg_doAction;
	} else {
		_src call _deleg_notFoundResult;
	};
	
};	

//FryingPan recipes

["FryingPan",null,["Meat"]] call kitext_addRecipe;
["FryingPan",null,["GribChopped"]] call kitext_addRecipe;
["FryingPan",null,["MeatChopped"]] call kitext_addRecipe;

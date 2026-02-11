// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================




init_function(goasm_attributes_main_init)
{
	//Показывает псевдоним вместо фактического названия.
	//Параметры: string - псевдоним
	["alias"] call goasm_attributes_bindAttribute;
	//Показывает описание члена класса в просмотре наследования (редактор кода).
	//Параметры: string - описание
	["Tooltip"] call goasm_attributes_bindAttribute;
	// Помечает член видимым в окне свойств объекта для настройки в рантайме
	/*Параметры: 
		type:[name] - тип переменной. Доступны bool,model,int,float,string,icon
		range:[min]:[max] - ограничение для числовых данных
		stringmaxsize:[val] - максимальный размер строки
		custom_provider:[name] - специальный поставщик редактирования специализированного значения.
	*/
	["EditorVisible"] call goasm_attributes_bindAttribute;
	// Указывает что член является элементом внутренней реализации и не может быть получен или увиден в коде
	//Параметры: нет
	["InternalImpl"] call goasm_attributes_bindAttribute;
	// Атрибут указывает что член используется только для чтения и не может быть изменён пользователем в окне редактирования
	//Параметры: нет
	["ReadOnly"] call goasm_attributes_bindAttribute;

	//Указывает что атрибут доступен в менеджере режима
	/*
		Параметры:
			TODO
	*/
	["GMField"] call goasm_attributes_bindAttribute;

	// ---------------- Классовые атрибуты ----------------
	// Атрибут для класса указывает что он является устаревшим и будет удален в будущем
	["Deprecated",{!_isInherited}] call goasm_attributes_bindAttribute;
	// Атрибут для класса указывает что он не может быть создан явно. Возможно только использование как наследника
	["InterfaceClass",{!_isInherited}] call goasm_attributes_bindAttribute;
	//Скрытые классы не видны в библиотеке объектов. Указав параметр "allChild" все наследники класса так же не будут видны
	["HiddenClass",{!_isInherited}] call goasm_attributes_bindAttribute;
	// Подсвечивает класс в инспекторе указанным цветом в формате HTML
	["ColorClass"] call goasm_attributes_bindAttribute;
	// Объекты партиклов создаются со своей специальной моделью и помещаются в слой эффектов
	["EffectClass"] call goasm_attributes_bindAttribute;
	//Класс сгенерирован через редактор
	["EditorGenerated"] call goasm_attributes_bindAttribute;
	//Атрибут указыает, что класс является прототипом для создания из шаблонов (для наследования от IStruct, Decor)
	["TemplatePrefab",{!_isInherited}] call goasm_attributes_bindAttribute;

	// Режимы, помеченные данным атрибутом не могут быть отредактированы
	["CodeOnyGamemode",{!_isInherited}] call goasm_attributes_bindAttribute;

	//Классы, помеченные данным атрибутом не собираются в библиотеку узлов и являются автосгенерированными
	["NodeClass"] call goasm_attributes_bindAttribute;

	//TODO нужно больше атрибутов
}

//Регистрация атрибута
/*
	Второй параметр указывает может ли атрибут быть унаследован.
	Применяются правила:
	- ссылка на класс до готовности компиляции
	- флаг члена ("class";"field";"method")
	- параметры, определенные в атрибуте
	- флаг специальной переменной, указывающий что атрибут унаследован или объявлен _isInherited
	Доступна специальная переменная
*/
function(goasm_attributes_bindAttribute)
{
	params ["_attr",["_code",{true}]];

	goasm_attributes_map_hashData set [_attr,_code];
}

/*
	Внутренняя проверка возможности добавления атрибута
*/
function(goasm_attributes_canAddAttribute)
{
	params ["_atrName","_type","_flag","_params","_isInherited"];
	[_type,_flag,_params,_isInherited] call (goasm_attributes_map_hashData getOrDefault [_atrName,{
		["%1 - Undefined attribute %2 in %3",__FUNC__,_atrName,_pObj] call printError;
		false
	}])
}

function(goasm_attributes_hasAttributeClass)
{
	params ["_t","_name"];
	[_t,"class",null,_name] call goasm_attributes_hasAttribute;
}

function(goasm_attributes_hasAttributeField)
{
	params ["_t","_memberName","_name"];
	[_t,"field",_memberName,_name] call goasm_attributes_hasAttribute;
}
function(goasm_attributes_hasAttributeMethod)
{
	params ["_t","_memberName","_name"];
	[_t,"method",_memberName,_name] call goasm_attributes_hasAttribute;
}

function(goasm_attributes_hasAttribute)
{
	params ["_typeOrObj","_memberCat","_memName","_atrName"];
	if equalTypes(_typeOrObj,"") then {
		_typeOrObj = missionNamespace getVariable ["pt_"+_typeOrObj,nullPtr];
	};
	if isNullReference(_typeOrObj) exitWith {false};
	
	private _reflectStorage = call {
		if (_memberCat=="class") exitWith {"_redit_attribClass"};
		if (_memberCat=="field") exitWith {"_redit_attribFields"};
		if (_memberCat=="method") exitWith {"_redit_attribMethods"};
		""
	};
	if (_reflectStorage=="") exitWith {false};
	private _storage = (_typeOrObj getVariable _reflectStorage);
	if (_memberCat=="class") then {
		_atrName in _storage
	} else {
		private _mData = _storage get (tolower _memName);
		if isNullVar(_mData) exitWith {false};
		(_mData findif {equals(_x select 0,_atrName)})!=-1
	};
	
}
/*
["Item","field","EditorVisible","name"] call goasm_attributes_getValues
["Item","Class","ColorClass"] call goasm_attributes_getValues
*/
function(goasm_attributes_getValues)
{
	params ["_typeOrObj","_memberCat","_atrName","_memName"];
	if equalTypes(_typeOrObj,"") then {
		_typeOrObj = missionNamespace getVariable ["pt_"+_typeOrObj,nullPtr];
	};
	if isNullReference(_typeOrObj) exitWith {null};
	
	private _reflectStorage = call {
		if (_memberCat=="class") exitWith {"_redit_attribClass"};
		if (_memberCat=="field") exitWith {"_redit_attribFields"};
		if (_memberCat=="method") exitWith {"_redit_attribMethods"};
		""
	};
	if (_reflectStorage=="") exitWith {null};
	private _storage = (_typeOrObj getVariable _reflectStorage);
	if (_memberCat=="class") then {
		_storage get _atrName
	} else {
		private _mData = _storage get (tolower _memName);
		if isNullVar(_mData) exitWith {null};
		_mData select (_mData findif {equals(_x select 0,_atrName)})
	};
}

function(goasm_attributes_getClassValues)
{
	params ["_typeOrObj","_atrName"];
	[_typeOrObj,"Class",_atrName] call goasm_attributes_getValues;
}

function(goasm_attributes_getFieldValues)
{
	params ["_typeOrObj","_atrName","_memName"];
	[_typeOrObj,"field",_atrName,_memName] call goasm_attributes_getValues;
}

function(goasm_attributes_getMethodValues)
{
	params ["_typeOrObj","_atrName","_memName"];
	[_typeOrObj,"method",_atrName,_memName] call goasm_attributes_getValues;
}

function(goasm_attributes_getProperty)
{
	params ["_atrObj","_prop",["_isClassAtr",false]];
	private _copyAtrObj = array_copy(_atrObj);
	if (!_isClassAtr) then {
		_copyAtrObj deleteat 0;
	};
	private _indx = -1;
	{
		(_x splitString ":") params [["_key","NOKEY_______"]];
		if (_key == _prop) exitWith {
			_indx = _foreachIndex;
		};
	} foreach _copyAtrObj;
	if (_indx == -1) exitWith {""};
	_copyAtrObj select _indx;
}

function(goasm_attributes_getPropertyValue)
{
	params ["_atrObj","_prop",["_isClassAtr",false]];
	private _propObj = [_atrObj,_prop,_isClassAtr] call goasm_attributes_getProperty;
	private _params = _propObj splitString ":";
 	_params deleteAt 0;
	
	_params
}

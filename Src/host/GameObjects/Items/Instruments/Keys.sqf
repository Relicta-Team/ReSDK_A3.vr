// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>


class(Key) extends(Item)
	"
		name:Ключ
		desc:Ключ, открывающий и запирающий двери или наручники.
		path:Игровые объекты.Ключи
	" node_class

	var(name,"Ключ");
	var(model,"relicta_models\models\interier\props\key.p3d");
	var(material,"MatMetal");
	var(icon,invicon(key));
	var(weight,gramm(10));

	"
		name:Типы ключа
		namelib:Типы ключа
		desc:Тип или типы ключей, которые подходят к совместимым дверям (с учетом регистра). Указанные типы ключа будут проверяться при открытии двери или наручников. "+
		"Если в типах двери и типах ключа есть хотя-бы один элемент с одинаковым названием, то доступ предоставляется (происходит отпирание или запирание)
		prop:all
		return:array[string]:Имена замков, которые можно открыть этим ключом
		defval:[]
	" node_var
	var_array(keyOwner); //что можно открыть этим ключом

	"
		name:Задать типы ключа
		desc:Устанавливает ключу типы, которые подходят к совместимым дверям (с учетом регистра). Типы указываются с разделителями, которые могут быть комбинированы\: ';' '|' ',' ' '\n"+
		"Пример\: 'замок_1;замок_2' или 'lockhouse lockbar lockbar2' или 'Парадный_вход,Задний_вход|Дверь_второй_этаж'
		type:method
		lockoverride:1
		in:string:Типы:Типы ключа с указанными разделителями.
	" node_met
	func(_setKeyOwnerWrapper)
	{
		objParams_1(_kt);
		assert_str(!isNullVar(_kt),"Null param");
		assert_str(equalTypes(_kt,""),"Type missmatch");

		setSelf(keyOwner,_kt splitString ";| ,");
	};

	getter_func(getDropSound,"dropping\keydrop");
	getter_func(getPickupSound,"updown\keyring_up");
	getter_func(getPutdownSound,"updown\keyring_up");

	editor_attribute("alias" arg "Типы ключа")
	editor_attribute("Tooltip" arg "Тип или типы ключей, которые подходят к совместимым дверям (с учетом регистра).\n\nЗдесь можно перечислить типы с разделитерями: \n точка с запятой (;)\n запятой (" pcomma ")\n прямой чертой (|)\n пробелом ( )\n\nПример: ""key1;key2;key3""")
	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:512")
	var(preinit@__keyTypesStr,""); //системная переменная для установки ключей через редактор

	func(__handlePreInitVars__)
	{
		objParams();
		super();
		private _ktypes = getSelf(preinit@__keyTypesStr);
		if (count _ktypes > 0) then {
			private _listKeys = _ktypes splitString ";| ,";
			_listKeys append getSelf(keyOwner); //append types setted from code
			setSelf(keyOwner,_listKeys);
		};
		setSelf(preinit@__keyTypesStr,null);
	};

	//при интеракции ключа с другим ключом они образуют связку ключей
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,Key) then {
			private _isInWorld = callSelf(isInWorld);
			private _pos = callSelf(getPos);
			
			private _keyChain = if (_isInWorld) then {
				["KeyChain",_pos] call createGameObjectInWorld;
			} else {
				private _loc = getSelf(loc);
				callFuncParams(_loc,removeItem,this);
				callFuncParams(_loc,removeItem,_with);
				["KeyChain",_loc] call createItemInInventory;
			};

			if _isInWorld then {
				callSelf(unloadModel);
			};

			callFuncParams(_keyChain,addItem,this);
			callFuncParams(_keyChain,addItem,_with);
			callFuncParams(_usr,meSay,"cвязывает ключи вместе");
			callFuncParams(_usr,playSound,"updown\keyring_up" arg getRandomPitchInRange(0.9,1.1));
		};
	};
endclass


class(Lockpick) extends(Item)

	var(name,"Отмычка");
	var(model,"relicta_models\models\interier\props\spichka.p3d");
	var(icon,invicon(key));
	var(weight,gramm(15));
	var(size,ITEM_SIZE_TINY);
	var(material,"MatMetal");

	getter_func(getDropSound,"dropping\keydrop");
	getter_func(getPickupSound,"updown\keyring_up");
	getter_func(getPutdownSound,"updown\keyring_up");

	//Модификатор отмычки (опциональный)
	var(lockpickBonus,0);

endclass

// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>

naming_parseNames = {
	
	params ["_path"];
	
	private _fullpath = "src\host\Namings\" + _path;
	
	if (fileExists(_fullpath)) then {
		logformat("Loaded naming (%1)",_fullpath);
		
		(preprocessFile _fullpath) splitString " " + endl
	} else {
		errorformat("Naming does not exists: %1",_fullpath);
		["Ошибочка"]
	};
};

//Генерирует имя персонажа в разных склонениях
naming_generateName = {
	params ['this',['_f',""],['_s',""]];
	
	if (_f == "") exitWith {
		errorformat("Parameter for first name is empty: %1",_this);
	};
	
	if equals(this,nullPtr) exitWith {
		errorformat("Mob object is null reference for name %1",_f);
	};
	
	//delete (memleak fix)
	if !isNullReference(getSelf(naming)) then {
		delete(getSelf(naming));
	};

	#ifdef SP_MODE
	if (true) exitWith {
		//потому что в сингле у нас нет эдиторных либ
		[this,_f,_s] call naming_generateName_old;
	};
	#endif
	
	private _retArr = "RelictaNC" callExtension (_f + " " + _s);
	
	(parseSimpleArray _retArr) params ["_1","_2","_3","_4","_5","_6"];
	
	//check casing
	if (_1 == _2 && {_3 == _4 && {_5 == _6}}) then {
		errorformat("Naming::generateName() - Name not converted %1 -> [%2 %3]",_retArr arg _f arg _s);
	};
	
	//set cases
	private _oname = new(HumanNaming);
	setVar(_oname,кто,_1);
	setVar(_oname,кого,_2);
	setVar(_oname,кому,_3);
	setVar(_oname,вин,_4);
	setVar(_oname,кем,_5);
	setVar(_oname,ком,_6);
	
	setSelf(Naming,_oname);
	
};	


naming_generateName_old = {
	params ['this',['_f',""],['_s',""]];
	
	if (_f == "") exitWith {
		error("Parameter for first name is empty");
	};
	
	if equals(this,nullPtr) exitWith {
		errorformat("Mob object is null reference for name %1",_f);
	};

	private _nf = str toArray _f;
	_nf = _nf select [1,count _nf - 2];
	_nf = _nf splitString "," joinString "|";
	
	private _ns = "";
	private _nsStruct = "";
	
	if (_s != "") then {
		_nsStruct = "&sn=%2";
		_ns = str toArray _s;
		_ns = _ns select [1,count _ns - 2];
		_ns = _ns splitString "," joinString "|";
	};
	//----- http://relicta.ru/apiname.php?fn=0|%1&sn=0|%2
	
	
	//http://relicta.ru/apiname.php?fn=%1&sn=%2
	_dt = format["http://relicta.ru/apiname.php?fn=%1" + _nsStruct,_nf,_ns];
	
	private _ctx = [this];
	private _callback = {
		objParams_1(_sklons);
		
		if not_equals(this,nullPtr) then {
			//пока лень разбираться
			#ifdef SP_MODE
			if not_equals(getSelf(Naming),naming_default) then {
				delete(getSelf(Naming));
			};
			#else
			if not_equals(getSelf(Naming),naming_default) exitWith {
				errorformat("Naming module already created for mob with names: %1",_sklons);
			};
			#endif
			
			private _oname = new(HumanNaming);
			private _struct = _sklons splitString "|";
			setVar(_oname,кто,_struct select 0);
			setVar(_oname,кого,_struct select 1);
			setVar(_oname,кому,_struct select 2);
			setVar(_oname,вин,_struct select 3);
			setVar(_oname,кем,_struct select 4);
			setVar(_oname,ком,_struct select 5);
			
			setSelf(Naming,_oname);
			
		} else {
			warningformat("naming::generateName->callback: this object is null reference. Naming %1",_sklons);
		};
	};
	
	[_dt,_callback,_ctx] call curl_addRequest;
};

#include "ParseNaming.sqf"


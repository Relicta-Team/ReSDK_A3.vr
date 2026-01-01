// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\Gender\Gender.hpp>

//Проверяет все имена и фамилии на возможность склонения
//#define NAMING_VALIDATE_CASING


#define loadMobNames(filename) ['Mobs\##filename##.txt'] call naming_parseNames


naming_list_ManFirstName = loadMobNames(ManFirstName);
naming_list_WomanFirstName = loadMobNames(WomanFirstName);

//подгрузка универсальных (редких) имён
_universalNames = loadMobNames(UniversalFirstName);
naming_list_ManFirstName append _universalNames;
naming_list_WomanFirstName append _universalNames;

naming_list_ManCavenick = loadMobNames(ManCavenick);
naming_list_WomanCavenick = loadMobNames(WomanCavenick);

naming_list_ManSecondName = loadMobNames(ManSecondName);
naming_list_WomanSecondName = loadMobNames(WomanSecondName);



_txt = format["First names: %1/%2 (man/woman); Second names: %3/%4 (man/woman); CaveNames: %5/%6 (man/woman)",
	count naming_list_ManFirstName, 
	count naming_list_WomanFirstName,
	count naming_list_ManSecondName,
	count naming_list_WomanSecondName,
	count naming_list_ManCavenick,
	count naming_list_WomanCavenick];


["Naming system loaded! %1",_txt] call logInfo;

#ifdef NAMING_VALIDATE_CASING
	_errorsNaming = 0;
	{
		parseSimpleArray("RelictaNC" callExtension _x) params ["_i","_r"];
		if (_i == _r) then {
			errorformat("[NAMECASE_VALIDATOR]: Casing name error %1",_i);
			INC(_errorsNaming);
		};	
	} foreach (naming_list_ManFirstName + naming_list_WomanFirstName + naming_list_ManCavenick + naming_list_WomanCavenick);
	
	{
		_name = "Вася " + _x;
		parseSimpleArray("RelictaNC" callExtension _name) params ["_i","_r"];
		_rcheck = (_r splitString " ") select 1;
		if (_r == _rcheck) then {
			errorformat("[NAMECASE_VALIDATOR]: Casing second name error %1",_i);
			INC(_errorsNaming);
		};
	} foreach (naming_list_ManSecondName + naming_list_WomanSecondName);
	if (_errorsNaming > 0) then {
		_allt = 0;
		{
			MOD(_allt,+ _x);
		} count [count naming_list_ManFirstName, 
			count naming_list_WomanFirstName,
			count naming_list_ManSecondName,
			count naming_list_WomanSecondName,
			count naming_list_ManCavenick,
			count naming_list_WomanCavenick];
		errorformat("Error naming found: %1 / %2",_allt arg _errorsNaming);
	} else {
		log("No error naming found!!!");
	};	
#endif


naming_getRandomName = {
	params ["_gender",["_retAsString",false]];
	
	if not_equalTypes(_gender,GENDER_MALE) then {_gender = [_gender] call gender_objectToEnum};
	
	private _result = if (_gender == GENDER_MALE) then {
		[pick naming_list_ManFirstName,pick naming_list_ManSecondName]
	} else {
		[pick naming_list_WomanFirstName,pick naming_list_WomanSecondName]
	};
	
	ifcheck(_retAsString,_result joinString " ",_result)
};	

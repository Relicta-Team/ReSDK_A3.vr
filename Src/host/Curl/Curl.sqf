// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <Curl.hpp>


//to get steamid https://relicta.ru/UidToName.php?&uid=76561198094364528

//#define u_test

curl_send = {
	curl(_this)
};

curl_get = {
	curl("OK")
};

/*
Probably does not working...
curl_getstatus = {
	curl("STATUS")
};*/

curl_error = {
	curl("ERROR")
};


curl_testName = {
	params ["_f","_s"];
	
	_nf = str toArray _f;
	_ns = str toArray _s;
	_nf = _nf select [1,count _nf - 2];
	_ns = _ns select [1,count _ns - 2];
	
	//http://relicta.ru/apiname.php?fn=0|%1&sn=0|%2
	_nf = _nf splitString "," joinString "|";
	_ns = _ns splitString "," joinString "|";
	
	
	
	_dt = format["http://relicta.ru/apiname.php?fn=%1&sn=%2",_nf,_ns];
	
	(_dt call curl_send);
	
	_dt
};

//check thread (НЕ ВКЛЮЧАТь)
//if (curl("") != "OK") then {
//	warningformat("Callback on init CURL resulted %1",curl("OK"));
//};

#include "CurlThread.sqf"

#ifdef u_test

	_low = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя";
	_up = toUpper _low;

	_la = toArray _low;
	_up = toArray _up;
	_strict = "array(' ' => '32', '|' => '124',";

	{
		_strict = _strict + format["'%1' => '%2',",toString [_x],_x] + endl;
	} foreach _la;

	{
		_strict = _strict + format["'%1' => '%2',",toString [_x],_x] + endl;
	} foreach _up;

	_strict = _strict + ")";

	glob = _strict;

	_new = "array('32' => ' ', '124' => '|',";
	_strict = "array(' ' => '32', '|' => '124',";

	{
		_new = _new + format["'%2' => '%1',",toString [_x],_x] + endl;
	} foreach _la;

	{
		_new = _new + format["'%2' => '%1',",toString [_x],_x] + endl;
	} foreach _up;

	_new = _new + ")";

	glob_invert = _new;

#endif

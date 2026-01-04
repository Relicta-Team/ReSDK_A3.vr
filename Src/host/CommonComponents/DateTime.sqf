// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>


//dateTime module
// [year, month, day, hour, minute, second, millisecond]

//Конвертация даты и времени в строку
dateTime_toString = {
	params ["_dt",["_zero",false],["_outms",false]];

	#define applyficator(val) (if (val < 10 && _zero) then {"0" + str val} else {str val})

	_dt params [["_y",1],["_mt",1],["_d",1],["_h",0],["_m",0],["_s",0],["_ms",0]];

	format["%1.%2.%3 %4:%5:%6",
		applyficator(_d),
		applyficator(_mt),
		applyficator(_y),
		applyficator(_h),
		applyficator(_m),
		applyficator(_s)
	] + (if (_outms)then{"."+str _ms}else{""})
};

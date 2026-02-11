// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>



newTest(Weighting mob) test_flags(onlyMultiplayer)

	private this = player getVariable 'link';

	private _weight = 0;
	{
		MOD(_weight,+ getVar(_x,weight));
	} forEach getSelf(bodyOrgans);

	{
		if (_forEachindex == 0) then {
			MOD(_weight,+ getVar(getVar(_x,brain),weight));
		};
		MOD(_weight,+ getVar(_x,weight));
	} forEach getSelf(bodyParts);

	//Константное
	_precBodyLeft = 41.53;
	#define wToPrec(val) _w * (val) / 100

	MOD(_weight,+ wToPrec(_precBodyLeft));

	test_true(_weight == getSelf(weight),format["Amount %1; Mob %2" arg _weight arg getSelf(weight)]);

endTest

newTest(Default naming case)

	#define dllExec(var) (parseSimpleArray ("RelictaNC" callExtension (var)))

	{
		_firstName = _x;
		{
			_secondName = _x;

			_ptr = dllExec(_firstName + " " + _secondName);

			_checked = _ptr select 0;

			assert_false(equals(_ptr count {_x == _checked},6),"wrong count man names");

		} foreach naming_list_ManSecondName;
	} foreach naming_list_ManFirstName;

	{
		_firstName = _x;
		{
			_secondName = _x;

			_ptr = dllExec(_firstName + " " + _secondName);

			_checked = _ptr select 0;

			assert_false(equals(_ptr count {_x == _checked},6),"wrong count woman names");

		} foreach naming_list_WomanSecondName;
	} foreach naming_list_WomanFirstName;

endTest

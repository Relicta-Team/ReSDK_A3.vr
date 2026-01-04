// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#ifdef YAML_TESTS

[true] call yaml_setDLLConfig;
yaml_debug_testData = "

	# test comment
	testLoot:
	- name: abc
		desc: cde
		test_num: 123
		test_bool: on
		test_float: -0.123
		test_str: abstring
	- onelinearr: [1,2,0xabc]
	- ab: 1
" regexReplace ["\t/g","  "];
private _bufferRef = refcreate(0);
_d1 = [yaml_debug_testData,_bufferRef] call yaml_loadData;
assert(_d1);
_d1 = refget(_bufferRef);
buf = _d1;
assert(count _d1 == 1);
_d1 = _d1 get "testLoot";
assert(count(_d1) == 3);
assert(_d1 isequaltype []);
assert(count (_d1 select 0)==6);
assert(count (_d1 select 1 get "onelinearr")==3);
assert((_d1 select 1 get "onelinearr") isequalto vec3(1,2,0xabc));


private _d = [];
for"_i" from 1 to 20480 do {
	_d pushBack (format["longkey_%1: Ключ с длинным значением по индексу %1",_i]);
};
_d pushBack "LATEST: ""EOF""   ";
yaml_debug_longData = _d joinString endl;

yaml_debug_fileContent = loadfile "src\host\Yaml\test.yaml";


#endif

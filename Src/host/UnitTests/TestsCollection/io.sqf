// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
#define PREPROCESS_DATA "PREPROCESS_OUTPUT"

#include "..\TestFramework.h"

TEST(Yaml_Extension)
{
	ASSERT_STR(call yaml_isExtensionLoaded,"ReYaml not found or not loaded");
	private _ver = call yaml_getExtensionVersion;
	traceformat("Yaml version: %1",_ver);
	ASSERT_STR(_ver getv(major) > 0,"ReYaml not updated");
	ASSERT_STR(_ver callp(compare,"1.0") >= 0,"ReYaml version < 1.0");
}

TEST(Yaml_Base)
{
private _dat = "
  a: 1
  b:
    c: [6,7,8]
    d: [a,b,c]
  one_line_test: {First: Hello, Second: ""World!"" }
";
	private _ref = refcreate(0);
	ASSERT([_dat arg _ref] call yaml_loadData);
	private _map = refget(_ref);
	
	ASSERT_EQ(count _map,3);
	ASSERT_EQ(_map get "a",1);
	
	ASSERT_EQ(count (_map get "b"),2);
	
	ASSERT_EQ(count (_map get "b" get "c"),3);
	ASSERT_EQ(_map get "b" get "c" select 2,8);
	
	ASSERT_EQ(count (_map get "b" get "d"),3);
	ASSERT_EQ(_map get "d" select 2,"c");

	ASSERT_EQ(count (_map getOrDefault vec2("one_line_test",[])),2);
	ASSERT_EQ(_map get "one_line_test" getOrDefault vec2("First","notdef"),"Hello");
	ASSERT_EQ(_map get "one_line_test" getOrDefault vec2("Second","notdef"),"World!");

	_dat = "
- name: 1
  val: On
- name: 2
  val: Off
";
	_ref = refcreate(0);
	ASSERT([_dat arg _ref] call yaml_loadData);
	_map = refget(_ref);
	ASSERT_EQ(count _map,2);
	ASSERT_EQ(_map select 0 get "name",1);
	ASSERT_EQ(_map select 0 get "val",true);
	ASSERT_EQ(_map select 1 get "name",2);
	ASSERT_EQ(_map select 1 get "val",false);
}

TEST(Yaml_PartialLoading)
{
	//test long yaml (partial loading)
	private _d = [];
	for"_i" from 1 to 20480 do {
		_d pushBack (format["longkey_%1: Ключ с длинным значением по индексу %1",_i]);
	};
	_d pushBack "LATEST: ""EOF""   ";
	_d = _d joinString endl;

	ASSERT([_dat arg _ref] call yaml_loadData);
	_map = refget(_ref);
	ASSERT_EQ(count _map,20480 + 1);
	ASSERT_EQ(_map get "LATEST","EOF");
	ASSERT_EQ(_map get "longkey_20480","Ключ с длинным значением по индексу 20480");
}

TEST(Yaml_FileLoadingAllTypes)
{
	private _dat = ["src\host\Yaml\test.yaml"] call yaml_loadFile;
	ASSERT(_dat);
	ASSERT(count _dat > 0);
	ASSERT_EQ(_dat get "key","value");
	ASSERT("test_null" in _dat && {isNull(_dat get "test_null")});

}

TEST(Yaml_References)
{
	private _dat = ["src\host\Yaml\test.yaml"] call yaml_loadFile;
	ASSERT(_dat);
	ASSERT(count _dat > 0);
	
	ASSERT(array_exists(_dat,"test_reference"));
	ASSERT_EQ(count (_dat get "test_reference"),2);
	ASSERT_EQ(_dat get "test_reference" getOrDefault vec2("a",-123321),1);
	ASSERT_EQ(_dat get "test_reference" getOrDefault vec2("b",-123321),2)
	
	ASSERT(array_exists(_dat,"test_obj_refered"));
	ASSERT_EQ(count (_dat get "test_obj_refered"),2);
	ASSERT_EQ(_dat get "test_obj_refered" getOrDefault vec2("a",-123321),1);
	ASSERT_EQ(_dat get "test_obj_refered" getOrDefault vec2("b",-123321),2);

	//overriding check
	ASSERT(array_exists(_dat,"test_obj_override"));
	ASSERT_EQ(count (_dat get "test_obj_override"),2);
	ASSERT_EQ(_dat get "test_obj_override" getOrDefault vec2("b",-123321),1000);

}


TEST(Yaml_stringEncoding)
{
	//todo check utf8 from extension
}

TEST(LootSystem_AllCheckBase)
{
	//cleanup
	loot_mapConfigs = createHashMap;
	loot_list_loader = [];// список файлов для загрузки

	//init
	private _fullpath = "src\host\LootSystem\test.yml";
	[_fullpath] call loot_addConfig;
	call loot_init;

	//checks
	ASSERT_STR(count loot_mapConfigs == 2,"Loot templates not loaded");
	ASSERT("TestLoot" in loot_mapConfigs);

	private _lootObj = loot_mapConfigs get "TestLoot";
	private _funcRef = oop_getFieldBaseValue;
	oop_getFieldBaseValue = { "TestMap" }; //override func to return "TestMap"
	ASSERT_EQ(_lootObj callp(checkLootSpawnRestriction,"GamemodeName"),true);
	oop_getFieldBaseValue = _funcRef; //restore func

	ASSERT_EQ(count (_lootObj getv(allowMaps)),4);
	ASSERT_EQ(count (_lootObj getv(allowModes)),0);
	ASSERT_EQ(count (_lootObj getv(items)),2);
	
	private _itemList = _lootObj getv(items);

	private _fit = _itemList select (_itemlist findif {_x getv(itemType) == "Item"});
	ASSERT_EQ(_fit getv(itemType),"Item");
	ASSERT_EQ(_fit getv(minValue),1);
	ASSERT_EQ(_fit getv(maxValue),3);
	ASSERT_EQ(_fit callv(getValue),35);

	private _sit = _itemList select (_itemlist findif {_x getv(itemType) == "Key"});
	ASSERT_EQ(_sit getv(itemType),"Key");
	ASSERT_EQ(_sit getv(minValue),4);
	ASSERT_EQ(_sit getv(maxValue),4);
	ASSERT_EQ(_sit callv(getValue),100);
	ASSERT_EQ(_sit getv(isRangeBased),false);

	//compare checks
	private _clst = _lootObj getv(allowMaps);
	
	//regex base
	traceformat("Compare now: %1",_clst select 0 getv(compareType))
	ASSERT_EQ(_clst select 0 callp(compareTo,"OMap4"),true);
	ASSERT_EQ(_clst select 0 callp(compareTo,"OMap"),false);
	
	//exact
	traceformat("Compare now: %1",_clst select 1 getv(compareType))
	ASSERT(_clst select 1 callp(compareTo,"TestMap"));
	ASSERT(_clst select 1 callp(compareTo,"testmap"));
	
	//inline exact
	ASSERT_EQ(_clst select 1 getv(compareType),_clst select 2 getv(compareType));
	
	//typeof
	traceformat("Compare now: %1",_clst select 3 getv(compareType))
	(_clst select 3) setv(value,"ManagedObject");
	ASSERT(_clst select 3 callp(compareTo,"object"));

	//loot spawn test
	private _tobj = ["OldWoodenBox",[10,10,10]] call createGameObjectInWorld;
	traceformat("GameObject %1",_tobj);
	ASSERT(!isNullReference(_tobj));

	traceformat("Loot items: %1",_lootObj getv(items))

	ASSERT(_lootObj callp(processSpawnLoot,_tobj));
	private _content = getVar(_tobj,content);
	traceformat("Count created items: %1",count _content);
	traceformat("Items: %1",_content)
	ASSERT(count _content >= 4);// fixed keys count 4

	//check naming override
	private _fkey = [_content,{isTypeOf(_x,Key)},nullPtr] call searchInList;
	ASSERT(!isNullReference(_fkey)); // ! Если снова вывалится это исключение значит увеличиваем pass_count
	ASSERT_EQ(getVar(_fkey,name),"Test-key");

	[_tobj] call deleteGameObject;
}

TEST(FileSystem_Basic)
{
	private _thisfile = "src\host\UnitTests\TestsCollection\io.sqf";

	ASSERT(fileExists(_thisFile));
	ASSERT([_thisfile] call fileExists_Node);
	
	//content load
	private _content = [_thisfile] call fileLoad_Node;
	ASSERT("#define PREPROCESS_DATA" in _content);
	
	private _pcontent = [_thisfile,true] call fileLoad_Node;
	ASSERT(PREPROCESS_DATA in _pcontent);
}

TEST(FileSystem_Pathes)
{
	private _sdkPath = RBuilder_map_defines get "RBUILDER_RESDK_PATH";
	traceformat("sdk path: %1",_sdkPath)
	ASSERT(!isNull(_sdkPath));

	private _required = toLower "src\host\UnitTests\TestsCollection\io.sqf"; //path delimeter constant \
	private _data = [_required] call file_read;
	traceformat("Data len: %1 bytes",count _data)
	ASSERT(count _data > 0);


	ASSERT_STR(!isNull(fso_getFiles),"fso::getFiles() not defined");

	private _test = "Src\host/UnitTests\TESTsCollection\";
	private _files = [_test,null,false] call fso_getFiles;
	ASSERT(count fso_map_tree > 0);
	ASSERT(count _files > 0);
	trace("Files: ")
	{
		traceformat("    %1",_x)
	} foreach _files;
	ASSERT(_required in _files);
}

TEST(MacroIfdefs)
{
	private _filePath = "src\host\UnitTests\utility\header_test.h";
	
	private _test1 = "not_overriden";
	private _dummyVal = 0;
	private _versionMes = "default";
	private _included_def = "null";
	private _mulInclAll = "default_value";
	private _mixedValue = 0;
	private _endmacro = "empty";

	ASSERT(fileExists(_filePath));

	private _pdata = preprocessFileLineNumbers _filePath;
	traceformat("Preprocessed: %1",_pdata);
	ASSERT(count _pdata > 0);
	call compile _pdata;
	
	traceformat("Result _test1: %1",_test1)
	traceformat("Result _dummyVal: %1",_dummyVal)
	traceformat("Result _versionMes: %1",_versionMes)
	traceformat("Result _included_def: %1",_included_def)
	traceformat("Result _mulInclAll: %1",_mulInclAll)
	traceformat("Result _mixedValue: %1",_mixedValue)
	traceformat("Result _endmacro: %1",_endmacro)

	ASSERT_EQ(_dummyVal,1);
	ASSERT_EQ(_test1,"true");
	ASSERT_EQ(_versionMes,"true");
	ASSERT_EQ(_included_def,"connected");
	ASSERT_EQ(_mulInclAll,"success");
	ASSERT_EQ(_mixedValue,6);
	ASSERT_EQ(_endmacro,"ok");

}
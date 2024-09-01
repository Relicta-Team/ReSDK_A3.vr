// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
#define PREPROCESS_DATA "PREPROCESS_OUTPUT"

#include "..\TestFramework.h"

// TEST(FileSystem_Basic)
// {
// 	private _thisfile = "src\host\UnitTests\TestsCollection\io.sqf";

// 	ASSERT(fileExists(_thisFile));
// 	ASSERT([_thisfile] call fileExists_Node);
	
// 	//content load
// 	private _content = [_thisfile] call fileLoad_Node;
// 	ASSERT("#define PREPROCESS_DATA" in _content);
	
// 	private _pcontent = [_thisfile,true] call fileLoad_Node;
// 	ASSERT(PREPROCESS_DATA in _pcontent);
// }

// TEST(Yaml_Basic)
// {
// 	private _emptyMap = ["","data"] call yml_parse;
// 	ASSERT_EQ(count _emptyMap,2); //source + errors
// 	private _err = [_emptyMap] call yml_getErrors;
// 	ASSERT_EQ(count _err,1);
// 	ASSERT_EQ(_emptyMap get "#SOURCE",stringEmpty);

// private _content = "
// # comment
// a: 1
// b: 2
// ";

// 	private _map = [_content,"data"] call yml_parse;
// 	traceformat("Errors: %1",[_map] call yml_getErrors);
// 	ASSERT_EQ(count _map,2 + 2);
// 	ASSERT("a" in _map);
// 	ASSERT_EQ(_map get "a",1);
// 	ASSERT("b" in _map);
// 	ASSERT_EQ(_map get "b",2);
	
// private _content2 = "
// a:
//   - 1
//   - 2
// b: ['test end', 'test2 end']
// c: 'str end'
// d:
//   - e:
//     - f: [3,4]
//     - g: [5,6]
//   - x: 4

// ";

// _content2 = "
// TestLoot:
//   type: Loot # Все конфиги должны иметь тип
//   interface: true # интерфейсы только для заготовки шаблонов
//   inherit: BaseLoot # Опциональное наследование конфигурации.
//   name: some name # Описательное название конфигурации (опционально)
//   allowmaps: # попадание хотя бы под одну группу разрешает тип
//     - regex: *Map[1-9] #regex like pattern
//     - name: TestMap #exact
//     - TestMap
//     - typeof: BaseMap #type inheritance check
//   #allowgamemodes: # не определенный тип снимает все ограничения
//   items:
//     Item:
//       name: Overriden name {i} # {i} - counter of created items
//       prob: 35
//       count: [1, 3] #ranged count
//     Key:
//       prob: 20
//       count: 4 #fixed count
// ";

// 	private _map2 = [_content2,"data"] call yml_parse;
// 	traceformat("Map2 content: %1",[_map2] call yml_getData)
// 	["RBuilder","wait",[7 * 1000]] call rescript_callCommandVoid;
// 	ASSERT_EQ(count _map2, 4 + 2);

// 	ASSERT("a" in _map2);
// 	ASSERT_EQ(_map2 get "a", [1 arg 2]);

// 	ASSERT("b" in _map2);
// 	ASSERT_EQ(_map2 get "b", ["test end" arg "test2 end"]);

// 	ASSERT("c" in _map2);
// 	ASSERT_EQ(_map2 get "c", "str end");

// 	ASSERT("d" in _map2);
// 	private _o = _map2 get "d";
// 	traceformat("D content: %1",_o);
	
// }

// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"

"
	name:Получить национальность по лицу
	desc:Получает национальность персонажа по его лицу.
	exec:all
	in:string:Лицо:Лицо персонажа.
	out:enum.Nation:Национальность:Национальность персонажа.
"
node_func(getNationByFace_Node) = {
	params ["_face"];
	_face = tolower _face;
	if (_face == "") exitWith {"white"};
	private _dict = ifcheck(array_exists(faces_list_man,_face),faces_map_man,faces_map_woman);
	private _ret = "white";
	{
		if (_face in (_dict get _x)) exitWith {
			_ret = _x
		};
	} foreach _face;
	_ret
};

"
	name:Получить лица национальности
	desc:Получает массив всех лиц указанной национальности. При ошибках будет получен массив лиц.
	exec:all
	in:enum.Nation:Национальность:Национальность персонажа.
	in:enum.Gender:Пол:Пол персонажа.
	out:array[string]:Лица:Лица, указанного пола и национальности.
"
node_func(getNationAllFaces_Node) = {
	params ["_ntype","_genderEnum"];
	assert_str(_genderEnum >= 0 && _genderEnum <= 2,"Invalid gender enum");
	private _dict = [faces_map_man,faces_map_woman,faces_list_man] select _genderEnum;
	//copy array
	+(_dict getOrDefault [_ntype,faces_map_man get "white"])
};
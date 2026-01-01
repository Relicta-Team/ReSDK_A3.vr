// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\..\client\Inventory\inventory.hpp>
#include <..\CombatSystem\CombatSystem.hpp>
#include <..\..\client\Interactions\interact.hpp>

//эту функцию можно ускорить переделав выбор типа из хэшкарты
ata_buf_process = {
	params ["_ctx","_type","_mode"];
	private _selectorSet = {
		_2byte = _this;
		private _r = _list find _ctx;
		_r = str _r;
		if (count _r == 1 && _2byte) then {_r="0"+_r};
		_r
	};
	private _selectorGet = {
		private _r = parseNumber(_ctx select _this);
		_list select _r
	};
	if (_type == "activeHand") exitWith {
		if(_mode) then {
			ifcheck(equals(_ctx,INV_HAND_L),"1","2")
		} else {
			private _r = parseNumber(_ctx select [0,1]);
			if !inRange(_r,1,2) exitWith {
				errorformat("ata::buff::process() - wrong data %1[%2]",_type arg _ctx);
				INV_HAND_R
			};
			if (_r == 1) exitWith {INV_HAND_L};
			INV_HAND_R
		};
	};
	if (_type == "combatStyle") exitWith {
		private _list = COMBAT_STYLE_LIST_ALL;
		if (_mode) then {
			false call _selectorSet
		} else {
			[1,1] call _selectorGet
		};
	};
	if (_type == "attackType") exitWith {
		private _list = [ATTACK_TYPE_SWING,ATTACK_TYPE_THRUST,ATTACK_TYPE_SPECIAL,ATTACK_TYPE_HANDLE];
		if (_mode) then {
			true call _selectorSet
		} else {
			[2,2] call _selectorGet
		};
	};
	if (_type == "attackTypesList") exitWith {
		if (_mode) then {
			private _r = str _ctx;
			if (count _r!=2)then{_r = "0"+_r};
			_r
		} else {
			private _d = _ctx select [4,2];
			parseNumber _d
		};
	};
	//dot + 1
	if (_type == "targetZone") exitWith {
		if (_mode)then {
			private _r = str _ctx;
			if (count _r!=2)then{_r = "0"+_r};
			_r
		} else {
			parseNumber(_ctx select [7,2])
		};
	};
	//offset by 1
	if (_type == "specialAction") exitWith {
		if (_mode)then {
			private _r = str (_ctx+2);
			if (count _r!=2)then{_r = "0"+_r};
			_r
		} else {
			(parseNumber(_ctx select [9,2]))-2
		};
	};
	
	errorformat("ata::buf::process() - unknown type <%1> m(%2)",_type arg _mode);
	null
};

//assoc for attack types
ata_assoc_map = createHashMap;
_thurst_t = vec2(ATTACK_TYPE_THRUST,"Точечные удары");
_swing_t = vec2(ATTACK_TYPE_SWING,"Размашистые удары");
{
	_x params ["_enum","_list"];
	ata_assoc_map set [_enum,_list];
} foreach [
	[ATTACK_TYPE_ASSOC_HAND,
		[vec2(ATTACK_TYPE_THRUST,"Удар кулаком")]
	],
	[ATTACK_TYPE_ASSOC_THRUST_ONLY,
		[_thurst_t]
	],
	[ATTACK_TYPE_ASSOC_SWING_ONLY,
		[_swing_t]
	],
	[ATTACK_TYPE_ASSOC_STANDARD,
		[_thurst_t,_swing_t]
	],
	[ATTACK_TYPE_ASSOC_WPN_HANDLE,
		[_thurst_t,vec2(ATTACK_TYPE_SPECIAL,"Стрельба")]
	],
	[ATTACK_TYPE_ASSOC_WPN_1,
		[vec2(ATTACK_TYPE_THRUST,"Одиночные"),vec2(ATTACK_TYPE_SPECIAL,"Ближний бой")]
	],
	[ATTACK_TYPE_ASSOC_WPN_1_3,
		[vec2(ATTACK_TYPE_THRUST,"Одиночные"),vec2(ATTACK_TYPE_SWING,"Короткая очередь"),vec2(ATTACK_TYPE_SPECIAL,"Ближний бой")]
	],
	[ATTACK_TYPE_ASSOC_SWING_HANDLE,
		[vec2(ATTACK_TYPE_SWING,"Рубить"),vec2(ATTACK_TYPE_HANDLE,"Бить рукоятью")]
	]
]
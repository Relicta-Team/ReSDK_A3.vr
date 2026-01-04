// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\..\host\keyboard.hpp>
#include "..\..\host\lang.hpp"

namespace(Input,input_)

decl(map)
input_map_keyName = createHashMap;
decl(string[])
input_keyList_reversedAssoc = [];

macro_func(input_bindKey,void(string;int))
#define bindKey(name,val) input_map_keyName set [name,val];
inline_macro
#define mouse_key_prefix "@"
macro_func(input_bindMouse,void(string;int))
#define bindMouse(name,val) bindKey(mouse_key_prefix  + name,val)

bindKey("ESCAPE",0x01)
bindKey("1",0x02)
bindKey("2",0x03)
bindKey("3",0x04)
bindKey("4",0x05)
bindKey("5",0x06)
bindKey("6",0x07)
bindKey("7",0x08)
bindKey("8",0x09)
bindKey("9",0x0A)
bindKey("0",0x0B)
bindKey("MINUS",0x0C)
bindKey("EQUALS",0x0D)
bindKey("BACK",0x0E)
bindKey("TAB",0x0F)
bindKey("Q",0x10)
bindKey("W",0x11)
bindKey("E",0x12)
bindKey("R",0x13)
bindKey("T",0x14)
bindKey("Y",0x15)
bindKey("U",0x16)
bindKey("I",0x17)
bindKey("O",0x18)
bindKey("P",0x19)
bindKey("LBRACKET",0x1A)
bindKey("RBRACKET",0x1B)
bindKey("RETURN",0x1C)
bindKey("LCONTROL",0x1D)
bindKey("A",0x1E)
bindKey("S",0x1F)
bindKey("D",0x20)
bindKey("F",0x21)
bindKey("G",0x22)
bindKey("H",0x23)
bindKey("J",0x24)
bindKey("K",0x25)
bindKey("L",0x26)
bindKey("SEMICOLON",0x27)
bindKey("APOSTROPHE",0x28)
bindKey("GRAVE",0x29)
bindKey("LSHIFT",0x2A)
bindKey("BACKSLASH",0x2B)
bindKey("Z",0x2C)
bindKey("X",0x2D)
bindKey("C",0x2E)
bindKey("V",0x2F)
bindKey("B",0x30)
bindKey("N",0x31)
bindKey("M",0x32)
bindKey("COMMA",0x33)
bindKey("PERIOD",0x34)
bindKey("SLASH",0x35)
bindKey("RSHIFT",0x36)
bindKey("MULTIPLY",0x37)
bindKey("LMENU",0x38)
bindKey("SPACE",0x39)
bindKey("CAPITAL",0x3A)
bindKey("F1",0x3B)
bindKey("F2",0x3C)
bindKey("F3",0x3D)
bindKey("F4",0x3E)
bindKey("F5",0x3F)
bindKey("F6",0x40)
bindKey("F7",0x41)
bindKey("F8",0x42)
bindKey("F9",0x43)
bindKey("F10",0x44)
bindKey("NUMLOCK",0x45)
bindKey("SCROLL",0x46)
bindKey("NUMPAD7",0x47)
bindKey("NUMPAD8",0x48)
bindKey("NUMPAD9",0x49)
bindKey("SUBTRACT",0x4A)
bindKey("NUMPAD4",0x4B)
bindKey("NUMPAD5",0x4C)
bindKey("NUMPAD6",0x4D)
bindKey("ADD",0x4E)
bindKey("NUMPAD1",0x4F)
bindKey("NUMPAD2",0x50)
bindKey("NUMPAD3",0x51)
bindKey("NUMPAD0",0x52)
bindKey("DECIMAL",0x53)
bindKey("OEM_102",0x56)
bindKey("F11",0x57)
bindKey("F12",0x58)
bindKey("F13",0x64)
bindKey("F14",0x65)
bindKey("F15",0x66)
bindKey("KANA",0x70)
bindKey("ABNT_C1",0x73)
bindKey("CONVERT",0x79)
bindKey("NOCONVERT",0x7B)
bindKey("YEN",0x7D)
bindKey("ABNT_C2",0x7E)
bindKey("NUMPADEQUALS",0x8D)
bindKey("PREVTRACK",0x90)
bindKey("AT",0x91)
bindKey("COLON",0x92)
bindKey("UNDERLINE",0x93)
bindKey("KANJI",0x94)
bindKey("STOP",0x95)
bindKey("AX",0x96)
bindKey("UNLABELED",0x97)
bindKey("NEXTTRACK",0x99)
bindKey("NUMPADENTER",0x9C)
bindKey("RCONTROL",0x9D)
bindKey("MUTE",0xA0)
bindKey("CALCULATOR",0xA1)
bindKey("PLAYPAUSE",0xA2)
bindKey("MEDIASTOP",0xA4)
bindKey("VOLUMEDOWN",0xAE)
bindKey("VOLUMEUP",0xB0)
bindKey("WEBHOME",0xB2)
bindKey("NUMPADCOMMA",0xB3)
bindKey("DIVIDE",0xB5)
bindKey("SYSRQ",0xB7)
bindKey("RMENU",0xB8)
bindKey("PAUSE",0xC5)
bindKey("HOME",0xC7)
bindKey("UP",0xC8)
bindKey("PRIOR",0xC9)
bindKey("LEFT",0xCB)
bindKey("RIGHT",0xCD)
bindKey("END",0xCF)
bindKey("DOWN",0xD0)
bindKey("NEXT",0xD1)
bindKey("INSERT",0xD2)
bindKey("DELETE",0xD3)
bindKey("LWIN",0xDB)
bindKey("RWIN",0xDC)
bindKey("APPS",0xDD)
bindKey("POWER",0xDE)
bindKey("SLEEP",0xDF)
bindKey("WAKE",0xE3)
bindKey("WEBSEARCH",0xE5)
bindKey("WEBFAVORITES",0xE6)
bindKey("WEBREFRESH",0xE7)
bindKey("WEBSTOP",0xE8)
bindKey("WEBFORWARD",0xE9)
bindKey("WEBBACK",0xEA)
bindKey("MYCOMPUTER",0xEB)
bindKey("MAIL",0xEC)
bindKey("MEDIASELECT",0xED)
bindKey("BACKSPACE",KEY_BACK)
bindKey("NUMPADSTAR",KEY_MULTIPLY)
bindKey("LALT",KEY_LMENU)
bindKey("CAPSLOCK",KEY_CAPITAL)
bindKey("NUMPADMINUS",KEY_SUBTRACT)
bindKey("NUMPADPLUS",KEY_ADD)
bindKey("NUMPADPERIOD",KEY_DECIMAL)
bindKey("NUMPADSLASH",KEY_DIVIDE)
bindKey("RALT",KEY_RMENU)
bindKey("UPARROW",KEY_UP)
bindKey("PGUP",KEY_PRIOR)
bindKey("LEFTARROW",KEY_LEFT)
bindKey("RIGHTARROW",KEY_RIGHT)
bindKey("DOWNARROW",KEY_DOWN)
bindKey("PGDN",KEY_NEXT)
bindKey("CIRCUMFLEX",KEY_PREVTRACK)
bindMouse("LEFT",0)
bindMouse("RIGHT",1)
bindMouse("MIDDLE",2)



{
	input_keyList_reversedAssoc pushBack [_y,_x];
} foreach input_map_keyName;

// Получает значение ключа из клавиатуры
decl(int(string;bool))
input_getKeyValue = {
	params ["_str","_isMouse"];
	if (_isMouse) then {_str = mouse_key_prefix + _str};
	
	
	if (_str in input_map_keyName) then {
		input_map_keyName get _str
	} else {
		warningformat("input::getKeyValue() - Cant find key %1",_str);
		KEY_RETURN
	};
	
};	

//Получает массив всех названий кнопок
decl(string[](int))
input_getAllKeyNames = {
	params ["_idx"];
	private _list = [];
	{
		if ((_x select 0) == _idx && (_x select 1 select [0,1] != mouse_key_prefix)) then {_list pushBack (_x select 1)};
	true;} count input_keyList_reversedAssoc;
	
	_list
};	
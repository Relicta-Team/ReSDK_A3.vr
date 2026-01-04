// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(Input,input_)

//// [name,desc,current,default,variable]
enum(KeybindIndex,KEYBIND_INDEX_)
#define KEYBIND_INDEX_NAME 0
#define KEYBIND_INDEX_DESC 1
#define KEYBIND_INDEX_CURRENT 2
#define KEYBIND_INDEX_DEFAULT 3
#define KEYBIND_INDEX_VARNAME 4
#define KEYBIND_INDEX_SERIALIZED 5
enumend

// [value,shift,ctrl,alt,isMouse]
enum(KeyDataIndex,KEYDATA_INDEX_)
#define KEYDATA_INDEX_KEY 0
#define KEYDATA_INDEX_SHIFT 1
#define KEYDATA_INDEX_CTRL 2
#define KEYDATA_INDEX_ALT 3
#define KEYDATA_INDEX_ISMOUSE 4
enumend

//Распаковывает массив клавиш
macro_func(input_unpackKeyData,array())
#define unpackKeyData(_dat) _dat select [1,4]

macro_func(input_doPrepareKeyData,void(any))
#define doPrepareKeyData(pars) input__ikdp = unpackKeyData(pars)

//Проверяет состояние кейдаты
macro_func(input_isPressedKey,bool(any,any))
#define isPressedKey(_key,variable) ([_key,variable,true] call input_checkKeyState)

macro_func(input_isPressed,bool(any))
#define isPressed(var) isPressedKey(input__ikdp,var)

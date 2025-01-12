// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//// [name,desc,current,default,variable]

#define KEYBIND_INDEX_NAME 0
#define KEYBIND_INDEX_DESC 1
#define KEYBIND_INDEX_CURRENT 2
#define KEYBIND_INDEX_DEFAULT 3
#define KEYBIND_INDEX_VARNAME 4
#define KEYBIND_INDEX_SERIALIZED 5

// [value,shift,ctrl,alt,isMouse]
#define KEYDATA_INDEX_KEY 0
#define KEYDATA_INDEX_SHIFT 1
#define KEYDATA_INDEX_CTRL 2
#define KEYDATA_INDEX_ALT 3
#define KEYDATA_INDEX_ISMOUSE 4

//Распаковывает массив клавиш
#define unpackKeyData(_dat) _dat select [1,4]

#define doPrepareKeyData() __ikdp = unpackKeyData(_this)
#define isPressed(var) isPressedKey(__ikdp,var)

//Проверяет состояние кейдаты
#define isPressedKey(_key,variable) ([_key,variable,true] call input_checkKeyState)

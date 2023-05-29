# Препроцессор
Когда вы компилируете любой скрипт он проходит через этап препроцесса. Препроцессором по сути является заменой кусков кода с помощью макросов на этапе компиляции. Он широко используется при создании константных (неизменяемых) значений, в объектной системе, а так же для условной компиляции (например с использованием флагов `DEBUG` и `RELEASE`). Понимая простейшие принципы работы макросов вы свободно сможете писать любой функционал для проекта. Препроцессор в языке SQF очень сильно схож с си-подобными макросами (С, С++). 

Более развернутая информация по препроцессору описана [на официальной вики](https://community.bistudio.com/wiki/PreProcessor_Commands)

## Макросы
Все макросы **РЕГИСТРОЗАВИСИМЫЕ** в отличии от переменных. Их область видимости работает по аналогии с локальными переменными за исключением того, что вместо блоков кода они доступны в файле и всех вложенных файлах.

```sqf
#define PI_NUMBER 3.14
private _str = "Pi number equals " + str PI_NUMBER; // _str == "Pi number equals 3.14"
_str2 = 'Pi number equals PI_NUMBER';
// _str == _str2; Встраивание значений макросов в строку доступно только если строка начинается с одиночых кавычек

#define ACCESS_LEVEL_PLAYER 1
#define ACCESS_LEVEL_ADMIN 2

private _level = ACCESS_LEVEL_PLAYER;
private _adminPanelEnabled = false;

if (_level == ACCESS_LEVEL_ADMIN) then {
	_adminPanelEnabled = true;
};

//_adminPanelEnabled == false, потому что _level равен ACCESS_LEVEL_PLAYER

```

Помимо обычных макросов мы можем использовать аналог функций с передачей параметров в макросы:

```sqf
#define combineNumbers(a,b) a + b

private _num = combineNumbers(1,4); 
//_num == 5

#define inlineFunction(x,y,z) x = y + z

inlineFunction(_value,_num,3); //препроцессится в _value = _num + 3;
//_value == 8

```

**!Внимание!**
> В языке SQF макросы оторваны от контекста кода. Короткое наглядное описание какие ошибки могут возникать с макросами ниже:

```sqf
#define macroWith3Params(a,b,c) a + b + c

_result1 = macroWith3Params(1,3,3); //_result1 == 7

_result2 = macroWith3Params(1,2,3,4); //ошибка компиляции. макрос допускает только 3 параметра

#define arrayPlusArray(arr1,arr2) arr1 + arr2

_resArr = arrayPlusArray([1,2,3],[4,5,6]); //ошибка компиляции из-за отрыва от контекста. Препроцессор ожидает, что в параметрах макроса могут быть указаны только 2 значения а запятую после двойки и последующее число 3 он считает третьим параметром и далее.
// Данную проблему можно решить тремя способами:

// Способ 1. Создать макрос для массивов
#define array3Elements(a,b,c) [a,b,c]

_resArr = arrayPlusArray(array3Elements(1,2,3),array3Elements(4,5,6));
//_resArr == [1,2,3,4,5,6]

// Способ 2. Вместо запятых в массиве использовать макрос с подстановкой запятой

#define arg ,

_resArr = arrayPlusArray([1 arg 2 arg 3],[4 arg 5 arg 6]);
//_resArr == [1,2,3,4,5,6]

// Способ 3. Просто вынесем массивы в отдельные локальные переменные и используем их

_a1 = [1,2,3];
_a2 = [4,5,6];

_resArr = arrayPlusArray(_a1,_a2);
//_resArr == [1,2,3,4,5,6]
	
// Второй способ очень часто используется при работе с вызовом методов классов с несколькими параметрами


```


## Условная компиляция
Условная компиляция нужна для переключения логики выполнения на этапе компиляции кода а не выполнения. Это гораздо удобнее и быстрее чем вычислять некоторые действия во время исполнения программы. Например в режиме `DEBUG` нам доступен вывод различных отладочных сообщений, которые в релизной версии не должны быть отображены.

```sqf
#define DEBUG_PRINT_LARGE_NUMBERS

#define CONSTANT_ARRAY [2,3,4,23,2,34]

private _countBigNumbers = 0;
{

	if (_x > 10) then {
		#ifdef DEBUG_PRINT_LARGE_NUMBERS
			log("Finded big number: " + str _x + " at index " + str _foreachIndex); // log() - это тоже макрос, определенный в заголовочном файле engine.hpp, использующийся для логирования в консоль
		#endif
		_countBigNumbers = _countBigNumbers + 1;
	};
} foreach CONSTANT_ARRAY;
// _countBigNumbers == 2
```

Вот как будет выглядить код после препроцессинга:

С флагом *DEBUG_PRINT_LARGE_NUMBERS*
```sqf




private _countBigNumbers = 0;
{

	if (_x > 10) then {
		
			log("Finded big number: " + str _x + " at index " + str _foreachIndex); 
		
		_countBigNumbers = _countBigNumbers + 1;
	};
} foreach [2,3,4,23,2,34];

```
И без него
```sqf




private _countBigNumbers = 0;
{
	if (_x > 10) then {
		
		_countBigNumbers = _countBigNumbers + 1;
	};
} foreach [2,3,4,23,2,34];

```

Также существует директива **#ifndef** которая работает противоположно **#ifdef**

```sqf
#ifndef DEBUG
	log("is not debug mode");
#endif

//выведет в консоли is not debug mode если макрос DEBUG не определён
```

## Заголовочные файлы (директива #include)

Заголовочные файлы подключаются с помощью директивы `#inlcude`. Нужно написать директиву и указать **относитлеьный путь до файла**. Путь до файла должен быть в кавычках или угловых скобках
```sqf
#include "header1.hpp"
#include <header2.hpp>
```
Понятие относительный путь означает, что путь до файла должен быть указан относительно места подключения:
```
 |___ allmacros.h
 |\
 | \
 |  \_ FolderOther
 |       |
 |       |
 |        \_file1.sqf
  \
   \_FolderTest
        |
        |\
        | \_scriptConstants.h
        |
         \_testScript.sqf
```

```sqf
// File: testScript.sqf

#inlcude "scriptConstants.h"
#include "..\FolderOther\file1.sqf"
#include "..\allmacros.h"

```

```sqf
// File: file1.sqf

#inlcude "..\FolderTest\scriptConstants.h"
#inlcude "..\FolderTest\testScript.sqf"
#include "..\allmacros.h"

```

> Для поднятие по директории вверх используйте две точки (`..`) в пути.

## На этом гайд закончен. Освоив этот и предыдущие разделы вы можете приступить к самостоятельному написанию своего первого серьёзного кода.
# Массивы

Массив - это список элементов с различными типами переменных. Различные типы могут сосуществовать в пределах одного и того же массива. Массив может быть как одномерным, так и многомерным.

> Массивы ограничены максимум 9 999 999 (иногда 10 000 000) элементами

Переменная array является ссылкой на массив; это означает, что при редактировании массива все функции, использующие ссылку на этот массив, увидят редакцию.

```sqf
private _myArray = ["a", "b", "c"];
private _myNewArray = _myArray;
_myArray set [1, "z"];
_myNewArray select 1; // возвращает "z"
```

# Создание массивов

```sqf
// Пример пустого массива
private _myArray = [];
count _myArray;	// возвращает 0

// Пример заполненного массива
private _myFilledArray = ["abc", "def"];
count _myFilledArray; //возвращает 2
```

Массив может содержать внутри себя другой массив, который сам может содержать другой массив и т.д:

```sqf
private _myArray = [
	["my", "subArray", 1], 
	["mySubArray2"], 
	[
		["my", "sub", "sub", "array"]
	]
]; 

count   _myArray; // возвращает 3
count  (_myArray select 0); // возвращает 3
count  (_myArray select 1); // возвращает 1
count  (_myArray select 2); // возвращает 1
count ((_myArray select 2) select 0); // возвращает 4
```

# Получение элементов
Массив использует индекс, основанный на нуле, для своих элементов:
```sqf
private _myArray = ["first item", "second item", "third item"];
_myArray select 0; // возвращает "first item"
_myArray select 2; // возвращает "third item"
```

# Установка элементов
```sqf
private _myArray = ["first item", "second item", "third item"];
_myArray select 1; // возвращает "second item"
_myArray set [1, "hello there"]; // _myArray равен ["first item", "hello there", "third item"]
```

> Если индекс, заданный команде `set`, выходит за пределы допустимых значений, размер массива изменится, чтобы включить индекс в качестве его последнего значения. Все "пустые места" между последним допустимым элементом и новым элементом `set` будут заполнены значением `null`

# Подсчет элементов

```sqf
private _myArray = ["first item", ["second item's subitem 1", "second item's subitem 2"], "third item"];
count _myArray; // возвращает 3 - массивы не подсчитываются рекурсивно
```

# Изменение размера массива
Команда resize предназначена для уменьшения или расширения массива:
```sqf
private _myArray = [1, 2, 3, 4, 5];
_myArray resize 3; // _myArray равен [1, 2, 3]
```

```sqf
private _myArray = [1, 2, 3];
_myArray resize 5; // _myArray равен [1, 2, 3, null, null]
```

> Вам не нужно расширять массив перед добавлением элементов!

# Копии массивов
```sqf
private _myArray = ["a", "b", "c"];
private _myNewArray = _myArray;
_myArray set [1, "z"];
_myNewArray select 1; // возвращает "z"
```

```sqf
private _myArray = [["a", "b", "c"], ["d", "e", "f"]];
private _subArray1 = _myArray select 0;
_subArray1 set [1, "z"];
// _subArray1 равен ["a", "z", "c"]
// _myArray равен [["a", "z", "c"], ["d", "e", "f"]]
```

Чтобы избежать такого поведения, скопируйте массив с помощью + (плюс), либо с помощью array_copy(), который определён в `engine.hpp`:

```sqf
// создание копии
private _myArray = ["a", "b", "c"];
private _myNewArray = +_myArray;
_myArray set [1, "z"];
_myNewArray select 1; // возвращает "b"

// Пример ниже эквивалентен
private _myArray = ["a", "b", "c"];
private _myNewArray = array_copy(_myArray);
_myArray set [1, "z"];
_myNewArray select 1; // возвращает "b"
```
Подмассивы также копируются глубоко; _myNewArray не будет указывать на одни и те же экземпляры подмассива.

# Добавление элементов

Для добавления элементов в массив используйте команды `append` и `pushBack`:
```sqf
private _myArray = [1, 2, 3];
_myArray pushBack 4; // _myArray равен [1, 2, 3, 4]
_myArray append [5, 6];	 // _myArray равен [1, 2, 3, 4, 5, 6]
```
Вы также могли бы использовать оператор (+) для добавления массивов. Разница в том, что такой подход возвращает копию массива и, следовательно, немного медленнее, чем `append` и `pushBack`, которые изменяют целевой массив.
```sqf
private _myArray = [1, 2, 3];
_myArray = _myArray + [4]; // _myArray равен [1, 2, 3, 4]
_myArray = _myArray + [5, 6]; // _myArray равен [1, 2, 3, 4, 5, 6]
```

# Удаление элементов
Для удаление элементов массива используйте `deleteAt` и `deleteRange`:
```sqf
private _myArray = [1, 2, 3, 4, 5];
_myArray deleteAt 0; // _myArray равен [2, 3, 4, 5]
```
```sqf
private _myArray = [1, 2, 3, 4, 5];
_myArray deleteRange [1, 2]; // _myArray равен [1, 4, 5]
```
Вы также можете использовать оператор (-) для вычитания массивов. Вычитание возвращает копию массива, точно так же, как сложение, и это не так быстро, как `deleteAt` и `deleteRange`, которые изменяют целевые массивы.
```sqf
private _myArray = [1, 2, 3, 4, 5];
_myArray = _myArray - [1]; // _myArray равен [2, 3, 4, 5]
```
Удаление вложенных массивов так же возможно:
```sqf
private _myArray = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
_myArray = _myArray - [[4, 5, 6]]; // _myArray равен [[1, 2, 3], [7, 8, 9]]
```
Удаление через вычитание приведет к удалению всех элементов второго массива из первого массива:
```sqf
_myArray = [1, 2, 3, 1, 2, 3] - [1, 2]; // _myArray равен [3, 3]
```
Решением этой проблемы является комбинированное использование set и элемента, который, как вы знаете, отсутствует в массиве:
```sqf
private _myArray = [1, 2, 3, 1, 2, 3];
_myArray set [2, objNull]; // _myArray равен [1, 2, objNull, 1, 2, 3]
_myArray = _myArray - [objNull]; // _myArray равен [1, 2, 1, 2, 3]
```
Используя этот метод, можно имитировать поведение удаления таким образом:
```sqf
private _myArray = [1, 2, 3, 4, 5];
{ _myArray set [_x, objNull] } forEach [1, 2]; // _myArray равен [1, objNull, objNull, 4, 5]
_array = _array - [objNull]; // _myArray равен [1, 4, 5]
```

## Перебор массивов
Самый простой способ перебора массива - это команда `foreach`:
```sqf
private _myArray = [1, 2, 3, 4, 5];
{ [str _x] call messageBox } forEach _myArray;
```
Также можно использовать комбинацию `for`, `count` и `select`:
```sqf
private _myArray = [1, 2, 3, 4, 5];
for "_i" from 0 to (count _myArray) -1 do { //count вернул бы 5, но 5 находится в индексе массива 4
	[str (_myArray select _i)] call messageBox;
};
```

# Расширенное использование

## apply 
Аналогично функции "map" в Javascript, `apply` позволяет применить код к каждому элементу массива и вернуть копию:
```sqf
private _myArray = [1, 2, 3, 4, 5];
_myArray = _myArray apply { _x * 2 }; // _myArray равен [2, 4, 6, 8, 10]

// эквивалетно
_myArray = + _myArray;
for "_i" from 0 to count _myArray -1 do {
	private _element = _myArray select _i;
	_myArray set [_i, _element * 2];
};
```

## select
Простой способ отфильтровать массив (и получить новый) - использовать альтернативный синтаксис `select`:
```sqf
private _myArray = [1, 2, 3, 4, 5];
private _filteredArray = _myArray select { _x > 3 }; // _filteredArray равен [4, 5]

// эквивалетно
private _filteredArray = [];
{ if (_x > 3) then { _filteredArray pushBack _x } } forEach _myArray;
```

## findif
Команда findIf позволяет вам просмотреть весь список и остановиться, как только условие будет выполнено, **возвращая индекс массива элемента**, удовлетворяющего условию:
```sqf
private _myArray = [1, 2, 3, 4, 5];
_myArray findIf { _x == 3 } > -1; // возвращает значение true, означающее, что существует элемент, равный 3
_myArray findIf { _x == 6 } > -1; // возвращает значение false, означающее, что нет элемента, равного 6
```
Вы могли бы использовать count для достижения того же результата, однако count не остановится, пока не выполнит итерацию по всему массиву, так что это может занять больше времени.
```sqf
private _myArray = [1, 2, 3, 4, 5];
{ _x == 3 } count _myArray > 0; // возвращает значение true, означающее, что существует элемент, равный 3
{ _x == 6 } count _myArray > 0; // возвращает значение false, означающее, что нет элемента, равного 6
```

## arrayintersect
Команда arrayIntersect возвращает новый массив, заполненный элементами, найденными в обоих предоставленных списках:
```sqf
private _array1 = [1, 2, 3, 4];
private _array2 = [3, 4, 5, 6];
private _result = _array1 arrayIntersect _array2; // _result равен [3, 4]
```

# Сортировка массивов

## sort
Команда sort позволяет выполнить сортировку массива String, Number или подмассивов string/number. Он изменяет исходный массив и ничего не возвращает:
```sqf
private _myArray = ["zzz", "aaa", "ccc"];
_myArray sort true; // _myArray равен ["aaa", "ccc", "zzz"]

private _myArray2 = [666, 57, 1024, 42];
_myArray sort false; // _myArray2 равен [1024, 666, 57, 42]

private _myArray3 = [["zzz", 0], ["aaa", 42], ["ccc", 33]];
_myArray sort true; // _myArray3 равен [["aaa", 42], ["ccc", 33], ["zzz", 0]]
```
## reverse
Команда reverse просто изменяет порядок в массиве на противоположный:
```sqf
private _myArray = [99, 33, 17, 24, "a", [3,2,1], 7777];
reverse _myArray; // _myArray равен [7777, [3,2,1], "a", 24, 17, 33, 99]
```

# Заключение
Ещё раз пройдемся по основным функциям для работы с массивами: 
```sqf
private _x = [1,2,3,4,5];
private _g = _x select [4]; // _g == 5
private _p = _x select [2,2]; // _p == [3,4]
_x deleteAt 0; // _x == [2,3,4,5]
private _j = _x deleteAt 0; // _x == [3,4,5]; _j == 2
_x set [0,_g]; // _x == [5,4,5]

private _v = [true,true,true];
_v pushBack false; //_v == [true,true,true,false]
_v pushBackUnique true; //_v == [true,true,true,false]
```

# [Следующий раздел](Classes.md)

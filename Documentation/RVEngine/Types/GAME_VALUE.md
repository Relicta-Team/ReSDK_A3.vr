# game_value - Универсальный контейнер

## Обзор

`game_value` — это универсальный контейнер, который может хранить любой тип данных, используемый в Arma 3. Это основной тип для передачи данных между C++ кодом и движком игры.

```cpp
class game_value : public serialize_class {
protected:
    static uintptr_t __vptr_def;
public:
    ref<game_data> data;  // Умный указатель на данные
    
    // Конструкторы, операторы, методы...
};
```

## Ключевые особенности

- ✅ **Универсальность**: Может хранить любой тип (числа, строки, массивы, объекты и т.д.)
- ✅ **Автоматическое управление памятью**: Использует reference counting
- ✅ **Безопасность типов**: Проверка типов во время выполнения
- ✅ **Автоматическая конвертация**: Неявное приведение к/из C++ типов
- ✅ **Совместимость с SQF**: Прямая передача в/из SQF функций

## Создание game_value

### Из примитивных типов

```cpp
// Числа (float)
game_value val1 = 42.0f;
game_value val2 = 3.14f;
game_value val3 = static_cast<float>(100);

// Целые числа (конвертируются в float)
game_value val4 = 42;      // int → float
game_value val5 = 100u;    // size_t → float

// Логические значения
game_value val6 = true;
game_value val7 = false;
```

### Из строк

```cpp
// std::string
game_value val1 = std::string("Hello");

// C-строка
game_value val2 = "World";

// string_view
game_value val3 = std::string_view("Test");

// r_string (движковая строка)
r_string engine_str = "Engine";
game_value val4 = engine_str;
```

### Из массивов

```cpp
// std::vector
std::vector<game_value> vec = {1, 2, 3, "four", true};
game_value arr1 = vec;

// Initializer list
game_value arr2 = {1.0f, 2.0f, 3.0f};

// auto_array (движковый массив)
auto_array<game_value> engine_arr;
engine_arr.push_back(1);
engine_arr.push_back(2);
game_value arr3 = std::move(engine_arr);

// Типизированный массив
std::vector<int> numbers = {1, 2, 3, 4, 5};
game_value arr4 = std::vector<game_value>(numbers.begin(), numbers.end());
```

### Из векторов

```cpp
// vector3
types::vector3 pos3d = {100, 200, 50};
game_value val1 = pos3d;

// vector2
types::vector2 pos2d = {100, 200};
game_value val2 = pos2d;
```

### Из игровых объектов

```cpp
// Объект (юнит, техника и т.д.)
types::object player = sqf::player();
game_value val1 = player;

// Группа
types::group grp = sqf::group(player);
game_value val2 = grp;

// Код
types::code code = sqf::compile("hint 'Hello'");
game_value val3 = code;

// Конфиг
types::config cfg = sqf::config_file() >> "CfgWeapons";
game_value val4 = cfg;
```

### Из хэш-карты

```cpp
// rv_hashmap
rv_hashmap map;
map.insert({game_value("key1"), game_value(42)});
map.insert({game_value("key2"), game_value("value")});
game_value val = map;
```

### Пустое значение (nil)

```cpp
game_value empty;              // По умолчанию nil
game_value nil = game_value(); // Явно nil

// Проверка на nil
if (empty.is_nil()) {
    // Значение не инициализировано
}
```

## Извлечение данных

### Неявная конвертация (операторы)

```cpp
game_value val = 42.5f;

// Автоматическая конвертация
int num_int = val;           // 42 (усечение)
float num_float = val;       // 42.5
bool is_true = val;          // true (ненулевое значение)
std::string str = val;       // "42.5"
r_string engine_str = val;   // r_string("42.5")
```

### Конвертация векторов

```cpp
game_value pos = sqf::get_pos(player);

// vector3
types::vector3 pos3d = pos;
float x = pos3d.x;
float y = pos3d.y;
float z = pos3d.z;

// vector2
types::vector2 pos2d = pos;
float x = pos2d.x;
float y = pos2d.y;
```

### Работа с массивами

```cpp
game_value arr = std::vector{1, 2, 3, 4, 5};

// Получить ссылку на массив
auto_array<game_value>& array_data = arr.to_array();

// Доступ по индексу
game_value first = arr[0];        // 1
game_value second = arr[1];       // 2

// Безопасный доступ (возвращает optional)
if (auto element = arr.get(10)) {
    // Элемент существует
    float value = *element;
} else {
    // Индекс вне диапазона
}

// Размер массива
size_t count = arr.size();        // 5

// Итерация
for (auto& element : array_data) {
    float num = element;
    std::cout << num << std::endl;
}
```

### Работа с хэш-картами

```cpp
game_value map_val = /* хэш-карта */;

// Получить ссылку на хэш-карту
rv_hashmap& map = map_val.to_hashmap();

// Итерация
for (auto& pair : map) {
    game_value key = pair.key;
    game_value value = pair.value;
    
    std::cout << std::string(key) << " = " 
              << std::string(value) << std::endl;
}
```

### Доступ к game_data

#### Метод get_as<T>()

`get_as<T>()` - безопасный способ получить типизированный указатель на `game_data`:

```cpp
game_value val = 42.0f;

// Получить типизированный game_data
ref<game_data_number> num_data = val.get_as<game_data_number>();

if (num_data) {
    // Безопасно работать с данными
    float number = num_data->number;        // Чтение
    num_data->number = 100.0f;              // Запись
    
    std::cout << "Number: " << num_data->number << std::endl;
}

// Для других типов
ref<game_data_string> str_data = val.get_as<game_data_string>();
ref<game_data_array> arr_data = val.get_as<game_data_array>();
ref<game_data_object> obj_data = val.get_as<game_data_object>();
ref<game_data_code> code_data = val.get_as<game_data_code>();
```

**Важно**: `get_as<T>()` НЕ проверяет тип! Вернёт `ref<T>` даже если тип неправильный. Всегда проверяйте результат:

```cpp
auto num_data = val.get_as<game_data_number>();

// ✅ Правильно: проверка перед использованием
if (num_data) {
    float value = num_data->number;
}

// ❌ Опасно: использование без проверки
float value = val.get_as<game_data_number>()->number;  // Может быть nullptr!
```

**Альтернатива**: Проверьте тип сначала:

```cpp
if (val.type_enum() == types::game_data_type::SCALAR) {
    auto num_data = val.get_as<game_data_number>();
    // Гарантированно безопасно
    float value = num_data->number;
}
```

#### Прямой доступ к полю data

`game_value` содержит публичное поле `data` типа `ref<game_data>`:

```cpp
class game_value : public serialize_class {
public:
    ref<game_data> data;  // Публичное поле!
    // ...
};
```

**Использование поля data:**

```cpp
game_value val = 42.0f;

// Прямой доступ к ref<game_data>
ref<game_data>& data_ref = val.data;

// Проверка на null
if (val.data) {
    // Данные инициализированы
}

if (val.data.is_null()) {
    // Данные == nullptr
}

// Получить сырой указатель через get()
game_data* raw_ptr = val.data.get();

if (raw_ptr) {
    // Вызов виртуальных методов
    r_string str = raw_ptr->to_string();
    const char* type = raw_ptr->type_as_string();
    uint64_t hash = raw_ptr->get_hash();
}

// Доступ через оператор ->
if (val.data) {
    r_string str = val.data->to_string();
    bool is_nil = val.data->is_nil();
}
```

**Замена данных:**

```cpp
game_value val = 42.0f;

// Полная замена содержимого
val.data = new game_data_string("New value");

// Теперь val содержит строку вместо числа
std::string str = val;  // "New value"

// Очистка
val.data.free();    // Освободить данные
val.data = nullptr; // Установить в null
// Или просто:
val.clear();        // Удобный метод game_value
```

**Прямое приведение типа:**

```cpp
game_value val = 42.0f;

// Через get() получаем сырой указатель
game_data* raw = val.data.get();

// Проверка типа и приведение
if (raw && raw->type_as_string() == std::string("SCALAR")) {
    game_data_number* num = static_cast<game_data_number*>(raw);
    num->number = 100.0f;
}

// Или безопаснее через get_as<>
if (auto num = val.get_as<game_data_number>()) {
    num->number = 100.0f;
}
```

#### Разница между get_as<>() и data.get()

```cpp
game_value val = 42.0f;

// 1. get_as<T>() - возвращает ref<T>
ref<game_data_number> typed_ref = val.get_as<game_data_number>();
// Автоматическое управление памятью
// Можно сохранить и использовать позже

// 2. data.get() - возвращает сырой указатель Type*
game_data* raw_ptr = val.data.get();
// Сырой указатель, осторожно с временем жизни!
// Не сохраняйте надолго без ref<>

// 3. data (само поле) - ref<game_data>
ref<game_data>& data_ref = val.data;
// Ссылка на ref<>, можно использовать все методы ref<>
```

**Когда использовать что:**

- **`get_as<T>()`** - для безопасного получения типизированного `ref<T>`
- **`data.get()`** - для временного доступа к сырому указателю
- **`data` (поле)** - для прямой работы с `ref<game_data>`

#### Пример: Модификация данных

```cpp
game_value val = std::vector{1, 2, 3};

// Способ 1: Через get_as<>
auto arr_data = val.get_as<game_data_array>();
if (arr_data) {
    arr_data->data.push_back(4);
    arr_data->data.push_back(5);
}

// Способ 2: Через поле data
if (val.data) {
    auto* arr = static_cast<game_data_array*>(val.data.get());
    arr->data.push_back(6);
}

// Способ 3: Через to_array() (удобнее для массивов)
auto& arr_ref = val.to_array();
arr_ref.push_back(7);

// Теперь val содержит [1, 2, 3, 4, 5, 6, 7]
```

## Проверка типов

### Проверка через enum

```cpp
game_value val = /* ... */;

// Получить тип
types::game_data_type type = val.type_enum();

// Сравнение
if (type == types::game_data_type::SCALAR) {
    float num = val;
} else if (type == types::game_data_type::STRING) {
    std::string str = val;
} else if (type == types::game_data_type::ARRAY) {
    auto& arr = val.to_array();
}

// Switch
switch (type) {
    case types::game_data_type::SCALAR:
        // Число
        break;
    case types::game_data_type::BOOL:
        // Логическое
        break;
    case types::game_data_type::ARRAY:
        // Массив
        break;
    // ... другие типы
}
```

### Проверка через vtable

```cpp
game_value val = /* ... */;

// Получить vtable указатель
uintptr_t type_ptr = val.type();

// Сравнение с известными типами
if (type_ptr == game_data_number::type_def) {
    // Это точно число
} else if (type_ptr == game_data_string::type_def) {
    // Это точно строка
}
```

### Проверка на nil/null

```cpp
game_value val = /* ... */;

// Проверка на nil (неинициализированное значение)
if (val.is_nil()) {
    // Значение == nil
}

// Проверка на null (для объектов)
if (val.is_null()) {
    // Для объектов: objNull, grpNull и т.д.
    // Для других типов: is_nil() || специфичная проверка
}

// Для объектов отдельно
types::object obj = val;
if (obj.is_null()) {
    // Объект == objNull
}
```

### Получение размера

```cpp
game_value val = /* ... */;

size_t size = val.size();

// Для массивов - количество элементов
// Для строк - длина строки
// Для других типов - 0 или 1
```

## Операторы

### Операторы присваивания

```cpp
game_value val;

// Копирующее присваивание
val = 42.0f;                    // Число
val = "hello";                  // Строка
val = true;                     // Bool
val = std::vector{1, 2, 3};     // Массив
val = sqf::player();            // Объект

// Перемещающее присваивание
game_value other = /* ... */;
val = std::move(other);
```

### Операторы сравнения

```cpp
game_value val1 = 42;
game_value val2 = 42;
game_value val3 = "42";

// Равенство
if (val1 == val2) {  // true (одинаковые значения)
    // ...
}

// Неравенство
if (val1 != val3) {  // true (разные типы)
    // ...
}

// Сравнение с учётом nil
if (val1.is_equalto_with_nil(val2)) {
    // Учитывает nil значения правильно
}
```

### Оператор индексации

```cpp
game_value arr = std::vector{10, 20, 30, 40};

// Доступ по индексу (бросает исключение при ошибке)
game_value first = arr[0];      // 10
game_value second = arr[1];     // 20

// Модификация через индекс
arr[0] = 100;                   // Изменить первый элемент
```

## Продвинутое использование

### Хэширование

```cpp
game_value val = "test";

// Получить хэш
uint64_t hash = val.get_hash();

// Использование в std::unordered_map
std::unordered_map<game_value, int> map;
map[val] = 42;

// std::hash специализирован для game_value
```

### Сериализация

```cpp
// game_value поддерживает сериализацию
game_value val = /* ... */;

param_archive archive(/* ... */);
val.serialize(archive);
```

### Оптимизация move semantics

```cpp
// Эффективное перемещение больших массивов
game_value create_large_array() {
    std::vector<game_value> vec;
    vec.reserve(10000);
    
    for (int i = 0; i < 10000; i++) {
        vec.push_back(i);
    }
    
    return vec;  // Автоматически перемещается, не копируется
}

// Использование
game_value large = create_large_array();  // Быстро!
```

### Детальная информация о доступе к данным

Подробное описание методов доступа к внутренним данным `game_value` см. выше в разделе **"Доступ к game_data"**.

## Исключения и ошибки

### game_value_conversion_error

```cpp
game_value val = "not a number";

try {
    float num = val;  // Попытка конвертировать строку в число
} catch (const game_value_conversion_error& e) {
    std::cerr << "Ошибка конвертации: " << e.what() << std::endl;
}
```

### Безопасные конвертации

```cpp
game_value val = /* ... */;

// Проверка перед конвертацией
if (val.type_enum() == game_data_type::SCALAR) {
    float num = val;  // Безопасно
} else {
    // Обработка ошибки
}

// Использование get() вместо operator[]
if (auto element = val.get(0)) {
    // Элемент существует
} else {
    // Обработка отсутствия элемента
}
```

## Производительность

### Рекомендации

**✅ Хорошо:**

```cpp
// Использование ссылок
void process(const game_value& val) {
    // Нет копирования
}

// Move semantics
game_value create_value() {
    game_value val = /* ... */;
    return val;  // Автоматическое перемещение
}

// Резервирование памяти
auto_array<game_value> arr;
arr.reserve(1000);
for (int i = 0; i < 1000; i++) {
    arr.push_back(i);
}
```

**❌ Плохо:**

```cpp
// Лишнее копирование
void process(game_value val) {  // Копия!
    // ...
}

// Множественные реаллокации
auto_array<game_value> arr;
for (int i = 0; i < 1000; i++) {
    arr.push_back(i);  // Множество реаллокаций
}

// Создание временных объектов в цикле
for (int i = 0; i < 1000; i++) {
    game_value val = sqf::player();  // Каждую итерацию!
    // ...
}
```

### Замеры производительности

| Операция | Время (наносекунды) |
|----------|---------------------|
| Создание пустого game_value | ~10 |
| Создание game_value из int | ~50 |
| Создание game_value из string | ~100 |
| Копирование game_value | ~20 |
| Перемещение game_value | ~5 |
| Доступ к элементу массива | ~30 |
| Конвертация в float | ~20 |
| Проверка типа | ~10 |

## Практические примеры

### Пример 1: Обработка результата SQF функции

```cpp
// Получить все юниты игрока
game_value units = sqf::units(sqf::player());

// Проверить, что это массив
if (units.type_enum() == game_data_type::ARRAY) {
    auto& units_array = units.to_array();
    
    for (auto& unit_val : units_array) {
        types::object unit = unit_val;
        r_string name = sqf::name(unit);
        
        sqf::system_chat("Unit: " + std::string(name));
    }
}
```

### Пример 2: Создание сложной структуры данных

```cpp
// Создать структуру данных для передачи в SQF
game_value player_data = std::vector<game_value>{
    sqf::player(),                                    // Объект игрока
    sqf::name(sqf::player()),                         // Имя
    sqf::damage(sqf::player()),                       // Урон
    sqf::get_pos(sqf::player()),                      // Позиция
    std::vector<game_value>{                          // Инвентарь
        "ItemMap",
        "ItemCompass",
        "ItemWatch"
    }
};

// Передать в SQF
sqf::set_variable(sqf::mission_namespace(), "playerData", player_data);
```

### Пример 3: Работа с return значениями

```cpp
// Вызвать SQF функцию
game_value result = sqf::call(sqf::compile(R"(
    private _data = [];
    for "_i" from 0 to 9 do {
        _data pushBack _i;
    };
    _data
)"));

// Обработать результат
if (!result.is_nil() && result.type_enum() == game_data_type::ARRAY) {
    auto& data = result.to_array();
    
    int sum = 0;
    for (auto& val : data) {
        sum += static_cast<int>(static_cast<float>(val));
    }
    
    std::cout << "Сумма: " << sum << std::endl;  // 45
}
```

### Пример 4: Создание пользовательской функции

```cpp
game_value my_function(game_state& state, game_value_parameter right_arg) {
    // right_arg - это game_value
    
    // Проверка типа входных данных
    if (right_arg.type_enum() != game_data_type::ARRAY) {
        state.set_script_error(
            game_state::game_evaluator::evaluator_error_type::type,
            "Expected ARRAY"
        );
        return {};
    }
    
    // Обработка массива
    auto& input_array = right_arg.to_array();
    std::vector<game_value> output;
    
    for (auto& element : input_array) {
        if (element.type_enum() == game_data_type::SCALAR) {
            float num = element;
            output.push_back(num * 2);
        }
    }
    
    return output;  // Автоматически конвертируется в game_value
}
```

## game_value_static

Специальная версия для статических переменных:

```cpp
// Обычный game_value разрушается при выходе из области видимости
static game_value_static persistent_value = sqf::player();

// Не будет разрушен до конца программы
// Безопасно использовать в статических контекстах
```

## game_value_threadsafe

Потокобезопасная версия (отложенное освобождение памяти):

```cpp
// В другом потоке
std::thread worker([]{
    game_value_threadsafe val = /* ... */;
    // При выходе из области видимости, память не освобождается сразу
    // Будет освобождена при вызове garbage_collect()
});

// В главном потоке (on_frame)
game_value_threadsafe::garbage_collect();
```

## Заключение

`game_value` — это мощный и гибкий контейнер для работы с данными в RVEngine. Правильное использование `game_value` обеспечивает:

- ✅ Безопасную работу с разнородными типами данных
- ✅ Автоматическое управление памятью
- ✅ Высокую производительность
- ✅ Простоту интеграции с SQF

---

**Следующие шаги:**
- [game_data - Базовые типы данных](GAME_DATA.md)
- [Контейнеры](CONTAINERS.md)
- [Конвертация типов](CONVERSIONS.md)


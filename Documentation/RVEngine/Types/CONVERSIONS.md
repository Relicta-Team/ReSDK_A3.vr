# Конвертация типов в RVEngine

Этот документ описывает конвертацию между различными типами данных в RVEngine.

## Обзор системы конвертации

RVEngine поддерживает два вида конвертации:

1. **Неявная (автоматическая)** - через операторы конвертации
2. **Явная** - через функции и методы

## Таблица конвертации

| Из \ В | game_value | int/float | bool | string | array | object | vector3 |
|--------|------------|-----------|------|--------|-------|--------|---------|
| **Примитивы** | ✅ Автоматически | - | - | - | - | - | - |
| **game_value** | - | ✅ operator | ✅ operator | ✅ operator | ✅ to_array() | ✅ operator | ✅ operator |
| **string** | ✅ Конструктор | ❌ | ❌ | - | ❌ | ❌ | ❌ |
| **array** | ✅ Конструктор | ❌ | ❌ | ❌ | - | ❌ | ❌ |
| **object** | ✅ Наследование | ❌ | ❌ | ❌ | ❌ | - | ❌ |
| **vector3** | ✅ Конструктор | ❌ | ❌ | ❌ | ✅ Массив из 3 | ❌ | - |

## Из примитивных типов в game_value

### Числа

```cpp
// int → game_value
game_value val1 = 42;
game_value val2 = static_cast<float>(42);

// float → game_value
game_value val3 = 42.5f;
game_value val4 = 3.14159;

// size_t → game_value
size_t count = 100;
game_value val5 = count;
```

### Логические значения

```cpp
// bool → game_value
game_value val1 = true;
game_value val2 = false;

// Условное выражение
bool condition = (x > 10);
game_value val3 = condition;
```

### Строки

```cpp
// C-string → game_value
game_value val1 = "Hello World";

// std::string → game_value
std::string str = "Test";
game_value val2 = str;

// string_view → game_value
std::string_view sv = "View";
game_value val3 = sv;

// r_string → game_value
r_string engine_str = "Engine";
game_value val4 = engine_str;
```

### Массивы

```cpp
// std::vector → game_value
std::vector<game_value> vec = {1, 2, 3, "four", true};
game_value arr1 = vec;

// Initializer list → game_value
game_value arr2 = {1.0f, 2.0f, 3.0f};

// auto_array → game_value
auto_array<game_value> engine_arr;
engine_arr.push_back(1);
engine_arr.push_back(2);
game_value arr3 = std::move(engine_arr);

// Типизированный массив
std::vector<int> numbers = {1, 2, 3, 4, 5};
std::vector<game_value> gv_numbers(numbers.begin(), numbers.end());
game_value arr4 = gv_numbers;
```

### Векторы

```cpp
// vector3 → game_value
types::vector3 pos3d = {100.0f, 200.0f, 50.0f};
game_value val1 = pos3d;

// vector2 → game_value
types::vector2 pos2d = {100.0f, 200.0f};
game_value val2 = pos2d;
```

### Игровые объекты

```cpp
// object → game_value (через наследование)
types::object player = sqf::player();
game_value val1 = player;

// Другие типы аналогично
types::group grp = sqf::group(player);
game_value val2 = grp;

types::code code = sqf::compile("hint 'test'");
game_value val3 = code;
```

## Из game_value в другие типы

### В числа

```cpp
game_value val = 42.5f;

// Неявная конвертация
float num1 = val;                    // 42.5
int num2 = val;                      // 42 (усечение)

// Явная конвертация
float num3 = static_cast<float>(val);
int num4 = static_cast<int>(static_cast<float>(val));

// Проверка типа перед конвертацией
if (val.type_enum() == types::game_data_type::SCALAR) {
    float num = val;  // Безопасно
}
```

### В логические значения

```cpp
game_value val = true;

// Неявная конвертация
bool flag = val;  // true

// Правила конвертации:
// - true → true
// - false → false
// - Ненулевое число → true
// - Нулевое число → false
// - Непустая строка → true
// - Пустая строка → false

game_value num = 0;
bool is_zero = num;  // false

game_value str = "";
bool is_empty = str;  // false
```

### В строки

```cpp
game_value val = "Hello World";

// Неявная конвертация
std::string str1 = val;

// Явная конвертация
std::string str2 = static_cast<std::string>(val);

// В r_string
r_string str3 = val;

// Для других типов - через to_string()
game_value num = 42.5f;
r_string num_str = num.data->to_string();  // "42.5"
```

### В массивы

```cpp
game_value val = std::vector{1, 2, 3, 4, 5};

// Получить ссылку на массив
auto_array<game_value>& arr = val.to_array();

// Безопасная проверка
if (val.type_enum() == types::game_data_type::ARRAY) {
    auto& arr = val.to_array();
    
    // Доступ к элементам
    game_value first = arr[0];
}

// Конвертация элементов
std::vector<int> numbers;
for (auto& element : val.to_array()) {
    numbers.push_back(static_cast<int>(static_cast<float>(element)));
}
```

### В векторы

```cpp
game_value pos = sqf::get_pos(sqf::player());

// vector3
types::vector3 pos3d = pos;
float x = pos3d.x;
float y = pos3d.y;
float z = pos3d.z;

// vector2
types::vector2 pos2d = pos;
float x2 = pos2d.x;
float y2 = pos2d.y;

// Из массива
game_value arr = std::vector{100.0f, 200.0f, 50.0f};
types::vector3 vec(
    arr[0],
    arr[1],
    arr[2]
);
```

### В игровые объекты

```cpp
game_value val = sqf::player();

// Через оператор конвертации
types::object player = val;

// Проверка на null
if (!player.is_null()) {
    r_string name = sqf::name(player);
}

// Другие типы
game_value grp_val = sqf::group(player);
types::group grp = grp_val;

game_value code_val = sqf::compile("hint 'test'");
types::code code = code_val;
```

## Специализированные конвертации

### game_data к типизированному указателю

```cpp
game_value val = 42.0f;

// Получить типизированный game_data
auto num_data = val.get_as<game_data_number>();
if (num_data) {
    float number = num_data->number;
    num_data->number = 100.0f;  // Модификация
}

// Для других типов
auto str_data = val.get_as<game_data_string>();
auto arr_data = val.get_as<game_data_array>();
auto obj_data = val.get_as<game_data_object>();
```

### Хэш-карты

```cpp
game_value map_val = /* хэш-карта из SQF */;

// Получить хэш-карту
rv_hashmap& map = map_val.to_hashmap();

// Итерация
for (auto& pair : map) {
    game_value key = pair.key;
    game_value value = pair.value;
    
    // Конвертация ключа и значения
    std::string key_str = key;
    float value_num = value;
}
```

### Составные конвертации

```cpp
// Массив позиций → std::vector<vector3>
game_value positions = /* массив из SQF */;

std::vector<types::vector3> pos_list;
for (auto& pos_val : positions.to_array()) {
    if (pos_val.type_enum() == types::game_data_type::ARRAY) {
        types::vector3 pos = pos_val;
        pos_list.push_back(pos);
    }
}

// Объекты → имена → std::vector<string>
game_value units = sqf::units(sqf::player());

std::vector<std::string> names;
for (auto& unit_val : units.to_array()) {
    types::object unit = unit_val;
    r_string name = sqf::name(unit);
    names.push_back(std::string(name));
}
```

## Обработка ошибок конвертации

### game_value_conversion_error

```cpp
game_value val = "not a number";

try {
    float num = val;  // Попытка конвертировать строку в число
} catch (const game_value_conversion_error& e) {
    std::cerr << "Ошибка: " << e.what() << std::endl;
    // Обработка ошибки
}
```

### Безопасная конвертация

```cpp
float safe_to_float(const game_value& val, float default_value = 0.0f) {
    if (val.type_enum() == types::game_data_type::SCALAR) {
        return val;
    } else if (val.type_enum() == types::game_data_type::BOOL) {
        bool b = val;
        return b ? 1.0f : 0.0f;
    } else if (val.type_enum() == types::game_data_type::STRING) {
        try {
            std::string str = val;
            return std::stof(str);
        } catch (...) {
            return default_value;
        }
    }
    return default_value;
}

// Использование
game_value val = "42.5";
float num = safe_to_float(val);  // 42.5
```

### Проверка перед конвертацией

```cpp
game_value val = /* ... */;

// Проверка типа
if (val.type_enum() == types::game_data_type::SCALAR) {
    float num = val;  // Безопасно
} else if (val.type_enum() == types::game_data_type::ARRAY) {
    auto& arr = val.to_array();  // Безопасно
} else {
    // Неподдерживаемый тип
}

// Проверка на nil
if (!val.is_nil()) {
    // Значение инициализировано
}

// Проверка на null (для объектов)
types::object obj = val;
if (!obj.is_null()) {
    // Объект валиден
}
```

## Производительность конвертаций

| Конвертация | Сложность | Комментарий |
|-------------|-----------|-------------|
| Примитив → game_value | O(1) | Быстро, создание game_data |
| game_value → примитив | O(1) | Очень быстро, чтение поля |
| string → game_value | O(n) | Копирование строки |
| game_value → string | O(n) | Копирование строки |
| array → game_value | O(n) | Копирование элементов |
| game_value → array | O(1) | Получение ссылки |
| object → game_value | O(1) | Наследование, нет конвертации |

### Оптимизация

```cpp
// ✅ Хорошо: избегаем копирования
void process(const game_value& val) {
    if (val.type_enum() == types::game_data_type::ARRAY) {
        auto& arr = val.to_array();  // Ссылка, нет копирования
        // Работа с arr
    }
}

// ❌ Плохо: лишнее копирование
void process_bad(game_value val) {  // Копия!
    if (val.type_enum() == types::game_data_type::ARRAY) {
        auto arr = val.to_array();  // Ещё одна копия!
        // Работа с arr
    }
}

// ✅ Хорошо: кэшируем конвертации
types::object player = sqf::player();
types::vector3 pos = sqf::get_pos(player);

for (int i = 0; i < 100; i++) {
    // Используем кэшированные значения
    if (pos.x > 1000) { /*...*/ }
}

// ❌ Плохо: множественные конвертации
for (int i = 0; i < 100; i++) {
    types::object player = sqf::player();  // Каждую итерацию!
    types::vector3 pos = sqf::get_pos(player);  // Каждую итерацию!
}
```

## Практические примеры

### Универсальная функция обработки

```cpp
game_value process_value(const game_value& val) {
    switch (val.type_enum()) {
        case types::game_data_type::SCALAR: {
            float num = val;
            return num * 2;
        }
        case types::game_data_type::STRING: {
            std::string str = val;
            return str + " processed";
        }
        case types::game_data_type::ARRAY: {
            auto& arr = val.to_array();
            std::vector<game_value> result;
            for (auto& element : arr) {
                result.push_back(process_value(element));
            }
            return result;
        }
        default:
            return val;  // Без изменений
    }
}
```

### Конвертация структурированных данных

```cpp
// SQF массив [имя, возраст, позиция] → C++ структура
struct PlayerData {
    std::string name;
    int age;
    types::vector3 position;
};

PlayerData from_game_value(const game_value& val) {
    if (val.type_enum() != types::game_data_type::ARRAY) {
        throw std::runtime_error("Expected array");
    }
    
    auto& arr = val.to_array();
    if (arr.size() < 3) {
        throw std::runtime_error("Array too small");
    }
    
    PlayerData data;
    data.name = std::string(arr[0]);
    data.age = static_cast<int>(static_cast<float>(arr[1]));
    data.position = arr[2];
    
    return data;
}

// C++ структура → SQF массив
game_value to_game_value(const PlayerData& data) {
    return std::vector<game_value>{
        data.name,
        data.age,
        data.position
    };
}
```

## Заключение

Система конвертации типов RVEngine обеспечивает:

- ✅ Удобную работу между C++ и SQF типами
- ✅ Автоматическую конвертацию где возможно
- ✅ Безопасность через проверки типов
- ✅ Высокую производительность

**Ключевые принципы:**
1. Проверяйте типы перед конвертацией
2. Используйте ссылки для избежания копирования
3. Кэшируйте часто используемые значения
4. Обрабатывайте ошибки конвертации

---

**Следующие шаги:**
- [game_value](GAME_VALUE.md)
- [Клиентские типы](CLIENT_TYPES.md)
- [Примеры использования](../Examples/README.md)


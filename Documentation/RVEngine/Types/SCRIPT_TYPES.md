# sqf_script_type - Система типов SQF

## Обзор

`sqf_script_type` содержит метаданные о типах данных в системе SQF. Эта информация используется для проверки типов, регистрации функций и создания новых типов.

```cpp
class sqf_script_type : public serialize_class {
public:
    const script_type_info* single_type;           // Простой тип
    compound_script_type_info* compound_type;       // Составной тип
    uint64_t bitmask;                              // Битовая маска для быстрой проверки
    
    value_types type() const;          // Набор имён типов
    r_string type_str() const;         // Строковое представление
    void update_bitmask();             // Обновить битовую маску
};
```

## script_type_info

Информация о конкретном типе данных:

```cpp
struct script_type_info {
    using createFunc = game_data* (*)(param_archive* ar);
    
    r_string _name;             // "SCALAR", "ARRAY", "OBJECT" и т.д.
    createFunc _createFunction; // Функция создания экземпляра
    r_string _localizedName;    // "@STR_EVAL_TYPESCALAR"
    r_string _readableName;     // "Number", "Array", "Object"
    r_string _description;      // "A real number."
    r_string _category;         // "Default"
    r_string _typeName;         // "float", "NativeObject"
    uint64_t _bitmask;         // Битовая маска типа
};
```

### Встроенные типы

| Имя | Читаемое имя | Описание |
|-----|--------------|----------|
| SCALAR | Number | Числа с плавающей точкой |
| BOOL | Boolean | Логические значения |
| ARRAY | Array | Массивы game_value |
| STRING | String | Строки |
| NOTHING | Nothing | Nil/Nothing |
| NAMESPACE | Namespace | Пространства имён |
| CODE | Code | Скомпилированный код |
| OBJECT | Object | Игровые объекты |
| SIDE | Side | Стороны (west, east и т.д.) |
| GROUP | Group | Группы |
| TEXT | Structured Text | Форматированный текст |
| CONFIG | Config | Конфигурационные записи |
| DISPLAY | Display | UI дисплеи |
| CONTROL | Control | UI контролы |
| LOCATION | Location | Локации на карте |
| TASK | Task | Задачи |
| HASHMAP | HashMap | Хэш-карты |

## Простые и составные типы

### Простой тип

Представляет один конкретный тип:

```cpp
// Создание простого типа (SCALAR)
const script_type_info* scalar_info = /* получить из движка */;
sqf_script_type scalar_type(scalar_info);

// Проверка
value_types types = scalar_type.type();
// types содержит {"SCALAR"}

r_string type_str = scalar_type.type_str();
// "SCALAR"
```

### Составной тип (Compound)

Представляет несколько возможных типов:

```cpp
// Создание составного типа (SCALAR | ARRAY | STRING)
auto_array<const script_type_info*> type_list;
type_list.push_back(scalar_info);
type_list.push_back(array_info);
type_list.push_back(string_info);

compound_script_type_info* compound = new compound_script_type_info(type_list);
sqf_script_type any_type(type_def_vtable, nullptr, compound);

// Проверка
value_types types = any_type.type();
// types содержит {"SCALAR", "ARRAY", "STRING"}

r_string type_str = any_type.type_str();
// "SCALAR | ARRAY | STRING"
```

### compound_script_type_info

```cpp
struct compound_script_type_info : public auto_array<const script_type_info*> {
    compound_script_type_info(const auto_array<const script_type_info*>& types) {
        reserve(types.size());
        insert(begin(), types.begin(), types.end());
    }
};
```

## Битовые маски

Каждый тип имеет уникальную битовую маску для быстрой проверки:

```cpp
sqf_script_type type1 = /* ... */;
sqf_script_type type2 = /* ... */;

// Сравнение масок
if (type1.bitmask & type2.bitmask) {
    // Типы совместимы или пересекаются
}

// Обновление маски
type1.update_bitmask();
```

## Регистрация пользовательских типов

### Шаг 1: Подготовка функции создания

```cpp
game_data* create_my_type(param_archive* ar) {
    auto* instance = new my_custom_type();
    if (ar) {
        instance->serialize(*ar);
    }
    return instance;
}
```

### Шаг 2: Регистрация через Host API

```cpp
void intercept::pre_init() {
    // Регистрация нового типа
    auto [type_enum, script_type] = client::host::register_sqf_type(
        "MY_TYPE",                              // Внутреннее имя (заглавными)
        "Мой пользовательский тип",             // Локализованное имя
        "Описание моего типа данных",           // Описание
        "MyType",                               // Читаемое имя
        create_my_type                          // Функция создания
    );
    
    // Сохранить type_def
    my_custom_type::type_def = script_type->get_vtable();
    
    // type_enum - новый game_data_type enum (если нужно)
    // script_type - sqf_script_type* для использования
}
```

### Шаг 3: Использование зарегистрированного типа

```cpp
// В конструкторе вашего типа
my_custom_type::my_custom_type() {
    *reinterpret_cast<uintptr_t*>(this) = type_def;
    *reinterpret_cast<uintptr_t*>(static_cast<I_debug_value*>(this)) = data_type_def;
}

// В методе type()
const sqf_script_type& my_custom_type::type() const {
    static sqf_script_type _type(/* полученный script_type */);
    return _type;
}
```

## Проверка типов

### Сравнение sqf_script_type

```cpp
sqf_script_type type1 = /* ... */;
sqf_script_type type2 = /* ... */;

// Оператор ==
if (type1 == type2) {
    // Типы идентичны
}

// Оператор !=
if (type1 != type2) {
    // Типы различны
}
```

### Получение типа из game_value

```cpp
game_value val = 42.0f;

// Через game_data
if (val.data) {
    const sqf_script_type& type = val.data->type();
    r_string type_name = type.type_str();  // "SCALAR"
}
```

### Проверка совместимости

```cpp
bool is_compatible(const sqf_script_type& expected, const sqf_script_type& actual) {
    // Проверка через битовую маску
    if (expected.bitmask & actual.bitmask) {
        return true;
    }
    
    // Или через сравнение типов
    value_types expected_types = expected.type();
    value_types actual_types = actual.type();
    
    // Проверить пересечение множеств
    for (const auto& exp_type : expected_types) {
        if (actual_types.count(exp_type) > 0) {
            return true;
        }
    }
    
    return false;
}
```

## Составные типы для команд

При регистрации SQF команд можно использовать составные типы:

```cpp
// Функция принимает SCALAR ИЛИ ARRAY
game_value my_command(game_state& state, game_value_parameter right_arg) {
    if (right_arg.type_enum() == game_data_type::SCALAR) {
        float num = right_arg;
        // Обработка числа
    } else if (right_arg.type_enum() == game_data_type::ARRAY) {
        auto& arr = right_arg.to_array();
        // Обработка массива
    }
    return {};
}

// Регистрация с составным типом
void intercept::pre_init() {
    // Получить составной тип (SCALAR | ARRAY)
    auto_array<types::game_data_type> accepted_types;
    accepted_types.push_back(types::game_data_type::SCALAR);
    accepted_types.push_back(types::game_data_type::ARRAY);
    
    sqf_script_type* compound_type = client::host::register_compound_sqf_type(accepted_types);
    
    // Зарегистрировать команду (используя low-level API)
    // Обычно используются enum типы, но можно и sqf_script_type*
}
```

## Получение информации о типе

### Из game_state

```cpp
void my_function(game_state& state, game_value_parameter arg) {
    // Получить все зарегистрированные типы
    const auto& script_types = state.get_script_types();
    
    // Итерация по типам
    for (const auto* type_info : script_types) {
        r_string name = type_info->_name;
        r_string readable = type_info->_readableName;
        // ...
    }
}
```

### Поиск типа по имени

```cpp
const script_type_info* find_type(const r_string& name, game_state& state) {
    const auto& types = state.get_script_types();
    
    for (const auto* type_info : types) {
        if (type_info->_name == name) {
            return type_info;
        }
    }
    
    return nullptr;
}

// Использование
const script_type_info* scalar_info = find_type("SCALAR", state);
if (scalar_info) {
    // Тип найден
}
```

## value_types

Множество (set) строк с именами типов:

```cpp
typedef std::set<r_string> value_types;

// Использование
sqf_script_type type = /* ... */;
value_types types = type.type();

// Проверка наличия типа
if (types.count("SCALAR") > 0) {
    // Тип содержит SCALAR
}

// Итерация
for (const r_string& type_name : types) {
    std::cout << std::string(type_name) << std::endl;
}
```

## Примеры

### Проверка типа аргумента функции

```cpp
game_value my_command(game_state& state, game_value_parameter right_arg) {
    // Получить тип аргумента
    const sqf_script_type& arg_type = right_arg.data->type();
    value_types types = arg_type.type();
    
    // Проверить, что это SCALAR
    if (types.count("SCALAR") == 0) {
        state.set_script_error(
            game_state::game_evaluator::evaluator_error_type::type,
            "Expected SCALAR, got " + arg_type.type_str()
        );
        return {};
    }
    
    float number = right_arg;
    return number * 2;
}
```

### Создание универсальной функции

```cpp
game_value universal_command(game_state& state, game_value_parameter right_arg) {
    const sqf_script_type& arg_type = right_arg.data->type();
    r_string type_name = arg_type.type_str();
    
    if (type_name == "SCALAR") {
        return handle_scalar(right_arg);
    } else if (type_name == "STRING") {
        return handle_string(right_arg);
    } else if (type_name == "ARRAY") {
        return handle_array(right_arg);
    } else {
        // Неподдерживаемый тип
        return {};
    }
}
```

## Производительность

### Сравнение методов проверки типов

| Метод | Скорость | Использование |
|-------|----------|---------------|
| Битовая маска | Самый быстрый | Простые проверки |
| type_enum() | Быстрый | Большинство случаев |
| type().count() | Средний | Составные типы |
| type_str() | Медленный | Отладка, логирование |

### Рекомендации

```cpp
// ✅ Быстро: Используйте enum
if (val.type_enum() == game_data_type::SCALAR) { /*...*/ }

// ✅ Быстро: Битовая маска
if (type1.bitmask & type2.bitmask) { /*...*/ }

// ⚠️ Средне: Проверка множества
if (type.type().count("SCALAR") > 0) { /*...*/ }

// ❌ Медленно: Строковое сравнение
if (type.type_str() == "SCALAR") { /*...*/ }
```

## Заключение

`sqf_script_type` обеспечивает:

- ✅ Метаданные о типах данных
- ✅ Проверку совместимости типов
- ✅ Регистрацию пользовательских типов
- ✅ Поддержку составных типов

---

**Следующие шаги:**
- [Контейнеры](CONTAINERS.md)
- [game_data](GAME_DATA.md)
- [Создание пользовательских типов](../API/CUSTOM_TYPES.md)


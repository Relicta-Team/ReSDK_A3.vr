# Система типов RVEngine

Этот раздел описывает систему типов данных в RVEngine, которая является фундаментом для работы с Arma 3.

## Обзор

RVEngine предоставляет C++ обёртки над внутренними типами движка Real Virtuality. Система типов спроектирована так, чтобы:

- ✅ Обеспечить безопасную работу с памятью через reference counting
- ✅ Автоматически конвертировать между C++ и SQF типами
- ✅ Предоставить удобный API для манипуляции данными
- ✅ Поддерживать все нативные типы данных Arma 3

## Иерархия типов

```
serialize_class (базовый класс для сериализации)
    │
    ├── game_data (refcount, I_debug_value)
    │   ├── game_data_number          (числа: float)
    │   ├── game_data_bool            (логические значения)
    │   ├── game_data_string          (строки: r_string)
    │   ├── game_data_array           (массивы)
    │   ├── game_data_hashmap         (хэш-карты)
    │   ├── game_data_code            (код/скрипты)
    │   ├── game_data_object          (игровые объекты)
    │   ├── game_data_group           (группы)
    │   ├── game_data_config          (конфиги)
    │   ├── game_data_control         (UI контролы)
    │   ├── game_data_display         (UI дисплеи)
    │   ├── game_data_location        (локации)
    │   ├── game_data_side            (стороны)
    │   ├── game_data_namespace       (пространства имён)
    │   └── ... (другие типы)
    │
    ├── game_value (универсальный контейнер)
    │   └── ref<game_data> data
    │
    └── sqf_script_type (информация о типе)
        ├── script_type_info* single_type
        └── compound_script_type_info* compound_type
```

## Основные компоненты

### 1. [game_value](GAME_VALUE.md)

Универсальный контейнер, способный хранить любой тип данных:

```cpp
game_value val = 42.0f;              // число
game_value val = "hello";            // строка
game_value val = true;               // bool
game_value val = std::vector{1,2,3}; // массив
```

**Ключевые особенности:**
- Автоматическая конвертация типов
- Reference counting для управления памятью
- Проверка типов во время выполнения
- Поддержка всех типов SQF

### 2. [game_data](GAME_DATA.md)

Базовый класс для всех типов данных движка:

```cpp
class game_data : public refcount, public I_debug_value {
public:
    virtual const sqf_script_type& type() const;
    virtual ~game_data();
    virtual game_data* copy() const;
    virtual r_string to_string() const;
    // ... другие виртуальные методы
};
```

**Производные типы:**
- `game_data_number` - числа
- `game_data_bool` - логические значения
- `game_data_string` - строки
- `game_data_array` - массивы
- `game_data_object` - игровые объекты
- и другие...

### 3. [sqf_script_type](SCRIPT_TYPES.md)

Информация о типе данных в системе SQF:

```cpp
class sqf_script_type {
public:
    const script_type_info* single_type;       // Простой тип
    compound_script_type_info* compound_type;   // Составной тип
    uint64_t bitmask;                          // Битовая маска типа
    
    value_types type() const;      // Получить набор имён типов
    r_string type_str() const;     // Строковое представление
};
```

### 4. [Контейнеры](CONTAINERS.md)

Специализированные контейнеры для работы с данными:

- **auto_array<T>** - динамический массив с аллокатором движка
- **r_string** - строка с подсчётом ссылок
- **rv_hashmap** - хэш-карта для пар ключ-значение

### 5. [Клиентские типы](CLIENT_TYPES.md)

Обёртки для удобной работы с игровыми объектами:

```cpp
types::object player = sqf::player();
types::group grp = sqf::group(player);
types::code code = sqf::compile("hint 'Hello'");
types::config cfg = sqf::config_file() >> "CfgWeapons";
```

**Доступные типы:**
- `object` - игровые объекты (юниты, техника и т.д.)
- `group` - группы
- `code` - код/скрипты
- `config` - конфигурационные записи
- `control` - UI контролы
- `display` - UI дисплеи
- `location` - локации
- `side` - стороны
- `task` - задачи
- и другие...

### 6. [Конвертация типов](CONVERSIONS.md)

Автоматическая и явная конвертация между типами:

```cpp
// Автоматическая конвертация
game_value val = 42.0f;
float num = val;                    // Автоматически

// Явная конвертация
std::string str = static_cast<std::string>(val);

// Через операторы
auto& arr = val.to_array();
auto& map = val.to_hashmap();
```

## Управление памятью

### Reference Counting

Все типы данных используют подсчёт ссылок:

```cpp
template<typename Type>
class ref {
    Type* _ref;
public:
    ref() : _ref(nullptr) {}
    
    ref(Type* new_ref) : _ref(new_ref) {
        if (_ref) _ref->add_ref();  // Увеличить счётчик
    }
    
    ~ref() {
        if (_ref) _ref->release();   // Уменьшить счётчик
    }
    
    // Автоматическое управление временем жизни
};
```

### Аллокаторы

RVEngine использует аллокаторы движка для совместимости:

```cpp
// Выделение через движок
rv_allocator<Type>::create_single();
rv_allocator<Type>::destroy_deallocate(ptr);

// Pool аллокаторы для частых типов
game_data_number::operator new(size);
game_data_number::operator delete(ptr, size);
```

## Типобезопасность

### Проверка типов во время выполнения

```cpp
game_value val = /* ... */;

// Проверка типа через enum
if (val.type_enum() == game_data_type::SCALAR) {
    float num = val;
}

// Проверка типа через vtable
if (val.type() == game_data_number::type_def) {
    // Это точно число
}

// Безопасное получение типизированных данных
if (auto num_data = val.get_as<game_data_number>()) {
    float number = num_data->number;
}
```

### Доступные типы (game_data_type enum)

```cpp
enum class game_data_type {
    SCALAR,          // Числа
    BOOL,            // Логические значения
    ARRAY,           // Массивы
    STRING,          // Строки
    NOTHING,         // Nil/Nothing
    ANY,             // Любой тип
    NAMESPACE,       // Пространства имён
    NaN,             // Not a Number
    CODE,            // Код/скрипты
    OBJECT,          // Игровые объекты
    SIDE,            // Стороны
    GROUP,           // Группы
    TEXT,            // Structured Text
    SCRIPT,          // Скрипты
    TARGET,          // Цели
    CONFIG,          // Конфигурация
    DISPLAY,         // UI дисплеи
    CONTROL,         // UI контролы
    NetObject,       // Сетевые объекты
    SUBGROUP,        // Подгруппы
    TEAM_MEMBER,     // Члены команды
    TASK,            // Задачи
    DIARY_RECORD,    // Записи дневника
    LOCATION,        // Локации
    HASHMAP,         // Хэш-карты
    end              // Маркер конца
};
```

## Примеры использования

### Работа с числами

```cpp
game_value num = 42.5f;
float value = num;                  // 42.5
int rounded = static_cast<int>(value); // 42

// Через game_data
auto data = num.get_as<game_data_number>();
data->number = 100.0f;
```

### Работа со строками

```cpp
game_value str = "Hello World";
std::string cpp_str = str;          // "Hello World"
r_string engine_str = str;          // r_string

sqf::hint(str);                     // Вывести hint в игре
```

### Работа с массивами

```cpp
game_value arr = std::vector<game_value>{1, 2, 3, "four", true};

// Доступ по индексу
game_value first = arr[0];          // 1
game_value second = arr[1];         // 2

// Размер
size_t size = arr.size();           // 5

// Получить ссылку на массив
auto& array_data = arr.to_array();
for (auto& element : array_data) {
    // Обработка элементов
}
```

### Работа с объектами

```cpp
types::object player = sqf::player();

// Проверка на null
if (player.is_null()) {
    sqf::hint("Нет игрока");
    return;
}

// Получение данных
types::vector3 pos = sqf::get_pos(player);
r_string name = sqf::name(player);

// Установка данных
sqf::set_pos(player, {100, 100, 0});
```

### Создание пользовательских типов

```cpp
class my_custom_type : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    
    int my_value;
    r_string my_name;
    
    // Переопределение виртуальных методов
    const sqf_script_type& type() const override {
        static sqf_script_type _type(/* ... */);
        return _type;
    }
    
    r_string to_string() const override {
        return "MyType: " + my_name;
    }
    
    // ... другие методы
};
```

## Производительность

### Сравнение с SQF

| Операция | SQF | RVEngine | Улучшение |
|----------|-----|----------|-----------|
| Создание переменной | 1x | ~5x | 5x быстрее |
| Доступ к элементу массива | 1x | ~20x | 20x быстрее |
| Конвертация типов | 1x | ~50x | 50x быстрее |
| Создание объекта | 1x | ~10x | 10x быстрее |

### Советы по оптимизации

1. **Избегайте лишних копирований**
   ```cpp
   // Плохо - копирование
   game_value val = some_value;
   process(val);
   
   // Хорошо - ссылка
   const game_value& val = some_value;
   process(val);
   ```

2. **Используйте move semantics**
   ```cpp
   game_value create_value() {
       game_value val = std::vector{1, 2, 3};
       return val;  // Автоматически перемещается
   }
   ```

3. **Кэшируйте часто используемые значения**
   ```cpp
   // Плохо - каждый раз получаем игрока
   for (int i = 0; i < 100; i++) {
       types::object player = sqf::player();  // Медленно!
       // ...
   }
   
   // Хорошо - получаем один раз
   types::object player = sqf::player();
   for (int i = 0; i < 100; i++) {
       // Используем кэшированное значение
   }
   ```

4. **Резервируйте память для массивов**
   ```cpp
   auto_array<game_value> arr;
   arr.reserve(1000);  // Избежать реаллокаций
   
   for (int i = 0; i < 1000; i++) {
       arr.push_back(i);
   }
   ```

## Отладка типов

### Получение информации о типе

```cpp
game_value val = /* ... */;

// Тип через enum
game_data_type type = val.type_enum();
std::cout << "Type enum: " << static_cast<int>(type) << std::endl;

// Тип через string
if (val.data) {
    const char* type_str = val.data->type_as_string();
    std::cout << "Type: " << type_str << std::endl;
}

// Строковое представление значения
r_string str_repr = val.data->to_string();
std::cout << "Value: " << std::string(str_repr) << std::endl;
```

### ArmaDebugEngine интеграция

RVEngine поддерживает интеграцию с ArmaDebugEngine для отладки:

```cpp
class I_debug_value {
public:
    virtual void getTypeStr(char* buffer, int len) const = 0;
    virtual void getValue(unsigned int base, char* buffer, int len) const = 0;
    virtual bool isArray() const = 0;
    virtual int itemCount() const = 0;
    virtual RefType getItem(int i) const = 0;
};
```

## Документация разделов

### Подробные руководства

1. **[game_value - Универсальный контейнер](GAME_VALUE.md)**
   - Создание и инициализация
   - Операторы конвертации
   - Доступ к данным
   - Проверка типов

2. **[game_data - Базовые типы данных](GAME_DATA.md)**
   - Иерархия классов
   - Создание собственных типов
   - Виртуальные методы
   - Сериализация

3. **[sqf_script_type - Система типов SQF](SCRIPT_TYPES.md)**
   - Простые и составные типы
   - Регистрация типов
   - Проверка совместимости типов

4. **[Контейнеры (auto_array, r_string, rv_hashmap)](CONTAINERS.md)**
   - auto_array - динамический массив
   - r_string - строки с refcount
   - rv_hashmap - хэш-карты
   - Аллокаторы и память

5. **[Клиентские типы (object, group, code и др.)](CLIENT_TYPES.md)**
   - Обёртки для игровых типов
   - Специализированные методы
   - Безопасная работа с null-объектами

6. **[Конвертация между типами](CONVERSIONS.md)**
   - Автоматическая конвертация
   - Явная конвертация
   - Проверка возможности конвертации
   - Обработка ошибок

## Следующие шаги

После изучения системы типов рекомендуется:

1. [API для плагинов](../API/README.md) - Использование типов в плагинах
2. [Примеры](../Examples/README.md) - Практические примеры работы с типами
3. [Управление памятью](../Reference/MEMORY_MANAGEMENT.md) - Детали работы с памятью

---

**Важно**: Понимание системы типов критично для эффективной работы с RVEngine. Уделите время изучению каждого раздела.


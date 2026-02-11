# game_data - Базовые типы данных

## Обзор

`game_data` — базовый класс для всех типов данных в RVEngine. Каждый конкретный тип (число, строка, массив и т.д.) наследуется от этого класса.

```cpp
class game_data : public refcount, public __internal::I_debug_value {
public:
    virtual const sqf_script_type& type() const;
    virtual ~game_data();
    virtual game_data* copy() const;
    virtual r_string to_string() const;
    virtual bool equals(const game_data*) const;
    virtual const char* type_as_string() const;
    virtual bool is_nil() const;
    virtual uint64_t get_hash() const;
    virtual serialization_return serialize(param_archive& ar);
    // ... другие виртуальные методы
};
```

## Иерархия типов

```
game_data (базовый класс)
├── game_data_number (float)
├── game_data_bool (bool)
├── game_data_string (r_string)
├── game_data_array (auto_array<game_value>)
├── game_data_hashmap (rv_hashmap)
├── game_data_code (r_string + instructions)
├── game_data_object (внутренний указатель на объект)
├── game_data_group (указатель на группу)
├── game_data_config (указатель на конфиг)
├── game_data_control (указатель на UI контрол)
├── game_data_display (указатель на UI дисплей)
├── game_data_location (указатель на локацию)
├── game_data_side (указатель на сторону)
├── game_data_namespace (переменные + имя)
├── game_data_nothing (nil)
├── game_data_script (указатель на скрипт)
├── game_data_rv_text (Structured Text)
└── game_data_team_member (член команды)
```

## Встроенные типы

### game_data_number

Представляет числа с плавающей точкой:

```cpp
class game_data_number : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    static rv_pool_allocator* pool_alloc_base;
    
    float number;  // Хранимое значение
    
    game_data_number() noexcept;
    game_data_number(float val_) noexcept;
    
    static void* operator new(std::size_t sz_);
    static void operator delete(void* ptr_, std::size_t sz_);
};

// Использование
auto num = new game_data_number(42.5f);
float value = num->number;  // 42.5
```

### game_data_bool

Представляет логические значения:

```cpp
class game_data_bool : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    static rv_pool_allocator* pool_alloc_base;
    
    bool val;  // true или false
    
    game_data_bool();
    game_data_bool(bool val_);
    
    static void* operator new(std::size_t sz_);
    static void operator delete(void* ptr_, std::size_t sz_);
};

// Использование
auto boolean = new game_data_bool(true);
bool value = boolean->val;  // true
```

### game_data_string

Представляет строки:

```cpp
class game_data_string : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    static rv_pool_allocator* pool_alloc_base;
    
    r_string raw_string;  // Строка с refcount
    
    game_data_string() noexcept;
    game_data_string(const std::string& str_);
    game_data_string(const r_string& str_);
    ~game_data_string();
    
    static void* operator new(std::size_t sz_);
    static void operator delete(void* ptr_, std::size_t sz_);
};

// Использование
auto str = new game_data_string("Hello World");
r_string value = str->raw_string;
```

### game_data_array

Представляет массивы:

```cpp
class game_data_array : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    static rv_pool_allocator* pool_alloc_base;
    
    auto_array<game_value> data;  // Элементы массива
    
    game_data_array();
    game_data_array(size_t size_);
    game_data_array(const std::vector<game_value>& init_);
    game_data_array(auto_array<game_value>&& init_);
    ~game_data_array();
    
    auto length() const { return data.size(); }
    
    static void* operator new(std::size_t sz_);
    static void operator delete(void* ptr_, std::size_t sz_);
};

// Использование
auto arr = new game_data_array();
arr->data.push_back(1);
arr->data.push_back(2);
arr->data.push_back(3);
size_t len = arr->length();  // 3
```

### game_data_hashmap

Представляет хэш-карты (HashMap):

```cpp
class game_data_hashmap : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    static rv_pool_allocator* pool_alloc_base;
    
    rv_hashmap data;  // Хэш-карта с game_value ключами и значениями
    
    game_data_hashmap();
    game_data_hashmap(rv_hashmap&& init_);
    game_data_hashmap(const rv_hashmap& copy_);
    ~game_data_hashmap();
    
    static void* operator new(std::size_t sz_);
    static void operator delete(void* ptr_, std::size_t sz_);
};

// Использование
auto map = new game_data_hashmap();
map->data.insert({game_value("key"), game_value(42)});
```

### game_data_code

Представляет SQF код:

```cpp
class game_data_code : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    static rv_pool_allocator* pool_alloc_base;
    
    r_string code_string;                        // Исходный код
    auto_array<ref<game_instruction>> instructions;  // Скомпилированные инструкции
    
    game_data_code() noexcept;
    
    static void* operator new(std::size_t sz_);
    static void operator delete(void* ptr_, std::size_t sz_);
};

// Использование
auto code = sqf::compile("hint 'Hello'");
auto code_data = code.get_as<game_data_code>();
r_string source = code_data->code_string;  // "hint 'Hello'"
```

### game_data_object

Представляет игровые объекты (юниты, техника):

```cpp
class game_data_object : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    
    struct {
        uint32_t _x;
        void* object;  // Внутренний указатель движка
    } * object;
    
    game_data_object() noexcept;
    
    // Специальные методы (Windows only)
    visualState get_position_matrix() const noexcept;
    visual_head_pos get_head_pos() const;
};

// Использование
types::object player = sqf::player();
auto obj_data = player.get_as<game_data_object>();
bool is_null = (obj_data->object == nullptr || obj_data->object->object == nullptr);
```

### game_data_group

Представляет группы:

```cpp
class game_data_group : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    
    void* group;  // Внутренний указатель на группу
    
    game_data_group() noexcept;
};
```

### game_data_config

Представляет конфигурационные записи:

```cpp
class game_data_config : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    
    struct config_internal;
    config_internal* config;
    
    game_data_config() noexcept;
    
    bool is_null() const {
        return config == nullptr || config->_entry == nullptr;
    }
};

// Использование
types::config cfg = sqf::config_file() >> "CfgWeapons";
auto cfg_data = cfg.get_as<game_data_config>();
if (!cfg_data->is_null()) {
    // Конфиг валиден
}
```

### game_data_namespace

Представляет пространства имён (переменные):

```cpp
class game_data_namespace : public game_data, public dummy_vtable_class {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    
    map_string_to_class<game_variable, auto_array<game_variable>> _variables;
    r_string _name;
    bool _1;
    
    game_data_namespace() noexcept;
};

// Использование
types::rv_namespace ns = sqf::mission_namespace();
auto ns_data = ns.get_as<game_data_namespace>();
r_string name = ns_data->_name;
```

### game_data_nothing

Представляет nil/nothing:

```cpp
class game_data_nothing : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    
    game_data_nothing() noexcept;
    
    static uint64_t hash() { return 0xCBF29CE484222325; }
};
```

## Создание пользовательских типов

### Шаг 1: Определение класса

```cpp
class my_custom_type : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    static rv_pool_allocator* pool_alloc_base;
    
    // Ваши данные
    int my_integer;
    r_string my_string;
    std::vector<float> my_array;
    
    my_custom_type() {
        *reinterpret_cast<uintptr_t*>(this) = type_def;
        *reinterpret_cast<uintptr_t*>(static_cast<I_debug_value*>(this)) = data_type_def;
    }
    
    // Переопределение виртуальных методов
    const sqf_script_type& type() const override;
    r_string to_string() const override;
    bool equals(const game_data* other) const override;
    const char* type_as_string() const override;
    game_data* copy() const override;
    uint64_t get_hash() const override;
    
    // Опционально: оператор new/delete для pool allocator
    static void* operator new(std::size_t sz_);
    static void operator delete(void* ptr_, std::size_t sz_);
};

// Инициализация статических членов
uintptr_t my_custom_type::type_def = 0;
uintptr_t my_custom_type::data_type_def = 0;
rv_pool_allocator* my_custom_type::pool_alloc_base = nullptr;
```

### Шаг 2: Реализация методов

```cpp
const sqf_script_type& my_custom_type::type() const {
    static sqf_script_type _type(/* информация о типе */);
    return _type;
}

r_string my_custom_type::to_string() const {
    return "MyCustomType: " + my_string;
}

bool my_custom_type::equals(const game_data* other) const {
    if (!other) return false;
    if (other->type() != type()) return false;
    
    auto* other_custom = static_cast<const my_custom_type*>(other);
    return my_integer == other_custom->my_integer &&
           my_string == other_custom->my_string;
}

const char* my_custom_type::type_as_string() const {
    return "MY_CUSTOM_TYPE";
}

game_data* my_custom_type::copy() const {
    auto* new_copy = new my_custom_type();
    new_copy->my_integer = my_integer;
    new_copy->my_string = my_string;
    new_copy->my_array = my_array;
    return new_copy;
}

uint64_t my_custom_type::get_hash() const {
    // Простое хэширование
    return std::hash<int>()(my_integer) ^ 
           std::hash<r_string>()(my_string);
}
```

### Шаг 3: Функция создания

```cpp
game_data* create_my_custom_type(param_archive* ar) {
    auto* instance = new my_custom_type();
    
    if (ar) {
        // Десериализация из архива
        instance->serialize(*ar);
    }
    
    return instance;
}
```

### Шаг 4: Регистрация типа

```cpp
void intercept::pre_init() {
    auto [type_enum, script_type] = client::host::register_sqf_type(
        "MY_CUSTOM_TYPE",                  // Внутреннее имя
        "Мой пользовательский тип",        // Локализованное имя
        "Описание типа",                   // Описание
        "MyCustomType",                    // Имя для типа
        create_my_custom_type              // Функция создания
    );
    
    // Сохранить type_def для использования
    my_custom_type::type_def = script_type->get_vtable();
}
```

### Шаг 5: Использование

```cpp
// Создание экземпляра
auto* instance = new my_custom_type();
instance->my_integer = 42;
instance->my_string = "test";

// Обёртка в game_value
game_value val = instance;

// Передача в SQF
sqf::set_variable(sqf::mission_namespace(), "myVar", val);

// Получение из SQF
game_value retrieved = sqf::get_variable(sqf::mission_namespace(), "myVar");
auto* retrieved_instance = retrieved.get_as<my_custom_type>();
if (retrieved_instance) {
    int value = retrieved_instance->my_integer;  // 42
}
```

## Виртуальные методы

### Обязательные для переопределения

```cpp
// Возвращает информацию о типе
virtual const sqf_script_type& type() const;

// Строковое представление
virtual r_string to_string() const;

// Имя типа
virtual const char* type_as_string() const;
```

### Опциональные для переопределения

```cpp
// Копирование объекта
virtual game_data* copy() const { return nullptr; }

// Сравнение
virtual bool equals(const game_data*) const { return false; }

// Хэширование
virtual uint64_t get_hash() const { return 0; }

// Проверка на nil
virtual bool is_nil() const { return false; }

// Сериализация
virtual serialization_return serialize(param_archive& ar);

// Получение как число (для конвертации)
virtual float get_as_number() const { return 0.f; }

// Получение как bool (для конвертации)
virtual bool get_as_bool() const { return false; }

// Получение как строка (только для STRING и CODE!)
virtual const r_string& get_as_string() const;

// Получение как массив (только для ARRAY!)
virtual auto_array<game_value>& get_as_array();
virtual const auto_array<game_value>& get_as_const_array() const;
```

## Управление памятью

### Reference Counting

Все game_data используют подсчёт ссылок:

```cpp
class game_data : public refcount {
    // refcount предоставляет:
    int add_ref();     // Увеличить счётчик
    int release();     // Уменьшить счётчик, удалить если 0
};

// Использование через ref<>
ref<game_data> data_ptr = new game_data_number(42);
// Автоматическое управление временем жизни
```

### Pool Allocators

Часто создаваемые типы используют pool allocators:

```cpp
class game_data_number : public game_data {
public:
    static rv_pool_allocator* pool_alloc_base;
    
    static void* operator new(std::size_t sz_) {
        return pool_alloc_base->allocate(sz_);
    }
    
    static void operator delete(void* ptr_, std::size_t sz_) {
        pool_alloc_base->deallocate(ptr_);
    }
};
```

### Ручное управление

```cpp
// Создание
game_data* data = rv_allocator<game_data_number>::create_single();

// Инициализация
new (data) game_data_number(42.0f);

// Удаление
rv_allocator<game_data_number>::destroy_deallocate(data);
```

## Отладка и инспекция

### I_debug_value интерфейс

Для интеграции с отладчиками:

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

### Получение информации

```cpp
game_data* data = /* ... */;

// Тип как строка
const char* type_str = data->type_as_string();

// Значение как строка
r_string value_str = data->to_string();

// Хэш
uint64_t hash = data->get_hash();

// Vtable
uintptr_t vtable = data->get_vtable();
```

## Сериализация

### Базовая сериализация

```cpp
serialization_return my_custom_type::serialize(param_archive& ar) {
    // Вызвать базовую сериализацию
    game_data::serialize(ar);
    
    // Сериализовать свои данные
    if (ar._isExporting) {
        // Экспорт
        ar.serialize(r_string("my_integer"), my_integer, 1);
        ar.serialize(r_string("my_string"), my_string, 1);
    } else {
        // Импорт
        ar.serialize(r_string("my_integer"), my_integer, 1);
        ar.serialize(r_string("my_string"), my_string, 1);
    }
    
    return serialization_return::no_error;
}
```

## Заключение

Понимание `game_data` и его производных критично для:

- ✅ Создания пользовательских типов данных
- ✅ Эффективной работы с внутренними типами движка
- ✅ Правильного управления памятью
- ✅ Интеграции с системой типов RVEngine

---

**Следующие шаги:**
- [sqf_script_type - Система типов](SCRIPT_TYPES.md)
- [Контейнеры](CONTAINERS.md)
- [game_value](GAME_VALUE.md)


# Создание пользовательских типов

## Шаги создания типа

### 1. Определение класса

```cpp
class my_custom_type : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    
    // Ваши данные
    int my_integer;
    r_string my_string;
    
    my_custom_type() {
        *reinterpret_cast<uintptr_t*>(this) = type_def;
        *reinterpret_cast<uintptr_t*>(static_cast<I_debug_value*>(this)) = data_type_def;
    }
    
    // Виртуальные методы (см. ниже)
};

uintptr_t my_custom_type::type_def = 0;
uintptr_t my_custom_type::data_type_def = 0;
```

### 2. Реализация виртуальных методов

```cpp
const sqf_script_type& my_custom_type::type() const override {
    static sqf_script_type _type(/* ... */);
    return _type;
}

r_string my_custom_type::to_string() const override {
    return "MyType: " + my_string;
}

const char* my_custom_type::type_as_string() const override {
    return "MY_CUSTOM_TYPE";
}

game_data* my_custom_type::copy() const override {
    auto* new_copy = new my_custom_type();
    new_copy->my_integer = my_integer;
    new_copy->my_string = my_string;
    return new_copy;
}

bool my_custom_type::equals(const game_data* other) const override {
    if (!other || other->type() != type()) return false;
    auto* other_custom = static_cast<const my_custom_type*>(other);
    return my_integer == other_custom->my_integer;
}
```

### 3. Функция создания

```cpp
game_data* create_my_custom_type(param_archive* ar) {
    return new my_custom_type();
}
```

### 4. Регистрация

```cpp
void intercept::pre_init() {
    auto [type_enum, script_type] = client::host::register_sqf_type(
        "MY_CUSTOM_TYPE",              // Внутреннее имя
        "Мой пользовательский тип",    // Локализованное
        "Описание типа",               // Описание
        "MyCustomType",                // Читаемое имя
        create_my_custom_type          // Функция создания
    );
    
    my_custom_type::type_def = script_type->get_vtable();
}
```

### 5. Использование

```cpp
// Создание
auto* instance = new my_custom_type();
instance->my_integer = 42;

game_value val = instance;

// Передача в SQF
sqf::set_variable(sqf::mission_namespace(), "myVar", val);

// Получение из SQF
game_value retrieved = sqf::get_variable(sqf::mission_namespace(), "myVar");
auto* data = retrieved.get_as<my_custom_type>();
if (data) {
    int value = data->my_integer;  // 42
}
```

## Создание команд для типа

```cpp
game_value my_type_get_value(game_state& state, game_value_parameter arg) {
    auto* custom = arg.get_as<my_custom_type>();
    if (!custom) {
        state.set_script_error(
            game_state::game_evaluator::evaluator_error_type::type,
            "Expected MY_CUSTOM_TYPE"
        );
        return {};
    }
    
    return custom->my_integer;
}

void intercept::pre_init() {
    // Регистрация типа...
    
    // Регистрация команды для работы с типом
    client::host::register_sqf_command(
        "myTypeGetValue",
        "Gets value from MY_CUSTOM_TYPE",
        my_type_get_value,
        types::game_data_type::SCALAR,
        types::game_data_type::ANY  // Примет любой тип
    );
}

// SQF:
// _value = myTypeGetValue myCustomTypeInstance;
```

---

[API README](README.md) | [Custom Commands](CUSTOM_COMMANDS.md) | [game_data](../Types/GAME_DATA.md)


# Регистрация собственных SQF команд

## Обзор

RVEngine позволяет регистрировать пользовательские функции, доступные из SQF.

## Типы функций

### Nular - без аргументов

```cpp
game_value my_nular_function(game_state& state) {
    return sqf::time();
}

void intercept::pre_init() {
    client::host::register_sqf_command(
        "myTime",                          // Имя в SQF
        "Returns mission time",            // Описание
        my_nular_function,                 // Функция
        types::game_data_type::SCALAR      // Тип возврата
    );
}

// SQF: _time = myTime;
```

### Unary - один аргумент

```cpp
game_value my_unary_function(game_state& state, game_value_parameter right) {
    float number = right;
    return number * 2;
}

void intercept::pre_init() {
    client::host::register_sqf_command(
        "myDouble",
        "Doubles a number",
        my_unary_function,
        types::game_data_type::SCALAR,     // Возврат
        types::game_data_type::SCALAR      // Аргумент
    );
}

// SQF: _result = myDouble 5;  // 10
```

### Binary - два аргумента

```cpp
game_value my_binary_function(
    game_state& state,
    game_value_parameter left,
    game_value_parameter right
) {
    float a = left;
    float b = right;
    return a + b;
}

void intercept::pre_init() {
    client::host::register_sqf_command(
        "myAdd",
        "Adds two numbers",
        my_binary_function,
        types::game_data_type::SCALAR,     // Возврат
        types::game_data_type::SCALAR,     // Левый
        types::game_data_type::SCALAR      // Правый
    );
}

// SQF: _result = 5 myAdd 10;  // 15
```

## Работа с типами

### Проверка типов

```cpp
game_value my_function(game_state& state, game_value_parameter arg) {
    // Автоматическая проверка через error_check_type
    if (!state.error_check_type(arg, types::game_data_type::SCALAR)) {
        return {};  // Ошибка уже установлена
    }
    
    float number = arg;
    return number * 2;
}
```

### Массивы

```cpp
game_value process_array(game_state& state, game_value_parameter arg) {
    if (!state.error_check_type(arg, types::game_data_type::ARRAY)) {
        return {};
    }
    
    auto& arr = arg.to_array();
    
    float sum = 0;
    for (auto& element : arr) {
        if (element.type_enum() == types::game_data_type::SCALAR) {
            sum += static_cast<float>(element);
        }
    }
    
    return sum;
}

// SQF: _sum = processArray [1,2,3,4,5];  // 15
```

### Объекты

```cpp
game_value get_unit_info(game_state& state, game_value_parameter arg) {
    types::object unit = arg;
    
    if (unit.is_null()) {
        return {};
    }
    
    return std::vector<game_value>{
        sqf::name(unit),
        sqf::damage(unit),
        sqf::get_pos(unit)
    };
}

// SQF: _info = getUnitInfo player;
```

## Установка ошибок

```cpp
game_value my_function(game_state& state, game_value_parameter arg) {
    // Ручная установка ошибки
    if (/* условие ошибки */) {
        state.set_script_error(
            game_state::game_evaluator::evaluator_error_type::type,
            "Expected SCALAR type"
        );
        return {};
    }
    
    return 42;
}
```

## Локальные переменные

```cpp
game_value access_locals(game_state& state, game_value_parameter arg) {
    // Получить локальную переменную из SQF
    game_value local_var = state.get_local_variable("_myVar");
    
    // Установить локальную переменную
    state.set_local_variable("_result", 42);
    
    return {};
}

// SQF:
// _myVar = 100;
// call accessLocals;
// hint str _result;  // 42
```

## Возврат зарегистрированной функции

```cpp
registered_sqf_function my_command_handle;

void intercept::pre_init() {
    my_command_handle = client::host::register_sqf_command(
        "myCommand",
        "Description",
        my_function,
        types::game_data_type::SCALAR
    );
}

// Позже можно очистить
void intercept::handle_unload() {
    my_command_handle.clear();
}
```

---

[API README](README.md) | [Custom Types](CUSTOM_TYPES.md) | [Plugin Interfaces](PLUGIN_INTERFACES.md)


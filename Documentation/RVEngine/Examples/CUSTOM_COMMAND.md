# Custom Command - Своя SQF команда

Создание плагина с пользовательской SQF командой.

## main.cpp

```cpp
#include <intercept.hpp>

using namespace intercept;

// Binary команда - складывает два числа
game_value add_numbers(
    game_state& state,
    game_value_parameter left,
    game_value_parameter right
) {
    // Проверка типов
    if (!state.error_check_type(left, types::game_data_type::SCALAR)) return {};
    if (!state.error_check_type(right, types::game_data_type::SCALAR)) return {};
    
    float a = left;
    float b = right;
    return a + b;
}

// Unary команда - удваивает число
game_value double_number(game_state& state, game_value_parameter right) {
    if (!state.error_check_type(right, types::game_data_type::SCALAR)) return {};
    
    float num = right;
    return num * 2;
}

// Nular команда - возвращает случайное число
game_value random_number(game_state& state) {
    return static_cast<float>(rand()) / RAND_MAX;
}

int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}

void intercept::pre_init() {
    // Регистрация binary команды
    client::host::register_sqf_command(
        "myAdd",
        "Adds two numbers",
        add_numbers,
        types::game_data_type::SCALAR,  // возврат
        types::game_data_type::SCALAR,  // левый
        types::game_data_type::SCALAR   // правый
    );
    
    // Регистрация unary команды
    client::host::register_sqf_command(
        "myDouble",
        "Doubles a number",
        double_number,
        types::game_data_type::SCALAR,
        types::game_data_type::SCALAR
    );
    
    // Регистрация nular команды
    client::host::register_sqf_command(
        "myRandom",
        "Returns random number 0-1",
        random_number,
        types::game_data_type::SCALAR
    );
}

void intercept::post_init() {
    sqf::system_chat("Custom commands registered");
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    return TRUE;
}
```

## Тестирование в SQF

```sqf
// Binary
_result = 5 myAdd 10;
hint str _result;  // 15

// Unary
_result = myDouble 21;
hint str _result;  // 42

// Nular
_result = myRandom;
hint str _result;  // 0.742...
```

---

[Examples](README.md) | [Event Handling](EVENT_HANDLING.md)


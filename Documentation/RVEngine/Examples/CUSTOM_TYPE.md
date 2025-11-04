# Custom Type - Пользовательский тип

Создание нового типа данных, доступного из SQF.

## custom_type.hpp

```cpp
#pragma once
#include <intercept.hpp>

using namespace intercept;

class player_data : public types::game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    
    r_string name;
    int level;
    float health;
    
    player_data() {
        *reinterpret_cast<uintptr_t*>(this) = type_def;
        *reinterpret_cast<uintptr_t*>(static_cast<types::__internal::I_debug_value*>(this)) = data_type_def;
    }
    
    const types::sqf_script_type& type() const override;
    r_string to_string() const override;
    const char* type_as_string() const override;
    types::game_data* copy() const override;
    bool equals(const types::game_data* other) const override;
};

types::game_data* create_player_data(types::param_archive* ar);
```

## custom_type.cpp

```cpp
#include "custom_type.hpp"

uintptr_t player_data::type_def = 0;
uintptr_t player_data::data_type_def = 0;

const types::sqf_script_type& player_data::type() const {
    static types::sqf_script_type _type;
    return _type;
}

r_string player_data::to_string() const {
    return "PlayerData: " + name + " (Level " + 
           r_string(std::to_string(level)) + ")";
}

const char* player_data::type_as_string() const {
    return "PLAYER_DATA";
}

types::game_data* player_data::copy() const {
    auto* new_data = new player_data();
    new_data->name = name;
    new_data->level = level;
    new_data->health = health;
    return new_data;
}

bool player_data::equals(const types::game_data* other) const {
    if (!other || other->type() != type()) return false;
    auto* other_data = static_cast<const player_data*>(other);
    return name == other_data->name;
}

types::game_data* create_player_data(types::param_archive* ar) {
    return new player_data();
}
```

## main.cpp

```cpp
#include "custom_type.hpp"

using namespace intercept;

// Создать PlayerData
game_value create_player(game_state& state, game_value_parameter arg) {
    if (!state.error_check_type(arg, types::game_data_type::ARRAY)) return {};
    if (!state.error_check_size(arg, 3)) return {};
    
    auto& arr = arg.to_array();
    
    auto* data = new player_data();
    data->name = arr[0];
    data->level = static_cast<int>(static_cast<float>(arr[1]));
    data->health = arr[2];
    
    return data;
}

// Получить уровень
game_value get_level(game_state& state, game_value_parameter arg) {
    auto* data = arg.get_as<player_data>();
    if (!data) {
        state.set_script_error(
            types::game_state::game_evaluator::evaluator_error_type::type,
            "Expected PLAYER_DATA"
        );
        return {};
    }
    
    return data->level;
}

int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}

void intercept::pre_init() {
    // Регистрация типа
    auto [type_enum, script_type] = client::host::register_sqf_type(
        "PLAYER_DATA",
        "Player Data Type",
        "Stores player information",
        "PlayerData",
        create_player_data
    );
    
    player_data::type_def = script_type->get_vtable();
    
    // Регистрация команд
    client::host::register_sqf_command(
        "createPlayer",
        "Creates player data",
        create_player,
        types::game_data_type::ANY,
        types::game_data_type::ARRAY
    );
    
    client::host::register_sqf_command(
        "getPlayerLevel",
        "Gets player level",
        get_level,
        types::game_data_type::SCALAR,
        types::game_data_type::ANY
    );
}

void intercept::post_init() {
    sqf::system_chat("PlayerData type registered");
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    return TRUE;
}
```

## Тестирование в SQF

```sqf
// Создать данные игрока
_playerData = createPlayer ["John", 42, 100];

// Получить уровень
_level = getPlayerLevel _playerData;
hint str _level;  // 42

// Сохранить в переменную
missionNamespace setVariable ["myPlayer", _playerData];

// Получить обратно
_data = missionNamespace getVariable "myPlayer";
_level = getPlayerLevel _data;
```

---

[Examples](README.md) | [Advanced Plugin](ADVANCED_PLUGIN.md)


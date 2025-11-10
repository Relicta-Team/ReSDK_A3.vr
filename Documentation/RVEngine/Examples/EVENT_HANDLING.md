# Event Handling - Обработка событий

Плагин, реагирующий на игровые события.

## main.cpp

```cpp
#include <intercept.hpp>
#include <unordered_map>

using namespace intercept;

// Статистика убийств
std::unordered_map<types::object, int> kill_stats;

int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}

// Обработка убийства
void intercept::killed(types::object& unit, types::object& killer) {
    if (killer.is_null()) return;
    
    // Увеличить счётчик
    kill_stats[killer]++;
    
    r_string killer_name = sqf::name(killer);
    int kills = kill_stats[killer];
    
    std::string msg = std::string(killer_name) + 
                      " kills: " + std::to_string(kills);
    sqf::system_chat(msg);
}

// Обработка выстрела
void intercept::fired(
    types::object& unit,
    r_string weapon,
    r_string muzzle,
    r_string mode,
    r_string ammo,
    r_string magazine,
    types::object& projectile
) {
    sqf::hint("Fired: " + std::string(weapon));
}

// Обработка урона
void intercept::hit(types::object& unit, types::object& caused_by, float damage) {
    // Уменьшить полученный урон на 50%
    float current = sqf::damage(unit);
    sqf::set_damage(unit, current - damage * 0.5f);
    
    sqf::system_chat("Damage reduced!");
}

// Посадка в технику
void intercept::get_in(
    types::object& vehicle,
    r_string position,
    types::object& unit,
    rv_turret_path turret_path
) {
    r_string name = sqf::name(unit);
    sqf::system_chat(std::string(name) + " entered vehicle");
}

void intercept::post_init() {
    sqf::system_chat("Event handlers active");
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    return TRUE;
}
```

## Тестирование

1. Запустить миссию
2. Стрелять - увидеть hint с названием оружия
3. Получить урон - урон уменьшен на 50%
4. Убить юнита - увидеть статистику
5. Сесть в технику - увидеть сообщение

---

[Examples](README.md) | [Custom Type](CUSTOM_TYPE.md)


# Обработчики событий

Event Handlers позволяют реагировать на игровые события в реальном времени.

## Доступные события

### killed - Убийство

```cpp
void intercept::killed(types::object& unit, types::object& killer) {
    r_string unit_name = sqf::name(unit);
    r_string killer_name = sqf::name(killer);
    
    sqf::system_chat(std::string(unit_name) + " killed by " + std::string(killer_name));
}
```

### hit - Урон

```cpp
void intercept::hit(types::object& unit, types::object& caused_by, float damage) {
    // Уменьшить полученный урон на 50%
    float current_damage = sqf::damage(unit);
    sqf::set_damage(unit, current_damage - damage * 0.5f);
}
```

### fired - Выстрел

```cpp
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
```

### get_in / get_out - Посадка/высадка

```cpp
void intercept::get_in(
    types::object& vehicle,
    r_string position,
    types::object& unit,
    rv_turret_path turret_path
) {
    sqf::hint(std::string(sqf::name(unit)) + " entered vehicle");
}

void intercept::get_out(
    types::object& vehicle,
    r_string position,
    types::object& unit,
    rv_turret_path turret_path
) {
    sqf::hint(std::string(sqf::name(unit)) + " left vehicle");
}
```

### init - Инициализация

```cpp
void intercept::init(types::object& unit) {
    // Вызывается при создании объекта
    sqf::set_variable(unit, "initialized", true);
}
```

### Другие события

```cpp
// Урон (расширенный)
void intercept::handle_damage(
    types::object& unit,
    r_string selection,
    float damage,
    types::object& source,
    r_string projectile,
    int hit_part_index
);

// Лечение
void intercept::handle_heal(types::object& unit, types::object& healer, bool can_heal);

// Анимация
void intercept::anim_changed(types::object& unit, r_string anim);
void intercept::anim_done(types::object& unit, r_string anim);

// Контейнеры
void intercept::container_closed(types::object& container, types::object& player);
void intercept::inventory_closed(types::object& unit, types::object& container);
void intercept::inventory_opened(types::object& unit, types::object& container);

// Предметы
void intercept::put(types::object& unit, types::object& container, r_string item);
void intercept::take(types::object& unit, types::object& container, r_string item);
```

## Полный список

Все доступные event handlers объявлены в `intercept.hpp`. См. макрос `EH(x)` для полного списка.

---

[API README](README.md) | [Lifecycle](LIFECYCLE.md) | [Custom Commands](CUSTOM_COMMANDS.md)


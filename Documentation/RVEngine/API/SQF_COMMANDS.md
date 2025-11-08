# Вызов SQF команд

RVEngine предоставляет доступ к ~3000+ функциям движка через пространство имён `intercept::sqf`.

## Типы команд

### Nular - без аргументов

```cpp
// Возвращают значение, не принимают аргументов
types::object player = sqf::player();
float time = sqf::time();
float diag_fps = sqf::diag_fps();
```

### Unary - один аргумент справа

```cpp
// command arg
r_string name = sqf::name(player);
types::vector3 pos = sqf::get_pos(player);
float damage = sqf::damage(player);
```

### Binary - два аргумента

```cpp
// leftArg command rightArg
sqf::set_pos(player, {100, 100, 0});
sqf::set_damage(player, 0.5f);
sqf::set_variable(player, "varName", 42);
```

## Основные категории

### Core - Базовые функции

```cpp
// Управление временем
float time = sqf::time();              // Время миссии
float server_time = sqf::server_time(); // Серверное время

// Вызов кода
types::code code = sqf::compile("hint 'test'");
sqf::call(code);
sqf::spawn(code);

// Хинты и сообщения
sqf::hint("Message");
sqf::system_chat("Chat message");
sqf::title_text("Title", "PLAIN");
```

### Units - Юниты

```cpp
types::object player = sqf::player();
r_string name = sqf::name(player);
types::side side = sqf::side(player);
bool alive = sqf::alive(player);
float damage = sqf::damage(player);

// Управление
sqf::set_damage(player, 0.5f);
sqf::set_pos(player, {100, 100, 0});
sqf::set_dir(player, 90);
sqf::set_velocity(player, {0, 0, 1});
```

### Position - Позиционирование

```cpp
types::vector3 pos = sqf::get_pos(player);
types::vector3 pos_asl = sqf::get_pos_asl(player);
types::vector3 pos_atl = sqf::get_pos_atl(player);

float dir = sqf::get_dir(player);
types::vector3 velocity = sqf::velocity(player);

// Поиск объектов рядом
game_value near = sqf::near_entities(pos, {"Man"}, 100);
```

### Vehicles - Техника

```cpp
// Создание
types::object vehicle = sqf::create_vehicle(
    "B_MRAP_01_F",
    pos,
    {},
    0,
    "NONE"
);

// Управление
sqf::set_fuel(vehicle, 0.5f);
sqf::set_vehicle_ammo(vehicle, 0.5f);
sqf::set_engine_rpm(vehicle, 1000);

// Посадка/высадка
sqf::move_in_driver(player, vehicle);
sqf::move_out(player);
```

### Weapons - Оружие

```cpp
// Добавление оружия
sqf::add_weapon(player, "arifle_MX_F");
sqf::add_magazine(player, "30Rnd_65x39_caseless_mag");

// Информация
game_value weapons = sqf::weapons(player);
r_string current_weapon = sqf::current_weapon(player);
game_value magazines = sqf::magazines(player);

// Стрельба
sqf::fire(player, current_weapon, "single", "");
```

### World - Мир

```cpp
// Погода
float rain = sqf::rain();
float overcast = sqf::overcast();
float fog = sqf::fog();

sqf::set_rain(0.5f);
sqf::set_overcast(0.8f);
sqf::set_fog(0.3f);

// Время суток
sqf::set_date({2023, 6, 15, 12, 0});
game_value date = sqf::date();
```

## Полный список категорий

Команды организованы в заголовочных файлах:

- `sqf/actions.hpp` - Действия (addAction и т.д.)
- `sqf/ai.hpp` - Искусственный интеллект
- `sqf/camera.hpp` - Камера и обзор
- `sqf/cargo.hpp` - Инвентарь и грузы (и т.д.)

Для полного списка см. папку `src/client/headers/client/sqf/` в исходниках RVEngine.

---

[API README](README.md) | [Lifecycle](LIFECYCLE.md) | [Event Handlers](EVENT_HANDLERS.md)


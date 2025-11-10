# Клиентские типы (object, group, code и др.)

Клиентские типы — это удобные обёртки над `game_value` для работы с игровыми объектами Arma 3.

## Обзор

Все клиентские типы наследуются от `internal_object`, который в свою очередь наследуется от `game_value`:

```cpp
class internal_object : public game_value {
public:
    internal_object();
    internal_object(const game_value& value_);
    // ...
};

// Макрос для создания специализированных типов
#define RV_GENERIC_OBJECT_DEC(type) class type : public internal_object { /*...*/ }
```

## Доступные типы

| Тип | Описание | Пример |
|-----|----------|--------|
| `object` | Игровые объекты (юниты, техника) | player, vehicle |
| `group` | Группы юнитов | group player |
| `code` | Скомпилированный код | {hint "test"} |
| `config` | Конфигурационные записи | configFile >> "CfgWeapons" |
| `control` | UI контролы | findDisplay 46 displayCtrl 1 |
| `display` | UI дисплеи | findDisplay 46 |
| `location` | Локации на карте | createLocation |
| `script` | Запущенные скрипты | spawn/execVM |
| `side` | Стороны | west, east, resistance |
| `rv_text` | Structured Text | parseText "<t>Text</t>" |
| `team_member` | Члены команды | teamMember |
| `rv_namespace` | Пространства имён | missionNamespace |
| `task` | Задачи | createSimpleTask |

## object - Игровые объекты

### Описание

Представляет любой игровой объект: юнита, технику, здание и т.д.

```cpp
class object : public internal_object {
public:
    object();
    object(const game_value& value_);
    // ...
};
```

### Примеры использования

```cpp
// Получение игрока
types::object player = sqf::player();

// Проверка на null
if (player.is_null()) {
    sqf::hint("Нет игрока");
    return;
}

// Получение информации
r_string name = sqf::name(player);
types::vector3 pos = sqf::get_pos(player);
float damage = sqf::damage(player);
r_string type = sqf::type_of(player);

// Установка данных
sqf::set_pos(player, {100, 100, 0});
sqf::set_damage(player, 0.5f);
sqf::set_variable(player, "myVar", 42);

// Создание объектов
types::object vehicle = sqf::create_vehicle(
    "B_MRAP_01_F",
    sqf::get_pos(player),
    {},
    0,
    "NONE"
);

// Удаление объекта
sqf::delete_vehicle(vehicle);
```

### Специальные методы

```cpp
// Сравнение объектов
types::object obj1 = sqf::player();
types::object obj2 = sqf::player();

if (obj1 == obj2) {  // Одинаковые объекты
    // ...
}

// Хэширование (для unordered_map)
std::unordered_map<types::object, int> object_map;
object_map[player] = 100;
```

## group - Группы

### Описание

Представляет группу юнитов.

```cpp
class group : public internal_object {
public:
    group();
    group(const game_value& value_);
    // ...
};
```

### Примеры использования

```cpp
// Получение группы игрока
types::group player_group = sqf::group(sqf::player());

// Получение юнитов группы
game_value units = sqf::units(player_group);
auto& units_arr = units.to_array();

for (auto& unit_val : units_arr) {
    types::object unit = unit_val;
    r_string name = sqf::name(unit);
    sqf::system_chat(name);
}

// Создание группы
types::group new_group = sqf::create_group(sqf::west());

// Добавление юнита в группу
types::object unit = sqf::player();
sqf::join(unit, new_group);

// Waypoints
sqf::add_waypoint(player_group, {100, 100, 0}, 0);
```

## code - Код

### Описание

Представляет скомпилированный SQF код.

```cpp
class code : public internal_object {
public:
    code();
    code(const game_value& value_);
    // ...
};
```

### Примеры использования

```cpp
// Компиляция кода
types::code code1 = sqf::compile("hint 'Hello World'");

// Вызов кода
sqf::call(code1);

// Код с параметрами
types::code code2 = sqf::compile(R"(
    params ["_name", "_age"];
    hint format ["Name: %1, Age: %2", _name, _age];
)");

// Вызов с параметрами
sqf::call(code2, std::vector<game_value>{"John", 30});

// Spawn (асинхронное выполнение)
sqf::spawn(code1);

// Получение строки кода
r_string code_str = sqf::str(code1);
```

## config - Конфигурация

### Описание

Представляет записи в конфигурационных файлах.

```cpp
class config : public internal_object {
public:
    config();
    config(const game_value& value_);
    // ...
};
```

### Примеры использования

```cpp
// Получение корневого конфига
types::config root = sqf::config_file();

// Навигация по конфигу (оператор >>)
types::config cfg_weapons = root >> "CfgWeapons";
types::config rifle_cfg = cfg_weapons >> "arifle_MX_F";

// Получение значений
r_string display_name = sqf::get_text(rifle_cfg >> "displayName");
float weight = sqf::get_number(rifle_cfg >> "WeaponSlotsInfo" >> "mass");

// Проверка существования
if (!sqf::is_null(rifle_cfg)) {
    // Конфиг существует
}

// Получение подклассов
game_value subclasses = sqf::config_classes("true", cfg_weapons);
```

## control и display - UI элементы

### control - UI контролы

```cpp
// Получение контрола
types::display main_display = sqf::find_display(46);
types::control ctrl = sqf::display_ctrl(main_display, 1);

// Управление контролом
sqf::ctrl_set_text(ctrl, "New Text");
sqf::ctrl_show(ctrl, true);
sqf::ctrl_set_position(ctrl, {0, 0, 0.5f, 0.5f});
sqf::ctrl_commit(ctrl, 0.5f);

// Получение данных
r_string text = sqf::ctrl_text(ctrl);
bool shown = sqf::ctrl_shown(ctrl);
```

### display - UI дисплеи

```cpp
// Получение дисплея
types::display main_display = sqf::find_display(46);

// Создание дисплея
types::display custom_display = sqf::create_dialog("MyDialog");

// Закрытие дисплея
sqf::close_dialog(0);

// Получение контролов дисплея
game_value controls = sqf::all_controls(main_display);
```

## location - Локации

```cpp
// Создание локации
types::location loc = sqf::create_location(
    "NameVillage",
    {1000, 1000, 0},
    100,  // radius X
    100   // radius Y
);

// Установка параметров
sqf::set_text(loc, "Village Name");
sqf::set_side(loc, sqf::civilian());

// Получение локаций рядом
game_value near_locations = sqf::nearest_locations(
    sqf::get_pos(sqf::player()),
    {"NameCity", "NameVillage"},
    500
);
```

## side - Стороны

```cpp
// Получение стороны
types::side player_side = sqf::side(sqf::player());

// Стороны по умолчанию
types::side west = sqf::west();
types::side east = sqf::east();
types::side resistance = sqf::resistance();
types::side civilian = sqf::civilian();

// Отношения между сторонами
float friendliness = sqf::get_friend(west, east);  // -1 to 1

// Сравнение
if (player_side == west) {
    sqf::hint("You are BLUFOR");
}
```

## rv_namespace - Пространства имён

```cpp
// Получение пространств имён
types::rv_namespace mission_ns = sqf::mission_namespace();
types::rv_namespace ui_ns = sqf::ui_namespace();
types::rv_namespace profile_ns = sqf::profile_namespace();
types::rv_namespace parsing_ns = sqf::parsing_namespace();

// Работа с переменными
sqf::set_variable(mission_ns, "myVar", 42);
game_value value = sqf::get_variable(mission_ns, "myVar");

// Список переменных
game_value all_vars = sqf::all_variables(mission_ns);
```

## task - Задачи

```cpp
// Создание задачи
types::task task = sqf::create_simple_task(sqf::player(), "TaskName");

// Настройка задачи
sqf::set_simple_task_description(task, {
    "Task Description",
    "Task Title",
    "Task Marker"
});
sqf::set_simple_task_destination(task, {1000, 1000, 0});

// Состояние задачи
sqf::set_task_state(task, "ASSIGNED");
sqf::set_task_state(task, "SUCCEEDED");
sqf::set_task_state(task, "FAILED");

// Получение задач игрока
game_value player_tasks = sqf::simple_tasks(sqf::player());
```

## Вспомогательные типы

### sqf_string

```cpp
// Гибкий тип для строк в параметрах SQF функций
class sqf_string_const_ref {
    std::variant<r_string, std::string_view> _var;
public:
    sqf_string_const_ref(const std::string& ref);
    sqf_string_const_ref(r_string ref);
    sqf_string_const_ref(std::string_view ref);
    sqf_string_const_ref(const char* ref);
    
    operator std::string_view() const;
    operator r_string() const;
    operator game_value() const;
};

// Использование
void my_function(sqf_string_const_ref str) {
    // Принимает любой строковый тип
}

my_function("C string");
my_function(std::string("std::string"));
my_function(r_string("r_string"));
```

### rv_color

```cpp
struct rv_color {
    float red{0.f};
    float green{0.f};
    float blue{0.f};
    float alpha{0.f};
    
    operator game_value() const;
};

// Использование
rv_color red_color{1.0f, 0.0f, 0.0f, 1.0f};
sqf::set_marker_color("marker1", red_color);
```

### rv_turret_path

```cpp
class rv_turret_path {
    game_value pathRaw;
public:
    explicit rv_turret_path(game_value path);
    explicit operator std::vector<float>() const;
    operator game_value() const;
};

// Использование
rv_turret_path turret{game_value({0, 0})};
sqf::move_in_turret(unit, vehicle, turret);
```

## Конвертация

### Из game_value

```cpp
game_value val = sqf::player();

// Явная конвертация
types::object obj = val;

// Через оператор
types::object obj2 = static_cast<types::object>(val);

// Проверка типа перед конвертацией
if (val.type_enum() == types::game_data_type::OBJECT) {
    types::object obj = val;
}
```

### В game_value

```cpp
types::object player = sqf::player();

// Неявная конвертация
game_value val = player;

// Передача в функции
sqf::set_damage(player, 0.5f);  // player автоматически конвертируется
```

## Проверка на null

```cpp
types::object obj = sqf::obj_null();

// Проверка через is_null()
if (obj.is_null()) {
    sqf::hint("Object is null");
}

// Сравнение с null объектом
if (obj == sqf::obj_null()) {
    // Тоже null
}
```

## Практические примеры

### Поиск ближайших врагов

```cpp
void find_enemies(types::object unit, float radius) {
    types::side unit_side = sqf::side(unit);
    types::vector3 pos = sqf::get_pos(unit);
    
    game_value near_units = sqf::near_entities(pos, {"Man"}, radius);
    auto& units_arr = near_units.to_array();
    
    for (auto& enemy_val : units_arr) {
        types::object enemy = enemy_val;
        
        if (sqf::side(enemy) != unit_side && sqf::alive(enemy)) {
            r_string name = sqf::name(enemy);
            sqf::system_chat("Enemy found: " + std::string(name));
        }
    }
}
```

### Работа с группой

```cpp
void manage_group(types::group grp) {
    // Получить всех юнитов
    game_value units = sqf::units(grp);
    auto& units_arr = units.to_array();
    
    // Подсчитать живых
    int alive_count = 0;
    for (auto& unit_val : units_arr) {
        types::object unit = unit_val;
        if (sqf::alive(unit)) {
            alive_count++;
        }
    }
    
    // Установить waypoint если группа жива
    if (alive_count > 0) {
        types::object leader = sqf::leader(grp);
        types::vector3 leader_pos = sqf::get_pos(leader);
        sqf::add_waypoint(grp, leader_pos + types::vector3{100, 0, 0}, 0);
    }
}
```

## Заключение

Клиентские типы обеспечивают:

- ✅ Типобезопасную работу с игровыми объектами
- ✅ Удобный интерфейс без лишних конвертаций
- ✅ Автоматическое управление памятью
- ✅ Интеграцию со всеми SQF функциями

---

**Следующие шаги:**
- [Конвертация типов](CONVERSIONS.md)
- [game_value](GAME_VALUE.md)
- [Примеры использования](../Examples/README.md)


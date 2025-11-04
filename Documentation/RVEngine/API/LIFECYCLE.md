# Жизненный цикл плагина

## Обзор

Host вызывает функции плагина в определённые моменты жизненного цикла игры.

## Порядок вызова

```
1. Загрузка Arma 3
2. Загрузка RVEngine Host
3. Загрузка Client плагинов
4. assign_functions() - передача API
5. api_version() - проверка версии
6. pre_start() - ДО инициализации функций движка
7. Загрузка основных систем игры
8. post_start() - ПОСЛЕ загрузки (CBA XEH_preStart)
9. pre_pre_init() - перед pre_init
10. pre_init() - Регистрация команд/типов (CBA XEH_preInit)
11. Загрузка миссии
12. post_init() - Миссия готова (CBA XEH_postInit)
13. [ИГРОВОЙ ЦИКЛ]
    - on_frame() - каждый кадр
    - События - при возникновении
14. mission_ended() - завершение миссии
15. Возврат к шагу 11 или выход
```

## Функции

### api_version() - ОБЯЗАТЕЛЬНАЯ

```cpp
int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}
```

### pre_start()

Вызывается ДО инициализации функций движка.

```cpp
void intercept::pre_start() {
    // Самая ранняя точка
    // Можно зарегистрировать команды/типы
}
```

### post_start()

После загрузки основных систем (эквивалент CBA XEH_preStart).

```cpp
void intercept::post_start() {
    // Основные системы загружены
}
```

### pre_pre_init()

Перед pre_init.

```cpp
void intercept::pre_pre_init() {
    // Дополнительная точка перед pre_init
}
```

### pre_init()

Основная точка регистрации (эквивалент CBA XEH_preInit).

```cpp
void intercept::pre_init() {
    // РЕКОМЕНДУЕТСЯ регистрировать здесь:
    client::host::register_sqf_command(/* ... */);
    client::host::register_sqf_type(/* ... */);
}
```

### post_init()

Миссия полностью инициализирована (эквивалент CBA XEH_postInit).

```cpp
void intercept::post_init() {
    sqf::system_chat("Plugin ready!");
    
    // Безопасно использовать все SQF функции
    types::object player = sqf::player();
}
```

### on_frame()

Вызывается каждый кадр (~30-60 раз в секунду).

```cpp
void intercept::on_frame() {
    // ВНИМАНИЕ: должно выполняться быстро!
    
    // Пример: проверка каждые 5 секунд
    static int counter = 0;
    if (++counter < 300) return;  // ~5 сек при 60 FPS
    counter = 0;
    
    // Ваша логика
}
```

### mission_ended()

Вызывается при завершении миссии.

```cpp
void intercept::mission_ended() {
    sqf::system_chat("Mission ended");
    
    // Очистка ресурсов
    // Сброс состояния
}
```

### on_signal()

Пользовательские сигналы.

```cpp
void intercept::on_signal(std::string& signal_name, game_value& value) {
    if (signal_name == "mySignal") {
        sqf::hint("Signal received");
    }
}

// Отправка сигнала из SQF:
// ["mySignal", 42] call intercept_fnc_signal;
```

### handle_unload()

Перед выгрузкой плагина.

```cpp
void intercept::handle_unload() {
    // Финальная очистка
}
```

## Лучшие практики

### ✅ Рекомендуется

```cpp
// 1. Регистрация в pre_init
void intercept::pre_init() {
    client::host::register_sqf_command(/* ... */);
}

// 2. Инициализация данных в post_init
void intercept::post_init() {
    g_player = sqf::player();
}

// 3. Лёгкая логика в on_frame
void intercept::on_frame() {
    static int counter = 0;
    if (++counter < 60) return;  // Раз в секунду
    counter = 0;
    // Лёгкая операция
}

// 4. Очистка в mission_ended
void intercept::mission_ended() {
    g_cached_data.clear();
}
```

### ❌ Не рекомендуется

```cpp
// 1. Тяжёлые операции в on_frame
void intercept::on_frame() {
    for (int i = 0; i < 10000; i++) {  // Медленно!
        sqf::player();
    }
}

// 2. Регистрация в неправильном месте
void intercept::post_init() {
    // Поздно регистрировать команды!
    client::host::register_sqf_command(/* ... */);
}
```

---

[API README](README.md) | [SQF Commands](SQF_COMMANDS.md) | [Event Handlers](EVENT_HANDLERS.md)


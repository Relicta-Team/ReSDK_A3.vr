# Быстрый старт - Создание плагина для RVEngine

Это руководство поможет вам создать ваш первый плагин для RVEngine (Intercept) за 15-20 минут.

## Предварительные требования

Перед началом работы убедитесь, что у вас установлено:

- **Visual Studio 2022** или новее (Community Edition подойдёт)
  - При установке выберите "Разработка классических приложений на C++"
- **CMake** версии 3.8 или выше
  - Скачать: https://cmake.org/download/
  - Добавить в PATH при установке
- **Git** для клонирования репозитория
- **Arma 3** для тестирования плагина

## Шаг 1: Клонирование RVEngine

Сначала клонируйте репозиторий RVEngine:

```bash
git clone https://github.com/intercept/intercept.git
cd intercept
```

## Шаг 2: Генерация проекта Visual Studio

Запустите генерацию проекта с помощью предоставленного скрипта:

```bash
# Для Visual Studio 2022 x64
cmake -B build -G "Visual Studio 17 2022" -A x64

# Или используйте GUI CMake
cmake-gui .
```

После успешной генерации у вас появится файл `build/Intercept.sln`.

## Шаг 3: Сборка RVEngine

Откройте `build/Intercept.sln` в Visual Studio и соберите проект:

1. Выберите конфигурацию **Release** (или **Debug** для отладки)
2. Собрать решение (Ctrl+Shift+B или Build → Build Solution)

После сборки вы получите:
- `build/Release/intercept/intercept_x64.dll` - Host библиотека
- `build/Release/intercept_client/intercept_client.lib` - Client библиотека для линковки

## Шаг 4: Создание нового плагина

### Структура проекта

Создайте новую папку для вашего плагина:

```
my_plugin/
├── CMakeLists.txt
├── src/
│   └── main.cpp
└── include/
    └── (опционально заголовочные файлы)
```

### CMakeLists.txt

Создайте файл `my_plugin/CMakeLists.txt`:

```cmake
cmake_minimum_required(VERSION 3.8)
project(my_plugin)

# Установите путь к Intercept
set(INTERCEPT_PATH "path/to/intercept" CACHE PATH "Path to intercept")

# Настройки C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Найти Intercept
find_package(intercept REQUIRED PATHS "${INTERCEPT_PATH}/build")

# Создать DLL
add_library(my_plugin SHARED
    src/main.cpp
)

# Линковать с Intercept Client
target_link_libraries(my_plugin PRIVATE intercept::client)

# Установить выходную директорию
set_target_properties(my_plugin PROPERTIES
    OUTPUT_NAME "my_plugin_x64"
    PREFIX ""
    SUFFIX ".dll"
)
```

### main.cpp - Простейший плагин

Создайте файл `my_plugin/src/main.cpp`:

```cpp
#include <intercept.hpp>
#include <string>

using namespace intercept;

// ============= ОБЯЗАТЕЛЬНЫЕ ФУНКЦИИ =============

// Возвращает версию API (всегда требуется)
int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}

// ============= LIFECYCLE HOOKS =============

// Вызывается перед инициализацией функций движка
void intercept::pre_start() {
    // Здесь можно зарегистрировать свои SQF команды
}

// Вызывается после загрузки основных систем (CBA XEH_preStart)
void intercept::post_start() {
    // Инициализация систем
}

// Вызывается перед инициализацией миссии (CBA XEH_preInit)
void intercept::pre_init() {
    // Регистрация обработчиков событий
}

// Вызывается после инициализации миссии (CBA XEH_postInit)
void intercept::post_init() {
    sqf::system_chat("My Plugin загружен!");
}

// ============= ОСНОВНОЙ ИГРОВОЙ ЦИКЛ =============

// Вызывается каждый кадр (~30-60 раз в секунду)
void intercept::on_frame() {
    // Ваша логика, выполняемая каждый кадр
    
    // Пример: получение позиции игрока
    static int frame_counter = 0;
    frame_counter++;
    
    // Выводим сообщение каждые 300 кадров (~5 секунд при 60 FPS)
    if (frame_counter >= 300) {
        frame_counter = 0;
        
        types::object player = sqf::player();
        if (!player.is_null()) {
            types::vector3 pos = sqf::get_pos(player);
            
            std::string message = "Позиция: X=" + 
                std::to_string(static_cast<int>(pos.x)) + " Y=" + 
                std::to_string(static_cast<int>(pos.y));
            
            sqf::system_chat(message);
        }
    }
}

// Вызывается при завершении миссии
void intercept::mission_ended() {
    sqf::system_chat("Миссия завершена!");
}

// ============= WINDOWS DLL ENTRY POINT =============

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    switch (ul_reason_for_call) {
        case DLL_PROCESS_ATTACH:
            break;
        case DLL_THREAD_ATTACH:
        case DLL_THREAD_DETACH:
        case DLL_PROCESS_DETACH:
            break;
    }
    return TRUE;
}
```

## Шаг 5: Сборка плагина

### Генерация проекта плагина

```bash
cd my_plugin
cmake -B build -G "Visual Studio 17 2022" -A x64 -DINTERCEPT_PATH="path/to/intercept"
```

### Сборка

```bash
cmake --build build --config Release
```

Или откройте `my_plugin/build/my_plugin.sln` в Visual Studio и соберите проект.

После сборки вы получите `my_plugin_x64.dll` в папке `build/Release/`.

## Шаг 6: Установка в Arma 3

### Структура папок Arma 3

Создайте следующую структуру в папке Arma 3:

```
Arma 3/
└── @YourMod/
    ├── intercept_x64.dll          ← Host из RVEngine
    └── intercept/
        └── my_plugin_x64.dll       ← Ваш плагин
```

### Пример путей

```
C:\Program Files (x86)\Steam\steamapps\common\Arma 3\@YourMod\
├── intercept_x64.dll
└── intercept\
    └── my_plugin_x64.dll
```

## Шаг 7: Запуск Arma 3

### Через лаунчер

1. Запустите Arma 3 Launcher
2. Перейдите в раздел "Моды"
3. Найдите и активируйте `@YourMod`
4. Нажмите "Играть"

### Через командную строку

```bash
arma3_x64.exe "-mod=@YourMod"
```

### Проверка загрузки

1. Запустите игру
2. Откройте редактор
3. Поместите юнит игрока
4. Нажмите "Preview"
5. В чате должно появиться сообщение "My Plugin загружен!"
6. Каждые ~5 секунд будет выводиться ваша позиция

## Расширенный пример: Регистрация SQF команды

Добавьте в ваш `main.cpp` регистрацию пользовательской команды:

```cpp
// Наша функция - удваивает число
game_value double_number(game_state& state, game_value_parameter right_arg) {
    float number = right_arg;  // Автоматическая конвертация
    return number * 2.0f;
}

// Регистрируем в pre_init
void intercept::pre_init() {
    client::host::register_sqf_command(
        "doubleNumber",                  // Имя команды в SQF
        "Удваивает переданное число",    // Описание
        double_number,                   // Указатель на функцию
        types::game_data_type::SCALAR,   // Тип возвращаемого значения
        types::game_data_type::SCALAR    // Тип аргумента
    );
    
    sqf::system_chat("Команда doubleNumber зарегистрирована!");
}
```

Теперь в SQF можно использовать:

```sqf
_result = doubleNumber 21;  // Вернёт 42
hint str _result;           // Выведет "42"
```

## Расширенный пример: Обработка событий

Добавьте обработчик события убийства:

```cpp
// Обработчик события "Killed"
void intercept::killed(types::object& unit, types::object& killer) {
    // unit - убитый юнит
    // killer - убийца
    
    r_string unit_name = sqf::name(unit);
    r_string killer_name = sqf::name(killer);
    
    std::string message = std::string(unit_name) + 
        " был убит игроком " + std::string(killer_name);
    
    sqf::system_chat(message);
}
```

## Отладка плагина

### Visual Studio Debugger

1. В Visual Studio откройте `Properties` вашего проекта
2. Перейдите в `Debugging`
3. Установите:
   - **Command**: `C:\...\Arma 3\arma3_x64.exe`
   - **Command Arguments**: `"-mod=@YourMod" -window -skipIntro`
   - **Working Directory**: `C:\...\Arma 3\`
4. Поставьте breakpoints в коде
5. Нажмите F5 для запуска с отладчиком

### Логирование

Используйте стандартный вывод или файлы для логирования:

```cpp
void log_to_file(const std::string& message) {
    std::ofstream file("my_plugin_log.txt", std::ios::app);
    file << message << std::endl;
}

void intercept::on_frame() {
    log_to_file("Frame executed");
}
```

## Частые проблемы

### Плагин не загружается

**Проблема**: Игра запускается, но плагин не работает

**Решения**:
1. Проверьте структуру папок (Host в корне, плагин в `intercept/`)
2. Убедитесь, что используется правильная версия API
3. Проверьте, что DLL собрана для x64
4. Проверьте зависимости DLL (используйте Dependency Walker)

### "Missing api_version()"

**Проблема**: Ошибка при загрузке плагина

**Решение**: Убедитесь, что функция `intercept::api_version()` определена и экспортируется

```cpp
int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}
```

### Crash при вызове SQF функций

**Проблема**: Игра вылетает при вызове `sqf::...` функций

**Решения**:
1. НЕ вызывайте SQF функции из других потоков
2. Используйте `is_null()` перед работой с объектами
3. Проверяйте типы данных перед конвертацией

```cpp
types::object player = sqf::player();
if (!player.is_null()) {
    // Безопасно работать с player
}
```

### Проблемы с линковкой

**Проблема**: Ошибки при линковке с `intercept_client.lib`

**Решения**:
1. Проверьте, что путь к Intercept правильный
2. Убедитесь, что используете ту же конфигурацию (Debug/Release)
3. Проверьте, что CMake нашёл Intercept: `find_package(intercept REQUIRED)`

## Следующие шаги

Теперь, когда у вас работает базовый плагин, изучите:

1. [Систему типов](Types/README.md) - Работа с game_value, game_data
2. [API плагинов](API/README.md) - Все доступные функции
3. [Примеры](Examples/README.md) - Готовые примеры кода
4. [Архитектуру](ARCHITECTURE.md) - Понимание внутренней работы

## Полезные ссылки

- [RVEngine GitHub](https://github.com/intercept/intercept)
- [Примеры плагинов](https://github.com/intercept/intercept-examples)
- [Discord сообщество](https://discord.com/invite/qF5qUacg63)
- [Arma 3 Commands](https://community.bistudio.com/wiki/Category:Arma_3:_Scripting_Commands)

---

**Поздравляем!** Вы создали свой первый плагин для RVEngine. Теперь вы можете расширять функциональность Arma 3 с помощью высокопроизводительного C++ кода!


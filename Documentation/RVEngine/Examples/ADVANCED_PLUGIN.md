# Advanced Plugin - Продвинутый плагин

Комплексный плагин с интерфейсами, многопоточностью и пользовательскими типами.

## Функциональность

- Регистрация plugin interface
- Фоновая обработка данных
- Пользовательские команды
- Event handlers
- Логирование в файл

## plugin_interface.hpp

```cpp
#pragma once

struct MyPluginAPI {
    void (*log_message)(const char* msg);
    int (*get_stat)(const char* stat_name);
    void (*process_async)(int data, void (*callback)(int result));
};
```

## main.cpp

```cpp
#include <intercept.hpp>
#include <fstream>
#include <thread>
#include <queue>
#include <mutex>
#include "plugin_interface.hpp"

using namespace intercept;

// Логирование
std::ofstream log_file;
std::mutex log_mutex;

void log_message_impl(const char* msg) {
    std::lock_guard<std::mutex> lock(log_mutex);
    log_file << msg << std::endl;
    log_file.flush();
}

// Статистика
std::unordered_map<std::string, int> stats;

int get_stat_impl(const char* stat_name) {
    return stats[stat_name];
}

// Асинхронная обработка
struct AsyncTask {
    int data;
    std::function<void(int)> callback;
};

std::queue<AsyncTask> task_queue;
std::mutex queue_mutex;

void process_async_impl(int data, void (*callback)(int result)) {
    std::thread([data, callback]{
        // Тяжёлая обработка
        std::this_thread::sleep_for(std::chrono::seconds(2));
        int result = data * 2;
        
        // Добавить в очередь для on_frame
        std::lock_guard<std::mutex> lock(queue_mutex);
        task_queue.push({data, [callback, result](int){ callback(result); }});
    }).detach();
}

// API
MyPluginAPI g_api = {
    log_message_impl,
    get_stat_impl,
    process_async_impl
};

// Lifecycle
int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}

void intercept::pre_start() {
    log_file.open("my_plugin_log.txt", std::ios::app);
    log_message_impl("Plugin loading...");
}

void intercept::register_interfaces() {
    client::host::register_plugin_interface("MyPlugin", 1, &g_api);
    log_message_impl("Interface registered");
}

void intercept::pre_init() {
    // Регистрация команд
    client::host::register_sqf_command(
        "myGetStat",
        "Gets plugin stat",
        [](game_state& state, game_value_parameter arg) -> game_value {
            std::string stat_name = arg;
            return stats[stat_name];
        },
        types::game_data_type::SCALAR,
        types::game_data_type::STRING
    );
}

void intercept::post_init() {
    log_message_impl("Plugin initialized");
    sqf::system_chat("Advanced plugin loaded");
}

void intercept::on_frame() {
    // Обработка async результатов
    std::lock_guard<std::mutex> lock(queue_mutex);
    while (!task_queue.empty()) {
        auto task = task_queue.front();
        task_queue.pop();
        
        task.callback(task.data);
    }
}

void intercept::killed(types::object& unit, types::object& killer) {
    stats["kills"]++;
    log_message_impl("Kill registered");
}

void intercept::handle_unload() {
    log_message_impl("Plugin unloading");
    log_file.close();
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    return TRUE;
}
```

## Использование из другого плагина

```cpp
void intercept::post_init() {
    // Запросить интерфейс
    auto interface = client::host::request_plugin_interface("MyPlugin", 1);
    
    if (interface) {
        MyPluginAPI* api = static_cast<MyPluginAPI*>(*interface);
        
        // Использовать
        api->log_message("Hello from other plugin");
        int kills = api->get_stat("kills");
        
        api->process_async(42, [](int result){
            sqf::hint("Result: " + std::to_string(result));
        });
    }
}
```

---

[Examples](README.md) | [Reference](../Reference/README.md)


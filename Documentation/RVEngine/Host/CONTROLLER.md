# Controller - Управление плагинами

Controller управляет жизненным циклом клиентских плагинов и диспетчеризацией событий.

## Основной класс

В `src/host/controller/controller.hpp`:

```cpp
class controller {
public:
    // Вызов lifecycle хуков у всех клиентов
    void call_pre_start();
    void call_post_start();
    void call_pre_init();
    void call_post_init();
    void call_on_frame();
    void call_mission_ended();
    
    // Диспетчеризация событий
    void dispatch_event(event_type type, game_value params);
};
```

## Отслеживание состояния

Controller следит за состоянием игры:

```cpp
enum class game_state_type {
    not_loaded,      // Игра не загружена
    pre_start,       // До инициализации
    running,         // Миссия запущена
    mission_ended    // Миссия завершена
};
```

## Диспетчеризация lifecycle

```
1. Arma 3 вызывает RVEngine через callExtension
2. Controller определяет текущий этап
3. Вызывает соответствующие хуки у всех клиентов:
   - pre_start()
   - post_start()
   - pre_init()
   - post_init()
   - on_frame()
   - mission_ended()
```

## Диспетчеризация событий

```cpp
// При возникновении события в игре
void dispatch_killed_event(object unit, object killer) {
    // Для каждого клиента
    for (auto& client : clients) {
        if (client.has_killed_handler) {
            client.killed(unit, killer);
        }
    }
}
```

## Очередь событий

Controller использует очередь для thread-safety:

```cpp
struct queued_event {
    event_type type;
    game_value params;
};

std::queue<queued_event> event_queue;
std::mutex queue_mutex;
```

---

[Host README](README.md) | [Extensions](EXTENSIONS.md)


# Многопоточность

## Важно: Движок НЕ потокобезопасен

**RV Engine не является потокобезопасным!** Вызовы SQF функций должны происходить только из главного игрового потока.

## Безопасная модель

### Обработка данных в фоне, результаты в on_frame

```cpp
// Очередь для результатов
std::queue<std::vector<int>> results_queue;
std::mutex queue_mutex;

// Фоновый поток
std::thread worker([]{
    // Тяжёлая обработка (безопасно)
    std::vector<int> processed_data = heavy_computation();
    
    // Добавить результат в очередь
    {
        std::lock_guard<std::mutex> lock(queue_mutex);
        results_queue.push(processed_data);
    }
});
worker.detach();

// Главный поток
void intercept::on_frame() {
    std::lock_guard<std::mutex> lock(queue_mutex);
    
    while (!results_queue.empty()) {
        auto data = results_queue.front();
        results_queue.pop();
        
        // Безопасно использовать SQF
        sqf::hint("Data processed");
    }
}
```

## invoker_lock

Для защиты доступа к Invoker:

```cpp
void background_thread() {
    // Подготовка данных (без SQF вызовов)
    std::vector<types::vector3> positions;
    
    // Критическая секция с SQF вызовами
    {
        client::invoker_lock lock;
        
        // Теперь безопасно вызывать SQF
        types::object player = sqf::player();
        sqf::hint("Thread-safe call");
    } // Автоматическая разблокировка
}
```

## Отложенная блокировка

```cpp
client::invoker_lock lock(true);  // Отложенная

// ... подготовка данных ...

lock.lock();    // Явная блокировка
// SQF вызовы
lock.unlock();  // Явная разблокировка
```

## Паттерны

### Task Queue

```cpp
struct Task {
    std::function<void()> work;
    std::function<void()> callback;
};

std::queue<Task> task_queue;
std::mutex queue_mutex;

// Добавление задачи
void add_task(std::function<void()> work, std::function<void()> callback) {
    std::thread([work, callback]{
        work();  // Выполнить в фоне
        
        std::lock_guard<std::mutex> lock(queue_mutex);
        Task task;
        task.callback = callback;
        task_queue.push(task);
    }).detach();
}

// Обработка в on_frame
void intercept::on_frame() {
    std::lock_guard<std::mutex> lock(queue_mutex);
    while (!task_queue.empty()) {
        auto task = task_queue.front();
        task_queue.pop();
        
        task.callback();  // Безопасно вызвать SQF
    }
}

// Использование
add_task(
    []{ /* тяжёлая работа */ },
    []{ sqf::hint("Done"); }
);
```

### Future/Promise

```cpp
std::promise<int> result_promise;
auto result_future = result_promise.get_future();

std::thread([promise = std::move(result_promise)]() mutable {
    int result = heavy_computation();
    promise.set_value(result);
}).detach();

// В on_frame
void intercept::on_frame() {
    if (result_future.valid() && 
        result_future.wait_for(std::chrono::seconds(0)) == std::future_status::ready) {
        int result = result_future.get();
        sqf::hint("Result: " + std::to_string(result));
    }
}
```

## ❌ ОПАСНО - НЕ ДЕЛАЙТЕ ТАК

```cpp
// ❌ Вызов SQF из потока без защиты
std::thread([]{ 
    sqf::hint("BAD!");  // CRASH!
}).detach();

// ❌ Работа с game_value в потоке
std::thread([]{
    game_value val = 42;  // Опасно!
    // game_value использует аллокаторы движка
}).detach();

// ❌ Получение игровых данных в потоке
std::thread([]{
    types::object player = sqf::player();  // CRASH!
}).detach();
```

## ✅ БЕЗОПАСНО

```cpp
// ✅ Только вычисления
std::thread([]{
    std::vector<int> data;
    for (int i = 0; i < 1000000; i++) {
        data.push_back(i * i);
    }
    // Передать результат в главный поток
}).detach();

// ✅ С invoker_lock
std::thread([]{
    client::invoker_lock lock;
    sqf::hint("Safe");  // Защищено
}).detach();

// ✅ Через очередь
std::thread([]{
    auto result = compute();
    {
        std::lock_guard lock(g_mutex);
        g_queue.push(result);
    }
}).detach();
```

## game_value_threadsafe

Потокобезопасная версия с отложенным освобождением:

```cpp
std::thread([]{
    game_value_threadsafe val = 42;
    // При выходе из области видимости память не освобождается сразу
}).detach();

// В on_frame
void intercept::on_frame() {
    game_value_threadsafe::garbage_collect();  // Освободить память
}
```

---

[API README](README.md) | [Lifecycle](LIFECYCLE.md) | [Best Practices](../Reference/BEST_PRACTICES.md)


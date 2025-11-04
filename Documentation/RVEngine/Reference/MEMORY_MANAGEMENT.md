# Управление памятью

## Reference Counting

### refcount

Базовый класс с подсчётом ссылок:

```cpp
class refcount {
    std::atomic<int> _ref_count{0};
public:
    int add_ref() { return ++_ref_count; }
    int release() {
        int count = --_ref_count;
        if (count == 0) delete this;
        return count;
    }
};
```

### ref<T>

Умный указатель:

```cpp
template<typename Type>
class ref {
    Type* _ref;
public:
    ref() : _ref(nullptr) {}
    
    ref(Type* new_ref) : _ref(new_ref) {
        if (_ref) _ref->add_ref();
    }
    
    ~ref() {
        if (_ref) _ref->release();
    }
    
    // Copy
    ref(const ref& copy) : _ref(copy._ref) {
        if (_ref) _ref->add_ref();
    }
    
    // Move
    ref(ref&& move) noexcept : _ref(move._ref) {
        move._ref = nullptr;
    }
};
```

### Использование

```cpp
ref<game_data> data = new game_data_number(42);
// Автоматическое управление временем жизни
```

### Методы ref<T>

#### Доступ к указателю

```cpp
ref<game_data> data = new game_data_number(42);

// DEPRECATED: старый метод (не используйте!)
Type* ptr1 = data.getRef();  // ❌ Устарело, будет удалено

// РЕКОМЕНДУЕТСЯ: используйте get()
Type* ptr2 = data.get();  // ✅ Правильно

// Оператор -> для доступа к членам
r_string str = data->to_string();
float num = data->get_as_number();

// Неявная конвертация в указатель
Type* raw_ptr = data;  // operator Type*()

// Явная конвертация
game_data* explicit_ptr = static_cast<game_data*>(data.get());
```

#### Проверки

```cpp
ref<game_data> data = /* ... */;

// Проверка на null - метод is_null()
if (data.is_null()) {
    // Указатель == nullptr
}

// Проверка через implicit bool conversion
if (data) {
    // Указатель != nullptr (безопасно использовать)
}

if (!data) {
    // Указатель == nullptr
}

// Получить счётчик ссылок
size_t count = data.ref_count();
std::cout << "Reference count: " << count << std::endl;
```

#### Управление временем жизни

```cpp
ref<game_data> data = new game_data_number(42);

// Ручное освобождение ссылки
data.free();  // Вызывает release() и устанавливает _ref в nullptr

// После free() указатель равен nullptr
if (data.is_null()) {
    std::cout << "Data freed" << std::endl;
}

// Обмен содержимым двух ref<>
ref<game_data> other = new game_data_string("test");
data.swap(other);
// Теперь data указывает на строку, other на число
```

#### Присваивание

```cpp
// Присваивание из указателя
ref<game_data> data;
data = new game_data_number(42);  // Автоматический add_ref()

// Копирующее присваивание
ref<game_data> copy;
copy = data;  // Увеличивает счётчик ссылок

// Перемещающее присваивание
ref<game_data> moved;
moved = std::move(data);  // data становится nullptr
```

#### Сравнение

```cpp
ref<game_data> data1 = new game_data_number(42);
ref<game_data> data2 = data1;  // Тот же объект
ref<game_data> data3 = new game_data_number(42);  // Другой объект

// Сравнение указателей (не значений!)
if (data1 != data2) {
    // Указывают на разные объекты
}

if (data1 != data3) {
    // true - разные объекты, хотя значения одинаковые
}

// Сравнение с nullptr
if (data1 != nullptr) {
    // Не null
}
```

### Пример: Подсчёт ссылок

```cpp
ref<game_data> data1 = new game_data_number(42);
std::cout << "Refs: " << data1.ref_count() << std::endl;  // 1

{
    ref<game_data> data2 = data1;  // Копирование
    std::cout << "Refs: " << data1.ref_count() << std::endl;  // 2
    
    ref<game_data> data3 = data1;
    std::cout << "Refs: " << data1.ref_count() << std::endl;  // 3
} // data2 и data3 уничтожены

std::cout << "Refs: " << data1.ref_count() << std::endl;  // 1
```

## Аллокаторы

### rv_allocator<T>

```cpp
// Выделение
Type* ptr = rv_allocator<Type>::create_single();
Type* arr = rv_allocator<Type>::create_array(count);

// Освобождение
rv_allocator<Type>::destroy_deallocate(ptr);
rv_allocator<Type>::destroy_deallocate_array(arr, count);
```

### rv_pool_allocator

Для часто создаваемых типов:

```cpp
void* operator new(std::size_t sz) {
    return pool_alloc_base->allocate(sz);
}

void operator delete(void* ptr, std::size_t sz) {
    pool_alloc_base->deallocate(ptr);
}
```

## Лучшие практики

```cpp
// ✅ Используйте ref<>
ref<game_data> data = new game_data_number(42);

// ✅ Избегайте сырых указателей
// ❌ game_data* data = new game_data_number(42);

// ✅ Move semantics
game_value create() {
    return game_value(42);  // Move
}

// ❌ Избегайте лишних копий
// game_value create() {
//     game_value val = 42;
//     return val;  // Копирование
// }
```

---

[Reference](README.md) | [Error Handling](ERROR_HANDLING.md)


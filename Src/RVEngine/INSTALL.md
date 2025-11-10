# RVEngine Build and Deployment Scripts

Коллекция batch-скриптов для автоматизации сборки и развертывания проекта RVEngine (Intercept).

## Скрипты

### 1. GENERATE_VCPROJ.bat
Генерирует файлы проекта Visual Studio 2022 в папке `vcproj64`.

**Использование:**
```bat
GENERATE_VCPROJ.bat
```

**Что делает:**
- Проверяет наличие CMake в PATH
- Создает папку `vcproj64` если её нет
- Генерирует Visual Studio 2022 проект (x64)
- Создает solution file `vcproj64/Intercept.sln`

---

### 2. BUILD.bat
Собирает проект используя CMake.

**Использование:**
```bat
BUILD.bat [Debug|Release]
```

**Примеры:**
```bat
BUILD.bat          # Сборка Release (по умолчанию)
BUILD.bat Debug    # Сборка Debug
BUILD.bat Release  # Сборка Release
```

**Что делает:**
- Проверяет наличие сгенерированного проекта
- Собирает указанную конфигурацию
- Выходные файлы: `vcproj64/build/[Debug|Release]/`

---

### 3. DEPLOY.bat
Развертывает собранные файлы в целевую директорию Arma 3.

**Использование:**
```bat
DEPLOY.bat [опции]
```

**Опции:**
- `-R` - Release сборка (по умолчанию)
- `-D` - Debug сборка
- `-P` - Развернуть плагины вместе с Intercept
- `-PO` - Развернуть ТОЛЬКО плагины (без обновления Intercept Core)

**Примеры:**
```bat
DEPLOY.bat              # Только Intercept (Release)
DEPLOY.bat -D           # Только Intercept (Debug)
DEPLOY.bat -R -P        # Intercept + плагины (Release)
DEPLOY.bat -D -P        # Intercept + плагины (Debug)
DEPLOY.bat -PO          # Только плагины (Release)
DEPLOY.bat -D -PO       # Только плагины (Debug)
```

**Целевой путь:**
```
P:\armatools\steamapps\common\Arma 3\@EditorContent
```

**Что развертывается:**

#### Intercept Core (без флагов или с `-P`):
- `intercept_x64.dll` → `@EditorContent/`
- `intercept_x64.pdb` → `@EditorContent/` (если есть)
- `intercept_x64_static.dll` → `@EditorContent/` (если есть)

#### Plugins (с флагом `-P` или `-PO`):
- `*.dll` → `@EditorContent/intercept/`
- `*.pdb` → `@EditorContent/intercept/` (отладочные символы)
- `intercept_client.lib` → `@EditorContent/intercept/`

---

### 4. CLEAN.bat
Удаляет папку `vcproj64` для чистой регенерации проекта.

**Использование:**
```bat
CLEAN.bat
```

**Что делает:**
- Запрашивает подтверждение
- Удаляет папку `vcproj64` со всеми сгенерированными файлами

---

## Типичные рабочие процессы

### Первая настройка проекта
```bat
1. GENERATE_VCPROJ.bat    # Генерация проекта
2. BUILD.bat Release      # Сборка Release
3. DEPLOY.bat -R -P       # Развертывание с плагинами
```

### Быстрая разработка плагинов
```bat
# После изменения кода плагина:
BUILD.bat Debug           # Пересборка Debug версии
DEPLOY.bat -D -PO         # Обновление только плагинов
```

### Обновление только Intercept Core
```bat
BUILD.bat Release
DEPLOY.bat -R             # Без флага -P = только Core
```

### Полное обновление (Core + Plugins)
```bat
BUILD.bat Release
DEPLOY.bat -R -P          # С флагом -P = все компоненты
```

### Чистая пересборка
```bat
CLEAN.bat                 # Удаление старых файлов
GENERATE_VCPROJ.bat       # Регенерация проекта
BUILD.bat Release         # Сборка
DEPLOY.bat -R -P          # Развертывание
```

---

## Структура выходных файлов

После сборки файлы располагаются в:
```
vcproj64/
└── build/
    ├── Debug/
    │   ├── intercept/
    │   │   ├── intercept_x64.dll
    │   │   ├── intercept_x64.pdb
    │   │   └── intercept_x64_static.dll
    │   ├── plugins/
    │   │   ├── rv_client_x64.dll
    │   │   └── rv_client_x64.pdb
    │   └── intercept_client/
    │       ├── intercept_client.lib
    │       └── intercept_client.pdb
    └── Release/
        └── (аналогичная структура)
```

---

## Требования

- **CMake** ≥ 3.8 (должен быть в PATH)
- **Visual Studio 2022** (с C++ toolchain)
- **Windows PowerShell** (для выполнения batch-скриптов)

---

## Настройка целевого пути

Чтобы изменить путь развертывания, отредактируйте `DEPLOY.bat`:

```bat
set "TARGET_PATH=P:\armatools\steamapps\common\Arma 3\@EditorContent"
```

Замените на свой путь к Arma 3.

---

## Добавление новых плагинов

1. Создайте папку в `src/plugins/your_plugin/`
2. Добавьте `CMakeLists.txt` и исходные файлы
3. Добавьте строку в `src/plugins/CMakeLists.txt`:
   ```cmake
   add_subdirectory(your_plugin)
   ```
4. Регенерируйте проект: `GENERATE_VCPROJ.bat`
5. Соберите и разверните: `BUILD.bat -P` → `DEPLOY.bat -R -P`

---

## Отладка

### Проблема: "CMake not found"
**Решение:** Установите CMake и добавьте в PATH

### Проблема: "Project not generated"
**Решение:** Запустите `GENERATE_VCPROJ.bat` перед сборкой

### Проблема: "Build directory not found"
**Решение:** Запустите `BUILD.bat` перед развертыванием

### Проблема: "Target directory not found"
**Решение:** Проверьте путь в `DEPLOY.bat` (строка 10)

---

## Автор

Скрипты созданы для упрощения разработки и развертывания RVEngine/Intercept проектов.


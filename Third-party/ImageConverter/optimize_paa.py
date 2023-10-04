import os
import subprocess
import sys
from PIL import Image

# Путь до Pal2PacE
pal2pace_path = r'.\Pal2PacE.exe'

if not os.path.exists(pal2pace_path):
    print("paltopac not found")
    sys.exit(1)

# Получение пути к папке из аргументов командной строки
if len(sys.argv) != 2:
    print("Пожалуйста, перетащите папку на скрипт.")
    sys.exit(1)

folder_path = sys.argv[1]

# Перебор всех файлов в папке
for filename in os.listdir(folder_path):
    filepath = os.path.join(folder_path, filename)

    # Если имя файла оканчивается на "_co.paa", выполняем конвертацию
    if filename.endswith('_co.paa'):
        # Полный путь до исходного файла
        source_fullpath = filepath

        # Создаем путь для сохранения временного PNG-файла
        temp_png_fullpath = source_fullpath.replace('_co.paa', '_co.png')

        # Подстановка пути в команду для выполнения конвертации в PNG
        png_conversion_command = f'"{pal2pace_path}" "{source_fullpath}" "{temp_png_fullpath}"'

        # Запуск программы для конвертации в PNG
        subprocess.run(png_conversion_command, shell=True)

        # Проверяем размер PNG-файла
        if os.path.exists(temp_png_fullpath):
            img = Image.open(temp_png_fullpath)
            width, height = img.size
            img.close()

            # Если размер больше 1024x1024, выполняем конвертацию с параметром -size=1024
            if width > 1024 or height > 1024:
                # Подстановка пути в команду для выполнения конвертации с измененным размером
                conversion_command = f'"{pal2pace_path}" -size=1024 "{temp_png_fullpath}" "{source_fullpath}"'

                # Запуск программы для конвертации с измененным размером
                subprocess.run(conversion_command, shell=True)

            # Удаляем временный PNG-файл
            os.remove(temp_png_fullpath)
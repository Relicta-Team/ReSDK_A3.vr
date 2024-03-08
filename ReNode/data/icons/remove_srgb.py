from PIL import Image
import os

# Путь к папке с изображениями
image_folder = "."

# Получите список файлов в папке
image_files = [f for f in os.listdir(image_folder) if os.path.isfile(os.path.join(image_folder, f))]

for image_file in image_files:
	if not image_file.endswith(".png"):
		continue
	image_path = os.path.join(image_folder, image_file)
	print(f"handle {image_path}")
	# Откройте изображение с помощью Pillow
	img = Image.open(image_path)

	print(f"data: {img.info.keys()}")
	if "icc_profile" in img.info.keys() and b"" in img.info.get('icc_profile',b''):
		img.info.pop("icc_profile")
		print(f'icc_profile removed')
		img.save(image_path)

print("Профиль sRGB удален из всех изображений в папке.")
#input()
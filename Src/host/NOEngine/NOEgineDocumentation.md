

Проблема перегрузки чанка:
	Когда клиент зашёл в изменённый чанк, он отправляет запрос на сервер с его временной отметкой
	Если отметки отличаются все объекты промаркированные позже этого момента


Данный компонент предоставляется по технологии общей компонентной системы

Информация на клиенте по каждому объекту:
указатель (строка) ~10байт
ключи:
	тип объекта: простой или динамический

	использует мировую позицию: да/нет
	использует вектор направления: да/нет
	1[тип объ,мирпоз,векнапр,свет,аним,тех]
	10000
референс на модель (число или строка) 8байт
	число - ссылка на индекс в карте моделей
позиция (вектор) 3*8~24байт где первый байт тип создания объекта и аллокации объекта



направление (вектор или число)
	вектор
		3*8~24байта
	число
		8 байт
вектор ротации (вектор) 3*8~24байта или null если стандартный вектор [0,0,1]
--далее опционально (не идёт в счёт пакета)--
источник света или звука (число) 8 байт - просто указатель на клиентскую карту света
//текстура (строка или число)


Итого: 10+8+32+8+8 : 66 байт на один объект (66 * 500 /1024) ->32кб для 500 объектов

Симуляция ситуации с перегрузкой:
Клиент зашёл в чанк. Абстрагировавшись от условий он загрузил всю инфу
Клиент выходит из чанка
В чанке происходят изменения нескольких объектов
	меняется позиция и свет - обновляются указатели отметки чанка
Клиент возвращается в чанк и отправляет стандартный запрос проверки с последней отметкой времени
На сервере проверяем запрос
	Отметка времени отличается
		проходимся по списку всех объектов
			Объекты чья отметка времени больше клиентской - добавляются в отправщик
			Отправляем клиенту данные

Клиент обрабатывает данные, загружает карту...

У клиента данные об объектах должны храниться в сериализованном виде:
key: serverHash,
value: [objPtr,arraypos]
Когда загружается чанк клиент распаковывает и отсортировывет всё по хэшам.
После этого все объекты грузятся в память клиенту


Информация о пакете объекта

[
	указатель
	простой ли объект
	ссылка на модель
	позиция
	направление
	вектор направления (vecup)
	свет?
]

варианты выгрузки объекта:
Если клиент в чанке:
	просто удаляем
Если клиент не в чанке:
	У клиентов хранится информация о загруженных чанках.
	Когда объект выгружается проходим по циклу всех клиентов смотрим у кого этот чанк выгружен и отсылаем ему удаление

Как выгружать, загружать свет:
	---


Возможный порядок дополнительных данных объекта:
	Нумерация:
		свет
		анимации
		текстура

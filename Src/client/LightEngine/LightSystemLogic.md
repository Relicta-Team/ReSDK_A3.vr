
# Лоигка процесса обработки освещения

Северные процессы уже готовы. Остаётся вопрос как клиент обрабатывает публичные данные.

Все данные получаются из объекта `le_glsData`. Локальные подтверждённые данные хранятся в `le_localGlsData`
Данные типы объектов обрабатываются с помощью макросов обозначенных ниже:
	getGLSData(chunkType,chunkPosX,chunkPosY) - получает информацию о чанке в формате массива
		Первый элемент всегда является уникальным айди, который меняется при изменениях световых источников
		в чанке. Даже если объектов в чанке нет, айди всё-равно существует
		
	getLocalGLSData(chunkType,chunkPosX,chunkPosY) - получает локальные клиентские данные в массиве. 
		Формат массива идентичен глобальному типу GLSData.
		
	setLocalGLSData(chunkType,chunkPosX,chunkPosY) - устанавливает значение синхронизированных данных чанка.
		По сути информация в этом массиве копируется из глобального типа GLSData
		
	glsNull - нулевой указатель типа GLSData. Используется в случаях когда:
		- информация о чанке не определена или не содержит источников света
		- локальный чанк не содержит никакой информации (отсутствуют декларации)
		
Используя данный функционал мы можем управлять источниками света. Обработка выполняется в специальном
потоке, который через определённые промежутки времени опрашивает все чанки, доступные локальному клиенту и
при необходимости загружает источники света с помощью конфигов. 
Информация, хранящаяся на объекте:
	__light - ссылка на источник света.
	__hash - уникальный айди gls чанка, который вызвал создание источника света.
	light - серверная ссылка на конфиг света
Информация, хранящаяся на источнике света:
	__config - нумератор конфигурации освещения.
	
Ниже полное описание процедуры опроса чанков на псевдокоде:

старт

получаем массив всех чанков, которые нужно опросить (реализация не имеет значения)

проход по массиву чанков
	если в памяти локального чанка возвращает glsNull то
		если в чанке есть объекты
			проход по массиву объектов
				создать источник освещения
			
			синхронизировать локальные данные чанка
		или
			синхронизировать локальные данные чанка
	или
		если хэши локального и глобального чанка различаются то
			проход по циклу объектов глобального чанка
			 	если свет на объекте не загружен
					загружаем свет
			объекты на убирание света = из старых объектов вычетаем новые 
			проход по циклу убирания света
				убираем свет 
			
			обновляем данные
		или
			ничего
		
	
# Логика персонажных предметов

Цель заключается в том, чтобы держать все синхронизируемые данные в общем пуле.


# Логика системы рендеринга света
Соблюдаются 3 правила: 
	чем больше предмет, тем меньше он пропускает света. Конфиг размера из boundingBoxReal
	уровень освещённости персонажа - более высокие значения купируют размеры объекта
	
	canVisibleLight - 
		линия от источника до камеры исключая источник и макс возвратом 10
		проход по циклу объектов
			_size = 
			
			
			
# Новый концепт на основе расстояний

Диапазонная система
Свет создаётся - 
высчитываются 2 точки верхняя точка света и нижняя точка где он попадает в пол



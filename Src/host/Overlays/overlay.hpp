// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// слои отображения
#define OVERLAY_LAYER_HEAD 0
#define OVERLAY_LAYER_FACE 2
#define OVERLAY_LAYER_BODY 3
#define OVERLAY_LAYER_ARMOR 4
#define OVERLAY_LAYER_BACKPACK 5

#define OVERLAY_LAYER_LIST_ALL [OVERLAY_LAYER_HEAD,OVERLAY_LAYER_FACE,OVERLAY_LAYER_BODY,OVERLAY_LAYER_ARMOR,OVERLAY_LAYER_BACKPACK]


/* 
	режим наслоения предмета. самый последний предмет в списке является отображаемым
	base - добавляется всегда в начало списка
	normal - добавляется в обычном порядке по приоритету
	external - добавляется всегда в конец списка
*/
#define OVERLAY_PRIORITY_BASE 0
#define OVERLAY_PRIORITY_NORMAL 1
#define OVERLAY_PRIORITY_EXTERNAL 2
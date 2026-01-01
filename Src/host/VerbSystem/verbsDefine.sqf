// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

#define verb(class,name,verbargs) _lastVerbClassName = 'class'; verb_list set [_lastVerbClassName,[name,_verbLastIndex,verbargs]]; verb_inverted_list set [_verbLastIndex,_lastVerbClassName]; INC(_verbLastIndex);

#define noargs null

verb_list = createHashMap;
verb_inverted_list = createHashMap;
private _verbLastIndex = 0;

verb(description,"Показать описание",noargs)
verb(description3d,"Осмотреть",noargs)
verb(standupfromchair,"Встать",noargs)
verb(smell,"Понюхать",noargs)
verb(clean,"Очистить от грязи",noargs)
verb(doempty,"Вылить содержимое",noargs)
verb(extinguish,"Вылить на",noargs)
verb(pull,"Тащить",noargs)
verb(pulltransform,"Повернуть",noargs)
verb(craft,"Создать",noargs)
verb(craft_here,"Создать здесь",noargs)
//verb(changeatt,"Сменить тип атаки",noargs)
verb(pickup,"Взять",noargs)
verb(undress,"Раздеть",noargs)
verb(twohands,"Двумя руками",noargs)
verb(transitem,"Отдать предмет",noargs)
verb(mainact,"Действие",noargs)
verb(wpnopnmode,"Оружие",noargs) //пример: разломить, соеденить
	verb(spinrev,"Крутить барабан",noargs)
	verb(dropammorev,"Опустошить барабан",noargs)
verb(showOrgans,"Внутренности",noargs)
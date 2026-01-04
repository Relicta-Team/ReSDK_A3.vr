// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define TIME_UNCONSCIOUS_ONWOUND randInt(10,60)

#define TIME_STUN_ONWOUND 2

//модификатор входа в комбат
#define TIME_RTA_MODIF_READY_FOR_FIGHT 0.3
//модификатор для RTA после атаки ближнего боя
#define TIME_RTA_MODIF_ATTACK_MELEE 1.3
//модификатор задержки времени стрельбы
#define TIME_RTA_MODIF_ATTACK_RANGED 0.5
//модификатор метания
#define TIME_RTA_MODIF_THROWING 2
//модификатор парирования
#define TIME_RTA_MODIF_PARRY 1.1
#define TIME_RTA_MODIF_PARRY_UNBALANCED 2
#define TIME_RTA_MODIF_PARRY_FENCING 0.5

//частота вызова метода проверки реакции
#define TIME_ATMOS_MAIN_HANDLER_UPDATE 0.1
//таймеры реакции моба на атмос. для тела и ног
#define TIME_ATMOS_DELAY_REACT_BODY 0.7
#define TIME_ATMOS_DELAY_REACT_LEGS 0.7
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define GERM_COUNT_MAX 100 
#define GERM_LIST_NAMES ["","<t color='#ddddbb'>Грязновато</t>","<t color='#aaaa55'>Грязно</t>","<t color='#666633' size='1.3'>Очень грязно</t>","<t color='#4d4d00' size='1.6'>ГРЯЗИЩА</t>"]
#define GERM_LIST_HUMAN_INFO ["","немного грязи","грязь","много грязи","очень грязно"]
#define GERM_LIST_HUMAN_COLOR ["","#ddddbb","#aaaa55","#666633","#4d4d00"]
#define GERM_LIST_COUNTS [0,20,40,60,GERM_COUNT_MAX]
#define GERM_COUNT_TO_NAME(val) (GERM_LIST_NAMES select (GERM_LIST_COUNTS findif {val <= _x}))
#define GERM_HUMAN_COUNT_TO_NAME(val) (GERM_LIST_HUMAN_INFO select (GERM_LIST_COUNTS findif {val <= _x}))
#define GERM_HUMAN_COUNT_TO_COLOR(val) (GERM_LIST_HUMAN_COLOR select (GERM_LIST_COUNTS findif {val <= _x}))
#define GERM_CONV_VALUE_TO_OPACITY(val) linearConversion [0,GERM_COUNT_MAX,val,1,0.5,true]
#define GERM_CONV_VALUE_TO_VISIBILITY_DECAL(val) linearConversion [0,GERM_COUNT_MAX,val,0,1,true]

//сколько микробов должно быть для инфекции
#define GERM_COUNT_INFECTION 25
// минимальный размер раны для инфекции
#define GERM_MIN_WOUND_SIZE WOUND_SIZE_MINOR
//размер инфекции
#define INFECTION_MAX_LEVEL 4
#define INFECTION_MIN_LEVEL 1
//больше или равно этому значению будет пахнуть
#define INFECTION_LEVEL_TOSMELL 3

// все что выше этого уровня считается непоправимым и нужно только отрубать конечность
#define INFECTION_LEVEL_TO_CAN_HEAL 2
// Время для уровней. 5+6+10+15 = 36 минуты для уровней 1-4.
#define INFECTION_LIST_DELAY_NEXTLEVEL [0, 60*5, 60*6, 60*10, 60*15]

#ifdef EDITOR
#define INFECTION_LIST_DELAY_NEXTLEVEL [0, 30, 30, 30, 60]
#endif
// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



#define EFFECT_EVENT_INDEX_CREATE 0
#define EFFECT_EVENT_INDEX_DESTROY 1
#define EFFECT_EVENT_INDEX_UPDATE 2

#define effect(class) _data = [{},{},{}]; _lasteff = tolower 'class';_lasteffstruct = [_lasteff,_data]; [{

#define destroy }]; _data set [EFFECT_EVENT_INDEX_DESTROY,{ 

#define create }]; _data set [EFFECT_EVENT_INDEX_CREATE,{
	
#define update }]; _data set [EFFECT_EVENT_INDEX_UPDATE,{

#define end }]; locef_allEffectsCfg set _lasteffstruct;

#define thisEventName _name

#define thisContext _ctx

#define jumpto(index) call(locef_allEffectsCfg get thisEventName select index)

#define updateContext(newdata) locef_allActiveEffects set [thisEventName,newdata]
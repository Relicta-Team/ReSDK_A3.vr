// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



#define emitter ped_emitterObject

//file,index bias(in bilboard mode only),blib index,drop flow
#define enum_par_sprite 0
//---> anim name 1 does not use. 
/*String - Enum: Billboard, SpaceObject*/
#define enum_par_partype 2
//---> time period. Не понял чё делает. Оставляем как 1. enum:3
// время жизни прямо влияет на переходное значение в drop flows
#define enum_par_lifetime 4
//pos relative to ref obj
#define enum_par_relpos 5 
//velocity (не сильно воспримчив но работает)
#define enum_par_velocity 6
//rotation. 
#define enum_par_rotation 7
//weight. между падением и лётом от 1.5 до 2
#define enum_par_weight 8 
//volume (объём) но я понимаю как множитель ускорения
#define enum_par_volume 9
//rubbing (кучкование). 0 нет, больше - плотнее частицы на выходе
#define enum_par_rubbing 10
//size (величина частиц)
#define enum_par_size 11
//colors
/*
	0 - arr (basic color)
	1 - arr (onTransform color)
	2 - arr finalize color
*/
#define enum_par_colors 12
//---> anim phase arr do not visible effect 13
// частота рандомизации смещения частицы в секундах
#define enum_par_randDirPeriod 14 
//интенсивность этого смещения
#define enum_par_randDirIntensity 15
//---> 16 and 17 fucked slow events. fuck this
// ---> 18 reference object. Тот, к кому прилинкан предмет. Всегда должен являться фактическим эмиттером.
//наклон частицы при создании. По тестам колеблется от 0 до 6
#define enum_par_angle 19 


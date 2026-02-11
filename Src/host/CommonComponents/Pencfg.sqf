// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
//penetration configs


//common data
pencfg_map_all = createHashMap;

#define addtobj(model,soundpen,armpen)  pencfg_map_all set [tolower model,[soundpen,armpen]]

pencfg_isExistsModel = {
	(
		tolower ((getModelInfo _this)select 1)
	) in pencfg_map_all
};

pencfg_handleVoice = {
	params ["_obj","_srcDist"];

	private _prMod = pencfg_map_all get (
		tolower ((getModelInfo _obj)select 1)
	) select 0;
	/*
		_prMod - процент громкости звука.
		Чем выше значение тем лучше слышно звук
		Чем меньше значение, тем больше объект гасится

		Чем меньше значение _srcDist на выходе тем лучше будет слышно
	 */
	_srcDist - precentage(_srcDist,_prMod);
};

pencfg_handleObject_canPenetrate = {
	params ["_obj"];
	private _probPen = pencfg_map_all get (
		tolower ((getModelInfo _obj)select 1)
	) select 1;
	/*
		проходимость пули через объект.
		чем больше процент тем выше вероятность что пуля пройдёт сквозь объект
	*/
	prob(_probPen)
};


//Двери
addtobj("ml\ml_object_new\model_14_10\dooor.p3d",10,30); //Стальная зелёная дверь
addtobj("ml\ml_object_new\model_14_10\dwerrj.p3d",10,30); //Стальная тёмно-серая дверь
addtobj("apalon\metro_a3\door_solar\door_solar.p3d",15,40); //Стальная серая дверь
addtobj("ml\ml_object_new\ml_object_2\l01_props\reshetka.p3d",100,90); //решётчатая дверь
addtobj("ml_shabut\xlamdoor\xlamdoor.p3d",50,70); //дверь из хлама
addtobj("ml_exodusnew\doub_bronedwerks.p3d",100,95); //решётчатая дверь у вахтёра

//Стены и прочая хуйня
addtobj("ml_shabut\exodus\kaleetka.p3d",100,90); //решётка типо стена
addtobj("ml_exodusnew\ganzazhelezo3.p3d",10,30); //железная стенка из всякого говна
addtobj("ml\ml_object_new\ml_object_2\l01_props\stair.p3d",100,30); //железная лестница
addtobj("ml_shabut\exoduss\metalplate.p3d",10,30); //железный лист
addtobj("a3\structures_f_exp\civilian\sheds\shed_06_f.p3d",70,70); //проф лист какой-то
addtobj("a3\structures_f\households\slum\cargo_addon01_v2_f.p3d",70,70); //какая-то конструкция из труб и проф листа
addtobj("ml\ml_object_new\ml_object_2\l01_props\gate_bridge.p3d",1,1); //толстый железный мост с перилами
addtobj("ml_exodusnew\ganzazhelezo2.p3d",20,40); //тонкая стена из железного хлама
addtobj("ml\ml_object_new\model_05\zabori.p3d",90,80); //деревянный заборчик
addtobj("a3\structures_f\households\slum\slum_house01_f.p3d",70,70); //лачуга из проф листа
addtobj("a3\structures_f\households\slum\slum_house03_f.p3d",70,70); //лачуга из проф листа 3
addtobj("a3\structures_f_exp\walls\net\netfence_02_m_4m_f.p3d",100,100); //вроде сетка рабица
addtobj("a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d",70,70); //стена из проф листа
addtobj("a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d",70,70); //низкая стена из проф листа
addtobj("ml_shabut\tinfence\tinfence.p3d",70,70); //калитка из говна и палок
addtobj("metro_ob\model\fence01.p3d",100,95); //решётка оконная она же забор на кладбище
addtobj("a3\structures_f_enoch\cultural\cemeteries\gravefence_04_f.p3d",100,95); //забор из прутьев вокруг могилы
addtobj("a3\structures_f_enoch\cultural\cemeteries\gravefence_03_f.p3d",100,95); //забор вогруг могилы
addtobj("a3\structures_f_enoch\cultural\cemeteries\gravefence_02_f.p3d",100,95); //забор вокруг могилы
addtobj("a3\structures_f_enoch\cultural\cemeteries\gravefence_01_f.p3d",100,95); //забор вокруг могилы
addtobj("metro_ob\model\vag_wash4_p1.p3d",100,30); //железная лестница 2
addtobj("ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d",100,95); //решётка на полу
addtobj("metro_ob\model\sartir_kabinka.p3d",90,80); //деревянный толкан
addtobj("ml\ml_object_new\model_24\most.p3d",100,30); // железный мост весь дырявыйй хуейго знает
addtobj("ca\structures\misc\misc_scaffolding\misc_scaffolding.p3d",90,80); //лестнциа на спуск в холерную яму
addtobj("ca\structures\barn_w\barn_w_02.p3d",90,80); //да это же амбар
addtobj("a3\props_f_exp\commercial\market\woodencounter_01_f.p3d",90,80); //барная стойка
addtobj("a3\structures_f\walls\sportground_fence_f.p3d",100,100); //сетка
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	PUBLIC HEADER FOR NONGEOMETRY OBJECTS
	! noe::client::... delc DO NOT RENAME !
*/



noe_client_map_ngoext = createHashMap;
// макрос добавления объекта без геометрии. tolower (path) потому что снаружи все пути приходят в lowercase
#define addNGO(path,vec__,resize__) noe_client_map_ngoext set [tolower (path),[vec__,resize__,"block_dirt"]]
#define addNGODecal(path,vec__,resize__,decal__) noe_client_map_ngoext set [tolower (path),[vec__,resize__,decal__]]
/*
Как узнать нужный размер ресайза:
(boundingBoxReal obj select 2) / 10

----------
Хелпер для регулировки позиции NGO:
В консоль (предварительно зарегать и нацелиться на NGO-объект):
	obj = call interact_cursorobject;
	src = attachedto (obj);
В строку выполнения:
	obj attachto [src,[0,0,-0.37]]; obj setObjectScale 0.06

*/

addNGO("ml\ml_object_new\model_14_10\knopka.p3d",vec3(0,-0,-0.01),0.0165941); //red button
addNGO("ml\ml_object_new\model_14_10\tumbler.p3d",vec3(0,0.04,0),0.025); //tumbler
addNGO("relicta_models\models\interier\props\svecha.p3d",vec3(0,0,0),0.0070); //candle
addNGO("metro_ob\model\shamp.p3d",vec3(0,0,0),0.01);//нарезка грибов
addNGO("ml\ml_object_new\model_24\okorok.p3d",vec3(-0.03,-0.03,-0.01),0.02);//кусок мяса здоровый
addNGO("ml\ml_object_new\model_05\hleb.p3d",vec3(0,0,0),0.02);
addNGO("ml_shabut\eft\ibuprofenka.p3d",vec3(0,0,0),0.009);
//лужи крови "geopolsm"
addNGODecal("BloodSplatter_01_Small_New_F",vec3(0,0,-0.019),0.18,"geopolsm");
addNGODecal("BloodPool_01_Medium_New_F",vec3(0,0,-0.025),0.24,"geopolsm");
addNGODecal("BloodPool_01_Large_New_F",vec3(0,0,-0.05),0.4,"geopolsm");
//кость
addNGO("ml\ml_object_new\model_14_10\kosti.p3d",vec3(0,0,0),0.018);

addNGO("ml\ml_object_new\model_24\patroni.p3d",vec3(0,0,0),0.018);

addNGO("a3\structures_f_epa\items\tools\metalwire_f.p3d",vec3(0,0,-0.1),0.025);

addNGO("ml_shabut\eft\svd_trubka.p3d",vec3(0,0,0),0.025);
//люк
addNGO("a3\structures_f_exp\infrastructure\roads\sewercover_03_f.p3d",vec3(0,0,-0.25),0.065);
// матрас
addNGODecal("ml\ml_object_new\model_05\matras_2.p3d",vec3(0,0,-0.05),0.4,"geopolsm");
//чайничек
addNGO("ml_shabut\furniture\teabaggin.p3d",vec3(0,0,0),0.018);
// ======================================================  
// Copyright (c) 2017-2025 the ReSDK_A3 project  
// sdk.relicta.ru  
// ======================================================  
  
#include <..\..\..\engine.hpp>  
#include <..\..\..\oop.hpp>  
#include <..\..\GameConstants.hpp>  
  
class(GermZone) extends(IStructNonReplicated)  
    editor_attribute("InternalImpl")  
    var(model,"VR_3DSelector_01_default_F");  
      
    editor_attribute("EditorVisible" arg "type:float")
    editor_attribute("alias" arg "Радиус")
    var(_radius,1);  
      
    // Настройки для случайного радиуса загрязнения  
    editor_attribute("EditorVisible" arg "type:float")
    editor_attribute("alias" arg "Мин.Радиус")
    var(_minRadius,1);  
    editor_attribute("EditorVisible" arg "type:float")
    editor_attribute("alias" arg "Макс.Радиус")   
    var(_maxRadius,10);  
      
    // Настройки распространения  
    editor_attribute("EditorVisible" arg "type:float")
    editor_attribute("alias" arg "Процент распространения")  
    var(_spreadPercent,0.3);  
    editor_attribute("EditorVisible" arg "type:float")
    editor_attribute("alias" arg "Интенсивность загрязнения")
    var(_contaminationIntensity,1.0);

    //отключение name, desc, weight
    editor_attribute("InternalImpl")
	var(name,null);
	editor_attribute("InternalImpl")
	var(desc,null);
	editor_attribute("InternalImpl")
	var(weight,null)

    func(InitModel)  
    {  
        objParams_3(_pos,_dir,_vec);  
          
        // Генерируем случайный радиус между минимальным и максимальным значениями  
        setSelf(_radius, rand(getSelf(_minRadius), getSelf(_maxRadius)));  
          
        super();  
    };  
      
    // Функция расчета интенсивности загрязнения по расстоянию  
    func(getContaminationIntensity)  
    {  
        objParams_1(_targetPos);  
        private _sourcePos = callSelf(getPos);  
        private _distance = _sourcePos distance _targetPos;  
        private _maxRadius = getSelf(_radius);  
          
        if (_distance > _maxRadius) exitWith {0};  
          
        // Линейное уменьшение интенсивности от центра к краю  
        private _normalizedDistance = _distance / _maxRadius;  
        private _intensity = linearConversion [0, 1, _normalizedDistance,   
            getSelf(_contaminationIntensity), 0.1, true];  
          
        _intensity  
    };  
      
    // Проверка, находится ли позиция в зоне загрязнения  
    func(isPositionInContaminationZone)  
    {  
        objParams_1(_targetPos);  
        private _sourcePos = callSelf(getPos);  
        private _distance = _sourcePos distance _targetPos;  
        _distance <= getSelf(_radius)  
    };  
      
    // Применение загрязнения к объекту  
    /*func(applyContaminationToObject)  
    {  
        objParams_1(_obj);  
        if (isNullReference(_obj)) exitWith {};  
          
        private _objPos = callFunc(_obj, getPos);  
        if !(callSelfParams(isPositionInContaminationZone, _objPos)) exitWith {};  
          
        private _intensity = callSelfParams(getContaminationIntensity, _objPos);  
        if (_intensity <= 0) exitWith {};  
          
        // Применяем загрязнение, если у объекта есть система микробов  
        if (callFunc(_obj, hasMethod, "addGerms")) then {  
            callFuncParams(_obj, addGerms, _intensity * 100); // конвертируем в количество микробов  
        };  
    };*/
endclass
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(Rendering.Debug,debug_)

decl(void(mesh;vector4;float;any))
debug_drawBoundingBox = {
	params ["_obj",["_color",[1,0,1,1]],["_width",3],"_bbdt"];
	private _bbox = ifcheck(isNullVar(_bbdt),boundingBoxReal _obj,_bbdt);

	_bbox params ["_point1","_point2"];
	_point1 params ["_x1","_y1","_z1"];
	_point2 params ["_x2","_y2","_z2"];

	private _p1 = _obj modelToWorld [_x1,_y1,_z1];
	private _p2 = _obj modelToWorld [_x2,_y1,_z1];
	private _p3 = _obj modelToWorld [_x2,_y1,_z2];
	private _p4 = _obj modelToWorld [_x1,_y1,_z2];
	private _p5 = _obj modelToWorld [_x1,_y2,_z1];
	private _p6 = _obj modelToWorld [_x2,_y2,_z1];
	private _p7 = _obj modelToWorld [_x2,_y2,_z2];
	private _p8 = _obj modelToWorld [_x1,_y2,_z2];
	
	drawLine3D [_p1, _p2, _color,_width];
	drawLine3D [_p2, _p3, _color,_width];
	drawLine3D [_p3, _p4, _color,_width];
	drawLine3D [_p4, _p1, _color,_width];
	drawLine3D [_p5, _p6, _color,_width];
	drawLine3D [_p6, _p7, _color,_width];
	drawLine3D [_p7, _p8, _color,_width];
	drawLine3D [_p8, _p5, _color,_width];
	drawLine3D [_p1, _p5, _color,_width];
	drawLine3D [_p2, _p6, _color,_width];
	drawLine3D [_p3, _p7, _color,_width];
	drawLine3D [_p4, _p8, _color,_width];
};

decl(void(vector3;vector4;float;any))
debug_drawBoundingBoxPos = {
	params ["_pos",["_color",[1,0,1,1]],["_width",3],"_bbx"];

	_bbx params ["_min","_max"];

	_min params ["_x1","_y1","_z1"];
	_max params ["_x2","_y2","_z2"];
	private _p1 = _pos vectorAdd [_x1,_y1,_z1];
	private _p2 = _pos vectorAdd [_x2,_y1,_z1];
	private _p3 = _pos vectorAdd [_x2,_y1,_z2];
	private _p4 = _pos vectorAdd [_x1,_y1,_z2];
	private _p5 = _pos vectorAdd [_x1,_y2,_z1];
	private _p6 = _pos vectorAdd [_x2,_y2,_z1];
	private _p7 = _pos vectorAdd [_x2,_y2,_z2];
	private _p8 = _pos vectorAdd [_x1,_y2,_z2];
	
	drawLine3D [_p1, _p2, _color,_width];
	drawLine3D [_p2, _p3, _color,_width];
	drawLine3D [_p3, _p4, _color,_width];
	drawLine3D [_p4, _p1, _color,_width];
	drawLine3D [_p5, _p6, _color,_width];
	drawLine3D [_p6, _p7, _color,_width];
	drawLine3D [_p7, _p8, _color,_width];
	drawLine3D [_p8, _p5, _color,_width];
	drawLine3D [_p1, _p5, _color,_width];
	drawLine3D [_p2, _p6, _color,_width];
	drawLine3D [_p3, _p7, _color,_width];
	drawLine3D [_p4, _p8, _color,_width];
};

decl(void(vector3;vector4;float;float))
debug_drawSphere = {
	params ["_pos",["_color",[1,0,1,1]],["_width",3],["_radius",1]];

	private _segments = 16; // Количество сегментов для окружностей
	private _angleStep = 360 / _segments;

	// Рисуем горизонтальные окружности
	for "_i" from 0 to (_segments - 1) do {
		private _angle1 = _i * _angleStep;
		private _angle2 = (_i + 1) * _angleStep;
		private _p1 = _pos vectorAdd [
			_radius * cos _angle1,
			_radius * sin _angle1,
			0
		];
		private _p2 = _pos vectorAdd [
			_radius * cos _angle2,
			_radius * sin _angle2,
			0
		];
		drawLine3D [_p1, _p2, _color, _width];
	};

	// Рисуем вертикальные окружности по оси X
	for "_i" from 0 to (_segments - 1) do {
		private _angle1 = _i * _angleStep;
		private _angle2 = (_i + 1) * _angleStep;
		private _p1 = _pos vectorAdd [
			0,
			_radius * cos _angle1,
			_radius * sin _angle1
		];
		private _p2 = _pos vectorAdd [
			0,
			_radius * cos _angle2,
			_radius * sin _angle2
		];
		drawLine3D [_p1, _p2, _color, _width];
	};

	// Рисуем вертикальные окружности по оси Y
	for "_i" from 0 to (_segments - 1) do {
		private _angle1 = _i * _angleStep;
		private _angle2 = (_i + 1) * _angleStep;
		private _p1 = _pos vectorAdd [
			_radius * cos _angle1,
			0,
			_radius * sin _angle1
		];
		private _p2 = _pos vectorAdd [
			_radius * cos _angle2,
			0,
			_radius * sin _angle2
		];
		drawLine3D [_p1, _p2, _color, _width];
	};
};

decl(void(vector3;vector4;float;float;int))
debug_drawSphereEx = {
	params ["_pos",["_color",[1,0,1,1]],["_width",3],["_radius",1],["_verticalLines",8]];

	private _segments = 16;  // Количество сегментов для каждой дуги (чем больше, тем плавнее линии)
	private _angleStep = 360 / _segments;
	private _verticalAngleStep = 360 / _verticalLines;  // Угол между вертикальными полосками

	// Рисуем экваториальный круг в плоскости XY
	for "_i" from 0 to (_segments - 1) do {
		private _angle1 = _i * _angleStep;
		private _angle2 = (_i + 1) * _angleStep;

		private _p1 = _pos vectorAdd [_radius * cos _angle1, _radius * sin _angle1, 0];
		private _p2 = _pos vectorAdd [_radius * cos _angle2, _radius * sin _angle2, 0];
		
		drawLine3D [_p1, _p2, _color, _width];
	};

	// Рисуем скругленные вертикальные линии от -Z до +Z
	for "_i" from 0 to (_verticalLines - 1) do {
		private _angle = _i * _verticalAngleStep;

		// Каждая вертикальная линия рисуется сегментами для скругленного эффекта
		for "_j" from 0 to (_segments - 1) do {
			private _vAngle1 = -90 + (_j * (180 / _segments));
			private _vAngle2 = -90 + ((_j + 1) * (180 / _segments));
			
			private _p1 = _pos vectorAdd [
				_radius * cos _angle * cos _vAngle1,
				_radius * sin _angle * cos _vAngle1,
				_radius * sin _vAngle1
			];

			private _p2 = _pos vectorAdd [
				_radius * cos _angle * cos _vAngle2,
				_radius * sin _angle * cos _vAngle2,
				_radius * sin _vAngle2
			];
			
			drawLine3D [_p1, _p2, _color, _width];
		};
	};
};

decl(void(vector3;float;float;float;float;float;float;vector4;vector4;float))
debug_drawLightCone = {
	params ["_pos", "_pitch", "_bank", "_distance", "_outerAngle", "_innerAngle", ["_attenuation",2], ["_colorOuter", [1, 0.5, 0, 0.5]], ["_colorInner", [1, 1, 0, 1]], ["_width", 2]];
	assert_str(false,"debug::drawLightCone is unsupported; Use debug::drawLightConeEx instead");
	private _segments = 16;  // Количество сегментов для окружности, большее значение делает конус более плавным
	private _angleStep = 360 / _segments;

	// Вспомогательная функция для вращения и смещения точки по углам pitch и bank
	private _rotatePoint = {
		params ["_point", "_pitch", "_bank"];
		
		// Применяем поворот по pitch
		private _rotatedPitch = [
			_point select 0,
			(_point select 1) * cos _pitch - (_point select 2) * sin _pitch,
			(_point select 1) * sin _pitch + (_point select 2) * cos _pitch
		];
		
		// Применяем поворот по bank
		private _rotatedBank = [
			(_rotatedPitch select 0) * cos _bank - (_rotatedPitch select 1) * sin _bank,
			(_rotatedPitch select 0) * sin _bank + (_rotatedPitch select 1) * cos _bank,
			_rotatedPitch select 2
		];
		
		_rotatedBank
	};

	
	private _distOut = if (_outerAngle > 180) then {_distance * -1} else {_distance};
	private _distIn = if (_innerAngle > 180) then {_distance * -1} else {_distance};

	// Функция для рисования круга на заданной дальности и угле
	private _drawConeCircle = {
		params ["_pos", "_radius", "_pitch", "_bank", "_color", "_width"];

		for "_i" from 0 to (_segments - 1) do {
			private _angle1 = _i * _angleStep;
			private _angle2 = (_i + 1) * _angleStep;
			
			private _p1 = [_radius * cos _angle1, _radius * sin _angle1, _distance];
			private _p2 = [_radius * cos _angle2, _radius * sin _angle2, _distance];
			
			_p1 = _pos vectorAdd ([_p1, _pitch, _bank] call _rotatePoint);
			_p2 = _pos vectorAdd ([_p2, _pitch, _bank] call _rotatePoint);
			
			drawLine3D [_p1, _p2, _color, _width];
		};
	};

	// Расчет радиусов для внутреннего и внешнего углов конуса
	private _outerRadius = _distOut * tan (_outerAngle / 2);
	private _innerRadius = _distIn * tan (_innerAngle / 2);

	// Рисуем внешний и внутренний круги на дальности света
	[_pos, _outerRadius, _pitch, _bank, _colorOuter, _width] call _drawConeCircle;
	[_pos, _innerRadius, _pitch, _bank, _colorInner, _width] call _drawConeCircle;

	// Рисуем линии от источника до границ конуса
	for "_i" from 0 to (_segments - 1) do {
		private _angle = _i * _angleStep;
		
		private _outerPoint = [_outerRadius * cos _angle, _outerRadius * sin _angle, _distOut];
		private _innerPoint = [_innerRadius * cos _angle, _innerRadius * sin _angle, _distIn];

		_outerPoint = _pos vectorAdd ([_outerPoint, _pitch, _bank] call _rotatePoint);
		_innerPoint = _pos vectorAdd ([_innerPoint, _pitch, _bank] call _rotatePoint);
		
		drawLine3D [_pos, _outerPoint, _colorOuter, _width * _attenuation];
		drawLine3D [_pos, _innerPoint, _colorInner, _width];
	};
};

decl(void(vector3;vector3;float;float;float;vector4;vector4;float))
debug_drawLightConeEx = {
    params ["_pos", "_endPos", "_outerAngle", "_innerAngle", "_attenuation", ["_colorOuter", [1, 0.5, 0, 0.5]], ["_colorInner", [1, 1, 0, 1]], ["_width", 2]];

    private _segments = 16;  // Количество сегментов для окружности, большее значение делает конус более плавным
    private _angleStep = 360 / _segments;

    // Вычисляем направление и расстояние
    private _direction = _endPos vectorDiff _pos;
    private _distance = vectorMagnitude _direction;
    private _normDirection = vectorNormalized _direction;
	
	// Функция для нахождения перпендикулярного вектора к заданному направлению
    private _getPerpendicularVector = {
        params ["_direction"];
        private _arbitraryVec = if ((abs (_direction select 2)) < 0.9) then {[0, 0, 1]} else {[0, 1, 0]};
        _direction vectorCrossProduct _arbitraryVec
    };

    // Получаем перпендикулярные оси для построения плоскости
    private _right = [_normDirection] call _getPerpendicularVector;
    private _up = _normDirection vectorCrossProduct _right;

    // Функция для вычисления точек окружности
    private _drawConeCircle = {
        params ["_centerPos", "_radius", "_normDirection", "_color", "_width"];

        // // Вектор, перпендикулярный направлению (для плоскости круга)
        // private _up = [0, 0, 1];
        // if ((_normDirection vectorDotProduct _up) > 0.99) then { _up = [0, 1, 0]; };
        // private _right = _normDirection vectorCrossProduct _up;
        // _up = _right vectorCrossProduct _normDirection;

        for "_i" from 0 to (_segments - 1) do {
            private _angle1 = _i * _angleStep;
            private _angle2 = (_i + 1) * _angleStep;
            
            private _p1 = _centerPos vectorAdd (
                (_right vectorMultiply (_radius * cos _angle1)) vectorAdd
                (_up vectorMultiply (_radius * sin _angle1))
            );
            private _p2 = _centerPos vectorAdd (
                (_right vectorMultiply (_radius * cos _angle2)) vectorAdd
                (_up vectorMultiply (_radius * sin _angle2))
            );
            
            drawLine3D [_p1, _p2, _color, _width];
        };
    };

	private _distOut = if (_outerAngle > 180) then {_distance * -1} else {_distance};
	private _distIn = if (_innerAngle > 180) then {_distance * -1} else {_distance};
	
    // Расчет радиусов для внутреннего и внешнего углов конуса
    private _outerRadius = _distOut * tan (_outerAngle / 2);
    private _innerRadius = _distIn * tan (_innerAngle / 2);

    // Позиции для внутренней и внешней окружностей на конце конуса
    private _outerCirclePos = _pos vectorAdd (_normDirection vectorMultiply _distOut);
    private _innerCirclePos = _pos vectorAdd (_normDirection vectorMultiply _distIn);

    // Рисуем внешний и внутренний круги на конце конуса
    [_outerCirclePos, _outerRadius, _normDirection, _colorOuter, _width] call _drawConeCircle;
    [_innerCirclePos, _innerRadius, _normDirection, _colorInner, _width] call _drawConeCircle;

	// Вектор, перпендикулярный направлению (для плоскости круга)
	// private _up = [0, 0, 1];
	// if ((_normDirection vectorDotProduct _up) > 0.99) then { _up = [0, 1, 0]; };
	// private _right = _normDirection vectorCrossProduct _up;
	// _up = _right vectorCrossProduct _normDirection;

    // Рисуем линии от источника до границ конуса
    for "_i" from 0 to (_segments - 1) do {
        private _angle = _i * _angleStep;

        private _outerPoint = _outerCirclePos vectorAdd (
            (_right vectorMultiply (_outerRadius * cos _angle)) vectorAdd
            (_up vectorMultiply (_outerRadius * sin _angle))
        );
        private _innerPoint = _innerCirclePos vectorAdd (
            (_right vectorMultiply (_innerRadius * cos _angle)) vectorAdd
            (_up vectorMultiply (_innerRadius * sin _angle))
        );
        
        drawLine3D [_pos, _outerPoint, _colorOuter, _width * _attenuation];
        drawLine3D [_pos, _innerPoint, _colorInner, _width];
    };
};

decl(struct_t.LoopedFunction(vector3;vector4;float;any))
debug_addRenderPos = {
	params ["_pos","_color","_wdt","_bbx"];

	struct_newp(LoopedFunction,debug_drawBoundingBoxPos arg [_pos arg _color arg _wdt arg _bbx]);
};

decl(int(mesh;float;any))
debug_addRenderObject = {
	params ["_obj","_color","_wdt","_bbxVec2"];
	if !isNullVar(_bbxVec2) then {
		addMissionEventHandler ["Draw3D", {
			if isNullReference(_thisArgs select 0) exitWith {
				removeMissionEventHandler ["Draw3D",_thisEventHandler];
			};
			_thisArgs call debug_drawBoundingBox;
			
		},[_obj,_color,_wdt,_bbxVec2]];
	} else {
		addMissionEventHandler ["Draw3D", {
			if isNullReference(_thisArgs select 0) exitWith {
				removeMissionEventHandler ["Draw3D",_thisEventHandler];
			};
			_thisArgs call debug_drawBoundingBox;
			
		},[_obj,_color,_wdt]];
	};

};
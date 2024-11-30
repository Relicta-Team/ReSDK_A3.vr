# RenderDistance.sqf

## setRendering(dist)

Type: constant

Description: 
- Param: dist

Replaced value:
```sqf
setViewDistance (dist); setObjectViewDistance (dist)
```
File: [client\Rendering\RenderDistance.sqf at line 13](../../../Src/client/Rendering/RenderDistance.sqf#L13)
## render_dist_handle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\Rendering\RenderDistance.sqf at line 7](../../../Src/client/Rendering/RenderDistance.sqf#L7)
## render_dist_maxDistance

Type: Variable

Description: 


Initial value:
```sqf
170
```
File: [client\Rendering\RenderDistance.sqf at line 8](../../../Src/client/Rendering/RenderDistance.sqf#L8)
## render_dist_minDistance

Type: Variable

Description: 


Initial value:
```sqf
25
```
File: [client\Rendering\RenderDistance.sqf at line 9](../../../Src/client/Rendering/RenderDistance.sqf#L9)
## render_dist_onupdate

Type: function

Description: 


File: [client\Rendering\RenderDistance.sqf at line 11](../../../Src/client/Rendering/RenderDistance.sqf#L11)
## render_dist_init

Type: function

Description: 


File: [client\Rendering\RenderDistance.sqf at line 35](../../../Src/client/Rendering/RenderDistance.sqf#L35)
# Render_debug.sqf

## debug_drawBoundingBox

Type: function

Description: 
- Param: _obj
- Param: _color (optional, default ['1', '0', '1', '1'])
- Param: _width (optional, default 3)
- Param: _bbdt

File: [client\Rendering\Render_debug.sqf at line 6](../../../Src/client/Rendering/Render_debug.sqf#L6)
## debug_drawBoundingBoxPos

Type: function

Description: 
- Param: _pos
- Param: _color (optional, default ['1', '0', '1', '1'])
- Param: _width (optional, default 3)
- Param: _bbx

File: [client\Rendering\Render_debug.sqf at line 37](../../../Src/client/Rendering/Render_debug.sqf#L37)
## debug_drawSphere

Type: function

Description: 
- Param: _pos
- Param: _color (optional, default ['1', '0', '1', '1'])
- Param: _width (optional, default 3)
- Param: _radius (optional, default 1)

File: [client\Rendering\Render_debug.sqf at line 67](../../../Src/client/Rendering/Render_debug.sqf#L67)
## debug_drawSphereEx

Type: function

Description: 
- Param: _pos
- Param: _color (optional, default ['1', '0', '1', '1'])
- Param: _width (optional, default 3)
- Param: _radius (optional, default 1)
- Param: _verticalLines (optional, default 8)

File: [client\Rendering\Render_debug.sqf at line 125](../../../Src/client/Rendering/Render_debug.sqf#L125)
## debug_drawLightCone

Type: function

Description: 
- Param: _pos
- Param: _pitch
- Param: _bank
- Param: _distance
- Param: _outerAngle
- Param: _innerAngle
- Param: _attenuation (optional, default 2)
- Param: _colorOuter (optional, default ['1', '0.5', '0', '0.5'])
- Param: _colorInner (optional, default ['1', '1', '0', '1'])
- Param: _width (optional, default 2)

File: [client\Rendering\Render_debug.sqf at line 169](../../../Src/client/Rendering/Render_debug.sqf#L169)
## debug_drawLightConeEx

Type: function

Description: 
- Param: _pos
- Param: _endPos
- Param: _outerAngle
- Param: _innerAngle
- Param: _attenuation
- Param: _colorOuter (optional, default ['1', '0.5', '0', '0.5'])
- Param: _colorInner (optional, default ['1', '1', '0', '1'])
- Param: _width (optional, default 2)

File: [client\Rendering\Render_debug.sqf at line 237](../../../Src/client/Rendering/Render_debug.sqf#L237)
## debug_addRenderPos

Type: function

Description: 
- Param: _pos
- Param: _color
- Param: _wdt
- Param: _bbx

File: [client\Rendering\Render_debug.sqf at line 322](../../../Src/client/Rendering/Render_debug.sqf#L322)
## debug_addRenderObject

Type: function

Description: 
- Param: _obj
- Param: _color
- Param: _wdt
- Param: _bbxVec2

File: [client\Rendering\Render_debug.sqf at line 328](../../../Src/client/Rendering/Render_debug.sqf#L328)
# Render_zpass.sqf

## render_zpass_cachePositions

Type: Variable

Description: 


Initial value:
```sqf
createhashMap
```
File: [client\Rendering\Render_zpass.sqf at line 154](../../../Src/client/Rendering/Render_zpass.sqf#L154)
## render_zpass_getObjBBX

Type: function

Description: list<vec3(distancetocam,list<screenproj>,metaObject)>
- Param: _cameraPos
- Param: _objlist

File: [client\Rendering\Render_zpass.sqf at line 10](../../../Src/client/Rendering/Render_zpass.sqf#L10)
## render_zpass_getBBXInfoVirtual

Type: function

Description: 
- Param: _psCenter
- Param: _bmin
- Param: _bmax

File: [client\Rendering\Render_zpass.sqf at line 46](../../../Src/client/Rendering/Render_zpass.sqf#L46)
## render_zpass_getBBXInfoVirtual_gbuffCheck

Type: function

Description: 
- Param: _psCenter
- Param: _bmin
- Param: _bmax

File: [client\Rendering\Render_zpass.sqf at line 75](../../../Src/client/Rendering/Render_zpass.sqf#L75)
## render_gbuffCheck_photonVisPrc

Type: function

Description: функция возвращает процентное значение видимости бокса
- Param: _psCenter
- Param: _bmin
- Param: _bmax
- Param: _lbIC (optional, default 0)

File: [client\Rendering\Render_zpass.sqf at line 116](../../../Src/client/Rendering/Render_zpass.sqf#L116)
## render_zpass_getBBXInfoVirtual_DEBUG

Type: function

Description: 
- Param: _psCenter
- Param: _bmin
- Param: _bmax

File: [client\Rendering\Render_zpass.sqf at line 155](../../../Src/client/Rendering/Render_zpass.sqf#L155)
## render_processZPass

Type: function

Description: Главная функция для сортировки и проверки видимости объектов
- Param: _cameraPos
- Param: _sortedObjects
- Param: _pipelineFnc

File: [client\Rendering\Render_zpass.sqf at line 195](../../../Src/client/Rendering/Render_zpass.sqf#L195)
## render_zpass_checkOverlapWithZone

Type: function

Description: Функция для проверки перекрытия двух проекций на экране
- Param: _screenBoxA
- Param: _screenBoxB

File: [client\Rendering\Render_zpass.sqf at line 237](../../../Src/client/Rendering/Render_zpass.sqf#L237)
## render_zpass_checkFullOverlap

Type: function

Description: 
- Param: _screenBoxA
- Param: _screenBoxB

File: [client\Rendering\Render_zpass.sqf at line 257](../../../Src/client/Rendering/Render_zpass.sqf#L257)
# CameraControl.hpp

## CAMERA_MODE_ARCADE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Rendering\Camera\CameraControl.hpp at line 8](../../../Src/client/Rendering/Camera/CameraControl.hpp#L8)
## CAMERA_MODE_REALISTIC

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Rendering\Camera\CameraControl.hpp at line 9](../../../Src/client/Rendering/Camera/CameraControl.hpp#L9)
# CameraControl.sqf

## dynamicCamera

Type: constant

Description: 


Replaced value:
```sqf
"Land_HandyCam_F"
```
File: [client\Rendering\Camera\CameraControl.sqf at line 13](../../../Src/client/Rendering/Camera/CameraControl.sqf#L13)
## staticCamera

Type: constant

Description: 


Replaced value:
```sqf
"camera"
```
File: [client\Rendering\Camera\CameraControl.sqf at line 14](../../../Src/client/Rendering/Camera/CameraControl.sqf#L14)
## initCam(camtype)

Type: constant

Description: 
- Param: camtype

Replaced value:
```sqf
call{private _c = camtype createVehicleLocal [0,0,0]; _c hideObject true; _c}
```
File: [client\Rendering\Camera\CameraControl.sqf at line 15](../../../Src/client/Rendering/Camera/CameraControl.sqf#L15)
## probInverse(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(pick [-1,1]) * (val)
```
File: [client\Rendering\Camera\CameraControl.sqf at line 97](../../../Src/client/Rendering/Camera/CameraControl.sqf#L97)
## convset(var,svar)

Type: constant

Description: linearConversion [minFrom, maxFrom, value, minTo, maxTo]
- Param: var
- Param: svar

Replaced value:
```sqf
_conv = linearConversion [_fDelta, _fDelta + _freq, tickTime, svar, var]; var = _conv
```
File: [client\Rendering\Camera\CameraControl.sqf at line 129](../../../Src/client/Rendering/Camera/CameraControl.sqf#L129)
## convsetFuller(var)

Type: constant

Description: Процентное соотношение когда движение начнет затухать: меньше знач. раньше начнет -V
- Param: var

Replaced value:
```sqf
_conv = linearConversion [_addTime, _left, tickTime, var*70/100, 0]; var = _conv
```
File: [client\Rendering\Camera\CameraControl.sqf at line 129](../../../Src/client/Rendering/Camera/CameraControl.sqf#L129)
## invertNum(val)

Type: constant

Description: #define conversion(data) linearConversion [0,1,data,] OR vectorLinearConversion
- Param: val

Replaced value:
```sqf
-(val)
```
File: [client\Rendering\Camera\CameraControl.sqf at line 261](../../../Src/client/Rendering/Camera/CameraControl.sqf#L261)
## cam_isEnabled

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [client\Rendering\Camera\CameraControl.sqf at line 16](../../../Src/client/Rendering/Camera/CameraControl.sqf#L16)
## cam_defaultPos

Type: Variable

Description: 


Initial value:
```sqf
[-0.05,-0.05,0.12]
```
File: [client\Rendering\Camera\CameraControl.sqf at line 17](../../../Src/client/Rendering/Camera/CameraControl.sqf#L17)
## cam_lastPlayerObject

Type: Variable

Description: 


Initial value:
```sqf
objNUll
```
File: [client\Rendering\Camera\CameraControl.sqf at line 18](../../../Src/client/Rendering/Camera/CameraControl.sqf#L18)
## cam_updateDelay

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Rendering\Camera\CameraControl.sqf at line 19](../../../Src/client/Rendering/Camera/CameraControl.sqf#L19)
## cam_currentCamera

Type: Variable

Description: 


Initial value:
```sqf
cam_fixedObject
```
File: [client\Rendering\Camera\CameraControl.sqf at line 27](../../../Src/client/Rendering/Camera/CameraControl.sqf#L27)
## cam_object

Type: Variable

Description: 


Initial value:
```sqf
initCam(dynamicCamera)
```
File: [client\Rendering\Camera\CameraControl.sqf at line 25](../../../Src/client/Rendering/Camera/CameraControl.sqf#L25)
## cam_fixedObject

Type: Variable

Description: 


Initial value:
```sqf
initCam(staticCamera)
```
File: [client\Rendering\Camera\CameraControl.sqf at line 26](../../../Src/client/Rendering/Camera/CameraControl.sqf#L26)
## cam_viewMode

Type: Variable

Description: 


Initial value:
```sqf
"INTERNAL"
```
File: [client\Rendering\Camera\CameraControl.sqf at line 29](../../../Src/client/Rendering/Camera/CameraControl.sqf#L29)
## cam_isNewCamera

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Rendering\Camera\CameraControl.sqf at line 45](../../../Src/client/Rendering/Camera/CameraControl.sqf#L45)
## cam_renderPos

Type: Variable

Description: Параметры для рендеринга. Нужны при отправке на сервер


Initial value:
```sqf
[0,0,0] //data in ATL coordinates
```
File: [client\Rendering\Camera\CameraControl.sqf at line 48](../../../Src/client/Rendering/Camera/CameraControl.sqf#L48)
## cam_renderVec

Type: Variable

Description: data in ATL coordinates


Initial value:
```sqf
[[0,0,0],[0,0,1]]
```
File: [client\Rendering\Camera\CameraControl.sqf at line 49](../../../Src/client/Rendering/Camera/CameraControl.sqf#L49)
## cam_renderVecMouse

Type: Variable

Description: мы получили вектор направления для мыши. Если луч не прокнул то


Initial value:
```sqf
[[0,0,0],[0,0,1]] //вектор направления мыши
```
File: [client\Rendering\Camera\CameraControl.sqf at line 50](../../../Src/client/Rendering/Camera/CameraControl.sqf#L50)
## cam_movingOffest

Type: Variable

Description: вектор направления мыши


Initial value:
```sqf
[0,0]
```
File: [client\Rendering\Camera\CameraControl.sqf at line 52](../../../Src/client/Rendering/Camera/CameraControl.sqf#L52)
## cam_camshakeDir

Type: Variable

Description: 


Initial value:
```sqf
[0,0]//x,y
```
File: [client\Rendering\Camera\CameraControl.sqf at line 54](../../../Src/client/Rendering/Camera/CameraControl.sqf#L54)
## cam_camshakePos

Type: Variable

Description: x,y


Initial value:
```sqf
[0,0,0]
```
File: [client\Rendering\Camera\CameraControl.sqf at line 55](../../../Src/client/Rendering/Camera/CameraControl.sqf#L55)
## cam_camshake_tasks

Type: Variable

Description: 


Initial value:
```sqf
[] //here adding tasks for shake
```
File: [client\Rendering\Camera\CameraControl.sqf at line 56](../../../Src/client/Rendering/Camera/CameraControl.sqf#L56)
## cam_camShake_internal_handler

Type: Variable

Description: 


Initial value:
```sqf
startUpdate(cam_camshake_onUpdate,0)
```
File: [client\Rendering\Camera\CameraControl.sqf at line 177](../../../Src/client/Rendering/Camera/CameraControl.sqf#L177)
## cam_internal_isEnabledBisCam

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Rendering\Camera\CameraControl.sqf at line 296](../../../Src/client/Rendering/Camera/CameraControl.sqf#L296)
## cam_setCameraOnPlayer

Type: function

Description: 


File: [client\Rendering\Camera\CameraControl.sqf at line 31](../../../Src/client/Rendering/Camera/CameraControl.sqf#L31)
## cam_camShake_resetAll

Type: function

Description: here adding tasks for shake


File: [client\Rendering\Camera\CameraControl.sqf at line 57](../../../Src/client/Rendering/Camera/CameraControl.sqf#L57)
## cam_addCamShake

Type: function

Description: 
- Param: _power
- Param: _powerDir
- Param: _freq
- Param: _duration

File: [client\Rendering\Camera\CameraControl.sqf at line 64](../../../Src/client/Rendering/Camera/CameraControl.sqf#L64)
## cam_camshake_onUpdate

Type: function

Description: 
- Param: _pwr
- Param: _frq
- Param: _left
- Param: _addTime
- Param: _fDelta
- Param: _freq
- Param: _fromPwr
- Param: _fromORX

File: [client\Rendering\Camera\CameraControl.sqf at line 72](../../../Src/client/Rendering/Camera/CameraControl.sqf#L72)
## cam_updateCameraRotation

Type: function

Description: 


File: [client\Rendering\Camera\CameraControl.sqf at line 189](../../../Src/client/Rendering/Camera/CameraControl.sqf#L189)
## cam_onFrame

Type: function

Description: 


File: [client\Rendering\Camera\CameraControl.sqf at line 297](../../../Src/client/Rendering/Camera/CameraControl.sqf#L297)
## cam_setCameraSetting

Type: function

Description: 
- Param: _camSetting
- Param: _applyToVar (optional, default true)

File: [client\Rendering\Camera\CameraControl.sqf at line 335](../../../Src/client/Rendering/Camera/CameraControl.sqf#L335)
# Camera_DEBUG.sqf

## probInverse(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(pick [-1,1]) * (val)
```
File: [client\Rendering\Camera\Camera_DEBUG.sqf at line 57](../../../Src/client/Rendering/Camera/Camera_DEBUG.sqf#L57)
## convset(var,svar)

Type: constant

Description: linearConversion [minFrom, maxFrom, value, minTo, maxTo]
- Param: var
- Param: svar

Replaced value:
```sqf
_conv = linearConversion [_fDelta, _fDelta + _freq, tickTime, svar, var]; var = _conv
```
File: [client\Rendering\Camera\Camera_DEBUG.sqf at line 88](../../../Src/client/Rendering/Camera/Camera_DEBUG.sqf#L88)
## convsetFuller(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
_conv = linearConversion [_addTime, _left, tickTime, var*70/100, 0]; var = _conv
```
File: [client\Rendering\Camera\Camera_DEBUG.sqf at line 88](../../../Src/client/Rendering/Camera/Camera_DEBUG.sqf#L88)
## cam_camShake_internal_handler

Type: Variable

Description: 


Initial value:
```sqf
startUpdate(cam_camshake_onUpdate,0)
```
File: [client\Rendering\Camera\Camera_DEBUG.sqf at line 128](../../../Src/client/Rendering/Camera/Camera_DEBUG.sqf#L128)
## cam_camShake_resetAll

Type: function

Description: FOR DEBUG ONLY
 DO NOT INCLUDE THIS FILE IN CLIENTSIDE


File: [client\Rendering\Camera\Camera_DEBUG.sqf at line 15](../../../Src/client/Rendering/Camera/Camera_DEBUG.sqf#L15)
## cam_addCamShake

Type: function

Description: 
- Param: _power
- Param: _powerDir
- Param: _freq
- Param: _duration

File: [client\Rendering\Camera\Camera_DEBUG.sqf at line 22](../../../Src/client/Rendering/Camera/Camera_DEBUG.sqf#L22)
## cam_camshake_onUpdate

Type: function

Description: 
- Param: _pwr
- Param: _frq
- Param: _left
- Param: _addTime
- Param: _fDelta
- Param: _freq
- Param: _fromPwr
- Param: _fromORX

File: [client\Rendering\Camera\Camera_DEBUG.sqf at line 32](../../../Src/client/Rendering/Camera/Camera_DEBUG.sqf#L32)
# Camera_ShakeDefs.sqf

## cam_camshake_map

Type: Variable

Description: 


Initial value:
```sqf
hashMapNewArgs [	...
```
File: [client\Rendering\Camera\Camera_ShakeDefs.sqf at line 18](../../../Src/client/Rendering/Camera/Camera_ShakeDefs.sqf#L18)
## cam_getCamShakeConfig

Type: function

Description: 


File: [client\Rendering\Camera\Camera_ShakeDefs.sqf at line 8](../../../Src/client/Rendering/Camera/Camera_ShakeDefs.sqf#L8)
## cam_addCamShakeByConfig

Type: function

Description: 
- Param: _configName
- Param: _duration

File: [client\Rendering\Camera\Camera_ShakeDefs.sqf at line 12](../../../Src/client/Rendering/Camera/Camera_ShakeDefs.sqf#L12)
# Effects_init.sqf

## RENDER_EFFECTS_UPDATEDELAY

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Rendering\Effects\Effects_init.sqf at line 7](../../../Src/client/Rendering/Effects/Effects_init.sqf#L7)
## newParticle()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
("#particlesource" createVehicleLocal [0,0,0])
```
File: [client\Rendering\Effects\Effects_init.sqf at line 9](../../../Src/client/Rendering/Effects/Effects_init.sqf#L9)
## render_effects_lastPlayer

Type: Variable

Description: 


Initial value:
```sqf
objnull
```
File: [client\Rendering\Effects\Effects_init.sqf at line 11](../../../Src/client/Rendering/Effects/Effects_init.sqf#L11)
## render_effects_dustParticles

Type: Variable

Description: 


Initial value:
```sqf
objnull
```
File: [client\Rendering\Effects\Effects_init.sqf at line 12](../../../Src/client/Rendering/Effects/Effects_init.sqf#L12)
## render_effects_dustGlob

Type: Variable

Description: 


Initial value:
```sqf
objNull
```
File: [client\Rendering\Effects\Effects_init.sqf at line 13](../../../Src/client/Rendering/Effects/Effects_init.sqf#L13)
## render_effects_init

Type: function

Description: 


File: [client\Rendering\Effects\Effects_init.sqf at line 15](../../../Src/client/Rendering/Effects/Effects_init.sqf#L15)
## render_effects_updateParticles

Type: function

Description: обновление частиц


File: [client\Rendering\Effects\Effects_init.sqf at line 39](../../../Src/client/Rendering/Effects/Effects_init.sqf#L39)
## render_effects_onUpdate

Type: function

Description: цикл обновления частиц


File: [client\Rendering\Effects\Effects_init.sqf at line 45](../../../Src/client/Rendering/Effects/Effects_init.sqf#L45)
# HDRInit.sqf

## render_hdr_init

Type: function

Description: 


File: [client\Rendering\HDR\HDRInit.sqf at line 8](../../../Src/client/Rendering/HDR/HDRInit.sqf#L8)
## render_hdr_setMode

Type: function

> Exists if **HDR_DYNAMIC_ENABLED** defined

Description: 


File: [client\Rendering\HDR\HDRInit.sqf at line 17](../../../Src/client/Rendering/HDR/HDRInit.sqf#L17)
## render_hdr_setWorldTIme

Type: function

> Exists if **HDR_DYNAMIC_ENABLED** defined

Description: underground, world


File: [client\Rendering\HDR\HDRInit.sqf at line 19](../../../Src/client/Rendering/HDR/HDRInit.sqf#L19)
# postprocessing.h

## PP_MACRO_PREF

Type: constant

Description: 


Replaced value:
```sqf
"pp_effect_"
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 8](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L8)
## setGV(var,val)

Type: constant

Description: 
- Param: var
- Param: val

Replaced value:
```sqf
missionNamespace setVariable [var,val]
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 10](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L10)
## getGV(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
(missionNamespace getVariable (var))
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 11](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L11)
## setPPVar(var,val)

Type: constant

Description: 
- Param: var
- Param: val

Replaced value:
```sqf
setGV(PP_MACRO_PREF + var,val)
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 13](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L13)
## getPPVar(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
getGV(PP_MACRO_PREF + var)
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 14](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L14)
## setEffect

Type: constant

Description: 


Replaced value:
```sqf
ppEffectAdjust
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 17](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L17)
## commitEffect

Type: constant

Description: 


Replaced value:
```sqf
ppEffectCommit
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 18](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L18)
## setThisEffect

Type: constant

Description: 


Replaced value:
```sqf
getPPVar(__EFFECT_NAME) setEffect
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 20](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L20)
## setThisEffectCommit

Type: constant

Description: 


Replaced value:
```sqf
getPPVar(__EFFECT_NAME) commitEffect
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 21](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L21)
## setThisEffectEnable

Type: constant

Description: 


Replaced value:
```sqf
getPPVar(__EFFECT_NAME) ppEffectEnable 
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 22](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L22)
## unpackParams()

Type: constant

Description: для отложенных вызовов
- Param: 

Replaced value:
```sqf
params ["__EFFECT_NAME","__args"]
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 25](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L25)
## packParams()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
vec2(__EFFECT_NAME,__args)
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 26](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L26)
# PPInit.sqf

## pp_buffer_efx

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Rendering\PostProcessing\PPInit.sqf at line 21](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L21)
## pp_allEffects

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Rendering\PostProcessing\PPInit.sqf at line 22](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L22)
## pp_uniIndex

Type: Variable

Description: 


Initial value:
```sqf
5000
```
File: [client\Rendering\PostProcessing\PPInit.sqf at line 23](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L23)
## pp_reload

Type: function

Description: 


File: [client\Rendering\PostProcessing\PPInit.sqf at line 25](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L25)
## pp_init

Type: function

Description: 


File: [client\Rendering\PostProcessing\PPInit.sqf at line 45](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L45)
## pp_init_active

Type: function

Description: 


File: [client\Rendering\PostProcessing\PPInit.sqf at line 70](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L70)
## pp_setEnable

Type: function

Description: 
- Param: _varName
- Param: _mode

File: [client\Rendering\PostProcessing\PPInit.sqf at line 76](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L76)

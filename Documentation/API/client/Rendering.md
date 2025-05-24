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

File: [client\Rendering\Render_debug.sqf at line 11](../../../Src/client/Rendering/Render_debug.sqf#L11)
## debug_drawBoundingBoxPos

Type: function

Description: 
- Param: _pos
- Param: _color (optional, default ['1', '0', '1', '1'])
- Param: _width (optional, default 3)
- Param: _bbx

File: [client\Rendering\Render_debug.sqf at line 43](../../../Src/client/Rendering/Render_debug.sqf#L43)
## debug_drawSphere

Type: function

Description: 
- Param: _pos
- Param: _color (optional, default ['1', '0', '1', '1'])
- Param: _width (optional, default 3)
- Param: _radius (optional, default 1)

File: [client\Rendering\Render_debug.sqf at line 74](../../../Src/client/Rendering/Render_debug.sqf#L74)
## debug_drawSphereEx

Type: function

Description: 
- Param: _pos
- Param: _color (optional, default ['1', '0', '1', '1'])
- Param: _width (optional, default 3)
- Param: _radius (optional, default 1)
- Param: _verticalLines (optional, default 8)

File: [client\Rendering\Render_debug.sqf at line 133](../../../Src/client/Rendering/Render_debug.sqf#L133)
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

File: [client\Rendering\Render_debug.sqf at line 178](../../../Src/client/Rendering/Render_debug.sqf#L178)
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

File: [client\Rendering\Render_debug.sqf at line 251](../../../Src/client/Rendering/Render_debug.sqf#L251)
## debug_addRenderPos

Type: function

Description: 
- Param: _pos
- Param: _color
- Param: _wdt
- Param: _bbx

File: [client\Rendering\Render_debug.sqf at line 340](../../../Src/client/Rendering/Render_debug.sqf#L340)
## debug_addRenderObject

Type: function

Description: 
- Param: _obj
- Param: _color
- Param: _wdt
- Param: _bbxVec2

File: [client\Rendering\Render_debug.sqf at line 347](../../../Src/client/Rendering/Render_debug.sqf#L347)
# Render_zpass.sqf

## render_zpass_cachePositions

Type: Variable

Description: 


Initial value:
```sqf
createhashMap
```
File: [client\Rendering\Render_zpass.sqf at line 163](../../../Src/client/Rendering/Render_zpass.sqf#L163)
## render_zpass_getObjBBX

Type: function

Description: 
- Param: _cameraPos
- Param: _objlist

File: [client\Rendering\Render_zpass.sqf at line 15](../../../Src/client/Rendering/Render_zpass.sqf#L15)
## render_zpass_getBBXInfoVirtual

Type: function

Description: 
- Param: _psCenter
- Param: _bmin
- Param: _bmax

File: [client\Rendering\Render_zpass.sqf at line 52](../../../Src/client/Rendering/Render_zpass.sqf#L52)
## render_zpass_getBBXInfoVirtual_gbuffCheck

Type: function

Description: 
- Param: _psCenter
- Param: _bmin
- Param: _bmax

File: [client\Rendering\Render_zpass.sqf at line 82](../../../Src/client/Rendering/Render_zpass.sqf#L82)
## render_gbuffCheck_photonVisPrc

Type: function

Description: 
- Param: _psCenter
- Param: _bmin
- Param: _bmax
- Param: _lbIC (optional, default 0)

File: [client\Rendering\Render_zpass.sqf at line 124](../../../Src/client/Rendering/Render_zpass.sqf#L124)
## render_zpass_getBBXInfoVirtual_DEBUG

Type: function

Description: 
- Param: _psCenter
- Param: _bmin
- Param: _bmax

File: [client\Rendering\Render_zpass.sqf at line 166](../../../Src/client/Rendering/Render_zpass.sqf#L166)
## render_processZPass

Type: function

Description: 
- Param: _cameraPos
- Param: _sortedObjects
- Param: _pipelineFnc

File: [client\Rendering\Render_zpass.sqf at line 207](../../../Src/client/Rendering/Render_zpass.sqf#L207)
## render_zpass_checkOverlapWithZone

Type: function

Description: 
- Param: _screenBoxA
- Param: _screenBoxB

File: [client\Rendering\Render_zpass.sqf at line 250](../../../Src/client/Rendering/Render_zpass.sqf#L250)
## render_zpass_checkFullOverlap

Type: function

Description: 
- Param: _screenBoxA
- Param: _screenBoxB

File: [client\Rendering\Render_zpass.sqf at line 271](../../../Src/client/Rendering/Render_zpass.sqf#L271)
# CameraControl.hpp

## CAMERA_MODE_ARCADE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Rendering\Camera\CameraControl.hpp at line 11](../../../Src/client/Rendering/Camera/CameraControl.hpp#L11)
## CAMERA_MODE_REALISTIC

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Rendering\Camera\CameraControl.hpp at line 12](../../../Src/client/Rendering/Camera/CameraControl.hpp#L12)
# CameraControl.sqf

## dynamicCamera

Type: constant

Description: 


Replaced value:
```sqf
"Land_HandyCam_F"
```
File: [client\Rendering\Camera\CameraControl.sqf at line 15](../../../Src/client/Rendering/Camera/CameraControl.sqf#L15)
## staticCamera

Type: constant

Description: 


Replaced value:
```sqf
"camera"
```
File: [client\Rendering\Camera\CameraControl.sqf at line 17](../../../Src/client/Rendering/Camera/CameraControl.sqf#L17)
## initCam(camtype)

Type: constant

Description: 
- Param: camtype

Replaced value:
```sqf
[camtype] call cam_initCamera
```
File: [client\Rendering\Camera\CameraControl.sqf at line 27](../../../Src/client/Rendering/Camera/CameraControl.sqf#L27)
## probInverse(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(pick [-1,1]) * (val)
```
File: [client\Rendering\Camera\CameraControl.sqf at line 129](../../../Src/client/Rendering/Camera/CameraControl.sqf#L129)
## convset(var,svar)

Type: constant

Description: 
- Param: var
- Param: svar

Replaced value:
```sqf
_conv = linearConversion [_fDelta, _fDelta + _freq, tickTime, svar, var]; var = _conv
```
File: [client\Rendering\Camera\CameraControl.sqf at line 163](../../../Src/client/Rendering/Camera/CameraControl.sqf#L163)
## convsetFuller(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
_conv = linearConversion [_addTime, _left, tickTime, var*70/100, 0]; var = _conv
```
File: [client\Rendering\Camera\CameraControl.sqf at line 163](../../../Src/client/Rendering/Camera/CameraControl.sqf#L163)
## invertNum(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
-(val)
```
File: [client\Rendering\Camera\CameraControl.sqf at line 290](../../../Src/client/Rendering/Camera/CameraControl.sqf#L290)
## cam_isEnabled

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [client\Rendering\Camera\CameraControl.sqf at line 30](../../../Src/client/Rendering/Camera/CameraControl.sqf#L30)
## cam_defaultPos

Type: Variable

Description: 


Initial value:
```sqf
[-0.05,-0.05,0.12]
```
File: [client\Rendering\Camera\CameraControl.sqf at line 32](../../../Src/client/Rendering/Camera/CameraControl.sqf#L32)
## cam_lastPlayerObject

Type: Variable

Description: 


Initial value:
```sqf
objNUll
```
File: [client\Rendering\Camera\CameraControl.sqf at line 34](../../../Src/client/Rendering/Camera/CameraControl.sqf#L34)
## cam_updateDelay

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Rendering\Camera\CameraControl.sqf at line 36](../../../Src/client/Rendering/Camera/CameraControl.sqf#L36)
## cam_currentCamera

Type: Variable

Description: 


Initial value:
```sqf
cam_fixedObject
```
File: [client\Rendering\Camera\CameraControl.sqf at line 45](../../../Src/client/Rendering/Camera/CameraControl.sqf#L45)
## cam_object

Type: Variable

Description: 


Initial value:
```sqf
initCam(dynamicCamera)
```
File: [client\Rendering\Camera\CameraControl.sqf at line 41](../../../Src/client/Rendering/Camera/CameraControl.sqf#L41)
## cam_fixedObject

Type: Variable

Description: 


Initial value:
```sqf
initCam(staticCamera)
```
File: [client\Rendering\Camera\CameraControl.sqf at line 43](../../../Src/client/Rendering/Camera/CameraControl.sqf#L43)
## cam_viewMode

Type: Variable

Description: 


Initial value:
```sqf
"INTERNAL"
```
File: [client\Rendering\Camera\CameraControl.sqf at line 48](../../../Src/client/Rendering/Camera/CameraControl.sqf#L48)
## cam_isNewCamera

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Rendering\Camera\CameraControl.sqf at line 66](../../../Src/client/Rendering/Camera/CameraControl.sqf#L66)
## cam_renderPos

Type: Variable

Description: save pos


Initial value:
```sqf
[0,0,0] //data in ATL coordinates
```
File: [client\Rendering\Camera\CameraControl.sqf at line 70](../../../Src/client/Rendering/Camera/CameraControl.sqf#L70)
## cam_renderVec

Type: Variable

Description: 


Initial value:
```sqf
[[0,0,0],[0,0,1]]
```
File: [client\Rendering\Camera\CameraControl.sqf at line 72](../../../Src/client/Rendering/Camera/CameraControl.sqf#L72)
## cam_renderVecMouse

Type: Variable

Description: мы получили вектор направления для мыши. Если луч не прокнул то


Initial value:
```sqf
[[0,0,0],[0,0,1]] //вектор направления мыши
```
File: [client\Rendering\Camera\CameraControl.sqf at line 74](../../../Src/client/Rendering/Camera/CameraControl.sqf#L74)
## cam_movingOffest

Type: Variable

Description: 


Initial value:
```sqf
[0,0]
```
File: [client\Rendering\Camera\CameraControl.sqf at line 77](../../../Src/client/Rendering/Camera/CameraControl.sqf#L77)
## cam_camshakeDir

Type: Variable

Description: 


Initial value:
```sqf
[0,0]//x,y
```
File: [client\Rendering\Camera\CameraControl.sqf at line 80](../../../Src/client/Rendering/Camera/CameraControl.sqf#L80)
## cam_camshakePos

Type: Variable

Description: 


Initial value:
```sqf
[0,0,0]
```
File: [client\Rendering\Camera\CameraControl.sqf at line 82](../../../Src/client/Rendering/Camera/CameraControl.sqf#L82)
## cam_camshake_tasks

Type: Variable

Description: 


Initial value:
```sqf
[] //here adding tasks for shake
```
File: [client\Rendering\Camera\CameraControl.sqf at line 84](../../../Src/client/Rendering/Camera/CameraControl.sqf#L84)
## cam_camShake_internal_handler

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\Rendering\Camera\CameraControl.sqf at line 214](../../../Src/client/Rendering/Camera/CameraControl.sqf#L214)
## cam_internal_isEnabledBisCam

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Rendering\Camera\CameraControl.sqf at line 326](../../../Src/client/Rendering/Camera/CameraControl.sqf#L326)
## cam_internal_handleOnFrame

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\Rendering\Camera\CameraControl.sqf at line 329](../../../Src/client/Rendering/Camera/CameraControl.sqf#L329)
## cam_initCamera

Type: function

Description: 
- Param: _camType

File: [client\Rendering\Camera\CameraControl.sqf at line 20](../../../Src/client/Rendering/Camera/CameraControl.sqf#L20)
## cam_setCameraOnPlayer

Type: function

Description: 


File: [client\Rendering\Camera\CameraControl.sqf at line 51](../../../Src/client/Rendering/Camera/CameraControl.sqf#L51)
## cam_camShake_resetAll

Type: function

Description: 


File: [client\Rendering\Camera\CameraControl.sqf at line 86](../../../Src/client/Rendering/Camera/CameraControl.sqf#L86)
## cam_addCamShake

Type: function

Description: 
- Param: _power
- Param: _powerDir
- Param: _freq
- Param: _duration

File: [client\Rendering\Camera\CameraControl.sqf at line 94](../../../Src/client/Rendering/Camera/CameraControl.sqf#L94)
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

File: [client\Rendering\Camera\CameraControl.sqf at line 104](../../../Src/client/Rendering/Camera/CameraControl.sqf#L104)
## cam_updateCameraRotation

Type: function

Description: 


File: [client\Rendering\Camera\CameraControl.sqf at line 217](../../../Src/client/Rendering/Camera/CameraControl.sqf#L217)
## cam_onFrame

Type: function

Description: 


File: [client\Rendering\Camera\CameraControl.sqf at line 332](../../../Src/client/Rendering/Camera/CameraControl.sqf#L332)
## cam_setCameraSetting

Type: function

Description: 
- Param: _camSetting
- Param: _applyToVar (optional, default true)

File: [client\Rendering\Camera\CameraControl.sqf at line 370](../../../Src/client/Rendering/Camera/CameraControl.sqf#L370)
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

Description: 


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
# Effects_init.sqf

## RENDER_EFFECTS_UPDATEDELAY

Type: constant

Description: ! this file not used


Replaced value:
```sqf
0.1
```
File: [client\Rendering\Effects\Effects_init.sqf at line 8](../../../Src/client/Rendering/Effects/Effects_init.sqf#L8)
## newParticle()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
("#particlesource" createVehicleLocal [0,0,0])
```
File: [client\Rendering\Effects\Effects_init.sqf at line 10](../../../Src/client/Rendering/Effects/Effects_init.sqf#L10)
## render_effects_lastPlayer

Type: Variable

Description: 


Initial value:
```sqf
objnull
```
File: [client\Rendering\Effects\Effects_init.sqf at line 12](../../../Src/client/Rendering/Effects/Effects_init.sqf#L12)
## render_effects_dustParticles

Type: Variable

Description: 


Initial value:
```sqf
objnull
```
File: [client\Rendering\Effects\Effects_init.sqf at line 13](../../../Src/client/Rendering/Effects/Effects_init.sqf#L13)
## render_effects_dustGlob

Type: Variable

Description: 


Initial value:
```sqf
objNull
```
File: [client\Rendering\Effects\Effects_init.sqf at line 14](../../../Src/client/Rendering/Effects/Effects_init.sqf#L14)
## render_effects_init

Type: function

Description: 


File: [client\Rendering\Effects\Effects_init.sqf at line 16](../../../Src/client/Rendering/Effects/Effects_init.sqf#L16)
## render_effects_updateParticles

Type: function

Description: обновление частиц


File: [client\Rendering\Effects\Effects_init.sqf at line 40](../../../Src/client/Rendering/Effects/Effects_init.sqf#L40)
## render_effects_onUpdate

Type: function

Description: цикл обновления частиц


File: [client\Rendering\Effects\Effects_init.sqf at line 46](../../../Src/client/Rendering/Effects/Effects_init.sqf#L46)
# HDRInit.sqf

## render_hdr_init

Type: function

Description: 


File: [client\Rendering\HDR\HDRInit.sqf at line 11](../../../Src/client/Rendering/HDR/HDRInit.sqf#L11)
## render_hdr_setMode

Type: function

Description: 


File: [client\Rendering\HDR\HDRInit.sqf at line 20](../../../Src/client/Rendering/HDR/HDRInit.sqf#L20)
## render_hdr_setWorldTIme

Type: function

Description: 


File: [client\Rendering\HDR\HDRInit.sqf at line 23](../../../Src/client/Rendering/HDR/HDRInit.sqf#L23)
# postprocessing.h

## PP_MACRO_PREF

Type: constant

Description: 


Replaced value:
```sqf
"pp_effect_"
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 11](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L11)
## setGV(var,val)

Type: constant

Description: 
- Param: var
- Param: val

Replaced value:
```sqf
missionNamespace setVariable [var,val]
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 14](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L14)
## getGV(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
(missionNamespace getVariable (var))
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 16](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L16)
## setPPVar(var,val)

Type: constant

Description: 
- Param: var
- Param: val

Replaced value:
```sqf
setGV(PP_MACRO_PREF + var,val)
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 19](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L19)
## getPPVar(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
getGV(PP_MACRO_PREF + var)
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 21](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L21)
## setEffect

Type: constant

Description: 


Replaced value:
```sqf
ppEffectAdjust
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 24](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L24)
## commitEffect

Type: constant

Description: 


Replaced value:
```sqf
ppEffectCommit
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 26](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L26)
## setThisEffect

Type: constant

Description: 


Replaced value:
```sqf
getPPVar(__EFFECT_NAME) setEffect
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 29](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L29)
## setThisEffectCommit

Type: constant

Description: 


Replaced value:
```sqf
getPPVar(__EFFECT_NAME) commitEffect
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 31](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L31)
## setThisEffectEnable

Type: constant

Description: 


Replaced value:
```sqf
getPPVar(__EFFECT_NAME) ppEffectEnable 
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 33](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L33)
## unpackParams()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
params ["__EFFECT_NAME","__args"]
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 38](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L38)
## packParams()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
vec2(__EFFECT_NAME,__args)
```
File: [client\Rendering\PostProcessing\postprocessing.h at line 40](../../../Src/client/Rendering/PostProcessing/postprocessing.h#L40)
# PPInit.sqf

## pp_buffer_efx

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Rendering\PostProcessing\PPInit.sqf at line 30](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L30)
## pp_allEffects

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Rendering\PostProcessing\PPInit.sqf at line 32](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L32)
## pp_uniIndex

Type: Variable

Description: 


Initial value:
```sqf
5000
```
File: [client\Rendering\PostProcessing\PPInit.sqf at line 34](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L34)
## pp_reload

Type: function

Description: 
- Param: _enableUpdated

File: [client\Rendering\PostProcessing\PPInit.sqf at line 37](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L37)
## pp_init

Type: function

Description: 


File: [client\Rendering\PostProcessing\PPInit.sqf at line 65](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L65)
## pp_init_active

Type: function

Description: 


File: [client\Rendering\PostProcessing\PPInit.sqf at line 93](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L93)
## pp_setEnable

Type: function

Description: 
- Param: _varName
- Param: _mode
- Param: _showError (optional, default true)

File: [client\Rendering\PostProcessing\PPInit.sqf at line 100](../../../Src/client/Rendering/PostProcessing/PPInit.sqf#L100)

# ai.h

## AI_DEBUG_TRACEPATH

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\AI\ai.h at line 6](../../../Src/host/AI/ai.h#L6)
## AI_DEBUG_BRAINIINFO

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\AI\ai.h at line 7](../../../Src/host/AI/ai.h#L7)
## toActor(mob)

Type: constant

Description: #define AI_DEBUG_MOVETOPLAYER
- Param: mob

Replaced value:
```sqf
getVar(mob,owner)
```
File: [host\AI\ai.h at line 10](../../../Src/host/AI/ai.h#L10)
## UPDATE_STATE_CONTINUE

Type: constant

Description: Brain action update states


Replaced value:
```sqf
0
```
File: [host\AI\ai.h at line 13](../../../Src/host/AI/ai.h#L13)
## UPDATE_STATE_COMPLETED

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\AI\ai.h at line 14](../../../Src/host/AI/ai.h#L14)
## UPDATE_STATE_FAILED

Type: constant

Description: 


Replaced value:
```sqf
-1
```
File: [host\AI\ai.h at line 15](../../../Src/host/AI/ai.h#L15)
## ai_reloadThis

Type: function

> Exists if **EDITOR** defined

Description: 


File: [host\AI\ai.h at line 18](../../../Src/host/AI/ai.h#L18)
# ai_init.sqf

## ai_nextUpdateReg

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\AI\ai_init.sqf at line 27](../../../Src/host/AI/ai_init.sqf#L27)
## ai_updateRegInterval

Type: Variable

Description: 


Initial value:
```sqf
0.2 //200ms - интервал обновления регионов
```
File: [host\AI\ai_init.sqf at line 28](../../../Src/host/AI/ai_init.sqf#L28)
## ai_maxRegUpdateTime

Type: Variable

Description: 200ms - интервал обновления регионов


Initial value:
```sqf
0.5 //сколько времени можно потратить на обновление регионов за один цикл
```
File: [host\AI\ai_init.sqf at line 29](../../../Src/host/AI/ai_init.sqf#L29)
## ai_regionsUpdateQueue

Type: Variable

Description: сколько времени можно потратить на обновление регионов за один цикл


Initial value:
```sqf
[] //очередь регионов на обновление
```
File: [host\AI\ai_init.sqf at line 31](../../../Src/host/AI/ai_init.sqf#L31)
## ai_regionsUpdateMap

Type: Variable

Description: очередь регионов на обновление


Initial value:
```sqf
createHashMap //маппинг региона на его индекс в очереди
```
File: [host\AI\ai_init.sqf at line 32](../../../Src/host/AI/ai_init.sqf#L32)
## ai_handleUpdate

Type: Variable

Description: маппинг региона на его индекс в очереди


Initial value:
```sqf
-1 //хэндл обновления AI
```
File: [host\AI\ai_init.sqf at line 34](../../../Src/host/AI/ai_init.sqf#L34)
## ai_allMobs

Type: Variable

Description: хэндл обновления AI


Initial value:
```sqf
[] //список всех мобов
```
File: [host\AI\ai_init.sqf at line 36](../../../Src/host/AI/ai_init.sqf#L36)
## ai_activeRegions

Type: Variable

Description: активатор регионов для симуляции


Initial value:
```sqf
createHashMap // регионы, в которых должен работать AI
```
File: [host\AI\ai_init.sqf at line 40](../../../Src/host/AI/ai_init.sqf#L40)
## ai_activeRegionsRadius

Type: Variable

Description: регионы, в которых должен работать AI


Initial value:
```sqf
4 // радиус в регионах
```
File: [host\AI\ai_init.sqf at line 41](../../../Src/host/AI/ai_init.sqf#L41)
## ai_playerLastRegions

Type: Variable

Description: радиус в регионах


Initial value:
```sqf
createHashMap // последний регион каждого игрока (clientOwner -> regionKey)
```
File: [host\AI\ai_init.sqf at line 42](../../../Src/host/AI/ai_init.sqf#L42)
## ai_countCreatedAI

Type: Variable

> Exists if **EDITOR** not defined

Description: 


Initial value:
```sqf
0
```
File: [host\AI\ai_init.sqf at line 75](../../../Src/host/AI/ai_init.sqf#L75)
## ai_debug_internal_needLoadBrainWidget

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
true
```
File: [host\AI\ai_init.sqf at line 397](../../../Src/host/AI/ai_init.sqf#L397)
## ai_modifyRegionRefCount

Type: function

Description: Увеличивает/уменьшает счётчик активности региона
- Param: _regionKey
- Param: _delta

File: [host\AI\ai_init.sqf at line 45](../../../Src/host/AI/ai_init.sqf#L45)
## ai_log

Type: function

Description: 


File: [host\AI\ai_init.sqf at line 67](../../../Src/host/AI/ai_init.sqf#L67)
## ai_createMob

Type: function

Description: 
- Param: _pos
- Param: _builderType (optional, default "AgentBuilderEater")

File: [host\AI\ai_init.sqf at line 78](../../../Src/host/AI/ai_init.sqf#L78)
## ai_createAgent

Type: function

Description: 
- Param: _pos
- Param: _mob
- Param: _agentType (optional, default "AgentEater")

File: [host\AI\ai_init.sqf at line 141](../../../Src/host/AI/ai_init.sqf#L141)
## ai_init

Type: function

Description: 


File: [host\AI\ai_init.sqf at line 168](../../../Src/host/AI/ai_init.sqf#L168)
## ai_onUpdate

Type: function

Description: цикл обновления AI


File: [host\AI\ai_init.sqf at line 193](../../../Src/host/AI/ai_init.sqf#L193)
## ai_debugStart

Type: function

Description: 


File: [host\AI\ai_init.sqf at line 332](../../../Src/host/AI/ai_init.sqf#L332)
## ai_debug_internal_drawPath

Type: function

Description: 


File: [host\AI\ai_init.sqf at line 380](../../../Src/host/AI/ai_init.sqf#L380)
## ai_debug_internal_brainiInfo

Type: function

> Exists if **EDITOR** defined

Description: 


File: [host\AI\ai_init.sqf at line 400](../../../Src/host/AI/ai_init.sqf#L400)
## ai_debug_showBrainInfo

Type: function

> Exists if **EDITOR** defined

Description: 
- Param: _mode

File: [host\AI\ai_init.sqf at line 500](../../../Src/host/AI/ai_init.sqf#L500)
## ai_reloadBehaviors

Type: function

> Exists if **EDITOR** defined

Description: ! fix score on recompile behaviors


File: [host\AI\ai_init.sqf at line 507](../../../Src/host/AI/ai_init.sqf#L507)
# ai_interact.sqf

## ai_internal_speedModes_names

Type: Variable

Description: константа режимов движения сущности


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\AI\ai_interact.sqf at line 463](../../../Src/host/AI/ai_interact.sqf#L463)
## ai_internal_stances_names

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\AI\ai_interact.sqf at line 490](../../../Src/host/AI/ai_interact.sqf#L490)
## ai_moveTo

Type: function

Description: =========================================================
- Param: _mob
- Param: _pos

File: [host\AI\ai_interact.sqf at line 19](../../../Src/host/AI/ai_interact.sqf#L19)
## ai_planMove

Type: function

Description: 
- Param: _mob
- Param: _destPos
- Param: _srcPosIn (optional, default null)

File: [host\AI\ai_interact.sqf at line 26](../../../Src/host/AI/ai_interact.sqf#L26)
## ai_handleMove

Type: function

Description: обработчик движения и корректировка пути (восстановление пути, если сущность зашла в препятствие)
- Param: _mob

File: [host\AI\ai_interact.sqf at line 133](../../../Src/host/AI/ai_interact.sqf#L133)
## ai_getClosestPointOnSegment

Type: function

Description: Вспомогательная функция: найти ближайшую точку на отрезке AB к точке P
- Param: _pointA
- Param: _pointB
- Param: _pointP

File: [host\AI\ai_interact.sqf at line 203](../../../Src/host/AI/ai_interact.sqf#L203)
## ai_internal_setStop

Type: function

Description: внутренняя функция установки остановки сущности
- Param: _mob
- Param: _stop

File: [host\AI\ai_interact.sqf at line 238](../../../Src/host/AI/ai_interact.sqf#L238)
## ai_stopMove

Type: function

Description: высокоуровневая функция остановки сущности
- Param: _mob

File: [host\AI\ai_interact.sqf at line 245](../../../Src/host/AI/ai_interact.sqf#L245)
## ai_retreatFrom

Type: function

Description: 
- Param: _mob
- Param: _fromTarget
- Param: _distance (optional, default 10)

File: [host\AI\ai_interact.sqf at line 292](../../../Src/host/AI/ai_interact.sqf#L292)
## ai_findNearestValidPosition

Type: function

Description: 
- Param: _mob
- Param: _centerPos (optional, default [])
- Param: _maxDistance (optional, default 30)
- Param: _minDistance (optional, default 5)
- Param: _selectRandom (optional, default false)

File: [host\AI\ai_interact.sqf at line 349](../../../Src/host/AI/ai_interact.sqf#L349)
## ai_setSpeed

Type: function

Description: 
- Param: _mob
- Param: _speedMode

File: [host\AI\ai_interact.sqf at line 469](../../../Src/host/AI/ai_interact.sqf#L469)
## ai_rotateTo

Type: function

Description: 
- Param: _mob
- Param: _posOrTarget

File: [host\AI\ai_interact.sqf at line 475](../../../Src/host/AI/ai_interact.sqf#L475)
## ai_setStance

Type: function

Description: 
- Param: _mob
- Param: _stance

File: [host\AI\ai_interact.sqf at line 496](../../../Src/host/AI/ai_interact.sqf#L496)
## ai_attackTarget

Type: function

Description: Атака цели
- Param: _mob
- Param: _target

File: [host\AI\ai_interact.sqf at line 508](../../../Src/host/AI/ai_interact.sqf#L508)
## ai_pickupItem

Type: function

Description: Подобрать предмет
- Param: _mob
- Param: _item

File: [host\AI\ai_interact.sqf at line 527](../../../Src/host/AI/ai_interact.sqf#L527)
## ai_dropItem

Type: function

Description: Выбросить предмет
- Param: _mob
- Param: _item

File: [host\AI\ai_interact.sqf at line 540](../../../Src/host/AI/ai_interact.sqf#L540)
## ai_useItem

Type: function

Description: ! пока не решено как будет использоваться
- Param: _mob
- Param: _item

File: [host\AI\ai_interact.sqf at line 554](../../../Src/host/AI/ai_interact.sqf#L554)
## ai_takeCover

Type: function

Description: Занять укрытие (пока простая реализация - лечь)
- Param: _mob
- Param: _coverPos (optional, default [])

File: [host\AI\ai_interact.sqf at line 564](../../../Src/host/AI/ai_interact.sqf#L564)
## ai_setCombatMode

Type: function

Description: Установить боевой режим
- Param: _mob
- Param: _enabled

File: [host\AI\ai_interact.sqf at line 574](../../../Src/host/AI/ai_interact.sqf#L574)
# ai_util.sqf

## ai_clamp

Type: function

Description: 
- Param: _val
- Param: _min
- Param: _max

File: [host\AI\ai_util.sqf at line 13](../../../Src/host/AI/ai_util.sqf#L13)
## ai_normalize

Type: function

Description: 
- Param: _val
- Param: _min
- Param: _max

File: [host\AI\ai_util.sqf at line 23](../../../Src/host/AI/ai_util.sqf#L23)
## ai_invNorm

Type: function

Description: 
- Param: _val
- Param: _min
- Param: _max

File: [host\AI\ai_util.sqf at line 32](../../../Src/host/AI/ai_util.sqf#L32)
## ai_powCurve

Type: function

Description: 
- Param: _x
- Param: _power

File: [host\AI\ai_util.sqf at line 41](../../../Src/host/AI/ai_util.sqf#L41)
## ai_sigmoid

Type: function

Description: 
- Param: _x
- Param: _k

File: [host\AI\ai_util.sqf at line 51](../../../Src/host/AI/ai_util.sqf#L51)
## ai_lerp

Type: function

Description: 
- Param: _a
- Param: _b
- Param: _t

File: [host\AI\ai_util.sqf at line 60](../../../Src/host/AI/ai_util.sqf#L60)
## ai_weightedBlend

Type: function

Description: 
- Param: _factors

File: [host\AI\ai_util.sqf at line 69](../../../Src/host/AI/ai_util.sqf#L69)
## ai_softmaxSelect

Type: function

Description: 
- Param: _values
- Param: _temp

File: [host\AI\ai_util.sqf at line 86](../../../Src/host/AI/ai_util.sqf#L86)
## ai_getApproachPosition

Type: function

Description: 
- Param: _sourcePos
- Param: _targetPos
- Param: _approachDist

File: [host\AI\ai_util.sqf at line 109](../../../Src/host/AI/ai_util.sqf#L109)
## ai_predictTargetPosition

Type: function

Description: 
- Param: _target
- Param: _predictionTime (optional, default 1.0)

File: [host\AI\ai_util.sqf at line 134](../../../Src/host/AI/ai_util.sqf#L134)
# brain_init.sqf

## ai_brain_getAllActionTypes

Type: function

Description: получает массив строк всех типов действий


File: [host\AI\Brain\brain_init.sqf at line 20](../../../Src/host/AI/Brain/brain_init.sqf#L20)
## ai_brain_update

Type: function

Description: Главная функция обновления Utility AI
 Вызывается каждый кадр для каждого агента
- Param: _mob
- Param: _agent

File: [host\AI\Brain\brain_init.sqf at line 32](../../../Src/host/AI/Brain/brain_init.sqf#L32)
## ai_brain_selectBestAction

Type: function

Description: Выбирает лучшее действие на основе score
 Возвращает действие с максимальным score или null
- Param: _agent
- Param: _mob

File: [host\AI\Brain\brain_init.sqf at line 112](../../../Src/host/AI/Brain/brain_init.sqf#L112)
## ai_brain_switchAction

Type: function

Description: Переключает действие со старого на новое
 Вызывает соответствующие события
- Param: _agent
- Param: _mob
- Param: _oldAction
- Param: _newAction

File: [host\AI\Brain\brain_init.sqf at line 145](../../../Src/host/AI/Brain/brain_init.sqf#L145)
# core.sqf

## AI_ENABLE_DEBUG_LOG

Type: constant

Description: #define AI_NAV_DEBUG_DRAW true


Replaced value:
```sqf

```
File: [host\AI\HPAstar\core.sqf at line 46](../../../Src/host/AI/HPAstar/core.sqf#L46)
## ai_debug_decl(linedecl)

Type: constant

> Exists if **AI_NAV_DEBUG** defined

Description: 
- Param: linedecl

Replaced value:
```sqf
linedecl
```
File: [host\AI\HPAstar\core.sqf at line 69](../../../Src/host/AI/HPAstar/core.sqf#L69)
## ai_debug_decl(linedecl)

Type: constant

> Exists if **AI_NAV_DEBUG** not defined

Description: 
- Param: linedecl

Replaced value:
```sqf

```
File: [host\AI\HPAstar\core.sqf at line 71](../../../Src/host/AI/HPAstar/core.sqf#L71)
## ai_nav_regions

Type: Variable

Description: Навигационные данные


Initial value:
```sqf
createHashMap      // regionKey -> region data
```
File: [host\AI\HPAstar\core.sqf at line 55](../../../Src/host/AI/HPAstar/core.sqf#L55)
## ai_nav_nodes

Type: Variable

Description: regionKey -> region data


Initial value:
```sqf
createHashMap        // nodeId -> node data  
```
File: [host\AI\HPAstar\core.sqf at line 56](../../../Src/host/AI/HPAstar/core.sqf#L56)
## ai_nav_adjacency

Type: Variable

Description: nodeId -> node data


Initial value:
```sqf
createHashMap    // nodeId -> [[neighborId, cost], ...]
```
File: [host\AI\HPAstar\core.sqf at line 57](../../../Src/host/AI/HPAstar/core.sqf#L57)
## ai_nav_regionSize

Type: Variable

Description: Конфигурация генерации сетки


Initial value:
```sqf
10              // Размер региона 10×10м
```
File: [host\AI\HPAstar\core.sqf at line 60](../../../Src/host/AI/HPAstar/core.sqf#L60)
## ai_nav_gridStep

Type: Variable

Description: Размер региона 10×10м


Initial value:
```sqf
1                 // Шаг сетки 1м
```
File: [host\AI\HPAstar\core.sqf at line 61](../../../Src/host/AI/HPAstar/core.sqf#L61)
## ai_nav_maxSlope

Type: Variable

Description: Шаг сетки 1м


Initial value:
```sqf
45                // Максимальный угол склона в градусах
```
File: [host\AI\HPAstar\core.sqf at line 62](../../../Src/host/AI/HPAstar/core.sqf#L62)
## ai_nav_raycastHeight

Type: Variable

Description: Максимальный угол склона в градусах


Initial value:
```sqf
300          // Высота начала raycast
```
File: [host\AI\HPAstar\core.sqf at line 63](../../../Src/host/AI/HPAstar/core.sqf#L63)
## ai_nav_minDistZ

Type: Variable

Description: Высота начала raycast


Initial value:
```sqf
0.7				// Минимальное расстояние по Z построения узлов по z
```
File: [host\AI\HPAstar\core.sqf at line 64](../../../Src/host/AI/HPAstar/core.sqf#L64)
## ai_nav_nodeIdCounter

Type: Variable

Description: Минимальное расстояние по Z построения узлов по z


Initial value:
```sqf
0
```
File: [host\AI\HPAstar\core.sqf at line 66](../../../Src/host/AI/HPAstar/core.sqf#L66)
## ai_nav_generateNodeId

Type: function

Description: Генерация уникального ID для узла


File: [host\AI\HPAstar\core.sqf at line 76](../../../Src/host/AI/HPAstar/core.sqf#L76)
## ai_nav_getSlopeAngleVec

Type: function

Description: 
- Param: _pos1
- Param: _pos2

File: [host\AI\HPAstar\core.sqf at line 81](../../../Src/host/AI/HPAstar/core.sqf#L81)
## ai_nav_checkSlopeFast

Type: function

Description: БЫСТРАЯ проверка наклона (без векторных операций)
- Param: _pos1
- Param: _pos2
- Param: _dist
- Param: _maxSlope

File: [host\AI\HPAstar\core.sqf at line 97](../../../Src/host/AI/HPAstar/core.sqf#L97)
## ai_nav_sortBy

Type: function

Description: 
- Param: _list
- Param: _algorithm
- Param: _modeIsAscend (optional, default true)

File: [host\AI\HPAstar\core.sqf at line 114](../../../Src/host/AI/HPAstar/core.sqf#L114)
## ai_nav_generateRegionNodes

Type: function

Description: 
- Param: _pos
- Param: _autoSave (optional, default true)

File: [host\AI\HPAstar\core.sqf at line 129](../../../Src/host/AI/HPAstar/core.sqf#L129)
## ai_nav_findNearestNode

Type: function

Description: Найти ближайший узел к позиции
- Param: _pos
- Param: _maxDistance (optional, default 50)

File: [host\AI\HPAstar\core.sqf at line 440](../../../Src/host/AI/HPAstar/core.sqf#L440)
## ai_nav_reconstructPath

Type: function

Description: Восстановить путь из массива родителей
- Param: _cameFrom
- Param: _current

File: [host\AI\HPAstar\core.sqf at line 492](../../../Src/host/AI/HPAstar/core.sqf#L492)
## ai_nav_heuristic

Type: function

Description: Эвристическая функция (расстояние по прямой)
- Param: _nodeId1
- Param: _nodeId2

File: [host\AI\HPAstar\core.sqf at line 507](../../../Src/host/AI/HPAstar/core.sqf#L507)
## ai_nav_heuristicPos

Type: function

Description: Эвристическая функция с позицией вместо ID узла
- Param: _nodeId
- Param: _targetPos

File: [host\AI\HPAstar\core.sqf at line 517](../../../Src/host/AI/HPAstar/core.sqf#L517)
## ai_nav_getNeighbors

Type: function

Description: Получить соседей узла
- Param: _nodeId

File: [host\AI\HPAstar\core.sqf at line 525](../../../Src/host/AI/HPAstar/core.sqf#L525)
## ai_nav_findPathNodes

Type: function

Description: A* алгоритм поиска пути между двумя узлами (ОПТИМИЗИРОВАННЫЙ)
- Param: _startNodeId
- Param: _goalNodeId

File: [host\AI\HPAstar\core.sqf at line 533](../../../Src/host/AI/HPAstar/core.sqf#L533)
## ai_nav_findPath

Type: function

Description: Найти путь между двумя позициями
- Param: _startPos
- Param: _endPos
- Param: _optimize (optional, default true)

File: [host\AI\HPAstar\core.sqf at line 648](../../../Src/host/AI/HPAstar/core.sqf#L648)
## ai_nav_smoothPath

Type: function

Description: Убирает промежуточные точки, если можно пройти напрямую
- Param: _path

File: [host\AI\HPAstar\core.sqf at line 692](../../../Src/host/AI/HPAstar/core.sqf#L692)
## ai_nav_hasLineOfSight

Type: function

Description: Проверка line-of-sight между двумя точками
- Param: _pos1
- Param: _pos2

File: [host\AI\HPAstar\core.sqf at line 734](../../../Src/host/AI/HPAstar/core.sqf#L734)
## ai_nav_smoothPath_fast

Type: function

Description: 
- Param: _path

File: [host\AI\HPAstar\core.sqf at line 753](../../../Src/host/AI/HPAstar/core.sqf#L753)
## ai_nav_findPath_autoGenerate

Type: function

Description: Найти путь с автогенерацией регионов
- Param: _startPos
- Param: _endPos
- Param: _optimize (optional, default true)
- Param: _maxRegionsToGenerate (optional, default 5)
- Param: _pathWidth (optional, default 1)

File: [host\AI\HPAstar\core.sqf at line 787](../../../Src/host/AI/HPAstar/core.sqf#L787)
## ai_nav_generateRegionsOnLine_withInit

Type: function

Description: _pathWidth - количество регионов в стороны от центральной линии (по умолчанию 1)
- Param: _startPos
- Param: _endPos
- Param: _maxRegions
- Param: _pathWidth (optional, default 1)

File: [host\AI\HPAstar\core.sqf at line 854](../../../Src/host/AI/HPAstar/core.sqf#L854)
## ai_nav_findPartialPath

Type: function

Description: Использует модифицированный A* с ранним выходом для оптимизации
- Param: _startPos
- Param: _endPos
- Param: _optimize (optional, default true)
- Param: _refPathNodes (optional, default null)

File: [host\AI\HPAstar\core.sqf at line 904](../../../Src/host/AI/HPAstar/core.sqf#L904)
## ai_nav_findPathToClosestNode

Type: function

Description: С оптимизацией раннего выхода для достижимых целей
- Param: _startNodeId
- Param: _targetPos
- Param: _earlyExitDistance (optional, default 2)

File: [host\AI\HPAstar\core.sqf at line 963](../../../Src/host/AI/HPAstar/core.sqf#L963)
## ai_nav_findNearestNodeTowards

Type: function

Description: ОПТИМИЗИРОВАНО: ищет только в регионах в направлении цели
- Param: _startPos
- Param: _targetPos
- Param: _maxSearchDistance (optional, default 100)

File: [host\AI\HPAstar\core.sqf at line 1073](../../../Src/host/AI/HPAstar/core.sqf#L1073)
# debug.sqf

## ai_debugLog

Type: function

Description: Работает как в редакторе (3DEN), так и в игре


File: [host\AI\HPAstar\debug.sqf at line 53](../../../Src/host/AI/HPAstar/debug.sqf#L53)
## ai_nav_clearDebugObjects

Type: function

Description: Очистка отладочных объектов


File: [host\AI\HPAstar\debug.sqf at line 64](../../../Src/host/AI/HPAstar/debug.sqf#L64)
## ai_nav_debug_createObj

Type: function

Description: 
- Param: _pos
- Param: _color (optional, default ['1', '1', '1'])
- Param: _size (optional, default 1)
- Param: _isSphere (optional, default false)
- Param: _list (optional, default ai_debug_objs)

File: [host\AI\HPAstar\debug.sqf at line 74](../../../Src/host/AI/HPAstar/debug.sqf#L74)
## ai_nav_debug_drawNode

Type: function

Description: 
- Param: _pos
- Param: _pos2
- Param: _color (optional, default ['1', '0', '0', '1'])
- Param: _wdt (optional, default 1)

File: [host\AI\HPAstar\debug.sqf at line 88](../../../Src/host/AI/HPAstar/debug.sqf#L88)
## ai_nav_quickInit

Type: function

Description: Быстрая инициализация навигации вокруг позиции
- Param: _pos
- Param: _radius (optional, default 50)

File: [host\AI\HPAstar\debug.sqf at line 98](../../../Src/host/AI/HPAstar/debug.sqf#L98)
## ai_nav_getStats

Type: function

Description: Получить информацию о системе навигации


File: [host\AI\HPAstar\debug.sqf at line 119](../../../Src/host/AI/HPAstar/debug.sqf#L119)
## ai_nav_debugDrawPath

Type: function

Description: Визуализация найденного пути
- Param: _path
- Param: _color (optional, default ['1', '0', '1', '1'])
- Param: _width (optional, default 30)

File: [host\AI\HPAstar\debug.sqf at line 138](../../../Src/host/AI/HPAstar/debug.sqf#L138)
## ai_nav_testPath

Type: function

Description: Тест: найти и визуализировать путь между двумя позициями
- Param: _startPos
- Param: _endPos
- Param: _optimize (optional, default true)
- Param: _fnc (optional, default "autogen")
- Param: _args (optional, default [])

File: [host\AI\HPAstar\debug.sqf at line 171](../../../Src/host/AI/HPAstar/debug.sqf#L171)
## ai_nav_debug_testPathOnline

Type: function

Description: 
- Param: _startPos
- Param: _endPos

File: [host\AI\HPAstar\debug.sqf at line 207](../../../Src/host/AI/HPAstar/debug.sqf#L207)
# entrance.sqf

## ai_nav_buildEntrancePoints

Type: function

Description: Найти переходные точки для всех регионов


File: [host\AI\HPAstar\entrance.sqf at line 8](../../../Src/host/AI/HPAstar/entrance.sqf#L8)
## ai_nav_findEntrancePoints

Type: function

Description: Найти переходные точки для конкретного региона (ОПТИМИЗИРОВАНО)
- Param: _regionKey

File: [host\AI\HPAstar\entrance.sqf at line 30](../../../Src/host/AI/HPAstar/entrance.sqf#L30)
# region.sqf

## ai_nav_getRegionKey

Type: function

Description: Генерация ключа региона по позиции
- Param: _x
- Param: _y

File: [host\AI\HPAstar\region.sqf at line 7](../../../Src/host/AI/HPAstar/region.sqf#L7)
## ai_nav_saveRegion

Type: function

Description: Сохранение данных региона в глобальные структуры
- Param: _regionKey
- Param: _nodes
- Param: _edges

File: [host\AI\HPAstar\region.sqf at line 15](../../../Src/host/AI/HPAstar/region.sqf#L15)
## ai_nav_getRegion

Type: function

Description: Получение данных региона
- Param: _regionKey

File: [host\AI\HPAstar\region.sqf at line 81](../../../Src/host/AI/HPAstar/region.sqf#L81)
## ai_nav_hasRegion

Type: function

Description: Проверка существования региона
- Param: _pos

File: [host\AI\HPAstar\region.sqf at line 87](../../../Src/host/AI/HPAstar/region.sqf#L87)
## ai_nav_regionToPos

Type: function

Description: 
- Param: _regionKey

File: [host\AI\HPAstar\region.sqf at line 93](../../../Src/host/AI/HPAstar/region.sqf#L93)
## ai_nav_getNodesInRegionArea

Type: function

Description: Используется для оптимизированного поиска ближайших узлов
- Param: _pos
- Param: _includeNeighbors (optional, default true)

File: [host\AI\HPAstar\region.sqf at line 106](../../../Src/host/AI/HPAstar/region.sqf#L106)
## ai_nav_generateRegions

Type: function

Description: Генерация сетки регионов в радиусе от центральной точки
- Param: _centerPos
- Param: _radius

File: [host\AI\HPAstar\region.sqf at line 139](../../../Src/host/AI/HPAstar/region.sqf#L139)
## ai_nav_clearAllRegions

Type: function

Description: Очистка всех регионов


File: [host\AI\HPAstar\region.sqf at line 184](../../../Src/host/AI/HPAstar/region.sqf#L184)
# update.sqf

## ai_nav_updateRegion

Type: function

Description: ============================================================================
- Param: _pos

File: [host\AI\HPAstar\update.sqf at line 9](../../../Src/host/AI/HPAstar/update.sqf#L9)
## ai_nav_createRegionIfNeed

Type: function

Description: 
- Param: _pos

File: [host\AI\HPAstar\update.sqf at line 31](../../../Src/host/AI/HPAstar/update.sqf#L31)
## ai_nav_requestUpdateRegion

Type: function

Description: 


File: [host\AI\HPAstar\update.sqf at line 42](../../../Src/host/AI/HPAstar/update.sqf#L42)
## ai_nav_requestUpdateRegion_internal

Type: function

Description: 
- Param: _pos

File: [host\AI\HPAstar\update.sqf at line 43](../../../Src/host/AI/HPAstar/update.sqf#L43)
## ai_nav_invalidateRegion

Type: function

Description: 
- Param: _regionKey

File: [host\AI\HPAstar\update.sqf at line 63](../../../Src/host/AI/HPAstar/update.sqf#L63)
## ai_nav_updateRegionEntrances

Type: function

Description: 
- Param: _regionKey

File: [host\AI\HPAstar\update.sqf at line 115](../../../Src/host/AI/HPAstar/update.sqf#L115)
## ai_nav_updateRegionEntrances_fast

Type: function

Description: 
- Param: _regionKey

File: [host\AI\HPAstar\update.sqf at line 146](../../../Src/host/AI/HPAstar/update.sqf#L146)
## ai_nav_updateEntrancesBetween

Type: function

Description: Обновить entrance points между двумя конкретными регионами (С ПРОФИЛИРОВАНИЕМ)
- Param: _regionKey1
- Param: _regionKey2

File: [host\AI\HPAstar\update.sqf at line 183](../../../Src/host/AI/HPAstar/update.sqf#L183)
## ai_nav_buildEntrancesBetween

Type: function

Description: Построить entrance points между двумя конкретными регионами (С ПРОФИЛИРОВАНИЕМ)
- Param: _regionKey1
- Param: _regionKey2

File: [host\AI\HPAstar\update.sqf at line 266](../../../Src/host/AI/HPAstar/update.sqf#L266)
## ai_nav_getBorderNodes

Type: function

Description: Получить граничные узлы региона в конкретном направлении
- Param: _regionKey
- Param: _dx
- Param: _dy

File: [host\AI\HPAstar\update.sqf at line 504](../../../Src/host/AI/HPAstar/update.sqf#L504)

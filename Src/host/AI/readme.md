# типы сущностей
Сущности разделены на 2 вида: человекоподобные и объектные. Их отличия заключаются в способах анимирования. В остальном вся логика работы одинакова.

# ai behaviour

Поведение АИ реализуется через структуры BehaviourState
Базовый интерфейс следующий:
```
struct(BehaviourState)
    //internal name for debugging
    def(name) -> string
    //объект контекста для хранения флагов поведения
    def(context) -> struct
    def(getContext) -> struct

    //ref for ai entity
    def(mob) -> object
    
    def(onEnter) -> void
    def(onExit) -> void

    def(onUpdate) -> void
    def(jumpTo) -> void
endstruct
```
Через наследование мы создаем собственные состояния поведения. Мы можем добавлять переменные в этих структурах. Для глобальных состояний реализуется контекст поведения. Он пробрасывается во все объекты состояний. Базовый интерфейс контекста:
```
struct(BehaviourContext)
    def(name) -> string
endstruct
```


Для разных сущностей мы реализуем разные наборы поведений. Набор поведений регистрируется в компоненте AIStateManager (AISM):

```
_mob = [] call api_getAIMob;

//list of struct behaviour types
_structTypenames = ["BSMob_Start", "BSMob_Idle","BSMob_Die"];
{
    [_mob,_x] call aism_registerBehaviour;
} foreach _structTypenames;

//BehaviourContextMob - struct for global mob context
[_mob,"BehaviourContextMob","BSMob_Start"] call aism_startBehaviour;

```

Компонент AISM реализует логику переключения между поведением и регистрацией поведений на сущностях.

# ai anim

Компонент AIAnim (AIA) отвечает за визуальное представление поведения и синхронизацию этого представления по сети.

```
[_mob,"platform_anim_config_name"] call aia_setNetAnim;

_objentity = [] call ...;

[_objentity,[0,1,0]] call aia_interpNetMove;
```

# ai moving

Компонент AIMove (AIM) отвечает за ориентацию в пространстве и передвижение сущностей. Для оценки местности и возможности передвижения используется паралеллельный рейкаст. 

```
_mob = ...
_targetpos = ...
_queryResult = [_mob,_targetpos] call aim_getMovePath; //get control path points
if (_queryResult call aim_isMovePossible) then {
    _movehandle = [_mob,_queryResult] call aim_moveFromPath;
};
```

На более низком уровне предоставляется API:
```
aim_canMove(_mob,_targetpos,_flags)
aim_raycastParallel(_from,_to)
```
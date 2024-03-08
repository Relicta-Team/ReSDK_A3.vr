# Logger_init.sqf

## DISABLE_LOG_IN_EDITOR

Type: constant

Description: отключить логгер в редакторе


Replaced value:
```sqf

```
File: [host\Logger\Logger_init.sqf at line 14](../../../Src/host/Logger/Logger_init.sqf#L14)
## __logger_decl_params__

Type: constant

Description: 


Replaced value:
```sqf
\
(if equalTypes(_this,[]) then { \
	format _this \
} else { \
	if not_equalTypes(_this,"") then {str _this} else {_this} \
})
```
File: [host\Logger\Logger_init.sqf at line 43](../../../Src/host/Logger/Logger_init.sqf#L43)
## __log_prefix(typo)

Type: constant

Description: 
- Param: typo

Replaced value:
```sqf
'(typo)	'
```
File: [host\Logger\Logger_init.sqf at line 50](../../../Src/host/Logger/Logger_init.sqf#L50)
## __log_prefix_DEBUG

Type: constant

Description: 


Replaced value:
```sqf
"(DEBUG)	"
```
File: [host\Logger\Logger_init.sqf at line 51](../../../Src/host/Logger/Logger_init.sqf#L51)
## isImplementedLoggerFunction(cat)

Type: constant

Description: 
- Param: cat

Replaced value:
```sqf
!isNull( missionNamespace getvariable vec2(cat + "log",nil))
```
File: [host\Logger\Logger_init.sqf at line 53](../../../Src/host/Logger/Logger_init.sqf#L53)
## decl_std_logger_type(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
type##Log = { [format _this, 'type'] call logger_action};
```
File: [host\Logger\Logger_init.sqf at line 55](../../../Src/host/Logger/Logger_init.sqf#L55)
## logger_internal_map

Type: Variable

Description: 


Initial value:
```sqf
hashMapNew
```
File: [host\Logger\Logger_init.sqf at line 41](../../../Src/host/Logger/Logger_init.sqf#L41)
## Log

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 55](../../../Src/host/Logger/Logger_init.sqf#L55)
## logger_internal_init

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 68](../../../Src/host/Logger/Logger_init.sqf#L68)
## logger_internal_registerLogCategory

Type: function

Description: 
- Param: _logCategory

File: [host\Logger\Logger_init.sqf at line 85](../../../Src/host/Logger/Logger_init.sqf#L85)
## logCritical

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 111](../../../Src/host/Logger/Logger_init.sqf#L111)
## logError

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 114](../../../Src/host/Logger/Logger_init.sqf#L114)
## logWarn

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 117](../../../Src/host/Logger/Logger_init.sqf#L117)
## logInfo

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 120](../../../Src/host/Logger/Logger_init.sqf#L120)
## logDebug

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 123](../../../Src/host/Logger/Logger_init.sqf#L123)
## logTrace

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 128](../../../Src/host/Logger/Logger_init.sqf#L128)
## logToFile

Type: function

Description: 
- Param: _cat

File: [host\Logger\Logger_init.sqf at line 134](../../../Src/host/Logger/Logger_init.sqf#L134)
## logger_action

Type: function

Description: 
- Param: _dat (optional, default "")
- Param: _cat (optional, default "")
- Param: _lvl (optional, default "")

File: [host\Logger\Logger_init.sqf at line 140](../../../Src/host/Logger/Logger_init.sqf#L140)
## logger_timeStampToString

Type: function

Description: 
- Param: _year
- Param: _month
- Param: _day
- Param: _hour
- Param: _minute
- Param: _second
- Param: _millisecond

File: [host\Logger\Logger_init.sqf at line 167](../../../Src/host/Logger/Logger_init.sqf#L167)

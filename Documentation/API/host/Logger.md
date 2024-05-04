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
File: [host\Logger\Logger_init.sqf at line 50](../../../Src/host/Logger/Logger_init.sqf#L50)
## __log_prefix(typo)

Type: constant

Description: 
- Param: typo

Replaced value:
```sqf
'(typo)	'
```
File: [host\Logger\Logger_init.sqf at line 57](../../../Src/host/Logger/Logger_init.sqf#L57)
## __log_prefix_DEBUG

Type: constant

Description: 


Replaced value:
```sqf
"(DEBUG)	"
```
File: [host\Logger\Logger_init.sqf at line 58](../../../Src/host/Logger/Logger_init.sqf#L58)
## isImplementedLoggerFunction(cat)

Type: constant

Description: 
- Param: cat

Replaced value:
```sqf
!isNull( missionNamespace getvariable vec2(cat + "log",nil))
```
File: [host\Logger\Logger_init.sqf at line 60](../../../Src/host/Logger/Logger_init.sqf#L60)
## decl_std_logger_type(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
type##Log = { [format _this, 'type'] call logger_action};
```
File: [host\Logger\Logger_init.sqf at line 62](../../../Src/host/Logger/Logger_init.sqf#L62)
## logger_internal_map

Type: Variable

Description: 


Initial value:
```sqf
hashMapNew
```
File: [host\Logger\Logger_init.sqf at line 48](../../../Src/host/Logger/Logger_init.sqf#L48)
## Log

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 62](../../../Src/host/Logger/Logger_init.sqf#L62)
## logger_internal_init

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 75](../../../Src/host/Logger/Logger_init.sqf#L75)
## logger_internal_registerLogCategory

Type: function

Description: 
- Param: _logCategory

File: [host\Logger\Logger_init.sqf at line 92](../../../Src/host/Logger/Logger_init.sqf#L92)
## logCritical

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 118](../../../Src/host/Logger/Logger_init.sqf#L118)
## logError

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 121](../../../Src/host/Logger/Logger_init.sqf#L121)
## logWarn

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 124](../../../Src/host/Logger/Logger_init.sqf#L124)
## logInfo

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 127](../../../Src/host/Logger/Logger_init.sqf#L127)
## logDebug

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 130](../../../Src/host/Logger/Logger_init.sqf#L130)
## logTrace

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 135](../../../Src/host/Logger/Logger_init.sqf#L135)
## logToFile

Type: function

Description: 
- Param: _cat

File: [host\Logger\Logger_init.sqf at line 141](../../../Src/host/Logger/Logger_init.sqf#L141)
## logger_action

Type: function

Description: 
- Param: _dat (optional, default "")
- Param: _cat (optional, default "")
- Param: _lvl (optional, default "")

File: [host\Logger\Logger_init.sqf at line 147](../../../Src/host/Logger/Logger_init.sqf#L147)
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

File: [host\Logger\Logger_init.sqf at line 178](../../../Src/host/Logger/Logger_init.sqf#L178)
## logger_formatMob

Type: function

Description: 
- Param: _mob

File: [host\Logger\Logger_init.sqf at line 185](../../../Src/host/Logger/Logger_init.sqf#L185)

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
## isImplementedLoggerFunction(cat)

Type: constant

Description: 
- Param: cat

Replaced value:
```sqf
!isNull( missionNamespace getvariable vec2(cat + "log",nil))
```
File: [host\Logger\Logger_init.sqf at line 52](../../../Src/host/Logger/Logger_init.sqf#L52)
## decl_std_logger_type(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
type##Log = { [format _this, 'type'] call logger_action};
```
File: [host\Logger\Logger_init.sqf at line 54](../../../Src/host/Logger/Logger_init.sqf#L54)
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


File: [host\Logger\Logger_init.sqf at line 54](../../../Src/host/Logger/Logger_init.sqf#L54)
## logger_internal_init

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 67](../../../Src/host/Logger/Logger_init.sqf#L67)
## logger_internal_registerLogCategory

Type: function

Description: 
- Param: _logCategory

File: [host\Logger\Logger_init.sqf at line 84](../../../Src/host/Logger/Logger_init.sqf#L84)
## logCritical

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 110](../../../Src/host/Logger/Logger_init.sqf#L110)
## logError

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 113](../../../Src/host/Logger/Logger_init.sqf#L113)
## logWarn

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 116](../../../Src/host/Logger/Logger_init.sqf#L116)
## logInfo

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 119](../../../Src/host/Logger/Logger_init.sqf#L119)
## logDebug

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 122](../../../Src/host/Logger/Logger_init.sqf#L122)
## logTrace

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 127](../../../Src/host/Logger/Logger_init.sqf#L127)
## logToFile

Type: function

Description: 
- Param: _cat

File: [host\Logger\Logger_init.sqf at line 133](../../../Src/host/Logger/Logger_init.sqf#L133)
## logger_action

Type: function

Description: 
- Param: _dat (optional, default "")
- Param: _cat (optional, default "")
- Param: _lvl (optional, default "")

File: [host\Logger\Logger_init.sqf at line 139](../../../Src/host/Logger/Logger_init.sqf#L139)
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

File: [host\Logger\Logger_init.sqf at line 166](../../../Src/host/Logger/Logger_init.sqf#L166)

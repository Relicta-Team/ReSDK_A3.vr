# Logger_init.sqf

## DISABLE_LOG_IN_EDITOR

Type: constant

Description: отключить логгер в редакторе


Replaced value:
```sqf

```
File: [host\Logger\Logger_init.sqf at line 16](../../../Src/host/Logger/Logger_init.sqf#L16)
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
File: [host\Logger\Logger_init.sqf at line 52](../../../Src/host/Logger/Logger_init.sqf#L52)
## __log_prefix(typo)

Type: constant

Description: 
- Param: typo

Replaced value:
```sqf
'(typo)	'
```
File: [host\Logger\Logger_init.sqf at line 59](../../../Src/host/Logger/Logger_init.sqf#L59)
## __log_prefix_DEBUG

Type: constant

Description: 


Replaced value:
```sqf
"(DEBUG)	"
```
File: [host\Logger\Logger_init.sqf at line 60](../../../Src/host/Logger/Logger_init.sqf#L60)
## isImplementedLoggerFunction(cat)

Type: constant

Description: 
- Param: cat

Replaced value:
```sqf
!isNull( missionNamespace getvariable vec2(cat + "log",nil))
```
File: [host\Logger\Logger_init.sqf at line 62](../../../Src/host/Logger/Logger_init.sqf#L62)
## decl_std_logger_type(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
type##Log = { [format _this, 'type'] call logger_action};
```
File: [host\Logger\Logger_init.sqf at line 64](../../../Src/host/Logger/Logger_init.sqf#L64)
## logger_internal_map

Type: Variable

Description: 


Initial value:
```sqf
hashMapNew
```
File: [host\Logger\Logger_init.sqf at line 50](../../../Src/host/Logger/Logger_init.sqf#L50)
## Log

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 64](../../../Src/host/Logger/Logger_init.sqf#L64)
## logger_internal_init

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 77](../../../Src/host/Logger/Logger_init.sqf#L77)
## logger_internal_registerLogCategory

Type: function

Description: 
- Param: _logCategory

File: [host\Logger\Logger_init.sqf at line 94](../../../Src/host/Logger/Logger_init.sqf#L94)
## logCritical

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 120](../../../Src/host/Logger/Logger_init.sqf#L120)
## logError

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 123](../../../Src/host/Logger/Logger_init.sqf#L123)
## logWarn

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 126](../../../Src/host/Logger/Logger_init.sqf#L126)
## logInfo

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 129](../../../Src/host/Logger/Logger_init.sqf#L129)
## logDebug

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 132](../../../Src/host/Logger/Logger_init.sqf#L132)
## logTrace

Type: function

Description: 


File: [host\Logger\Logger_init.sqf at line 137](../../../Src/host/Logger/Logger_init.sqf#L137)
## logToFile

Type: function

Description: 
- Param: _cat

File: [host\Logger\Logger_init.sqf at line 143](../../../Src/host/Logger/Logger_init.sqf#L143)
## logger_action

Type: function

Description: 
- Param: _dat (optional, default "")
- Param: _cat (optional, default "")
- Param: _lvl (optional, default "")

File: [host\Logger\Logger_init.sqf at line 149](../../../Src/host/Logger/Logger_init.sqf#L149)
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

File: [host\Logger\Logger_init.sqf at line 193](../../../Src/host/Logger/Logger_init.sqf#L193)
## logger_formatMob

Type: function

Description: 
- Param: _mob

File: [host\Logger\Logger_init.sqf at line 200](../../../Src/host/Logger/Logger_init.sqf#L200)
# Logger_RPTDump.h

## SYSTEM_LOG_DUMP_TO_RPT

Type: constant

Description: enabled by default


Replaced value:
```sqf

```
File: [host\Logger\Logger_RPTDump.h at line 8](../../../Src/host/Logger/Logger_RPTDump.h#L8)
## SYSTEM_LOG_DUMP_TO_RPT

Type: constant

> Exists if **RELEASE** defined

Description: enabled by default


Replaced value:
```sqf

```
File: [host\Logger\Logger_RPTDump.h at line 12](../../../Src/host/Logger/Logger_RPTDump.h#L12)
## SYSLOG_RPT_DUMP(data)

Type: constant

> Exists if **SYSTEM_LOG_DUMP_TO_RPT** defined

Description: 
- Param: data

Replaced value:
```sqf
diag_log (data)
```
File: [host\Logger\Logger_RPTDump.h at line 23](../../../Src/host/Logger/Logger_RPTDump.h#L23)
## SYSLOG_RPT_DUMP(data)

Type: constant

> Exists if **SYSTEM_LOG_DUMP_TO_RPT** not defined

Description: 
- Param: data

Replaced value:
```sqf

```
File: [host\Logger\Logger_RPTDump.h at line 25](../../../Src/host/Logger/Logger_RPTDump.h#L25)

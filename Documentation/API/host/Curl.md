# Curl.hpp

## curl(data)

Type: constant

Description: 
- Param: data

Replaced value:
```sqf
"url_fetch" callExtension (data)
```
File: [host\Curl\Curl.hpp at line 7](../../../Src/host/Curl/Curl.hpp#L7)
# Curl.sqf

## glob

Type: Variable

> Exists if **u_test** defined

Description: 


Initial value:
```sqf
_strict
```
File: [host\Curl\Curl.sqf at line 80](../../../Src/host/Curl/Curl.sqf#L80)
## glob_invert

Type: Variable

Description: 


Initial value:
```sqf
_new
```
File: [host\Curl\Curl.sqf at line 95](../../../Src/host/Curl/Curl.sqf#L95)
## curl_send

Type: function

Description: #define u_test


File: [host\Curl\Curl.sqf at line 14](../../../Src/host/Curl/Curl.sqf#L14)
## curl_get

Type: function

Description: 


File: [host\Curl\Curl.sqf at line 18](../../../Src/host/Curl/Curl.sqf#L18)
## curl_error

Type: function

Description: 


File: [host\Curl\Curl.sqf at line 28](../../../Src/host/Curl/Curl.sqf#L28)
## curl_testName

Type: function

Description: 
- Param: _f
- Param: _s

File: [host\Curl\Curl.sqf at line 33](../../../Src/host/Curl/Curl.sqf#L33)
# CurlThread.sqf

## __allowCurlMessageForSuccess

Type: constant

Description: #define __timePerformance


Replaced value:
```sqf

```
File: [host\Curl\CurlThread.sqf at line 11](../../../Src/host/Curl/CurlThread.sqf#L11)
## curl_thread_update

Type: constant

Description: частота обновления потока curl-а


Replaced value:
```sqf
0
```
File: [host\Curl\CurlThread.sqf at line 14](../../../Src/host/Curl/CurlThread.sqf#L14)
## curllog(mes)

Type: constant

> Exists if **__allowCurlLog** defined

Description: 
- Param: mes

Replaced value:
```sqf
log("[THREAD::CURL]: - " + mes);
```
File: [host\Curl\CurlThread.sqf at line 17](../../../Src/host/Curl/CurlThread.sqf#L17)
## curllog(mes)

Type: constant

> Exists if **__allowCurlLog** not defined

Description: 
- Param: mes

Replaced value:
```sqf

```
File: [host\Curl\CurlThread.sqf at line 19](../../../Src/host/Curl/CurlThread.sqf#L19)
## curl_query

Type: Variable

Description: 


Initial value:
```sqf
[] // очередь запроса
```
File: [host\Curl\CurlThread.sqf at line 23](../../../Src/host/Curl/CurlThread.sqf#L23)
## curl_isAwait

Type: Variable

Description: очередь запроса


Initial value:
```sqf
false//идёт ли ожидание на получение сообщения
```
File: [host\Curl\CurlThread.sqf at line 24](../../../Src/host/Curl/CurlThread.sqf#L24)
## curl_asyncAwaitData

Type: Variable

Description: идёт ли ожидание на получение сообщения


Initial value:
```sqf
[] //то что будет вызывано когда ответ будет получен
```
File: [host\Curl\CurlThread.sqf at line 25](../../../Src/host/Curl/CurlThread.sqf#L25)
## curl_addRequest

Type: function

Description: то что будет вызывано когда ответ будет получен
- Param: _reference
- Param: _callbackCode
- Param: _ctxPars (optional, default [])

File: [host\Curl\CurlThread.sqf at line 27](../../../Src/host/Curl/CurlThread.sqf#L27)

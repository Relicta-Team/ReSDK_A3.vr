// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

//#define __allowCurlLog

//#define __timePerformance
#define __allowCurlMessageForSuccess

//частота обновления потока curl-а
#define curl_thread_update 0

#ifdef __allowCurlLog
	#define curllog(mes) log("[THREAD::CURL]: - " + mes);
#else
	#define curllog(mes)
#endif


curl_query = []; // очередь запроса
curl_isAwait = false;//идёт ли ожидание на получение сообщения
curl_asyncAwaitData = []; //то что будет вызывано когда ответ будет получен

curl_addRequest = {
	params ["_reference","_callbackCode",["_ctxPars",[]]];
	
	if (!(_ctxPars isEqualType [])) then {_ctxPars = [_ctxPars]};
	
	#ifdef __timePerformance 
		curl_query pushBack [_reference,_callbackCode,_ctxPars,tickTime];
	#else
		curl_query pushBack [_reference,_callbackCode,_ctxPars];
	#endif
};

_threadFunc = {
	private _query = curl_query;
	
	if (!curl_isAwait && equals(_query,[])) exitWith {};
	curllog("-------------------------- Start query --------------------------" + str tickTime);
	
	if (curl_isAwait) then {
		
		curllog("Await response")
		
		private _cbAwait = call curl_get;
		if (_cbAwait == "ERROR") then {
			
			curllog("ERROR!!!")
			
			//on error
			private _errReason = call curl_error;
			errorformat("Curl async result returns error. Reason: %1",_errReason);
			
			//drop packet
			curl_isAwait = false;
			curl_asyncAwaitData = [];
			
		} else {
			if (_cbAwait == "WAIT") exitWith {
				curllog("Response NOT READY - status WAIT")
			}; //simple await
			
			curllog("Response getted. Caiing code")
			
			#ifdef __timePerformance
			    logformat("[CURL::CALLBACK-TIME]: - Response get in %1 sec",tickTime - (curl_asyncAwaitData select 2));
			#endif
			
			//now calling async and go to next packet
			private _async = curl_asyncAwaitData;
			(_async select 1) pushBack _cbAwait;
			(_async select 1) call (_async select 0);
			
			#ifdef __allowCurlMessageForSuccess
				logformat("[CURL::CALLBACK-SUCCESS]: - Calling some code. Result - %1",(_async select 1));
			#endif
			
			curl_isAwait = false;
			curl_asyncAwaitData = [];
			
		};
	} else {
		
		curllog("Not await anything. Send request")
		
		#ifdef __timePerformance
			(_query deleteAt 0) params ["_ref","_callback","_ctxPars","_timestamp"];
		#else
			(_query deleteAt 0) params ["_ref","_callback","_ctxPars"];
		#endif
		
		private _rez = _ref call curl_send;
		if (_rez != "OK") exitWith {
			errorformat("Curl result is not OK (%1) when try to send data (%2)",_rez arg _ref);
		};
		
		curl_isAwait = true;
		#ifdef __timePerformance
		    curl_asyncAwaitData = [_callback,_ctxPars,_timestamp];
		#else
			curl_asyncAwaitData = [_callback,_ctxPars];
		#endif	
	};
};

startUpdate(_threadFunc,curl_thread_update);
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <Network.hpp>

//#define net_log

#ifdef net_log
	#define netlog(mes,fmt) ["(RPC)		<FastSend> " + mes,fmt] call systemLog;
#else
	#define netlog(mes,fmt)
#endif

/*
	Description:
		Обеспечивает быструю передачу данных от сервера к клиенту.
		Используется для синхронизации статистики.
		Данные не гарантированы и то что отправляется клиенту используется на свой страх и риск

*/

net_send = {

	#ifdef ENABLE_LAG_NETWORK
		private _c = {
			params ["_var","_val","_owner"];

			if (!isMultiplayer) then {
				//work in sp only
				missionNamespace setVariable [_var,_val];
				netlog("Synced var %1 with value %2",_var arg _val)
			} else {
				if (_owner > 2) then {
					missionNamespace setVariable [_var,_val,_owner];
					netlog("Synced var %1 with value %2 to client %3",_var arg _val arg _owner)
				} else {
					errorformat("Cant sync var %1 with value %2. Owner is %3",_var arg _val arg _owner)
				};
			};
		}; invokeAfterDelayParams(_c,__LAG_NETWORK_GET_LAG__,_this);
	#else
		params ["_var","_val","_owner"];

		if (!isMultiplayer) then {
			//work in sp only
			missionNamespace setVariable [_var,_val];
			netlog("Synced var %1 with value %2",_var arg _val)
		} else {
			if (_owner > 2) then {
				missionNamespace setVariable [_var,_val,_owner];
				netlog("Synced var %1 with value %2 to client %3",_var arg _val arg _owner)
			} else {
				if (_owner == 0) exitWith {};
				errorformat("Cant sync var %1 with value %2. Owner is %3",_var arg _val arg _owner)
			};
		};
	#endif
};

net_sendToObject = {
	#ifdef ENABLE_LAG_NETWORK

		private _c = {
			params ["_var","_val","_targ"];

			if (!isMultiplayer) then {
				if (_targ isEqualType []) then {
					private _id = _targ find player;
					if (_id != -1) then {
						if equals(_targ deleteat _id,player) then {
							netSendVar(_var,_val,_targ);
						};
					};
				} else {
					if (equals(_targ,player)) then {
						netSendVar(_var,_val,_targ);
					};
				};
			} else {
				if (_targ isEqualType []) then {
					private _owners = [];
					private _id = 0;
					{
						_id = owner _targ;
						if (_id != 0) then {
							_owners pushBack _id;
						};
					} foreach _targ;

					netSendVar(_var,_val,_id);
				} else {
					private _id = owner _targ;
					if (_id != 0) then {
						netSendVar(_var,_val,_id);
					};
				};
			};
		}; invokeAfterDelayParams(_c,__LAG_NETWORK_GET_LAG__,_this);

	#else

	params ["_var","_val","_targ"];

	if (!isMultiplayer) then {
		if (_targ isEqualType []) then {
			private _id = _targ find player;
			if (_id != -1) then {
				if equals(_targ deleteat _id,player) then {
					netSendVar(_var,_val,_targ);
				};
			};
		} else {
			if (equals(_targ,player)) then {
				netSendVar(_var,_val,_targ);
			};
		};
	} else {
		if (_targ isEqualType []) then {
			private _owners = [];
			private _id = 0;
			{
				_id = owner _targ;
				if (_id != 0) then {
					_owners pushBack _id;
				};
			} foreach _targ;

			netSendVar(_var,_val,_id);
		} else {
			private _id = owner _targ;
			if (_id != 0) then {
				netSendVar(_var,_val,_id);
			};
		};
	};

	#endif
};

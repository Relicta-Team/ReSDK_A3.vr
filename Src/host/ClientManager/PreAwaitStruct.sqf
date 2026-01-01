// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\struct.hpp"

#include "ClientManager.h"


struct(PreAwaitClientData)
	def(owner) -1
	def(cancelToken) false

	def(gameToken) ""
	def(discordId) ""
	def(discordToken) ""
	def(refreshToken) ""
	def(expiryDate) ""

	def(init)
	{
		params ["_owner"];
		self setv(owner,_owner);
	}

	//called on timer timeout
	def(onConnectTimeout)
	{
		if (self getv(cancelToken)) exitWith {};

		private _owner = self getv(owner);
		if !(_owner call cm_isClientExist) then {
			warningformat("Client (%1) did not have time to pass authorization in the allotted time (%2 sec)",_owner arg TIME_TO_INIT_CLIENT);
			[_owner,"Истекло время ожидания инициализации клиента."] call cm_serverKickById;
		};
	}
endstruct
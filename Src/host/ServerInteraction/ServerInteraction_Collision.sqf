// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


/*
	Между игроками коллизия не отключается, но
	каждый игрок отключает коллизию от всех мобов в радиусе
*/
si_collision_onUpdate = {
	{
		_m = _x;
		{
			if (not_equals(_x,_m) && !isPlayer _x) then {
				_m disableCollisionWith _x;
			};
			true
		} count (_m nearEntities 15);
		true
	} count allPlayers;
};
si_collision_onUpdate_handle = startUpdate({call si_collision_onUpdate},0.1);
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//Тут определеены константы для навыков

#define _r(v1,v2) [v1,v2]
	skills_nodes_allowedMinSkillDefIndex = 4;
	skills_nodes_listKinds = [
			_r("fp","усталость"),
			_r("will","воля"),
			_r("per","восприятие"),
			_r("hp","жизнь"),
			//other
			_r("fight","рукопашный бой"),
			_r("shield","щиты"),
			_r("fencing","фехтование"),
			_r("axe","топоры"),
			_r("baton","дубины"),
			_r("spear","копья"),
			_r("sword","мечи"),
			_r("knife","ножи"),
			_r("whip","кнуты"),

			_r("pistol","пистолеты"),
			_r("rifle","винтовки"),
			_r("shotgun","дробовики"),
			_r("crossbow","луки"),

			_r("throw","метание"),

			_r("chemistry","химичество"),
			_r("alchemy","грибничество"),

			_r("engineering","инженерия"),
			_r("traps","ловушки"),
			_r("repair","ремонт"),
			_r("blacksmithing","кузнечество"),
			_r("craft","создание"),

			_r("theft","воровство"),
			_r("stealth","скрытность"),
			_r("agility","акробатика"),
			_r("lockpicking","взлом"),

			_r("healing","первая помощь"),
			_r("surgery","хирургия"),

			_r("cavelore","знание пещер"),

			_r("cooking","готовка"),
			_r("farming","фермерство")
	];
	#undef _r
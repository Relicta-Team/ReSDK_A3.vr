// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



//inline settings up


/// <summary>
/// Задает основные параметры CaveGenerator
/// </summary>
/// <param name="optionMidwayPoints">Количество дополнительных точек между входом и выходом</param>
/// <param name="optionSize">Размер строительного материала (10 - не изменять)</param>
/// <param name="optionTurnChanceEdge">Шанс поворота для основного пути</param>
/// <param name="optionTurnChanceBranch">Шанс поворота для веток</param>
#define cave_setOptionGeneral(a,b,c,d)	gvar(optionMidwayPoints) = a; gvar(optionSize) = b; gvar(optionTurnChanceEdge) = c; gvar(optionTurnChanceBranch) = d

/// <summary>
/// Задает параметры для веток первого поколения
/// </summary>
/// <param name="branchesMax">Максимум веток на одной Edge</param>
/// <param name="branchSizeMin">Минимальный размер веток</param>
/// <param name="branchSizeMax">Максимальный размер веток</param>
/// <param name="branchChance">Шанс заспавнить ветку</param>
#define cave_setOptionBranches(a,b,c,d) gvar(branchesMax) = a; gvar(branchSizeMin) = b; gvar(branchSizeMax) = c; gvar(branchChance) = d


/// <summary>
/// Задает параметры для веток второго поколения
/// </summary>
/// <param name="branchesSideMax">Максимум веток на главной ветке</param>
/// <param name="branchSideSizeMin">Минимальный размер веток</param>
/// <param name="branchSideSizeMax">Максимальный размер веток</param>
/// <param name="branchSideChance">Шанс заспавнить ветку</param>
#define cave_setOptionSideBranches(a,b,c,d) 	gvar(branchesSideMax) = a; gvar(branchSideSizeMin) = b; gvar(branchSideSizeMax) = c; gvar(branchSideChance) = d

/// <summary>
/// Ставит входы и выходы для пещеры (нужно указать направление с помощьтю вектора)
/// </summary>
/// <param name="entryOrigin">Вход начала пещеры</param>
/// <param name="entryExit">Вход конца пещеры</param>
#define cave_setOptionEntry(a,b) 	gvar(entryOrigin) = a; gvar(entryExit) = b;

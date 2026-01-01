// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(SyncMobData,smd_)

//частота обновления потока
macro_const(smd_update_delay)
#define smd_update_delay 0

//префикс для локальной переменной на мобе, необходимой для сранвнеия значений
macro_const(smd_local_prefix)
#define smd_local_prefix "__local_"
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



#define log_client(mes) logformat("[SERVER::MAIN]:    %1",mes)

#define logger_client(mes,fmt) logformat("[SERVER::MAIN]:    %1",format[mes arg fmt]); [mes arg fmt] call systemLog

//время на инициализацию (доп 30 секунд на предзагрузку и накладные расходы выполнения)
#define TIME_TO_INIT_CLIENT 60*3 + 30
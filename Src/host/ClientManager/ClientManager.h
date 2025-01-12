// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



#define log_client(mes) logformat("[SERVER::MAIN]:    %1",mes)

#define logger_client(mes,fmt) logformat("[SERVER::MAIN]:    %1",format[mes arg fmt]); [mes arg fmt] call systemLog

//5 секунд на инициализацию
#define TIME_TO_INIT_CLIENT 120
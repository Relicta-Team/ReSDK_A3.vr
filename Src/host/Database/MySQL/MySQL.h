// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


// main app interface
#define DLLCall(args) "extDB3" callExtension (args)

// call interface with parsed return
#define DLLCallRet(args) (parseSimpleArray (DLLCall(args)))

// getting version of extension
#define getVersion() DLLCall("9:VERSION")

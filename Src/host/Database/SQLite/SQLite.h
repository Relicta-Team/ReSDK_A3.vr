// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



#define dbRequest "sqlitenet" callExtension 

#ifdef EDITOR
	#define DB_PATH ((["WorkspaceHelper","getworkdir",[],true] call rescript_callCommand) + "\@EditorContent\db\GameMain.db")
#else
	#define DB_PATH "C:\Games\Arma3\A3Master\@server\db\GameMain.db"
#endif

#ifdef RBUILDER
	#define DB_PATH ((call ReBridge_getWorkspace) + ("\@server\db\GameMain.db"))
#endif
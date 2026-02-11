// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define FSO_INDEX_FILES 0
#define FSO_INDEX_FOLDERS 1

#define FSO_PATH_DELIMETER "\"

#define FSO_NEW_DATA [[],[]]

#define FSO_NORMALIZE_PATH(p) ((tolower (p)) splitString "\/" joinString FSO_PATH_DELIMETER)

#define FSO_PATH_JOIN(p1,p2) ([p1,p2] joinString FSO_PATH_DELIMETER)
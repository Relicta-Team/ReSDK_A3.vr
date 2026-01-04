// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define RADIO_TYPE_WALKIETALKIE "WalkieTalkie"
#define RADIO_TYPE_LOUDSPEAKER "Loudspeaker"
#define RADIO_TYPE_TELEPHONE "Telephone"
#define RADIO_TYPE_INTERCOM "Intercom"

#define RADIO_TYPE_LIST_ALL [RADIO_TYPE_WALKIETALKIE, RADIO_TYPE_LOUDSPEAKER, RADIO_TYPE_TELEPHONE, RADIO_TYPE_INTERCOM]

#define RADIO_TYPE_ENUM_TO_STRING(enumt) (RADIO_TYPE_LIST_ALL select (enumt))
#define RADIO_TYPE_STRING_TO_ENUM(stringt) (RADIO_TYPE_LIST_ALL find (stringt))
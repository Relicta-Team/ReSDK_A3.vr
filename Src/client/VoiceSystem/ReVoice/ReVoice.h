// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//usage: apiCmd ["test",[arg1,arg2]]
#define apiCmd "revoicer" callExtension 
#define apiRequest(p) ("revoicer" callExtension (p))

// ================ api requests ==========================
#define REQ_GET_VERSION "getVersion"
#define REQ_IS_CONNECTED_VOICE "isConnectedVoice"
#define REQ_GET_LAST_HEARTBEAT "getLastHeartbeat"
#define REQ_DISCONNECT_VOICE "disconnectVoice"

#define REQ_IS_SPEAKING "isSpeaking"
#define REQ_SPEAK_START "speakStart"
#define REQ_SPEAK_STOP "speakStop"
#define REQ_SPEAK_RELEASEALL "speakReleaseAll"

//=============== api command ===========================
#define CMD_CONNECT_VOICE "connectVoice"

#define CMD_GET_MIC_DEVICES "getMicDevices"
#define CMD_SET_MIC_DEVICE "setMicDevice"
#define CMD_GET_PLAYBACK_DEVICES "getPlaybackDevices"
#define CMD_SET_PLAYBACK_DEVICE "setPlaybackDevice"

#define CMD_SET_MASTER_VOICE_VOLUME "setMasterVoiceVolume"

#define CMD_GET_ALL_CLIENTS "getAllClients"

#define CMD_SYNC_LOCAL_PLAYER "syncLocalPlayer"
#define CMD_SYNC_REMOTE_PLAYER "syncRemotePlayer"

#define CMD_SETLOWPASS "setLowpass"
#define CMD_SETREVERB "setReverb"

//radio commands
#define CMD_RADIO_ADD "addRadio"
#define CMD_RADIO_REMOVE "removeRadio"

#define CMD_RADIO_SUBSCRIBE_RADIOSTREAM "subscribeRadio"
#define CMD_RADIO_APPLY_WAVE_FILTER "applyRadioWaveFilter"
#define CMD_SYNC_REMOTE_RADIO "syncRemoteRadio"
#define CMD_SYNC_REMOTE_RADIO_LOWPASS "syncRemoteRadioLowpass"
#define CMD_SYNC_REMOTE_RADIO_REVERB "syncRemoteRadioReverb"
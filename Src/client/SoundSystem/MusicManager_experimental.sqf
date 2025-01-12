// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


/*
	Music manager client subsystem.

		---- NEED MORE THINK ----

	Functions:
		mm::channel::register(uint order) - for create new channel
		mm::channel::unregister(uint order) - stop channel work and dispose him
		mm::getActiveChannel() - getting current layer
		mm::setActiveLayer(unit order,bool smooth,float smothchangetime) - transparent from current layer to new
		mm::play() - begin play active layer
		mm::pause() - pause play active layer
		mm::stop() - stop play active layer
		mm::getLayerState() - returns enum MM_STATE_PLAYED, MM_STATE_PAUSED, MM_STATE_STOPPED
		-- vol control --
		mm::setLayerVolume()
		mm::getLayerVolume()
		mm::setGlobalVolume()
		mm::getGlobalVolume()

		mm::setOption() - TODO

	Features requests:
		- play/pause current layer

*/

// Layer component
#define MM_CHANNELS_MAX_ORDER_ID 512
#define MM_LAYER_NULL objnull

//TODO move to public header
#define MM_STATE_PLAYED 0
#define MM_STATE_PAUSED 1
#define MM_STATE_STOPPED 2
//------------------------/

//elements info in mm_channels_internal_initStruct
mm_list_channels = [];

mm_channels_internal_initStruct = {
	[
		_this, //ref to layer
		false, //channel state is played
		1, //layer volume
		"" //current played
	]
};

mm_internal_mainThread_handle = -1;

mm_currentChannel = 0;
mm_globalVolume = 1;

mm_init = {
	mm_list_channels resize MM_CHANNELS_MAX_ORDER_ID;
	mm_list_channels = mm_list_channels apply {MM_LAYER_NULL};

	mm_internal_mainThread_handle = startUpdate(mm_internal_thread_onUpdate,0);

	logformat("mm::init() - Music manager loaded. Buffer size: %1",count mm_list_channels);
};

mm_internal_thread_onUpdate = {

};


mm_channel_register = {
	params ["_id"];
	if (_id < 0 || _id > MM_CHANNELS_MAX_ORDER_ID) exitWith {
		errorformat("mm::channel::register() - out of range channel %1",_id);
		false
	};
	mm_list_layers set [_id,_id call mm_channels_internal_initStruct];
	true
};

mm_layer_unregister = {
	params ["_channel"];
	private _struct = mm_list_layers select _channel;
	if equals(_struct,MM_LAYER_NULL) exitWith {
		errorformat("mm::channel::unregister() - Null ref to channel struct (not registered) [%1]",_channel);
		false
	};
	//todo: stop sound
	mm_list_layers set [_channel,MM_LAYER_NULL];

	true
};

mm_setChannelPlaying = {
	params ["_mode",["_channel",mm_currentChannel]];
};

mm_setChannelVolume = {
	params ["_vol",["_channel",mm_currentChannel]];
};

mm_getChannelVolume = {
	params [["_ch",mm_currentChannel]];
};

mm_internal_play = {
	params [["_id",mm_currentChannel],"_config",["_startTime",0],["_smoothStart",0],["_isLooped",false]];

	playMusic [_config,_startTime];
};

mm_getPlayedTime = {
	params [["_layer",mm_currentChannel]];
};

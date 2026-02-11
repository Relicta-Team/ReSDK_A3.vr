// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



#ifdef TEXTCHAT
	__b_flag_textChatEnabled = true;
#endif

if !isNullVar(__b_flag_textChatEnabled) then {
	
	_textchatrequest = {
		params ["_player",["_voiceDist",0]];
		unrefObject(this,_player,errorformat("textchatrequest() - Mob object has no exists virtual object - %1",_player));
		if (_voiceDist == 0) exitWith {};
		if isTypeOf(this,GMPreyMobEater) exitWith {};

		setSelf(textChat_lastvoicedist,_voiceDist);

		callSelf(openTextChatBox);

	}; rpcAdd("textchatrequest",_textchatrequest);


	var(textChat_lastvoicedist,0);

	var(__textChat_wrongWord,3);

	func(__textChat_jonBlow)
	{
		objParams();
		private _act = this;
		callFuncParams(_act,destroyLimb,BP_INDEX_HEAD);
		callFuncParams(_act,playSoundUI,"emotes\fart2" arg 1 arg 4);
		private _mobName = callFuncParams(_act,getNameEx,"кого");
		callFuncParams(_act,worldSay,"<t size='2.0' color='#f41cff'>" + "У " + _mobName + " заканчивается томная жизнь</t>");
		callFuncParams(_act,localSay,"<t size='3.0' color='#ff0000'>ВЫ ПОБЕДИЛИ</t>");
		callFuncParams(getVar(_act,client),removePoints,2);		
	};

	func(__textChat_hasWrongWord)
	{
		objParams_1(_text);
		forceUnicode 0;

		//caps
		if equals(toUpper _text,_text) exitWith {"капс"};
		//eng words
		if ([_text,"[a-zA-Z]{1,}"] call regex_isMatch) exitWith {"плохие символы"};
		//ru spam
		if ([_text,"([А-Яа-я])\1{9,}"] call regex_isMatch) exitWith {"спам-текст"};
		//wrong charachters
		if ([_text,"[^А-Яа-я\,\.\ \-\:\;\?\!\""\'0-9]"] call regex_isMatch) exitWith {"недопустимый символ"};
		//badwords
		//! not implemented
		//if (tolower _text in (server_textchat_badwords)) exitWith {"плохое слово"};

		""
	};

	func(openTextChatBox)
	{
		objParams();
		
		//if not active
		if (!callSelf(isActive)) exitWith {};

		private _h = {
			
			if (!callSelf(isActive)) exitWith {
				callSelf(CloseMessageBox);
			};
			
			forceUnicode 0;
			
			private _text = _value;
			
			if (count _text >= 200) exitWith {
				callSelfParams(localSay,"Слишком много текста. Напиши более кратко." arg "error");
			};
			
			_text = [_text,"[\n\r]",""] call regex_replace;
			if ([_text,"\ $"] call regex_isMatch) then {
				_text = [_text,"\ $",""] call regex_replace;
			};

			_text = sanitizeHTML(_text);
			private _wordCheck = callSelfParams(__textChat_hasWrongWord,_text);
			if (_wordCheck != "")  exitWith {
				modSelf(__textChat_wrongWord, - 1);
				private _m = format["Сработала защита от приколов (%2). Для победы повторите такое ещё %1 раз",getSelf(__textChat_wrongWord),_wordCheck];
				if (getSelf(__textChat_wrongWord) <= 0) then {
					callSelf(__textChat_jonBlow);
				} else {
					callSelfParams(localSay,_m arg "error");
				};
				callSelf(CloseMessageBox);
			};

			//debug_text = _text;
			private _dist = getSelf(textChat_lastvoicedist);
			private _hasCustomEnder = false;
			
			private _talkMes = pick["говорит","вещает"];
			if ([_text,"\?$"] call regex_isMatch) then {
				_talkMes = pick["спрашивает","озадачивается"];
				_hasCustomEnder = true;
			};
			if ([_text,"\!$"] call regex_isMatch) then {
				_talkMes = pick["восклицает"];
				_hasCustomEnder = true;
			};

			if (!([_text,"\.$"] call regex_isMatch)) then {
				if (_hasCustomEnder) exitWith {};
				modvar(_text) + ".";
			};

			//dist - 4 whisper, 9,18
			if (_dist == 4) then {
				_talkMes = pick["шепчет"];
			};
			if (_dist == 9) then {
				private _talkMesFmt = (pick["тихонько %1","тихо %1","%1 в пол голоса"]);
				_talkMes = format[_talkMesFmt,_talkMes];
			};
			if (_dist == 60) then {
				_talkMes = pick["орёт","кричит"];
			};

			//native text handler
			if callSelfParams(hasStatusEffect,"SEAlcoholHangover") then {
				//forceUnicode 0;
				//debug_text = _text;
				//_text = [_text,"[бвгд]",pick["ф","п","х"]] call regex_replace;
				private _tarr = _text splitString "";
				{
					if (prob(40) && {
						[_x,"[бвгдяоефхшщзс]"] call regex_isMatch
					}) then {
						private _tx = _x;
						for"_ivx"from 1 to randInt(1,3) do {
							modvar(_tx) + _x;	
						};
						_tarr set [_foreachIndex,_tx];
						_x = _tx;
					};
					if prob(35) then {
						_tarr set [_forEachIndex,toupper _x];
					} else {
						_tarr set [_forEachIndex,tolower _x];
					};
				} foreach _tarr;
				_text = _tarr joinString "";
				//_text = [_text,"[лмнр]",pick[""]] call regex_replace;
			};
			if (getSelf(inAgony)) then {
				private _tarr = _text splitString "";
				{
					if prob(50) then {
						_tarr set [_forEachIndex,toupper _x];
					} else {
						_tarr set [_forEachIndex,tolower _x];
					};
				} foreach _tarr;
				_text = _tarr joinString "";
			};
			if (callSelf(getIQ) <= 3) then {
				_text = [_text,"[а-я]",pick("эиыазх" splitString "")] call regex_replace;
				_text = [_text,"[А-Я]",pick("ЭИЫАЗХ" splitString "")] call regex_replace;
			};

			_text = capitalize(_text);

			private _struct = format["<t size='1.25'><t color='%4'>%1</t> <t color='%5'>%2 - %3</t></t>",callSelfParams(getNameEx,"кто"),_talkMes,_text,
				getSelf(customColorName),
				getSelf(customColorTextChat)
			];
			callSelfParams(worldSay,_struct arg "default" arg _dist);
			
			callSelfParams(syncSmdVar,"chatMessage" arg vec3(_text,_dist,netTickTime));
			callSelf(CloseMessageBox);

			[format["(TEXTCHAT) %1 %4 - %2 (%3)",callSelfParams(getNameEx,"кто"),_text,getVar(getSelf(client),name),_talkMes]] call rpLog;
			[format["[TEXTCHAT]:	%1 %4 - %2 (%3)",callSelfParams(getNameEx,"кто"),_text,getVar(getSelf(client),name),_talkMes]] call discLog;

			#ifdef EDITOR
			{
				callFuncParams(_x,syncSmdVar,"chatMessage" arg vec3(_text,_dist,netTickTime));
				callFuncParams(_x,syncSmdVar,"isPrintingSay" arg true);
				callFuncAfterParams(_x,syncSmdVar,2,"isPrintingSay" arg false);
			} foreach callSelfParams(getNearMobs,200);
			#endif
		};
		private _hClose = {
			callSelfParams(syncSmdVar,"isPrintingSay" arg false);
		};
		callSelfParams(syncSmdVar,"isPrintingSay" arg true);

		private _t = pick["Что скажем?","Говори.","Рассказывай","Что расскажешь?"];
		callFuncParams(this,ShowMessageBox,"Input" arg [_t arg "" arg "Сказать" arg null arg true] arg _h arg null arg _hClose);
	};

	var(customColorName,"#ffffff");
	var(customColorTextChat,"#ffffff");

	func(initializeVoice)
	{
		objParams();
		if isTypeOf(this,GMPreyMobEater) exitWith {};
		private _isFem = isTypeOf(this,MobWoman);
		private _voiceMode = if _isFem then {
			"female\"+(str randInt(1,9))
		} else {
			"male\"+(str randInt(1,12))
		};
		//["female\6",1,20.5,0.07]
		//"_voiceType","_basePitch","_baseSpeed","_pertick"
		private _args = [_voiceMode];
		_args pushBack (if _isFem then {
			private _cnv = (linearConversion [18,90,getSelf(age),2,0.6]);
			clamp(_cnv + rand(-0.2,0.2),0.5,2)
		} else {
			private _cnv = (linearConversion [18,90,getSelf(age),1.7,0.5]);
			clamp(_cnv + rand(-0.2,0.2),0.5,2)
		});

		//basespeed
		_args pushBack 20.5;

		//pertick 0.05-0.1
		private _pt = linearConversion[18,90,getSelf(age),0.035,0.1] + rand(-0.05,0.05);
		_args pushBack (clamp(_pt,0.03,0.1));

		callSelfParams(syncSmdVar,"voiceBlob" arg _args);
		private _customName = [rand(0.3,0.8),rand(0.5,1),rand(0.3,0.7)] call color_RGBtoHTML;
		private _customText = "#86993C";//"#A8BA5D";

		setSelf(customColorName,_customName);
		setSelf(customColorTextChat,_customText);
	};

	/*
	server_textchat_badwords_string = "";

	modvar(server_textchat_badwords_string) + "";

	server_textchat_badwords = hashSet_create(server_textchat_badwords_string splitString " ");
	*/
};


func(handleVoiceUpdate)
{
	objParams();
	private _item = callSelfParams(getItemInSlot,INV_FACE);
	private _val = null; //null val equals reset to std
	if !isNullReference(_item) then {
		if isTypeOf(_item,Bandage) then {
			_val = getSelf(__originVoiceType) + "_block";
		};
	};
	callSelfParams(updateVoiceType,_val);
};





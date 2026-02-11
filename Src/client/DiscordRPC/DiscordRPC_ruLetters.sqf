// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(DiscordRPC,discrpc_)

//http://www.online-decoder.com/ru utf-8 -> win-1251
private _maplet = discrpc_list_ruLetters;
#ifdef USE_LOCALES

	_maplet set ["а",["Р°","Ð°"]];
	_maplet set ["б",["Р±","Ð±"]];
	_maplet set ["в",["РІ","Ð²"]];
	_maplet set ["г",["Рі","Ð³"]];
	_maplet set ["д",["Рґ","Ð´"]];
	_maplet set ["е",["Рµ","Ðµ"]];
	_maplet set ["ё",["С‘","Ñ‘"]];
	_maplet set ["ж",["Р¶","Ð¶"]];
	_maplet set ["з",["Р·","Ð·"]];
	_maplet set ["и",["Рё","Ð¸"]];
	_maplet set ["й",["Р№","Ð¹"]];
	_maplet set ["к",["Рє","Ðº"]];
	_maplet set ["л",["Р»","Ð»"]];
	_maplet set ["м",["Рј","Ð¼"]];
	_maplet set ["н",["РЅ","Ð½"]];
	_maplet set ["о",["Рѕ","Ð¾"]];
	_maplet set ["п",["Рї","Ð¿"]];
	_maplet set ["р",["СЂ","Ñ€"]];
	_maplet set ["с",["СЃ","Ñ�"]];
	_maplet set ["т",["С‚","Ñ‚"]];
	_maplet set ["у",["Сѓ","Ñƒ"]];
	_maplet set ["ф",["С„","Ñ„"]];
	_maplet set ["х",["С…","Ñ…"]];
	_maplet set ["ц",["С†","Ñ†"]];
	_maplet set ["ч",["С‡","Ñ‡"]];
	_maplet set ["ш",["С€","Ñˆ"]];
	_maplet set ["щ",["С‰","Ñ‰"]];
	_maplet set ["ь",["СЊ","ÑŒ"]];
	_maplet set ["ы",["С‹","Ñ‹"]];
	_maplet set ["ъ",["СЉ","ÑŠ"]];
	_maplet set ["э",["СЌ","Ñ�"]];
	_maplet set ["ю",["СЋ","ÑŽ"]];
	_maplet set ["я",["СЏ","Ñ�"]];
	_maplet set ["А",["Рђ","Ð�"]];
	_maplet set ["Б",["Р‘","Ð‘"]];
	_maplet set ["В",["Р’","Ð’"]];
	_maplet set ["Г",["Р“","Ð“"]];
	_maplet set ["Д",["Р”","Ð”"]];
	_maplet set ["Е",["Р•","Ð•"]];
	_maplet set ["Ё",["РЃ","Ð�"]];
	_maplet set ["Ж",["Р–","Ð–"]];
	_maplet set ["З",["Р—","Ð—"]];
	_maplet set ["И",["Р","Ð˜"]];
	_maplet set ["Й",["Р™","Ð™"]];
	_maplet set ["К",["Рљ","Ðš"]];
	_maplet set ["Л",["Р›","Ð›"]];
	_maplet set ["М",["Рњ","Ðœ"]];
	_maplet set ["Н",["Рќ","Ð�"]];
	_maplet set ["О",["Рћ","Ðž"]];
	_maplet set ["П",["Рџ","ÐŸ"]];
	_maplet set ["Р",["Р ","Ð "]];
	_maplet set ["С",["РЎ","Ð¡"]]; 
	_maplet set ["Т",["Рў","Ð¢"]];
	_maplet set ["У",["РЈ","Ð£"]];
	_maplet set ["Ф",["Р¤","Ð¤"]];
	_maplet set ["Х",["РҐ","Ð¥"]];
	_maplet set ["Ц",["Р¦","Ð¦"]];
	_maplet set ["Ч",["Р§","Ð§"]];
	_maplet set ["Ш",["РЁ","Ð¨"]];
	_maplet set ["Щ",["Р©","Ð©"]];
	_maplet set ["Ь",["Р¬","Ð¬"]];
	_maplet set ["Ы",["Р«","Ð«"]];
	_maplet set ["Ъ",["РЄ","Ðª"]];
	_maplet set ["Э",["Р­","Ð"]];
	_maplet set ["Ю",["Р®","Ð®"]];
	_maplet set ["Я",["РЇ","Ð¯"]];

#else

	_maplet set ["а","Р°"];
	_maplet set ["б","Р±"];
	_maplet set ["в","РІ"];
	_maplet set ["г","Рі"];
	_maplet set ["д","Рґ"];
	_maplet set ["е","Рµ"];
	_maplet set ["ё","С‘"];
	_maplet set ["ж","Р¶"];
	_maplet set ["з","Р·"];
	_maplet set ["и","Рё"];
	_maplet set ["й","Р№"];
	_maplet set ["к","Рє"];
	_maplet set ["л","Р»"];
	_maplet set ["м","Рј"];
	_maplet set ["н","РЅ"];
	_maplet set ["о","Рѕ"];
	_maplet set ["п","Рї"];
	_maplet set ["р","СЂ"];
	_maplet set ["с","СЃ"];
	_maplet set ["т","С‚"];
	_maplet set ["у","Сѓ"];
	_maplet set ["ф","С„"];
	_maplet set ["х","С…"];
	_maplet set ["ц","С†"];
	_maplet set ["ч","С‡"];
	_maplet set ["ш","С€"];
	_maplet set ["щ","С‰"];
	_maplet set ["ь","СЊ"];
	_maplet set ["ы","С‹"];
	_maplet set ["ъ","СЉ"];
	_maplet set ["э","СЌ"];
	_maplet set ["ю","СЋ"];
	_maplet set ["я","СЏ"];
	_maplet set ["А","Рђ"];
	_maplet set ["Б","Р‘"];
	_maplet set ["В","Р’"];
	_maplet set ["Г","Р“"];
	_maplet set ["Д","Р”"];
	_maplet set ["Е","Р•"];
	_maplet set ["Ё","РЃ"];
	_maplet set ["Ж","Р–"];
	_maplet set ["З","Р—"];
	_maplet set ["И","Р"];
	_maplet set ["Й","Р™"];
	_maplet set ["К","Рљ"];
	_maplet set ["Л","Р›"];
	_maplet set ["М","Рњ"];
	_maplet set ["Н","Рќ"];
	_maplet set ["О","Рћ"];
	_maplet set ["П","Рџ"];
	_maplet set ["Р","Р "];
	_maplet set ["С","РЎ"]; 
	_maplet set ["Т","Рў"];
	_maplet set ["У","РЈ"];
	_maplet set ["Ф","Р¤"];
	_maplet set ["Х","РҐ"];
	_maplet set ["Ц","Р¦"];
	_maplet set ["Ч","Р§"];
	_maplet set ["Ш","РЁ"];
	_maplet set ["Щ","Р©"];
	_maplet set ["Ь","Р¬"];
	_maplet set ["Ы","Р«"];
	_maplet set ["Ъ","РЄ"];
	_maplet set ["Э","Р­"];
	_maplet set ["Ю","Р®"];
	_maplet set ["Я","РЇ"];

#endif
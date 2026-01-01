// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//<
#define lt &lt;
#define slt "&lt;"
//>
#define gt &gt;
#define sgt "&gt;"

#define br_inline <br/>
//Не изменять!!! зависимости есть!!!
#define sbr "<br/>"

//Просто символ запятой (обычно используется в препроцессоре чтобы избежать ошибки)
#define comma ","

#define pcomma +comma+

//Первую букву большую
#define capitalize(text) (text call {private _s = toArray _this; toupper tostring(_s select [0,1]) + tostring(_s select [1,count _s - 1])})
#define lowerize(text) (text call {forceUnicode 0; toLower (_this select [0,1]) + (_this select [1,count _this - 1])})

//очищает строку от тегов, превращая в обычный текст
#define sanitize(text) ((text) call {if not_equalTypes(_this,"") then {str _this} else {_this regexReplace ["&", "&amp;"] regexReplace ["<", "&lt;"] regexReplace [">", "&gt;"] regexReplace ["""", "&quot;"] regexReplace ["'", "&apos;"]}})

//Убирает форматирование html. Используется для отслыки в чат дискорда
#define sanitizeHTML(text) ((text) call {if not_equalTypes(_this,"") then {str _this} else {str parseText _this}})

//pseudoname for sanitizeHTML()
#define htmlToString(text) sanitizeHTML(text)

//all special symbols are here
//http://htmlbook.ru/samhtml/tekst/spetssimvoly

#define setstyle(txt,stl) ('<t stl >'+(txt)+"</t>")
#define style_prop(name,valstr) name=''valstr''

#define style_learnedskills style_prop(align,center) style_prop(size,1.4) style_prop(color,#00B74A)
#define style_learnedskillscategory style_prop(align,center) style_prop(size,1.5) style_prop(color,#ffffff)
#define style_test color='#ff0000'
#define style_redbig style_prop(color,#ff0000) style_prop(size,1.5)


//unmap serialized rehtml:
/*
	@1 <t
	@2 >
	@3 </t>
*/
//"T_ATTR(T_SIZE(1.2) T_COLOR(ff0000) T_H_ALIGN_CENTER)Hello world T_ATTR_END" //attr end error? If not need one space?!
//Решение проблемы с T_ATTR_END - поиск по закрывающему токену и пробелу перед ним

#define ST_ATTR_TOKEN_OPEN @1
#define ST_ATTR_TOKEN_CLOSE @2
#define ST_ATTR_TOKEN_END @3

#define ST_ATTR_TOKEN_OPEN_S @1
#define ST_ATTR_TOKEN_CLOSE_S @2
#define ST_ATTR_TOKEN_END_S @3

//breaklines
#define T_BREAK @4
#define T_BREAK_S 'T_BREAK'

#define T_ATTR_S(attributes__) 'ST_ATTR_TOKEN_OPEN attributes__ ST_ATTR_TOKEN_CLOSE'
#define T_ATTR(attrs_) ST_ATTR_TOKEN_OPEN attrs_ ST_ATTR_TOKEN_CLOSE

#define T_ATTR_END_S 'ST_ATTR_TOKEN_END'
#define T_ATTR_END ST_ATTR_TOKEN_END

#define T_SIZE(val) s=val
#define T_SIZE_S(val) 'T_SIZE(val)'

#define T_COLOR(val) c=val
#define T_COLOR_S(val) 'T_COLOR(val)'

#define T_FONT_TAHOMA f=0
// todo add more fonts and fonts map


// align attribute

#define __t_align_provider(val) a=val

#define T_H_ALIGN_LEFT __t_align_provider(0)
#define T_H_ALIGN_CENTER __t_align_provider(1)
#define T_H_ALIGN_RIGHT __t_align_provider(2)

#define T_H_ALIGN_LEFT_S 'T_H_ALIGN_LEFT'
#define T_H_ALIGN_CENTER_S 'T_H_ALIGN_CENTER'
#define T_H_ALIGN_RIGHT_S 'T_H_ALIGN_RIGHT'

//valign attribute
#define __t_valign_provider(val) v=val

#define T_V_ALIGN_TOP __t_valign_provider(0)
#define T_V_ALIGN_MIDDLE __t_valign_provider(1)
#define T_V_ALIGN_BOTTOM __t_valign_provider(2)

#define T_V_ALIGN_TOP_S 'T_V_ALIGN_TOP'
#define T_V_ALIGN_MIDDLE_S 'T_V_ALIGN_MIDDLE'
#define T_V_ALIGN_BOTTOM_S 'T_V_ALIGN_BOTTOM'

// underline

#define T_UNDERLINE(mode) u=mode
#define T_UNDERLINE_S(mode) 'T_UNDERLINE(mode)'

//shadow attributes
#define T_SHADOW_MODE(mode) h=mode
#define T_SHADOW_MODE_S(mode) 'T_SHADOW_MODE(mode)'

#define T_SHADOW_COLOR(col) g=col
#define T_SHADOW_COLOR_S(col) 'T_SHADOW_COLOR(col)'

#define T_SHADOW_OFFSET(val) j=val
#define T_SHADOW_OFFSET_S(val) 'T_SHADOW_OFFSET(val)'



//images: <img size='0.8' image='%1'/>
// T_IMAGE(T_SIZE(0.8) T_IMAGEPATH(\a3\dataf\flags\flag_altis_co.paa))
#define T_IMAGE(dat) @5 dat @6
#define T_IMAGE_S(dat) 'T_IMAGE(dat)'

#define T_IMAGEPATH(pth) i=pth
#define T_IMAGEPATH_S(pth) 'T_IMAGEPATH(pth)'

//references
#define T_HREF(data,text) @7 data @8text @9
#define T_HREF_S(data,text) 'T_HREF(data,text)'

#define T_HREF_COLOR(col) l=col
#define T_HREF_COLOR_S(col) 'T_HREF_COLOR(col)'

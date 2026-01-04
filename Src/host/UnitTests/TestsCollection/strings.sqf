// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\TestFramework.h"

TEST(StringStartWith)
{
	private _baseString = "This is a test string with BIG WORDS?!";
	ASSERT([_baseString arg "this" arg false] call stringStartWith); //lowecase compare
	ASSERT([_baseString arg "This"] call stringStartWith); //default compare (case sensitive)
	ASSERT([stringEmpty arg stringEmpty] call stringStartWith); //empty check
}

TEST(stringEndWith)
{
	private _baseString = "This is a test string with BIG WORDS?!";
	ASSERT([_baseString arg "ords?!" arg false] call stringEndWith); //lowercase compare
	ASSERT([_baseString arg "BIG WORDS?!"] call stringEndWith); //default compare (case sensitive)
	ASSERT([stringEmpty arg stringEmpty] call stringEndWith); //empty check
}

TEST(stringReplace)
{
	private _baseStr = "This is BIG string";
	private _newStr = "This is small string";
	ASSERT_NE([_baseStr arg "big" arg "small"] call stringReplace,_newStr); //stringReplace always case sensitive
	ASSERT_EQ([_baseStr arg "BIG" arg "small"] call stringReplace,_newStr); // replace check
}

TEST(stringUtility)
{
	private _str = "This is a test string";
	private _strUnicode = "Это строка";
	//select
	EXPECT_EQ([_str arg 5 arg 2] call stringSelect,"is"); //default check
	EXPECT_EQ([_strUnicode arg 4 arg 3] call stringSelect,"стр"); //unicode check
	//format
	private _formatter = "Hello %1 %2!";
	private _formatterVal = "Value=%1";
	private _formatedVal = "Value=[1,2,3]";
	private _list = [1, 2, 3];
	EXPECT_EQ([_formatter arg ["my" arg "friend"] arg true] call stringFormat,"Hello my friend!");
	EXPECT_EQ([_formatterVal arg _list] call stringFormat,_formatedVal);
	EXPECT_EQ([_formatterVal arg _list arg true] call stringFormat,"Value=1");


	EXPECT_EQ(["Привет"] call stringLength,6);
	EXPECT_EQ(["Привет" arg false] call stringLength,6 * 2);
}

TEST(NumeralCheck)
{
	private _counter = ["вещь","вещи","вещей"];
	EXPECT_EQ([3 arg _counter] call toNumeralString,"вещи");
	EXPECT_EQ([3 arg _counter arg true] call toNumeralString,"3 вещи");
	EXPECT_EQ([6 arg _counter arg false] call toNumeralString,"вещей");
}

//check regex_isMatch
TEST(stringRegex)
{
	private _string = "This is oof string ""SUPER"" и немного Русского ТЕКСТА";
	private _stringEnd = "И немного Русского да Китайского.";
	EXPECT([_string arg "s.\w+"] call regex_isMatch); // std work
	EXPECT([_string arg "[А-Я][а-я]+ого"] call regex_isMatch); //match unicode

	EXPECT_EQ([_string arg "[А-Я][а-я]+ого" arg "Английского"] call regex_replace arg "И немного Английского да Английского."); //unicode replace
	EXPECT_EQ(["English is ""SUPER"" and simple" arg "\""\w+\""" arg "super"] call regex_replace,"English is super and simple");

	private _match = null;
	_match = ["Hello my little world! My name is not important.","\w+ (\w+ (\w+))"] call regex_getFirstMatch;
	EXPECT_EQ(_match,"Hello my little");
	_match = ["Hello my little world! My name is not important.","\w+ (\w+ (\w+))",2] call regex_getFirstMatch;
	EXPECT_EQ(_match,"little");

	private _string2 = "test Test Dest test2 Rest";
	private _matches = [_string2,"[A-Z]\w+/g"] call regex_getMatches;
	EXPECT_EQ(count _matches,3);
	EXPECT_EQ(_matches select 0,"Test");
	EXPECT_EQ(_matches select 1,"Dest");
	EXPECT_EQ(_matches select 2,"Rest");

	_matches = [_string2,"[A-Z](\w+)/g",1] call regex_getMatches;
	EXPECT_EQ(count _matches,3);
	EXPECT_EQ(_matches select 0,"est");
	EXPECT_EQ(_matches select 1,"est");
	EXPECT_EQ(_matches select 2,"est");

	//TODO outofrange check

}
// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using ReEngine;

class ScriptContext : IScript
{

	public static int GetArgsCount()
	{
		return ReScriptBuilder.GetScriptArgumentsCount();
	}
	public static string GetArg(int index)
	{
		return ReScriptBuilder.GetScriptArgument(index);
	}
	public static string GetWorkspace()
	{
		return Engine.GetWorkspace();
	}
	public static string GetAppDir()
	{
		return Directory.GetCurrentDirectory();
	}

	//Преобразует значения из нативного массива в игровой массив и сохраняет данные в строке
	public static void ConvertListToGame(StringBuilder sb,object[] values)
	{
		ReBridge.ArgumentsParse(sb,values);
	}
	//преобразует нативное значение в армовское
	public static void ConvertDataToGame(StringBuilder sb,object value)
	{
		ReBridge.ArgumentParse(sb, value);
	}

	public static void Sleep(int ms)
	{
		System.Threading.Thread.Sleep(ms);
	}

	public static void AddCallback(string funcname)
	{
		AddCallback(funcname, new object[] { });
	}
	public static void AddCallback(string funcname, object[] objects)
	{
		ReBridge.AddCallback(funcname, objects);
	}

	public void Init()
	{
		
	}

	public void Destroy()
	{
		
	}

	public void Command(string args,StringBuilder output)
	{
		
	}

	/// <summary>
	/// Преобразование строки в формат для движка платформы
	/// </summary>
	/// <param name="str">Входная строка</param>
	/// <returns>Преобразованная строка</returns>
	public static string EncodingToRV(string str) => Encoding.GetEncoding(1251).GetString(Encoding.GetEncoding(65001).GetBytes(str));
}
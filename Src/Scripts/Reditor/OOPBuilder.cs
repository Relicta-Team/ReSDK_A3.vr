// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

using ReEngine;
using System;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Collections.Generic;

class OOPBuilder : IScript
{
	public void Init()
	{
		
	}

	public void Destroy()
	{
		
	}

	public void Command(string args,StringBuilder output)
	{
		if (args == "runsavemap")
		{
			runSaveMap();
		} else if (args == "buildclass_DEPRECATED")
		{
			if (ScriptContext.GetArgsCount() < 3)
			{
				output.Append("err:argserror:" + ScriptContext.GetArgsCount());
			}

			output.Append(AddNewClassToFile(ScriptContext.GetArg(0),Int32.Parse(ScriptContext.GetArg(1)),ScriptContext.GetArg(2)));
		}
		else if (args == "buildclass")
		{
			
			if (ScriptContext.GetArgsCount() < 3)
			{
				output.Append("err:argserror:" + ScriptContext.GetArgsCount());
			}
			output.Append(clstofile(ScriptContext.GetArg(0),Int32.Parse(ScriptContext.GetArg(1)),ScriptContext.GetArg(2)));
		}
	}

	private void runSaveMap()
	{
		//Process.Start(ScriptContext.GetArg(0));
		try {
			Process runner = new Process();
			Console.WriteLine($"Run path: {ScriptContext.GetArg(0)}");
			runner.StartInfo.FileName = ScriptContext.GetArg(0);
			runner.StartInfo.Arguments = "\""+ScriptContext.GetArg(1)+"\"";
			runner.Start();
			runner.WaitForExit();
		} catch (Exception ex) {
			Console.WriteLine(ex.ToString());
		};
	}

	#region DEPRECATED
	//generated with chatgpt
	private string AddNewClassToFile(string filePath,int lineNumber,string text)
	{
		Console.WriteLine($"add class info:{filePath} at line {lineNumber}");
		//Console.WriteLine("START>>>"+text+"<<<END");

		text = text.Replace("","\"");

		try {
			if (!File.Exists(filePath))
			{
				throw new FileNotFoundException();
			}

			// Считываем все строки из файла в массив строк
			string[] lines = File.ReadAllLines(filePath);

			if (lineNumber > lines.Length)
			{
				File.AppendAllText(filePath,text);
				return "";
			}

			// Проверяем, что указанная строка существует в файле
			if (lineNumber < 1 /*|| lineNumber > lines.Length*/)
			{
				throw new ArgumentOutOfRangeException(nameof(lineNumber), "Invalid line number");
			}

			// Создаем новый массив строк, в который будем копировать все строки из исходного файла
			string[] newLines = new string[lines.Length + SplitStringByLines(text).Length];

			// Копируем все строки из исходного файла в новый массив строк до указанной строки
			for (int i = 0; i < lineNumber - 1; i++)
			{
				newLines[i] = lines[i];
			}

			// Вставляем новую многострочную строку в нужное место
			int j = lineNumber - 1;
			foreach (string line in SplitStringByLines(text))
			{
				newLines[j++] = line;
			}

			// Копируем оставшиеся строки из исходного файла в новый массив строк
			for (int i = lineNumber - 1; i < lines.Length; i++)
			{
				newLines[j++] = lines[i];
			}

			// Записываем новые строки в файл
			File.WriteAllLines(filePath, newLines);

			return "";
		} catch (Exception ex)
		{
			return "err:ex:"+ex.GetType()+":"+ex.Message;
		}
	}

	//generated in chatgpt
	private static string[] SplitStringByLines(string input)
	{
		// Разделитель строк для Windows
		string lineSeparator = "\r\n";

		// Разделяем строку на подстроки по разделителю строк
		string[] lines = input.Split(new string[] { lineSeparator }, StringSplitOptions.None);

		return lines;
	}
	#endregion

	private string clstofile(string filePath,int lineNumber,string text)
	{
		try {
			if (!File.Exists(filePath)) throw new FileNotFoundException();
			if (lineNumber < 1) throw new ArgumentOutOfRangeException(nameof(lineNumber), "Line starts only at line 1");
			
			text = text.Replace("","\"");
			
			//int ctr = 0;

			List<string> lines = new List<string>(File.ReadLines(filePath));
			Console.WriteLine($"lcount {lines.Count}; emplace line {lineNumber}");
			
			//ctr = 1; foreach(var s in lines) {Console.WriteLine("("+ ctr++ +")>"+s);}

			int addingLine = lineNumber;
			if (addingLine >= lines.Count)
			{
				for(int x = lines.Count; x < addingLine;x++)
					lines.Add("");
				
				lines[addingLine-1] += text;
			} else {
				lines.Insert(addingLine-1,text);//index-based line
			}

			//ctr = 1; foreach(var s in lines) {Console.WriteLine("("+ ctr++ +")>"+s);}

			File.WriteAllText(filePath,String.Join(Environment.NewLine, lines));

			return "";
		} catch (Exception ex)
		{
			return ex.GetType().ToString();
		}
		
	}
}
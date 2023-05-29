// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ReEngine;
using System.IO;
using System.Diagnostics;

class WorkspaceHelper : IScript
{
	public void Init()
	{
		
	}

	public void Destroy()
	{
		
	}

	public void Command(string args,StringBuilder output)
	{
		//ScriptContext.GetArg(0)
		switch (args)
		{
			case "gotoclass":
				RunVSCodeAtLine(ScriptContext.GetArg(0),ScriptContext.GetArg(1));
				break;
			default:
				Console.WriteLine("Error command");
				break;
		}
		
	}

	public static void RunVSCodeAtLine(string file,string line,string offset = "0")
	{
		foreach(var x in Process.GetProcessesByName("Code"))
		{
			string fp = x.MainModule.FileName;
			if (fp.Contains("Code.exe"))
			{
				RunVSCodeAtLine_Internal(fp,file,line,offset);
				return;
			}
			//Console.WriteLine($"process {x} : {x.MainModule.FileName}");
		}

		MessageBox.Show(
			"Не найден процесс Visual Studio Code. Запустите редактор для выполнения данной команды",
			"VSCode not found",
			MessageBoxButtons.OK,
			MessageBoxIcon.Error
		);
	}

	private static void RunVSCodeAtLine_Internal(string vscodepath,string file,string line,string offset)
	{
		Console.WriteLine($"vs:{vscodepath} f:{file} l:{line}eos;");
		System.Diagnostics.Process process = new System.Diagnostics.Process();
		System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
		//startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
		startInfo.FileName = vscodepath;
		startInfo.Arguments = $"--goto \"{file}\":{line}:{offset}";
		process.StartInfo = startInfo;
		process.Start();
	}
}


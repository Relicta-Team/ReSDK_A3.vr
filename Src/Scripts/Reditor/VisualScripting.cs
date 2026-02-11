// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

using ReEngine;
using System;
using System.Diagnostics;

class VisualScripting : IScript
{
	public void Init()
	{
		
	}

	public void Destroy()
	{
		
	}

	public void Command(string args,StringBuilder output)
	{
		if (args == "run")
		{
			string exePath = ScriptContext.GetArg(0);
			string processName = exePath; // Замените на имя вашей программы

			bool isRunning = isProcessRunning(processName);

			if (isRunning)
			{
				output.Append("already");
				return;
			}
			string argsCli = "";
			if (ScriptContext.GetArgsCount() > 1)
			{
				argsCli = ScriptContext.GetArg(1);
			}
			startEditor(exePath,argsCli);

			output.Append("ok");
		}
	}

	private void startEditor(string path,string arguments="")
	{
		System.Diagnostics.Process process = new System.Diagnostics.Process();
		System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
		startInfo.FileName = path;
		startInfo.Arguments = arguments;
		startInfo.WorkingDirectory = System.IO.Path.GetDirectoryName(path);
		process.StartInfo = startInfo;
		process.Start();
	}

	private bool isProcessRunning(string processPath)
	{
		string processName = System.IO.Path.GetFileNameWithoutExtension(processPath);

        Process[] processes = Process.GetProcessesByName(processName);
		
        foreach (Process process in processes)
        {
			//Console.WriteLine(processName + " => " + process.MainModule.FileName);
            try
            {
                if (!string.IsNullOrEmpty(process.MainModule.FileName) && process.MainModule.FileName.ToLower().EndsWith(processName.ToLower() + ".exe"))
                {
                    return true;
                }
            }
            catch (Exception)
            {
                // Ignore any exceptions that might occur while trying to access process information
            }
        }

        return false;
	}

}
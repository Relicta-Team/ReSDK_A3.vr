// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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

using System.Runtime.InteropServices;
using System.Drawing;

using System.Windows;

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
			case "init":
				var platformProcess = GetPlatformProcess();
		
				SetWindowText(platformProcess.MainWindowHandle,"ReEditor: " + ScriptContext.GetArg(0));
				Icon icon = new Icon(ScriptContext.GetArg(1));
				SendMessage(platformProcess.MainWindowHandle, WM_SETICON, ICON_BIG, icon.Handle);

				break;
			case "gotoclass":
				RunVSCodeAtLine(ScriptContext.GetArg(0),ScriptContext.GetArg(1));
				break;
			case "openfolder":
				OpenFolder(ScriptContext.GetArg(0),
					ScriptContext.GetArgsCount() > 2 &&
					ScriptContext.GetArg(2) == "with_select"
				);
				break;
			case "checkfilelock":
				output.Append(CheckFileAccess(ScriptContext.GetArg(0)).ToString());
				break;
			case "getworkdir":
				output.Append(ScriptContext.GetAppDir());
				break;
			default:
				Console.WriteLine("Error command: " + args);
				break;
		}
		
	}

	public static bool CheckFileAccess(string file)
	{
		//non-existent files is not locked
		if (!File.Exists(file)) return true;

		try
        {
            using (var fileStream = new FileStream(file, FileMode.Open, FileAccess.ReadWrite, FileShare.None))
            {
                // Если файл открыт другими процессами, будет выброшено исключение
                //Console.WriteLine("Файл не открыт другими процессами: "+ file);
				return true;
            }
        }
        catch (IOException ex)
        {
            //Console.WriteLine("Файл открыт другими процессами:");
            //Console.WriteLine(ex.Message);
			return false;
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

	//Generated in chatgpt
	private static void OpenFolder(string path,bool withSelction = false)
	{
		if (File.Exists(path))
		{
			//custom open folder with file selection
			if (withSelction)
			{
				Process.Start("explorer.exe", "/select,"+path);
				return;
			}

			// Это файл, открываем папку, содержащую файл
			path = Path.GetDirectoryName(path);
		}

		if (Directory.Exists(path))
		{
			// Путь существует, открываем папку в проводнике
			Process.Start("explorer.exe", path);
		}
		else
		{
			Console.WriteLine("OpenFolder - path not found: "+path);
			// Путь не существует, выбрасываем исключение
			//throw new DirectoryNotFoundException($"Directory not found: {path}");
		}
	}

	private Process GetPlatformProcess()
	{
		return Process.GetCurrentProcess();
	}

	[DllImport("user32.dll")]
	static extern int SetWindowText(IntPtr hWnd, string text);

	[DllImport("user32.dll")]
	static extern int SendMessage(IntPtr hwnd, int message, int wParam, IntPtr lParam);

	private const int WM_SETICON = 0x80;
	private const int ICON_SMALL = 0;
	private const int ICON_BIG = 1;
}


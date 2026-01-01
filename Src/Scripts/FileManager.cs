// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

using System;
using System.Text;
using ReEngine;
using System.IO;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.Diagnostics;

class FileManager : IScript
{
	public void Init()
	{

	}

	public void Destroy()
	{

	}

	private static string EncodingToRV(string str) => Encoding.GetEncoding(1251).GetString(Encoding.GetEncoding(65001).GetBytes(str));

	public enum PathType {
		File, Directory, Invalid
	}

	public static PathType GetPathType(string path)
	{
		if (File.Exists(path))
			return PathType.File;
		else if (Directory.Exists(path))
			return PathType.Directory;
		else
			return PathType.Invalid;
	}


	private bool useAbsPath = false;
	private List<string> lastEnumerateFiles = new List<string>();
	public void Command(string args, StringBuilder output)
	{
		switch (args)
		{
			case "Open":
				if (ScriptContext.GetArgsCount() == 1)
				{
					Process.Start(ScriptContext.GetArg(0));
				}
				else
				{
					string readedTextOpen = ScriptContext.GetArg(1);
					string cdelim = ScriptContext.GetArg(2);
					readedTextOpen = readedTextOpen.Replace(cdelim, "\"");
					Process.Start(ScriptContext.GetArg(0), readedTextOpen);
				}
				
				output.Append(File.Exists(ScriptContext.GetArg(0)));
				break;
			case "OpenReturn":
				Process procH = null;
				if (ScriptContext.GetArgsCount() == 1)
				{
					procH = Process.Start(ScriptContext.GetArg(0));
				}
				else
				{
					string readedTextOpenRet = ScriptContext.GetArg(1);
					string cdelim = ScriptContext.GetArg(2);
					readedTextOpenRet = readedTextOpenRet.Replace(cdelim, "\"");
					string fp_ = ScriptContext.GetArg(0);
					ProcessStartInfo psi_ = new ProcessStartInfo();

					psi_.FileName = fp_;
					psi_.Arguments = readedTextOpenRet;
					psi_.WorkingDirectory = Path.GetDirectoryName(fp_);
					procH = Process.Start(psi_);
				}
				procH.WaitForExit();
				output.Append(procH.ExitCode.ToString());
				break;
			case "Copy":
				try
				{
					string copyFrom = ScriptContext.GetArg(0);
					
					if (GetPathType(copyFrom) != PathType.File) throw new FileNotFoundException("copyFrom not a file");

					string copyTo = ScriptContext.GetArg(1);
					if (GetPathType(copyTo) == PathType.Directory)
					{
						copyTo = Path.Combine(copyTo, Path.GetFileName(copyFrom));
					}
					Console.WriteLine($"from {copyFrom} to {copyTo}");
					File.Copy(copyFrom, copyTo,bool.Parse(ScriptContext.GetArg(2)));
				} catch (Exception excopy)
				{
					output.Append(false);
				}

				output.Append(true);
				break;
			case "Move":
				try
				{
					string moveFrom = ScriptContext.GetArg(0);
					string moveTo = ScriptContext.GetArg(1);
					
					Console.WriteLine($"path type from {GetPathType(moveFrom)}");
					Console.WriteLine($"path type to {GetPathType(moveTo)}");

					if (GetPathType(moveFrom) == PathType.Directory && GetPathType(moveTo) == PathType.Invalid)
					{
						Console.WriteLine($"dir from {moveFrom} to {moveTo}");
						Directory.Move(moveFrom, moveTo);
						output.Append(true);
						break;
					}

					if (GetPathType(moveFrom) != PathType.File) throw new FileNotFoundException("moveFrom not a file");

					if (GetPathType(moveTo) == PathType.Directory)
					{
						moveTo = Path.Combine(moveTo, Path.GetFileName(moveFrom));
					}
					Console.WriteLine($"from {moveFrom} to {moveTo}");
					File.Move(moveFrom, moveTo);
				}
				catch (Exception exmove)
				{
					output.Append(false);
				}

				output.Append(true);
				break;
			case "Exists":
				output.Append(File.Exists(ScriptContext.GetArg(0)));
				break;
			case "ExistsDir":
				output.Append(Directory.Exists(ScriptContext.GetArg(0)));
				break;
			case "Read":
				string readedText = EncodingToRV( //данные полученные не из движка так же надо конвертировать...
					File.ReadAllText(ScriptContext.GetArg(0))
				);
				if (ScriptContext.GetArgsCount() > 1)
				{
					string cdelim = ScriptContext.GetArg(1);
					readedText = readedText.Replace("\"",cdelim);
				}
				if (readedText.Length >= 10240)
				{
					MessageBox.Show(
						"Cannot load file " + ScriptContext.GetArg(0),
						"Buffer overflow",
						MessageBoxButtons.OK,
						MessageBoxIcon.Error
					);
					output.Append("$BUFFER_OVERFLOW$");
					break;
				};
				
				output.Append(readedText);
				break;
			case "FreeFileLock":
				FreeFileLock();
				break;
			case "Append":
				File.AppendAllText(ScriptContext.GetArg(0), ScriptContext.GetArg(1));
				break;
			case "Write":
				string writedText = ScriptContext.GetArg(1);
				if (ScriptContext.GetArgsCount() > 2)
				{
					string delim = ScriptContext.GetArg(2);
					writedText = writedText.Replace(delim,"\"");
				}
				File.WriteAllText(ScriptContext.GetArg(0), writedText);
				break;
			case "Copy_old":
				File.Copy(ScriptContext.GetArg(0), ScriptContext.GetArg(1),true);
				break;
			case "Delete":
				File.Delete(ScriptContext.GetArg(0));
				break;
			case "FolderDelete":
				Directory.Delete(ScriptContext.GetArg(0),true);
				break;
			//seraching
			//not used in src code...
			case "SetRetAbsPath":
				if (ScriptContext.GetArgsCount()>=1)
				{
					string mode = ScriptContext.GetArg(0).ToLower();
					if (mode == "true")
					{
						useAbsPath = true;
						output.Append("ok");
					} 
					else if (mode == "false")
					{
						useAbsPath = false;
						output.Append("ok");
					}
					else
					{
						output.Append("");
					}
				} else
				{
					output.Append("");
				}
				break;
			case "GetFiles":
				List<string> objs = new List<string>();

				SearchOption option = SearchOption.TopDirectoryOnly;
				string pattern = "*.*";
				string pfile = ScriptContext.GetArg(0);
				if (ScriptContext.GetArgsCount() >= 2)
					pattern = ScriptContext.GetArg(1);

				if (ScriptContext.GetArgsCount() >= 3)
				{
					string argval = ScriptContext.GetArg(2);
					if (argval == "deep")
						option = SearchOption.AllDirectories;
				}
				List<string> files = new List<string>();
				foreach(var fle in Directory.GetFiles(pfile, pattern, option))
				{
					if (!useAbsPath)
						files.Add(fle.Replace(pfile+"\\", ""));
					else
						files.Add(fle);
					
				}

				ScriptContext.ConvertListToGame(output, files.ToArray());
				break;
			case "GetFileEnumerator":
				lastEnumerateFiles.Clear(); //clear enumerator

				option = SearchOption.TopDirectoryOnly;
				pattern = "*.*";
				pfile = ScriptContext.GetArg(0);
				if (ScriptContext.GetArgsCount() >= 2)
					pattern = ScriptContext.GetArg(1);

				if (ScriptContext.GetArgsCount() >= 3)
				{
					string argval = ScriptContext.GetArg(2);
					if (argval == "deep")
						option = SearchOption.AllDirectories;
				}
				
				files = new List<string>();
				foreach (var fle in Directory.GetFiles(pfile, pattern, option))
				{
					if (!useAbsPath)
						files.Add(fle.Replace(pfile + "\\", ""));
					else
						files.Add(fle);

				}
				lastEnumerateFiles.AddRange(files);
				ScriptContext.ConvertListToGame(output, new object[] { files.Count - 1 });

				break;
			case "EnumerateFile":
				ScriptContext.ConvertListToGame(output, new object[] { lastEnumerateFiles[Convert.ToInt32(ScriptContext.GetArg(0))] });
				break;
			case "GetFolders":
				pattern = "*.*";
				string pfl = ScriptContext.GetArg(0);
				if (ScriptContext.GetArgsCount() >= 2)
				{
					pattern = ScriptContext.GetArg(1);
				}

				option = SearchOption.TopDirectoryOnly;
				if (ScriptContext.GetArgsCount() >= 3)
				{
					string argval = ScriptContext.GetArg(2);
					if (argval == "deep")
						option = SearchOption.AllDirectories;
				}

				List<string> items = new List<string>();
				foreach (var item in Directory.EnumerateDirectories(pfl, pattern, option))
				{
					if (!useAbsPath)
						items.Add(item.Replace(pfl+"\\", ""));
					else
						items.Add(item);
				}

				
				ScriptContext.ConvertListToGame(output, items.ToArray());

				break;
		}
	}

	[DllImport("user32.dll")]
	private static extern bool SetForegroundWindow(IntPtr hWnd);

	[DllImport("user32.dll")]
	private static extern IntPtr SetFocus(IntPtr hWnd);

	[DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
	private static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

	//close all platform file handlers
	private static async void FreeFileLock()
	{
		IntPtr taskbarWindow = FindWindow("Shell_TrayWnd", null);
		SetForegroundWindow(taskbarWindow);
		SetFocus(taskbarWindow);

		Task task1 = Task.Run(async () =>
		{
			Process currentProcess = Process.GetCurrentProcess();
			IntPtr currentWindow = currentProcess.MainWindowHandle;
			//Console.WriteLine("Асинхронная задача 1 начата");
			await Task.Delay(1); // Асинхронная операция
			//Console.WriteLine("Асинхронная задача 1 завершена");
			SetForegroundWindow(currentWindow);
			SetFocus(currentWindow);
		});
		await Task.WhenAll(task1);
	}
}


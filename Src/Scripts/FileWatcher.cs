// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

using System;
using System.Text;
using ReEngine;
using System.IO;

class FileWatcher : IScript
{
	public void Init()
	{

	}

	public void Destroy()
	{
		if (fsObj!= null)
		{
			fsObj.Dispose();
		}
	}

	private FileSystemWatcher fsObj;
	
	public void Command(string args, StringBuilder output)
	{
		try
		{
			if (args == "init")
			{
				if (ScriptContext.GetArgsCount() != 3)
				{
					Console.WriteLine("		WARN: fws arguments error");
					return;
				}

				bool needLogs = ScriptContext.GetArg(2) != "";

				if (fsObj != null)
				{
					if (needLogs)
						Console.WriteLine("		WARN: fws not null");
					return;
				}

				string pathAbs = ScriptContext.GetArg(0);
				string filter = ScriptContext.GetArg(1);
				
				fsObj = new FileSystemWatcher(pathAbs, filter);

				fsObj.Disposed += FsObj_Disposed;

				fsObj.NotifyFilter = 
					/*NotifyFilters.Attributes
					|*/ NotifyFilters.FileName
					| NotifyFilters.LastWrite
					//| NotifyFilters.Size
					| NotifyFilters.DirectoryName
					//| NotifyFilters.CreationTime
					;

				fsObj.Created += FsObj_Created;
				fsObj.Deleted += FsObj_Deleted;
				fsObj.Renamed += FsObj_Renamed;
				fsObj.Changed += FsObj_Changed;
				fsObj.Error += FsObj_Error;

				fsObj.EnableRaisingEvents = true;
				fsObj.IncludeSubdirectories = true;

				if (needLogs)
					Console.WriteLine($"		FWS STARTED: {pathAbs} ({filter})");
			}
		} catch (Exception ex)
		{
			Console.WriteLine($"		ERROR: FWS command exception: {ex.Message}");
		}
		
	}
	private static string EncodingToRV(string str) => Encoding.GetEncoding(1251).GetString(Encoding.GetEncoding(65001).GetBytes(str));
	private void OnUpdate(string path,string changemode = "unknown",string cevent = "unkcevent")
	{
		ScriptContext.AddCallback("FileWatcher_handleCallbackExtension", new []{EncodingToRV(path), changemode, cevent});
	}

	private void FsObj_Changed(object sender, FileSystemEventArgs e)
	{
		OnUpdate(e.FullPath,e.ChangeType.ToString(),"change");
	}

	private void FsObj_Renamed(object sender, RenamedEventArgs e)
	{
		OnUpdate(e.FullPath,e.ChangeType.ToString(),"rename");
	}

	private void FsObj_Deleted(object sender, FileSystemEventArgs e)
	{
		OnUpdate(e.FullPath,e.ChangeType.ToString(),"delete");
	}

	private void FsObj_Created(object sender, FileSystemEventArgs e)
	{
		OnUpdate(e.FullPath, e.ChangeType.ToString(), "create");
	}

	private void FsObj_Error(object sender, ErrorEventArgs e)
	{
		Console.WriteLine($"FWS ERROR: {e.GetException().Message}");
	}

	private void FsObj_Disposed(object sender, EventArgs e)
	{
		Console.WriteLine("FWS DESTROYED");
	}
}


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

class TestScript : IScript
{
	public void Init()
	{
		Console.WriteLine("Test script created!");
	}

	public void Destroy()
	{
		Console.WriteLine("Script destroyed " + this);
	}

	public void Command(string args,StringBuilder output)
	{
		switch (args)
		{
			case "test":
				Console.WriteLine(1);
				break;
			case "ping":
				output.Append("pong");
				break;
			case "helloworld":
				Console.WriteLine("Hello world!");
				break;
			case "popup":
				string data = "";
				for(int i = 0; i < ReScriptBuilder.GetScriptArgumentsCount(); i++)
					data += $"SEG{i}" + ReScriptBuilder.GetScriptArgument(i) + Environment.NewLine;
				MessageBox.Show("Dumped info:" + Environment.NewLine + data,"CALLSTACK INFO",MessageBoxButtons.OK);
				break;
			default:
				output.Append("Command not found: " + args);
				break;
		}
	}

}



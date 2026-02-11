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

class Breakpoint : IScript
{
	public void Init()
	{
		
	}

	public void Destroy()
	{
		
	}

	public void Command(string args,StringBuilder output)
	{
		System.Console.WriteLine("called bp");
		MessageBoxButtons bts;
		string fileProb = ScriptContext.GetArg(1);
		if (fileProb == "CUSTOM")
		{
			output.Append((MessageBox.Show(
				ScriptContext.GetArg(0),
				args,
				MessageBoxButtons.YesNo,
				MessageBoxIcon.Warning
			) == DialogResult.Yes));
			return;
		}
		if (fileProb == "") {
			MessageBox.Show(
				ScriptContext.GetArg(0),
				args,
				MessageBoxButtons.OK,
				MessageBoxIcon.Warning
			);
		} else {
			if (MessageBox.Show(
				"(Нажмите \"Да\" для перехода к участку кода, вызывающего ошибку, либо \"Нет\" для закрытия данного окна)" + Environment.NewLine + Environment.NewLine + ScriptContext.GetArg(0),
				args,
				MessageBoxButtons.YesNo,
				MessageBoxIcon.Warning
			) == DialogResult.Yes)
			{
				WorkspaceHelper.RunVSCodeAtLine(fileProb,ScriptContext.GetArg(2),ScriptContext.GetArg(3));
			}
		}


		
	}
}


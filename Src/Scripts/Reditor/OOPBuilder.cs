// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

using ReEngine;
using System;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Collections.Generic;

using System.Windows.Forms;
using System.Drawing;
using System.Globalization;
using System.Runtime.InteropServices;
using System.Linq;

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
		}
		else if (args == "buildclass_DEPRECATED")
		{
			if (ScriptContext.GetArgsCount() < 3)
			{
				output.Append("err:argserror:" + ScriptContext.GetArgsCount());
			}

			output.Append(AddNewClassToFile(ScriptContext.GetArg(0), Int32.Parse(ScriptContext.GetArg(1)), ScriptContext.GetArg(2)));
		}
		else if (args == "buildclass")
		{

			if (ScriptContext.GetArgsCount() < 3)
			{
				output.Append("err:argserror:" + ScriptContext.GetArgsCount());
			}
			output.Append(clstofile(ScriptContext.GetArg(0), Int32.Parse(ScriptContext.GetArg(1)), ScriptContext.GetArg(2)));
		}
		else if (args == "inputbox")
		{
			string value = "";
			if (InputBox(ScriptContext.GetArg(0), ScriptContext.GetArg(1), ref value) == DialogResult.OK)
			{
				output.Append(value);
			}
			else
			{
				output.Append("$CLOSED$");
			}
		}
		else if (args == "colorbox")
		{

			var selectedColor = Color.Black;
			if (ScriptContext.GetArgsCount() == 3)
			{
				//try {
				//Console.WriteLine(ScriptContext.GetArg(0));
				double rNormalized = float.Parse(ScriptContext.GetArg(0).Replace(".", ","));
				double gNormalized = float.Parse(ScriptContext.GetArg(1).Replace(".", ","));
				double bNormalized = float.Parse(ScriptContext.GetArg(2).Replace(".", ","));
				//Console.WriteLine("POST COLOR");
				int r = (int)(rNormalized * 255.0);
				int g = (int)(gNormalized * 255.0);
				int b = (int)(bNormalized * 255.0);
				//Console.WriteLine($"PRESETUP {r} {g} {b}");
				selectedColor = Color.FromArgb(r, g, b);
				//Console.WriteLine($"POSTSETUP {selectedColor}");
				/*} catch (Exception ex)
				{
					Console.WriteLine(ex);
					output.Append("[]");
					return;
				}*/
			}
			ColorDialog colorDialog = new ColorDialog
			{
				Color = selectedColor,
				FullOpen = true
			};

			DialogResult result = colorDialog.ShowDialog();

			if (result == DialogResult.OK)
			{
				selectedColor = colorDialog.Color;
				double r = selectedColor.R / 255.0; // Нормализация к диапазону [0, 1]
				double g = selectedColor.G / 255.0;
				double b = selectedColor.B / 255.0;

				string colorText = $"[{r.ToString("0.######", CultureInfo.InvariantCulture)}, " +
								  $"{g.ToString("0.######", CultureInfo.InvariantCulture)}, " +
								  $"{b.ToString("0.######", CultureInfo.InvariantCulture)}]";
				output.Append(colorText);
			}
			else
			{
				output.Append("$CLOSED$");
			}

		}
		else if (args == "textbox")
		{
			string _maxlntbxS = ScriptContext.GetArg(4);
			int maxlntbx = 8; //maxlen
			string value = ScriptContext.GetArg(3);
			var mpos = Control.MousePosition;
			if (int.TryParse(_maxlntbxS, out maxlntbx) &&
			TextBox(
				ScriptContext.GetArg(0),
				ScriptContext.GetArg(1),
				ScriptContext.GetArg(2) == "true",
				ref value,
				maxlntbx
				) == DialogResult.OK)
			{
				SetCursorPos(mpos.X, mpos.Y);
				output.Append(ScriptContext.EncodingToRV(value));
			}
			else
			{
				SetCursorPos(mpos.X, mpos.Y);
				output.Append("$CLOSED$");
			}
		}
		else if (args == "tree")
		{
			var mpos = Control.MousePosition;
			string val = ScriptContext.GetArg(3);
			if (CreateTree(
				ScriptContext.GetArg(0),
				ScriptContext.GetArg(1),
				ScriptContext.GetArg(2),
				ref val
				) == DialogResult.OK)
			{
				SetCursorPos(mpos.X, mpos.Y);
				output.Append(ScriptContext.EncodingToRV(val));
			}
			else
			{
				SetCursorPos(mpos.X, mpos.Y);
				output.Append("$CLOSED$");
			}
		}
		else if (args == "gm_generator")
		{
			try
			{
				if (ScriptContext.GetArgsCount() != 5)
				{
					output.Append("false");
					return;
				}

				string fileFrom = ScriptContext.GetArg(0);
				string fileTo = ScriptContext.GetArg(1);
				string replaceFrom = ScriptContext.GetArg(2);
				string replaceTo = ScriptContext.GetArg(3);
				string replaceMapName = ScriptContext.GetArg(4);

				// read all text from
				string input = File.ReadAllText(fileFrom);
				// replace all
				input = input.Replace(replaceFrom, replaceTo);
				input = input.Replace("@MAP_NAME@", replaceMapName);

				//directory create if not exists
				System.IO.FileInfo file = new System.IO.FileInfo(fileTo);
				file.Directory.Create();

				// write to
				File.WriteAllText(fileTo, input);

				output.Append("true");
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex);
				output.Append("false");
			}
		}
		else if (args == "gm_generator_finalize")
		{
			try
			{
				if (ScriptContext.GetArgsCount() != 3)
				{
					output.Append("false");
					return;
				}

				string scriptloaderfile = ScriptContext.GetArg(0);
				string foldergamemode = ScriptContext.GetArg(1);
				string modename = ScriptContext.GetArg(2);

				//create file in foldergamemode loader.sqf
				string loaderfile = foldergamemode + "\\loader.sqf";
				File.WriteAllText(loaderfile, $"#include <..\\GameMode.h>\r\n\r\nload(\"{modename}\\{modename}.sqf\");\r\nload(\"{modename}\\{modename}_roles.sqf\");");

				//add this loader to scriptloaderfile
				File.AppendAllText(scriptloaderfile, $"\r\nload(\"{modename}\\loader.sqf\");");

				output.Append("true");
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex);
				output.Append("false");
			}
		}
	}

	// Главный метод для парсинга строки и добавления узлов в TreeView
	public static void ParseToTreeView(TreeView treeView, string input)
	{
		treeView.Nodes.Clear();
		// Парсим строку в словарь
		var nodesDictionary = ParseInput(input);

		// Определяем корневые узлы (те, которые не являются детьми)
		var rootNodes = BuildTree(nodesDictionary);

		// Добавляем узлы в TreeView
		treeView.Nodes.AddRange(rootNodes.ToArray());
	}

	// Метод для парсинга строки формата "ребенок:родитель;"
	private static Dictionary<string, TreeNode> ParseInput(string input)
	{
		var nodesDictionary = new Dictionary<string, TreeNode>();
		var parentChildMap = new Dictionary<string, string>();

		// Разбиваем входную строку на пары "ребенок:родитель"
		var pairs = input.Split(new[] { ';' }, StringSplitOptions.RemoveEmptyEntries);

		foreach (var pair in pairs)
		{
			var nodes = pair.Split(':');
			if (nodes.Length == 2)
			{
				var child = nodes[0].Trim();
				var parent = nodes[1].Trim();

				// Создаем узел только для lvalue (ребенок)
				if (!nodesDictionary.ContainsKey(child))
				{
					nodesDictionary[child] = new TreeNode(child);
				}

				// Сохраняем информацию о родительском отношении
				parentChildMap[child] = parent;
			}
		}

		// Устанавливаем родительские связи
		foreach (var kvp in parentChildMap)
		{
			var child = kvp.Key;
			var parent = kvp.Value;

			if (nodesDictionary.ContainsKey(parent))
			{
				nodesDictionary[parent].Nodes.Add(nodesDictionary[child]);
			}
		}

		return nodesDictionary;
	}

	// Метод для построения списка корневых узлов
	private static List<TreeNode> BuildTree(Dictionary<string, TreeNode> nodesDictionary)
	{
		var rootNodes = new List<TreeNode>();

		// Выбираем корневые узлы (те, которые не имеют родителей)
		foreach (var node in nodesDictionary.Values)
		{
			if (node.Parent == null)
			{
				rootNodes.Add(node);
			}
		}

		return rootNodes;
	}


	public static DialogResult CreateTree(string title,string promptText,string treeData,ref string value)
    {
		Form form = new Form();
		Label label = new Label();
		TreeView treeView = new TreeView();
		Button buttonOk = new Button();
		Button buttonCancel = new Button();
		TextBox searchBox = new TextBox(); // Добавляем поле для поиска

		form.Text = title;
		label.Text = promptText;

		buttonOk.Text = "ОК";
		buttonCancel.Text = "Отмена";
		buttonOk.DialogResult = DialogResult.OK;
		buttonCancel.DialogResult = DialogResult.Cancel;

		label.SetBounds(9, 20, 372, 13);
		searchBox.SetBounds(12, 36, 670, 20); // Поле поиска под меткой
		treeView.SetBounds(12, 60, 670, 475); // Дерево под полем поиска
		buttonOk.SetBounds(516, 546, 75, 23);
		buttonCancel.SetBounds(597, 546, 75, 23);

		label.AutoSize = true;
		treeView.Anchor = treeView.Anchor | AnchorStyles.Right;
		buttonOk.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
		buttonCancel.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;

		// Добавляем данные в дерево
		ParseToTreeView(treeView, treeData);

		// Оригинальные данные дерева для сброса фильтра
		TreeNode[] originalNodes = new TreeNode[treeView.Nodes.Count];
		treeView.Nodes.CopyTo(originalNodes, 0);

		// Обработчик поиска
		searchBox.TextChanged += (sender, e) =>
		{
			string searchText = searchBox.Text.ToLower();
			treeView.BeginUpdate(); // Отключаем перерисовку во время обновления

			treeView.Nodes.Clear();

			if (string.IsNullOrWhiteSpace(searchText))
			{
				// Восстанавливаем оригинальное дерево, если строка поиска пуста
				treeView.Nodes.AddRange(originalNodes);
				treeView.CollapseAll();
			}
			else
			{
				// Проходим по узлам и фильтруем по тексту поиска
				foreach (TreeNode node in originalNodes)
				{
					var matchedNodes = SearchTree(node, searchText);
					if (matchedNodes != null)
					{
						treeView.Nodes.Add(matchedNodes);
					}
				}

				treeView.ExpandAll();
			}

			treeView.EndUpdate(); // Включаем перерисовку после обновления
		};

		form.ClientSize = new Size(700, 600);
		form.Controls.AddRange(new Control[] { label, searchBox, treeView, buttonOk, buttonCancel });
		form.FormBorderStyle = FormBorderStyle.FixedDialog;
		form.StartPosition = FormStartPosition.CenterScreen;
		form.MinimizeBox = false;
		form.MaximizeBox = false;
		form.CancelButton = buttonCancel;

		DialogResult dialogResult = form.ShowDialog();
		if (treeView.SelectedNode != null)
		{
			value = treeView.SelectedNode.Text;
		}
		return dialogResult;
    }

	private static TreeNode SearchTree(TreeNode node, string searchText)
	{
		string lowerSearchText = searchText.ToLower();
		string lowerNodeText = node.Text.ToLower();

		// Создаем список для дочерних узлов
		List<TreeNode> matchedChildNodes = new List<TreeNode>();

		// Проходим по дочерним узлам и рекурсивно проверяем их
		foreach (TreeNode childNode in node.Nodes)
		{
			TreeNode matchedChild = SearchTree(childNode, searchText);
			if (matchedChild != null)
			{
				matchedChildNodes.Add(matchedChild); // Добавляем только совпадающие дочерние узлы
			}
		}

		// Если текст узла совпадает или есть совпадения в дочерних узлах
		if (lowerNodeText.Contains(lowerSearchText) || matchedChildNodes.Count > 0)
		{
			TreeNode matchedNode = new TreeNode(node.Text); // Создаем узел без клонирования
			if (lowerNodeText.Contains(lowerSearchText))
			{
				matchedNode.BackColor = Color.Green; // Подсветим совпадающий узел
			}

			// Добавляем дочерние узлы, которые содержат совпадения
			foreach (TreeNode matchedChild in matchedChildNodes)
			{
				matchedNode.Nodes.Add(matchedChild);
			}

			return matchedNode; // Возвращаем только совпавший узел с нужными дочерними
		}

		return null; // Если совпадений нет, возвращаем null
	}



	public static DialogResult InputBox(string title, string promptText, ref string value)
	{
		Form form = new Form();
		Label label = new Label();
		TextBox textBox = new TextBox();
		Button buttonOk = new Button();
		Button buttonCancel = new Button();

		form.Text = title;
		label.Text = promptText;
		textBox.Text = value;

		buttonOk.Text = "ОК";
		buttonCancel.Text = "Отмена";
		buttonOk.DialogResult = DialogResult.OK;
		buttonCancel.DialogResult = DialogResult.Cancel;

		label.SetBounds(9, 20, 372, 13);
		textBox.SetBounds(12, 36, 372, 20);
		buttonOk.SetBounds(228, 72, 75, 23);
		buttonCancel.SetBounds(309, 72, 75, 23);

		label.AutoSize = true;
		textBox.Anchor = textBox.Anchor | AnchorStyles.Right;
		buttonOk.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
		buttonCancel.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;

		form.ClientSize = new Size(396, 107);
		form.Controls.AddRange(new Control[] { label, textBox, buttonOk, buttonCancel });
		form.ClientSize = new Size(Math.Max(300, label.Right + 10), form.ClientSize.Height);
		form.FormBorderStyle = FormBorderStyle.FixedDialog;
		form.StartPosition = FormStartPosition.CenterScreen;
		form.MinimizeBox = false;
		form.MaximizeBox = false;
		form.AcceptButton = buttonOk;
		form.CancelButton = buttonCancel;

		DialogResult dialogResult = form.ShowDialog();
		value = textBox.Text;
		return dialogResult;
	}

	[DllImport("user32.dll")]
	private static extern bool SetCursorPos(int X, int Y);

	public static DialogResult TextBox(string title, string promptText,bool canMultiline, ref string value,int maxlen__)
	{
		Form form = new Form();
		Label label = new Label();
		TextBox textBox = new TextBox();
		Button buttonOk = new Button();
		Button buttonCancel = new Button();

		form.Text = title;
		label.Text = promptText;
		textBox.Text = value;
		textBox.Multiline = true; // Мультистрочное поле ввода
		textBox.ScrollBars = ScrollBars.Vertical; // Вертикальная прокрутка
		//установка ограничения по символам
		textBox.MaxLength = maxlen__;

		buttonOk.Text = "ОК";
		buttonCancel.Text = "Отмена";
		buttonOk.DialogResult = DialogResult.OK;
		buttonCancel.DialogResult = DialogResult.Cancel;

		label.SetBounds(9, 20, 372, 13);
		textBox.SetBounds(12, 36, 670, 500); // Изменил размеры на 670x500
		buttonOk.SetBounds(516, 546, 75, 23); // Изменил координаты кнопок
		buttonCancel.SetBounds(597, 546, 75, 23); // Изменил координаты кнопок

		label.AutoSize = true;
		textBox.Anchor = textBox.Anchor | AnchorStyles.Right;
		buttonOk.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
		buttonCancel.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;

		// Обработка нажатия клавиш в поле ввода
		if (!canMultiline)
		{
			textBox.TextChanged += (sender, e) =>
			{
				textBox.Text = textBox.Text.Replace(Environment.NewLine, " ");
			};
		}

		form.ClientSize = new Size(700, 600); // Устанавливаем размер окна
		form.Controls.AddRange(new Control[] { label, textBox, buttonOk, buttonCancel });
		form.FormBorderStyle = FormBorderStyle.FixedDialog;
		form.StartPosition = FormStartPosition.CenterScreen;
		form.MinimizeBox = false;
		form.MaximizeBox = false;
		form.CancelButton = buttonCancel;

		DialogResult dialogResult = form.ShowDialog();
		value = textBox.Text;
		return dialogResult;
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
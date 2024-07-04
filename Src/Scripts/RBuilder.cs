using System;
using ReEngine;
using System.Threading;
 

class RBuilder : IScript
{
    public void Init()
	{

	}

	public void Destroy()
	{

	}

	public void Command(string args, StringBuilder output)
	{
        switch (args)
        {
            case "exit":
                if (ScriptContext.GetArgsCount() != 1) return;
                int arg = int.Parse(ScriptContext.GetArg(0));
                Environment.Exit(arg);
                break;
            case "wait":
                if (ScriptContext.GetArgsCount() != 1) return;
                int ms = int.Parse(ScriptContext.GetArg(0));
                Thread.Sleep(ms);
                break;
            case "stdout_to_file":
                if (ScriptContext.GetArgsCount() != 1) return;
                string path = ScriptContext.GetArg(0);
                
                if (File.Exists(path)) File.Delete(path);

                // read stdout from current process and write into path

                using (var reader = new StreamReader(Console.OpenStandardOutput()))
                {
                    using (var writer = new StreamWriter(path))
                    {
                        string line;
                        while ((line = reader.ReadLine()) != null)
                        {
                            writer.WriteLine(line);
                        }
                    }
                }
                
                break;
        }
    }
}
// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

using System;
using ReEngine;
using System.Threading;
using System.Net.Sockets;
using System.Collections.Generic;

class RBuilder : IScript
{
    private const string serverIp = "127.0.0.1";
    private const int serverPort = 9897;

    private TcpClient tcpClient = null;
    private bool clientConnected => tcpClient != null && tcpClient.Connected;
    private static Queue<string> messages = new Queue<string>();

    private int parentApplicationPID = 0;

    private void stopClient()
	{
        if (clientConnected)
		{
            tcpClient.Close();
		}
        tcpClient = null;
	}

    private bool startClient()
	{
        if (clientConnected) return true;
        try
		{
            tcpClient = new TcpClient(serverIp, serverPort);
            if (tcpClient.Connected)
            {
                // Начать асинхронное чтение сообщений
                Task.Run(ReceiveMessagesAsync);
                //print("Client started!");
            }
            return tcpClient.Connected;
        } 
        catch (Exception ex)
		{
            print($"Exception on start client: {ex}");
            return false;
		}
	}
    private static string EncodingToRV(string str) => Encoding.GetEncoding(1251).GetString(Encoding.GetEncoding(65001).GetBytes(str));
    private async Task ReceiveMessagesAsync()
    {
        try
        {
            NetworkStream stream = tcpClient.GetStream();
            byte[] buffer = new byte[1024];

            while (tcpClient.Connected)
            {
                int bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length);

                if (bytesRead > 0)
                {
                    string receivedMessage = Encoding.UTF8.GetString(buffer, 0, bytesRead);
                    string rm = EncodingToRV(receivedMessage);
                    print($"Received message from server: {rm}");
                    //ScriptContext.AddCallback("rbuilder_callback",new[]{rm});
                    messages.Enqueue(rm);
                    
                }
                else
                {
                    // Сервер закрыл соединение
                    print("Server disconnected");
                    Environment.Exit(-5502);
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            print($"Error receiving messages: {ex.Message}");
            Environment.Exit(-5503);
        }
    }

    private void SendMessage(string message)
    {
        if (!clientConnected) return;
        
        try
        {
            if (tcpClient.Connected)
            {
                NetworkStream stream = tcpClient.GetStream();
                //add end terminator
                message += "\0";
                byte[] messageBytes = Encoding.UTF8.GetBytes(message);
                stream.Write(messageBytes, 0, messageBytes.Length);
                
            }
            else
            {
                print("Error: Connection to RBuilder server is not established.");
                Environment.Exit(-5504);
            }
        }
        catch (Exception ex)
        {
            print($"Error send to RBuilder: {ex.Message}");
            Environment.Exit(-5505);
        }
    }

    private static void print(string mes)
	{
        Console.WriteLine("rbcs: "+mes);
    }

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
            case "c_start":
                output.Append(startClient());
                break;
            case "c_stop":
                stopClient();
                break;
            case "c_send":
                if (ScriptContext.GetArgsCount() < 1) return;
                string message = ScriptContext.GetArg(0);
                string par = string.Empty;
                if (ScriptContext.GetArgsCount() > 1) par = ScriptContext.GetArg(1);
                if (message == "print")
                {
                    par = par.Replace(";","");
                }
                string msnd = $"m:{message};{par}";
                SendMessage(msnd);
                break;
            case "c_get":
                if (messages.Count > 0)
                {
                    output.Append(messages.Dequeue());
                }
                break;
            case "init_console_redirect":
                if (ScriptContext.GetArgsCount() != 1) return;
                int argPID = int.Parse(ScriptContext.GetArg(0));
                this.parentApplicationPID = argPID;
                break;
            // case "write_data":
            //     if (ScriptContext.GetArgsCount() != 1) return;
            //     string contentConsole__ = ScriptContext.GetArg(0);
            //     Process powner = System.Diagnostics.Process.GetProcessById(this.parentApplicationPID);
            //     Console.WriteLine($"pown {powner}: {contentConsole__}");
            //     powner.StandardInput.WriteLine(contentConsole__);
            //     break;
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
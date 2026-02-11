// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.IO.Pipes;

using System.Net;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization.Formatters.Binary;

using ReEngine;
using System.Threading;
using System.Net.Sockets;



public class ReNodeDebugger : IScript
{
    private const string serverIp = "127.0.0.1";  // Замените на IP-адрес вашего Python-сервера
    private const int serverPort = 9987;           // Замените на порт вашего Python-сервера

    private TcpClient tcpClient = null;
    private bool clientConnected => tcpClient != null && tcpClient.Connected;

    private static void print(string mes)
	{
        Console.WriteLine(mes);
    }

    public void Init()
    {
        // Инициализация может остаться пустой, если не требуется какая-то дополнительная логика
    }

    public void Destroy()
    {
        // Можете добавить необходимый код для завершения работы, если требуется
        stopClient();
    }

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
                //TODO включить когда понадобится сендить сообщения от renode к платформе
                //Task.Run(ReceiveMessagesAsync);
            }
            return tcpClient.Connected;
        } 
        catch (Exception ex)
		{
            print($"Exception on start client: {ex}");
            return false;
		}
	}

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
                    //print($"Received message from server: {receivedMessage}");

                    // Ваш код обработки полученного сообщения
                }
                else
                {
                    // Сервер закрыл соединение
                    print("Server disconnected");
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            print($"Error receiving messages: {ex.Message}");
        }
    }

    public void Command(string args, StringBuilder output)
    {
        switch (args)
        {
            case "start":
                output.Append(startClient());
                break;
            case "stop":
                stopClient();
                break;
            case "nlink":
                if (ScriptContext.GetArgsCount() == 1) {
                    string message = $"nlink@{ScriptContext.GetArg(0)}";
                    SendMessage(message);
                }
                break;
            case "connected":
                output.Append(clientConnected);
                break;
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
                print("Error: Connection to ReNode server is not established.");
            }
        }
        catch (Exception ex)
        {
            print($"Error send to ReNode: {ex.Message}");
        }
    }
}
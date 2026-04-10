using System;
using System.Net.Sockets;
using System.Text;

// =============================================
// CLIENT TCP - C#
// Chuc nang: Nhap chuoi HOA, gui len server va nhan ket qua
// =============================================

class Client
{
    static void Main(string[] args)
    {
        // Cau hinh ket noi den server
        string host = "127.0.0.1";  // Dia chi IP server
        int port = 9999;             // Cong ket noi (phai trung voi server)

        // Nhap chuoi HOA tu ban phim
        Console.Write("[CLIENT] Nhap vao mot chuoi ky tu HOA: ");
        string chuoi = Console.ReadLine();

        // Tao TcpClient va ket noi den server
        TcpClient client = new TcpClient();
        client.Connect(host, port);
        Console.WriteLine($"[CLIENT] Da ket noi den server {host}:{port}");

        // Lay luong du lieu
        NetworkStream stream = client.GetStream();

        // Gui chuoi len server
        byte[] dataGui = Encoding.UTF8.GetBytes(chuoi);
        stream.Write(dataGui, 0, dataGui.Length);
        Console.WriteLine("[CLIENT] Da gui chuoi len server.");

        // Nhan ket qua tu server
        byte[] buffer = new byte[4096];
        int bytesRead = stream.Read(buffer, 0, buffer.Length);
        string ketQua = Encoding.UTF8.GetString(buffer, 0, bytesRead);

        // Hien thi ket qua
        Console.WriteLine("\n[CLIENT] Ket qua nhan tu server:");
        Console.WriteLine("----------------------------------------");
        Console.WriteLine(ketQua);
        Console.WriteLine("----------------------------------------");

        // Dong ket noi
        client.Close();
        Console.WriteLine("[CLIENT] Da dong ket noi.");
        Console.ReadLine(); // Giu cua so lai
    }
}

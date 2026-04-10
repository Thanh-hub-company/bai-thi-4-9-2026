using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace Server
{
    class Program
    {
        static void Main(string[] args)
        {
            // Cau hinh Server
            string ip = "127.0.0.1";
            int port = 9999;

            // Tao TcpListener lang nghe ket noi
            TcpListener server = new TcpListener(IPAddress.Parse(ip), port);
            server.Start();

            Console.WriteLine("=== SERVER DA KHOI DONG ===");
            Console.WriteLine("Dang lang nghe tai: " + ip + ":" + port);
            Console.WriteLine("Cho client ket noi...\n");

            while (true)
            {
                // Chap nhan ket noi tu client
                TcpClient client = server.AcceptTcpClient();
                Console.WriteLine(">>> Co client vua ket noi!");

                // Lay luong du lieu
                NetworkStream stream = client.GetStream();

                // --- NHAN DU LIEU TU CLIENT ---
                byte[] buffer = new byte[1024];
                int bytesRead = stream.Read(buffer, 0, buffer.Length);
                string chuoi = Encoding.UTF8.GetString(buffer, 0, bytesRead);
                Console.WriteLine(">>> Nhan chuoi tu client: " + chuoi);

                // --- XU LY DU LIEU ---

                // 1. Dem so ky tu (khong tinh khoang trang)
                int soKyTu = chuoi.Replace(" ", "").Length;

                // 2. Dem so tu trong chuoi
                string[] mangTu = chuoi.Trim().Split(
                    new char[] { ' ' },
                    StringSplitOptions.RemoveEmptyEntries
                );
                int soTu = mangTu.Length;

                // 3. Chuyen chuoi thanh chu thuong
                string chuoiThuong = chuoi.ToLower();

                // --- DONG GOI KET QUA ---
                string ketQua =
                    "So luong ky tu (khong tinh khoang trang): " + soKyTu + "\n" +
                    "So tu trong chuoi: " + soTu + "\n" +
                    "Chuoi chuyen thanh chu thuong: " + chuoiThuong;

                // --- GUI KET QUA VE CLIENT ---
                byte[] dataGui = Encoding.UTF8.GetBytes(ketQua);
                stream.Write(dataGui, 0, dataGui.Length);

                Console.WriteLine(">>> Da gui ket qua ve client.");
                Console.WriteLine("--------------------------------\n");

                // Dong ket noi client
                client.Close();
            }
        }
    }
}
using System;
using System.IO;

class GhiFile
{
    static void Main(string[] args)
    {
        Console.Write("Nhap Ten Sinh Vien: ");
        string tenSV = Console.ReadLine();

        Console.Write("Nhap Lop: ");
        string lop = Console.ReadLine();

        string noiDung = tenSV + "_" + lop + "_Kiem tra giu mon";
        
        // Duong dan file co dinh
        string tenFile = @"C:\Users\Admin\Documents\thiltm.txt";

        // Ghi noi dung vao file
        File.WriteAllText(tenFile, noiDung, System.Text.Encoding.UTF8);
 
        Console.WriteLine("Da ghi thanh cong vao file: " + tenFile);
        Console.WriteLine("Noi dung: " + noiDung);
        Console.WriteLine("Duong dan: " + Path.GetFullPath(tenFile));
        Console.ReadLine();
    }
}
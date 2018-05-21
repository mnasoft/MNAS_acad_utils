using System;
using Microsoft.Win32;

namespace MNASoft
{
    public class AddRegistryPath
    {
        const string userRoot = "HKEY_CURRENT_USER";
        const string Software = "Software";
        const string Autodesk = "Autodesk";
        const string AutoCAD = "AutoCAD";
        const string CurVer = "CurVer";
        static string AcadDB;
        static string AcadRelease;
        static string Profile;
        const string Profiles = "Profiles";
        const string General = "General";
        const string ACAD = "ACAD";
        static string SupportPath;

        const string keyName = userRoot + "\\" + Software + "\\" + Autodesk + "\\" + AutoCAD;

        static string PWD = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);

        public static void Main()
        {
            AcadDB = (string)Registry.GetValue(userRoot + "\\" + Software + "\\" + Autodesk + "\\" + AutoCAD, CurVer, "NO-VER-CUR");

            AcadRelease = (string)Registry.GetValue(userRoot + "\\" + Software + "\\" + Autodesk + "\\" + AutoCAD + "\\" + AcadDB, CurVer, "NO-VER-CUR");

            Profile = (string)Registry.GetValue(userRoot + "\\" + Software + "\\" + Autodesk + "\\" + AutoCAD + "\\" + AcadDB +
                "\\" + AcadRelease + "\\" + Profiles, "", "NO-VER-CUR");

            SupportPath = (string)Registry.GetValue(userRoot + "\\" + Software + "\\" + Autodesk + "\\" + AutoCAD + "\\" + AcadDB +
                "\\" + AcadRelease + "\\" + Profiles + "\\" + Profile + "\\" + General, ACAD, "NO-VER-CUR");

            Console.WriteLine("Acad    : {0}", userRoot + "\\" + Software + "\\" + Autodesk + "\\" + AutoCAD);
            Console.WriteLine("Cur     : {0}", AcadDB);
            Console.WriteLine("Release : {0}", AcadRelease);
            Console.WriteLine("Profile : {0}", Profile);

            Console.WriteLine("PWD: {0}", PWD);

            SupportPath = SupportPath + ";" + 
                PWD + ";" +
                PWD + "\\" + "bin" + ";" +
                PWD + "\\" + "fonts" + ";" +
                PWD + "\\" + "support" + ";" +
                PWD + "\\" + "fonts\\Kompas" ;

            string[] SupportPathArray = SupportPath.Split(';');

            for (int i = 0; i < SupportPathArray.Length; i++)
                Console.WriteLine("SupportPath({0}): {1}", i, SupportPathArray[i]);

            Registry.SetValue(userRoot + "\\" + Software + "\\" + Autodesk + "\\" + AutoCAD + "\\" + AcadDB +
                "\\" + AcadRelease + "\\" + Profiles + "\\" + Profile + "\\" + General, ACAD, SupportPath);

            Console.WriteLine("\r\nUse the registry editor to examine the key.");
            Console.ReadLine();
          
        }
    }
}

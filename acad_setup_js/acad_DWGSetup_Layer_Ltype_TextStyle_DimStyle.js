//JScript
var WshShell = WScript.CreateObject("WScript.Shell");
var sleepTime=500;
if (WshShell.AppActivate("AutoCAD"))
{
/*Подключение путей поиска*/
  WriteWord("la_dhv");  WriteWord("{ENTER}");
  WriteWord("stl");  WriteWord("{ENTER}");
  WriteWord("ltp");  WriteWord("{ENTER}");
  WriteWord("MNASAddDimStyle");  WriteWord("{ENTER}");
/*Подключение путей поиска*/

}

function WriteWord(str) 
{
  WshShell.SendKeys(str);
  WScript.Sleep(sleepTime);
}

function WriteChar(str)
{
  var sss="";
  var len=str.length;
  for(var i=0;i<len;++i)
  {
    sss=str.substr(i,1);
    WshShell.SendKeys(sss);
    WScript.Sleep(sleepTime);
  }
}

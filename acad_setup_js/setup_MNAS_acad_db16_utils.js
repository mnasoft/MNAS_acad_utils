//JScript
var WshShell = WScript.CreateObject("WScript.Shell");
var sleepTime=500;
if (WshShell.AppActivate("AutoCAD"))
{
/*Подключение путей поиска*/
  WriteWord("_options");
  WriteWord("{ENTER}");
  WriteWord("%d");  WriteWord("C:\\Program Files\\MNASoft\\Mnas_acad_db16_utils\\acad_w.sup");  WriteWord("{ENTER}");
  WriteWord("%d");  WriteWord("C:\\Program Files\\MNASoft\\Mnas_acad_db16_utils\\acad.mnu\\acad_mnu_icon");  WriteWord("{ENTER}");
  WriteWord("%d");  WriteWord("C:\\Program Files\\MNASoft\\Mnas_acad_db16_utils\\acad.fnt");  WriteWord("{ENTER}");
  WriteWord("%d");  WriteWord("C:\\Program Files\\MNASoft\\Mnas_acad_db16_utils\\acad.fnt\\kompas");  WriteWord("{ENTER}");
  WriteWord("{ENTER}");
/*Подключение путей поиска*/

/*Подключение меню c:\\acad.mnu\\M_utility.cui*/
  WriteWord("cui");  WriteWord("{ENTER}");
  WriteWord("+{TAB}o");
  WriteWord("C:\\Program Files\\MNASoft\\Mnas_acad_db16_utils\\acad.mnu\\M_utility.cui");  WriteWord("{ENTER}");
  WriteWord("{ENTER}");
  WriteWord("+{TAB}+{TAB}+{TAB}+{TAB}+{TAB}+{TAB}");
  WriteWord("{ENTER}");
/*Подключение меню c:\\acad.mnu\\M_utility.cui*/

  WriteWord("quit");  WriteWord("{ENTER}");

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

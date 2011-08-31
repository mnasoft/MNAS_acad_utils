//JScript
var WshShell = WScript.CreateObject("WScript.Shell");
var sleepTime=250;
if (WshShell.AppActivate("AutoCAD"))
{
/*Подключение путей поиска*/
  WriteWord("{ESC}");  WriteWord("{ESC}");  WriteWord("{ESC}");
  WriteWord("_options{ENTER}");
  WriteWord("%d");  WriteWord("C:\\Program Files\\MNASoft\\MNAS_acad_db17_utils{ENTER}");
  WriteWord("%d");  WriteWord("C:\\Program Files\\MNASoft\\MNAS_acad_db17_utils\\acad_w.sup{ENTER}");
  WriteWord("%d");  WriteWord("C:\\Program Files\\MNASoft\\MNAS_acad_db17_utils\\acad.mnu\\acad_mnu_icon{ENTER}");
  WriteWord("%d");  WriteWord("C:\\Program Files\\MNASoft\\MNAS_acad_db17_utils\\acad.fnt{ENTER}");
  WriteWord("%d");  WriteWord("C:\\Program Files\\MNASoft\\MNAS_acad_db17_utils\\acad.fnt\\kompas{ENTER}");
  WriteWord("{ENTER}");
/*Подключение путей поиска*/

/*Подключение меню c:\\acad.mnu\\M_utility.cui*/
  WriteWord("_cui");                 WScript.Sleep(500);
  WriteWord("{ENTER}");              WScript.Sleep(3000);
  WshShell.SendKeys("+{TAB}{END}");  WScript.Sleep(1000);
  WriteWord("C:\\Program Files\\MNASoft\\MNAS_acad_db17_utils\\acad.mnu\\M_utility.cui{ENTER}");  
  WriteWord("{ENTER}");              WScript.Sleep(500);

  WriteWord("+{TAB}+{TAB}+{TAB}+{TAB}+{TAB}+{TAB}");
  WriteWord("{ENTER}");              WScript.Sleep(12000);
/*Подключение меню c:\\acad.mnu\\M_utility.cui*/

  WriteWord("_quit{ENTER}");
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

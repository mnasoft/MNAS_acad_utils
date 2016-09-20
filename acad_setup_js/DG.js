//JScript
var WshShell = WScript.CreateObject("WScript.Shell");
var sleepTime=500;
if (WshShell.AppActivate("ObjectArx"))
{
	for(var i=160;i<1000;++i)
	{
		PrintInPDF(i);
	}
}

function CopyInDoc()
{
	WriteWord("{ENTER}");
	WriteWord("{ENTER}");
	WriteWord("{F6}");
	WriteWord("^a");
	WriteWord("^c");
	WshShell.AppActivate("Документ1");
	WriteWord("^v");
	WshShell.AppActivate("ObjectArx");
	WriteWord("{F6}");
	WriteWord("{DOWN}");		
}

function PrintInPDF(page_no)
{
	WriteWord("{ENTER}{ENTER}{F6}^p");
	SleepWhileNotAppActivate("Печать");	
	WriteWord("{TAB}{TAB}{TAB}{TAB}{ENTER}");
	SleepWhileNotAppActivate("Save PDF File As");	
	WriteInt(page_no);
	WriteWord("{TAB}{TAB}{ENTER}");
	SleepWhileNotAppActivate("Adobe");
	WriteWord("%{F4}");
	SleepWhileNotAppActivate("Adobe");
	WriteWord("%{F4}");
	SleepWhileNotAppActivate("ObjectArx");
	WriteWord("{F6}{DOWN}");		
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

function WriteInt(lll)
{
  var sss="";
  var num="0123456789";
  var tmp=lll;
  while(tmp>0)
  {
	var ttt=tmp%10;
	tmp=tmp-ttt;
	tmp=tmp/10;
	sss=num.substr(ttt,1)+sss;
  }
  WshShell.SendKeys(sss);
  WScript.Sleep(sleepTime);
}

function SleepWhileNotAppActivate(str) 
{
  while(!WshShell.AppActivate(str))
  {
    WScript.Sleep(sleepTime);
  }
}


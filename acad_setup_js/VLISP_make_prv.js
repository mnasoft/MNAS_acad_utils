//JScript
var WshShell = WScript.CreateObject("WScript.Shell");
var sleepTime=500;
var sleepTimeBig=1500;
if (WshShell.AppActivate("AutoCAD"))
{
    WScript.Sleep(sleepTime);
    MakeVlispPRV();
}

function MakeVlispPRV()
{
//Производит компиляцию проектов PRV. Предполагается, что активизировано окно AutoCAD
    WriteWord("vlisp{ENTER}");
//	acad_w_path="C:\\MNAS_acad_db17_utils\\acad_w.sup\\";
	acad_w_path="D:\\MNAS_acad_db17_utils\\acad_w.sup\\";
	
	WScript.Sleep(5000);
	
	MakePrv(acad_w_path + "spec\\spec.prv");
	MakePrv(acad_w_path + "razvertka\\razvertka.prv");
	MakePrv(acad_w_path + "provoloka\\provoloka.prv");
    MakePrv(acad_w_path + "M_utils_loader\\M_utils_loader.prv");
    MakePrv(acad_w_path + "ABREV\\Abrev.prv");
    MakePrv(acad_w_path + "Acad_pgp\\ACAD_PGP.prv");
    MakePrv(acad_w_path + "Add_prefix\\Add_prefix.prv");
    MakePrv(acad_w_path + "ATOMS\\atoms.prv");
    MakePrv(acad_w_path + "AXIS\\Axis.prv");
    MakePrv(acad_w_path + "AXIS\\axis_podp.prv");
    MakePrv(acad_w_path + "Big_fnt\\big_fnt.prv");
    MakePrv(acad_w_path + "CHANGE\\Change.prv");
    MakePrv(acad_w_path + "CIRCLES\\CIRCLES.PRV");
    MakePrv(acad_w_path + "CLOCK\\Clock.prv");
    MakePrv(acad_w_path + "DIMS\\dims.prv");
    MakePrv(acad_w_path + "DIMS\\rou\\rou.prv");
    MakePrv(acad_w_path + "DIMS\\rou_1\\rou_1.prv");
    MakePrv(acad_w_path + "DIMS\\welding\\Welding1.prv");

    MakePrv(acad_w_path + "Dxf\\dxf.prv");
    MakePrv(acad_w_path + "D_CHPROP\\D_chprop.prv");
    MakePrv(acad_w_path + "Edit\\EDIT.PRV");
    MakePrv(acad_w_path + "ENTMAKE\\ENTMAKE.prv");
    MakePrv(acad_w_path + "Exel\\Exel.prv");
    MakePrv(acad_w_path + "Format\\format.prv");
    MakePrv(acad_w_path + "Fors_rh\\fors_rh.prv");
    MakePrv(acad_w_path + "FOR_LIC\\For_lic.prv");
    MakePrv(acad_w_path + "GRAF\\Graf.prv");
    MakePrv(acad_w_path + "HPGL\\HPGL.prv");
    MakePrv(acad_w_path + "KOMPAS\\kompas.prv");
    MakePrv(acad_w_path + "LAYER\\layer.prv");
    MakePrv(acad_w_path + "LINES\\lines.prv");
    MakePrv(acad_w_path + "LOPATKA\\Lopatka.prv");
    MakePrv(acad_w_path + "MNAS\\Pozition\\pozition.prv");
    MakePrv(acad_w_path + "MNAS\\Welding\\welding.prv");
    MakePrv(acad_w_path + "Otvjerstija\\f_otv.prv");
    MakePrv(acad_w_path + "Piping\\pipe.prv");
    MakePrv(acad_w_path + "point\\point.prv");
    MakePrv(acad_w_path + "PRJ\\man\\man.prv");
    MakePrv(acad_w_path + "RENAME\\rename.prv");
    MakePrv(acad_w_path + "SCR\\scr.prv");
    MakePrv(acad_w_path + "Smesitel_vla\\SMESITEL_vla.prv");
    MakePrv(acad_w_path + "Sort_shp\\Sort_shp.prv");
    MakePrv(acad_w_path + "TEXT\\text.prv");

    MakePrv(acad_w_path + "DOPUSK\\Dopusk.prv");
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

function MakePrv(str) 
{
//Производит вызов Меню Vlisp Make_Application. Предполагает, что активно приложение Vlisp.
  WriteWord("%fmm");
  WriteWord(str);
  WriteWord("{ENTER}");
  WScript.Sleep(sleepTimeBig);

}



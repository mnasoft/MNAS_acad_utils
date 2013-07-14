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

//	acad_w_path="C:\\Users\\namatv\\Develop\\MNAS_acad_utils\\acad_w.sup\\";

//	acad_w_path="E:\\Data\\Develop\\MNAS_acad_utils\\acad_w.sup\\"

//	acad_w_path="C:\\Develop\\MNAS_acad_utils\\acad_w.sup\\";
//	acad_w_path="D:\\Develop\\MNAS_acad_utils\\acad_w.sup\\";
//	acad_w_path="D:\\home\\namatv\\Develop\\git_mnasoft\\MNAS_acad_utils\\acad_w.sup\\";
//	acad_w_path="O:\\Develop\\MNAS_acad_utils\\acad_w.sup\\"
	acad_w_path="E:\\home\\namatv\\git\\GitHub\\MNAS_acad_utils\\acad_w.sup\\";
	
	WScript.Sleep(3000);
	
MakePrv(acad_w_path + "abrev\\Abrev.prv");
MakePrv(acad_w_path + "acad_pgp\\ACAD_PGP.prv");
MakePrv(acad_w_path + "add_prefix\\Add_prefix.prv");
MakePrv(acad_w_path + "atoms\\atoms.prv");
MakePrv(acad_w_path + "axis\\Axis.prv");
MakePrv(acad_w_path + "axis\\axis_podp.prv");
MakePrv(acad_w_path + "big_fnt\\big_fnt.prv");
MakePrv(acad_w_path + "change\\Change.prv");
MakePrv(acad_w_path + "circles\\CIRCLES.prv");
MakePrv(acad_w_path + "clock\\Clock.prv");
MakePrv(acad_w_path + "dims\\dims.prv");
MakePrv(acad_w_path + "dims\\dim_style\\dim_style.prv");
MakePrv(acad_w_path + "dims\\rou\\rou.prv");
MakePrv(acad_w_path + "dims\\rou_1\\rou_1.prv");
MakePrv(acad_w_path + "dims\\welding\\Welding1.prv");

MakePrv(acad_w_path + "dxf\\dxf.prv");
MakePrv(acad_w_path + "d_chprop\\D_chprop.prv");
MakePrv(acad_w_path + "edit\\EDIT.prv");
MakePrv(acad_w_path + "entmake\\ENTMAKE.prv");
MakePrv(acad_w_path + "exel\\Exel.prv");
MakePrv(acad_w_path + "format\\format.prv");
MakePrv(acad_w_path + "fors_rh\\fors_rh.prv");
MakePrv(acad_w_path + "for_lic\\For_lic.prv");
MakePrv(acad_w_path + "graf\\Graf.prv");
MakePrv(acad_w_path + "hpgl\\HPGL.prv");
MakePrv(acad_w_path + "kompas\\kompas.prv");
MakePrv(acad_w_path + "layer\\layer.prv");
MakePrv(acad_w_path + "lines\\lines.prv");
MakePrv(acad_w_path + "lopatka\\Lopatka.prv");
MakePrv(acad_w_path + "man\\man.prv");
MakePrv(acad_w_path + "mnas\\Pozition\\pozition.prv");
MakePrv(acad_w_path + "mnas\\Welding\\welding.prv");
MakePrv(acad_w_path + "mnas\\Welding_lsp\\welding_lsp.prv");
MakePrv(acad_w_path + "M_utils_loader\\M_utils_loader.prv");
MakePrv(acad_w_path + "otvjerstija\\f_otv.prv");
MakePrv(acad_w_path + "piping\\pipe.prv");
MakePrv(acad_w_path + "point\\point.prv");
MakePrv(acad_w_path + "prj\\arx_dbx_reg\\create_registry.prv");
MakePrv(acad_w_path + "prj\\Spring\\Spring.prv");
MakePrv(acad_w_path + "provoloka\\provoloka.prv");
MakePrv(acad_w_path + "razvertka\\razvertka.prv");
MakePrv(acad_w_path + "rename\\rename.prv");
MakePrv(acad_w_path + "scr\\scr.prv");
MakePrv(acad_w_path + "smesitel_vla\\SMESITEL_vla.prv");
MakePrv(acad_w_path + "sort_shp\\Sort_shp.prv");
MakePrv(acad_w_path + "spec\\spec.prv");
MakePrv(acad_w_path + "text\\text.prv");

MakePrv(acad_w_path + "dopusk\\Dopusk.prv");
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



;;;scr = �������������("MSScriptControl.ScriptControl");
;;;scr.language = "javascript";
;;;scr.eval("������=new Array()");
;;;������ = scr.eval("������");
;;;scr.AddCode("function SetItem(ind,val){������[ind]=val}");
;;;ServiceManager=�������������("com.sun.star.ServiceManager");
;;;scr.AddObject("ServiceManager",ServiceManager);
;;;Desktop = ServiceManager.createInstance("com.sun.star.frame.Desktop");
;;;Document = Desktop.LoadComponentFromURL("private:factory/scalc", "_blank", 0, ������);
;;;����� = Document.getSheets();
;;;���� = �����.getByIndex(0);
;;;��� � = 0 �� 10 ����
;;;   ����.getCellByPosition(0,�).value = �;
;;;����������;
;;;SaveParam = scr.Eval("ServiceManager.Bridge_GetStruct('com.sun.star.beans.PropertyValue')");
;;;SaveParam.Name = "FilterName";
;;;SaveParam.Value = "MS Excel 97";
;;;scr.CodeObject.SetItem(0,SaveParam);
;;;Document.storeToURL("file:///c:/Test.xls",������);

(vl-load-com)

(setq so (vlax-get-or-create-object "com.sun.star.ServiceManager") )
(setq Desktop (vlax-invoke so 'createInstance "com.sun.star.frame.Desktop"))
(setq Document (vlax-invoke-method Desktop 'LoadComponentFromURL "private:factory/scalc" "_blank" 0 ������))
"C:\\Program Files\\OpenOffice.org 3\\program\\scalc.exe"
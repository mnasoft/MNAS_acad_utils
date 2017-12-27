;;;scr = СоздатьОбъект("MSScriptControl.ScriptControl");
;;;scr.language = "javascript";
;;;scr.eval("Массив=new Array()");
;;;Массив = scr.eval("Массив");
;;;scr.AddCode("function SetItem(ind,val){Массив[ind]=val}");
;;;ServiceManager=СоздатьОбъект("com.sun.star.ServiceManager");
;;;scr.AddObject("ServiceManager",ServiceManager);
;;;Desktop = ServiceManager.createInstance("com.sun.star.frame.Desktop");
;;;Document = Desktop.LoadComponentFromURL("private:factory/scalc", "_blank", 0, Массив);
;;;Листы = Document.getSheets();
;;;Лист = Листы.getByIndex(0);
;;;Для к = 0 По 10 Цикл
;;;   Лист.getCellByPosition(0,к).value = к;
;;;КонецЦикла;
;;;SaveParam = scr.Eval("ServiceManager.Bridge_GetStruct('com.sun.star.beans.PropertyValue')");
;;;SaveParam.Name = "FilterName";
;;;SaveParam.Value = "MS Excel 97";
;;;scr.CodeObject.SetItem(0,SaveParam);
;;;Document.storeToURL("file:///c:/Test.xls",Массив);

(vl-load-com)

(setq so (vlax-get-or-create-object "com.sun.star.ServiceManager") )
(setq Desktop (vlax-invoke so 'createInstance "com.sun.star.frame.Desktop"))
(setq Document (vlax-invoke-method Desktop 'LoadComponentFromURL "private:factory/scalc" "_blank" 0 Массив))
"C:\\Program Files\\OpenOffice.org 3\\program\\scalc.exe"
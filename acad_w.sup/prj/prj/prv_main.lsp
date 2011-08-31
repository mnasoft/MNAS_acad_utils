;;;;;;("prv_main"
;;;;;;"
;;;;;;Формирует строки для вставки в файл C:/Acad.mnu/acad_setup/VLISP_make_prv.js,\n
;;;;;;служащий для пакетной перекомпиляции prv-проектов prv.\n
;;;;;;Указания к применению.\n
;;;;;;1) Выполните следующую команду Shell для каталога, содержащего файлы prv-проектов:\n
;;;;;;DIR /S /B *.prv >list_prv\n
;;;;;;2) Выполните команду prv_main. В далоговом окне выберите образованный вновь файл list_prv.\n
;;;;;;В результате выполнения команды на консоль ACAD будет выведен список файлов,\n
;;;;;;содержащий полные имена файлов проектов. Имена фойлов будут заключены в кавычки и оформлены как вызов функции.\n
;;;;;;3) Скопируйте результат вывода из консоли ACAD в файл C:/Acad.mnu/acad_setup/VLISP_make_prv.js.
;;;;;;4) Запустите на выполнение C:/Acad.mnu/acad_setup/VLISP_make_prv.js.
;;;;;;5) Выполните в консоли Visual Lisp функцию (make_lst g:fn_full_prj_lst).
;;;;;;" "not defined")

(defun c:prv_main (/ fn_list_prj do fl_list_prj path)
  (setq	fn_list_prj (getfiled "Откройте файл, содержащий проекты" (strcat (acad_sup) "/list_prv") "" 0)
	fl_list_prj (open fn_list_prj "r")
	do t
  )
  (cond
    ((/= 'str (type fn_list_prj))
     (alert (princ "Переменная fn_list_prj не содержит имени файла."))
    )
    ((null fl_list_prj)
     (alert
       (princ
	 (strcat "Не могу открыть файл: " fn_list_prj ".")
       )
     )
     (exit)
    )
  )
  (while (setq path (READ-LINE fl_list_prj))
    (princ "    MakePrv(")
    (prin1 path)
    (princ ");\n")
  )
  (close fl_list_prj)
  (princ)
)

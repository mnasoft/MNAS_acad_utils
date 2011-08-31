(defun form_reg_for_dbx_app (app-name ; Имя приложения
			     db_version ; Версия базы данных
			     LOADCTRLS ;
			     ObjectDBX-lst ;Поддерживаемая версия бд ACAD и N ACAD
			    )
	       ;  (princ "Windows Registry Editor Version 5.00" reg_file)
  (mapcar
    (function
      (lambda (el)
	(princ (strcat "\n\n\n"	"[" el "\\Applications\\" app-name "APP]")
	       reg_file
	)
;;;	(princ (strcat "\n" "\"LOADER\"=\"[CommonFilesFolder]Autodesk Shared/" app-name "_" db_version ".dbx\"")	       reg_file	)
	(princ (strcat "\n" "\"LOADER\"=\"[TARGETDIR]" app-name "_" db_version ".dbx\"")	       reg_file	)
	(princ (strcat "\n" "\"LOADCTRLS\"=" LOADCTRLS) reg_file)
	(princ (strcat "\n" "\"DESCRIPTION\"=\"" app-name "APPObj\"") reg_file)
      )
    )
    ObjectDBX-lst
  )
  (princ "\n\n\n" reg_file)
  (princ)
)


(defun form_reg_for_arx_app
			    ( ;fl							; Дескриптор для результирующего файла реестра
			     app-name ; Имя приложения
			     db_version ; Версия базы данных
			     LOADCTRLS ;
			     Commands ;Команды
			     acad-lst ;Поддерживаемая версия бд ACAD и N ACAD
			     / acad-bd ; Поддерживаемая версия бд ACAD
			     acad-num ; Поддерживаемый N ACAD
)
	       ;  (princ "Windows Registry Editor Version 5.00")
  (mapcar
    (function
      (lambda (el / acad-bd acad-num)
	;(setq acad-bd (car el))
	;(setq acad-num (cadr el))

	(princ
	  (strcat "\n\n\n\n" "[" el "\\Applications\\" app-name "]")
	  reg_file
	)
	(princ (strcat "\n" "\"LOADER\"=\"[TARGETDIR]" app-name "_" db_version ".arx\"") reg_file)
	(princ (strcat "\n" "\"DESCRIPTION\"=\"" app-name "\"") reg_file)
	(princ (strcat "\n" "\"LOADCTRLS\"=" LOADCTRLS) reg_file)
	(if Commands
	  (progn
	    (princ
	      (strcat "\n\n" "[" el "\\Applications\\" app-name "\\Commands]")
	      reg_file
	    )
	    (mapcar
	      (function
		(lambda	(el)
		  (princ (strcat "\n" "\"" (car el) "\"=\"" (cadr el) "\"") reg_file)
		)
	      )
	      Commands
	    )
	    (princ
	      (strcat "\n\n" "[" el "\\Applications\\" app-name "\\Groups]")
	      reg_file
	    )
	    (princ (strcat "\n" "\"" app-name "\"=\"" app-name "\"") reg_file)
	  )
	)
      )
    )
    acad-lst
  )
  (princ "\n\n\n" reg_file)
  (princ)
)


(defun suppoted_acad_relaeses ()
  '(("R16.0" "ACAD-201:409")
    ("R16.0" "ACAD-203:409")
    ("R16.1" "ACAD-301:409")
    ("R16.1" "ACAD-303:419")
    ("R16.2" "ACAD-4001:409")
    ("R16.2" "ACAD-4005:409")
    ("R16.2" "ACAD-4013:409")
   )
)

;;;_$ (registry-subdirs '("HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD"))
;;;("HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD\\R17.1" "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD\\R16.2")
(defun registry-subdirs	(root_dirs_lst / rez_lst)
  (setq	rez_lst
		(mapcar
		  (function
		    (lambda (el_1)
		      (mapcar
			(function
			  (lambda (el) (strcat el_1 "\\" el))
			)
			(vl-registry-descendents el_1)
		      )
		    )
		  )
		  root_dirs_lst
		)
	rez_lst	(apply 'append rez_lst)
  )
)

(defun restrict_not_match(str_lst match / tmp)
  (mapcar
    (function
      (lambda (el)
	(if (wcmatch el (strcat "*" match "*"))
	  (progn
	    (setq tmp (cons el tmp))
	  )
	)
      )
    )
    str_lst
  )
  tmp
)

;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

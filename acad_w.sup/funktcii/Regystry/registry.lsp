;;;f;;;("string-subst-all(new_substr olg_sustr str)"
;;;f;;;"Производит замену всех вхождений olg_sustr на new_substr для строки str.")
(defun string-subst-all	(new_substr olg_sustr str / do_while old_str)
  (setq do_while t)
  (while do_while
    (setq
      old_str str
      str     (vl-string-subst new_substr olg_sustr str)
    )
    (if	(= old_str str)
      (setq do_while nil)
    )
  )
  str
)


;(find-reg-tree "HKEY_CURRENT_USER\\SOFTWARE\\Autodesk\\AutoCAD")
(defun find-reg-tree (str / curr lst lst_fin reg reg-key)
  (setq lst (list str))
  (while lst
    (setq
      reg     (car lst)
      lst_fin (append lst_fin (list reg))
      lst     (cdr lst)
      reg-key (mapcar
		(function
		  (lambda (el)
		    (strcat reg "\\" el)
		  )
		)
		(vl-sort (vl-registry-descendents reg) (function <))
	      )
      lst     (append reg-key lst)
    )
  )
  lst_fin
  t
)






;(delete-reg-tree "HKEY_CURRENT_USER\\SOFTWARE\\Autodesk\\AutoCAD")
(defun delete-reg-tree (str)
  (mapcar
    (function
      (lambda (el)
	(vl-registry-delete el)
      )
    )
    (reverse (find-reg-tree str))
  )
)

;(delete-reg-tree-js-generate "HKEY_CURRENT_USER\\SOFTWARE\\Autodesk\\AutoCAD")
(defun delete-reg-tree-js-generate (str / fn fl)
  (setq
    fn (getfiled "Имя js-script" "del_acad_reg" "js" 1)
  )
  (if (null fn)
    (progn (alert (princ (strcat "\nИмя файла не задано.\n")))
	   (exit)
    )
  )
  (setq
    fl (open fn "w")
  )
  (if (null fl)
    (progn
      (alert
	(princ
	  (strcat
	    "\nНе могу открыть файл: "
	    fn
	    ".\n"
	  )
	)
      )
      (exit)
    )
  )
  (princ "WshShell=WScript.CreateObject(\"WScript.Shell\");" fl)
  (princ "\n" fl)
  (mapcar
    (function
      (lambda (el)
	(princ "WshShell.RegDelete(" fl)
	(prin1 el fl)
	(princ ");\n" fl)
      )
    )
    (reverse (find-reg-tree str))
  )
  (close fl)
)
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

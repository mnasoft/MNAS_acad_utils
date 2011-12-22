(defun print_html (/ fn)
  (setq
    fn (getfiled "Укажите файла для вывода" "Spring" "html" 1)
    fl (open fn "w")
  )
  (princ "<html>" fl)
  (princ "<head>" fl)
  (princ "</head>" fl)
  
  (princ "<body>" fl)
  (princ "<table border=\"2\" > \n <CAPTION ALIGN=\"top\">Результаты расчета пружины</CAPTION>" fl)
  (princ (strcat "<tr>" "<th>" "Нименование" "</th>" "<td>" "Обозначение" "</th>" "<th>" "Значение" "</th>" "</tr>" "\n" )fl)

  (mapcar
    (function
      (lambda (el1 el2)
	(princ (strcat "<tr>" "<td>" (cadr el2) "</td>" "<td>" (car el1) "</td>" "<td>" (cadr el1) "</td>" "</tr>" "\n" )fl)
      )
    )
    setup_lst
    setup_msg
  )
  (princ "</table>" fl)
  (princ "</body>" fl)
  (princ "</html>" fl)
  (close fl)
)
;|«Visual LISP© Format Options»
(72 2 25 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

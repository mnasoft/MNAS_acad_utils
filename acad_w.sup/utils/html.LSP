(defun table (str_head lst_head lst_table fl)
  (table_open fl)
  (tr_open fl)
  (mapcar
    (function
      (lambda (el)
	(th el fl)
      )
    )
    lst_head
  )
  (tr_close fl)
  (mapcar
    (function
      (lambda (lst)
	(tr_open fl)
	(mapcar
	  (function
	    (lambda (el)
	      (td el fl)
	    )
	  )
	  lst
	)
	(tr_close fl)
      )
    )
    lst_table
  )
  (table_close fl)
)


(defun table_open(fl)
  (princ "<table>\n" fl)
)

(defun table_close(fl)
  (princ "</table>\n" fl)
)

(defun td(str fl)
  (princ "<td>" fl)
  (princ str fl)
  (princ "<td>" fl)
)

(defun th(str fl)
  (princ "<th>" fl)
  (princ str fl)
  (princ "</th>" fl)
)

(defun tr_open(fl)
  (princ "<tr>\n" fl)
)

(defun tr_close(fl)
  (princ "</tr>\n" fl)
)

(setq
  fn "D:/home/_namatv/Site/Izdelija/Izdelije_Index.txt"
  fl (open fn "r")
  lst_izd nil
)

(while (setq str (read-line fl))
  (setq lst_izd (append lst_izd (list (list str)) ))
)
(close fl)

(setq
  fn "D:/home/_namatv/Site/Izdelija/Izdelije_Index.html"
  fl (open fn "w")
)
(table "str_head" '("Изделие")  lst_izd fl)
(close fl)

;|«Visual LISP© Format Options»
(105 2 40 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** НЕ добавляйте текст под комментариями! ***|;

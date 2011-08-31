;;;(princ "\nЗагружаю sort_shp/sort_shp   ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "sort_shp/sort_shp   "))

;;;;;;("sort_shp" "Cортировка символов находящихся в shp - файле." "not defined")
(defun c:sort_shp (/	      f_in    f_out   head    i	      i_nhv   ll_hv
	      ll_nhv  ll_npp  ll_str  n_f_in  n_f_out str     val
	     )
  (setq	n_f_in
	       (getfiled
		 "Выберите Shp файл для упорядочивания форм по возрастанию номеров"
		 ""
		 "shp"
		 2
	       )
	f_in   (open n_f_in "r")
	head   ""
	val    ""
  )
  (cond
    ((/= 'str (type n_f_in))
     (alert (princ "Переменная n_f_in не содержит имени файла."))     
    )
    ((null f_in)
     (alert(princ(strcat "Не могу открыть файл: " n_f_in ".")))
     (exit)
    )
  )
  (while (setq str (read-line f_in))
    (setq ll_str (append ll_str (list str)))
  )
  (close f_in)

  (setq	n_f_out
		(getfiled
		  "Имя  Shp-файла для вывода отсортированных форм"
		  ""
		  "shp"
		  1
		)
	f_out	(open n_f_out "w")
  )
  (cond
    ((/= 'str (type n_f_out))
     (alert (princ "Переменная n_f_out не содержит имени файла."))     
    )
    ((null f_out)
     (alert(princ(strcat "Не могу открыть файл: " n_f_out ".")))
     (exit)
    )
  )

  (mapcar
    (function
      (lambda (el)
	(cond
	  ((= "*" (substr el 1 1))
	   (setq
	     ll_hv (append ll_hv (list (list head val)))
	     head  el
	     val   ""
	   )
	  )
	  (t (setq val (strcat val el)))
	)
      )
    )
    ll_str
  )
  (setq
    ll_hv (cdr ll_hv)
    ll_hv (append ll_hv (list (list head val)))
  )
  (setq
    ll_nhv
     (mapcar
       (function
	 (lambda (el / sh_str sh_no)
	   (setq
	     sh_str (strcase (car (str_token (car el) "*,")))
	     sh_no  (cond
		      ((= sh_str (strcase "Degree_Sign")) 256)
		      ((= sh_str (strcase "Plus_Or_Minus_Sign")) 257)
		      ((= sh_str (strcase "Diameter_Symbol")) 258)
		      (t
		       (atoi sh_str)
		      )
		    )
	   )
	   (cons sh_no el)
	 )
       )
       ll_hv
     )
  )
  (setq
    i (apply (function max) (mapcar (function car) ll_nhv))
  )
  (while (>= i 0)
    (setq
      i_nhv (assoc i ll_nhv)
      i	    (1- i)
    )
    (cond
      (i_nhv (setq ll_npp (cons i_nhv ll_npp)))
    )
  )

  (mapcar      ;Вывод на печать
    (function
      (lambda (el)
	(princ (cadr el) f_out)
	(princ "\n" f_out)
	(mapcar
	  (function
	    (lambda (el1)
	      (princ el1 f_out)
	      (princ "\n" f_out)
	    )
	  )
	  (ff1 (caddr el) 80)
	)
      )
    )
    ll_npp
  )
  (close f_out)
  (princ)
)

;;; ff1 Разбивает строку на подстроки используя в качестве разделителя запятую.
(defun ff1 (str len / ch i l_str str_i_e str_len str_s_i)
  (while (>= (setq str_len (strlen str)) len)
    (setq i len)
    (while (>= i 1)
      (setq ch (substr str i 1))
      (cond
	((= ch ",")
	 (setq
	   str_i_e (substr str (1+ i))
	   str_s_i (substr str 1 i)
	   l_str   (append l_str (list str_s_i))
	   str	   str_i_e
	   i	   0
	 )
	)
      )
      (setq i (1- i))
    )
  )
  (setq l_str (append l_str (list str)))
  l_str
)

(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(72 2 15 2 nil "end of" 60 20 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

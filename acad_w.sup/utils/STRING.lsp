;;;(princ "\nЗагружаю utils/string        ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "utils/string        "))
       
;;	str_token(str div)
;;	Разбивает строку str на список подстрок по символам- разделителям
;;	находящимся в строке div. Символы-разделители исключаются из строки.
;;	(str_token "55.050 5.05 5650.05 07.0 " " .")
;;	("55" "050" "5" "05" "5650" "05" "07" "0")
(defun str_token (str div / add i k s1 d1 stmp lstr)
  (setq	i 0
	stmp ""
  )
  (repeat (strlen str)
    (setq i   (1+ i)
	  s1  (substr str i 1)
	  k   0
	  add t
    )
    (repeat (strlen div)
      (setq k  (1+ k)
	    d1 (substr div k 1)
      )
      (if (= s1 d1)
	(setq add nil)
      )
    )
    (if	add
      (setq stmp (strcat stmp s1))
      (progn
	(if (/= stmp "")
	  (setq lstr (cons stmp lstr))
	)
	(setq stmp "")
      )
    )
  )
  (if (/= stmp "")
    (setq lstr (cons stmp lstr))
  )
  (reverse lstr)
)

(defun string-subst-all (new-str pattern string / do)
  (setq do t)
  (while do
    (setq str-rez (vl-string-subst new-str pattern string))
    (if (/= str-rez string)
      (setq string str-rez)
      (setq do nil)
    )
  )
  string
)

(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

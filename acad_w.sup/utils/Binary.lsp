;;;(princ "\nЗагружаю utils/binary        ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "utils/binary        "))

;;; bin_or - Возвращает список из неповторяющиеся элементов				;;;

;;; bin_and - AND-операция над списками, возвращает список элементы которого 		;;;
;;; присутствуют в L_1 и в L_2								;;;

;;; bin_xor - XOR-операция над списком, в качестве битов элементы списка.		;;;

(defun bin_or (l_1 / l_2)
  (mapcar
    (function
      (lambda (el)
	(if (null (member el l_2))
	  (setq l_2 (cons el l_2))
	)
	t
      )
    )
    l_1
  )
  l_2
)

(defun bin_and (l_1 l_2 / l_3 l_4)
  (setq l_3 (append l_1 l_2))
  (mapcar
    (function
      (lambda (el)
	(if
	  (and
	    (member el l_1)
	    (member el l_2)
	    (null (member el l_4))
	  )
	   (setq l_4 (cons el l_4))
	)
	t
      )
    )
    l_3
  )
  l_4
)

(defun bin_xor (l_1 / l_2 temp)
  (mapcar
    (function
      (lambda
	(el / temp rez)
	 (setq temp l_1)
	 (while	temp
	   (setq
	     temp (member el temp)
	     rez  (if temp
		    (if	rez
		      nil
		      t
		    )
		    rez
		  )
	     temp (cdr temp)
	   )
	 )
	 (if (and rez (null (member el l_2)))
	   (setq l_2 (cons el l_2))
	 )
	 t
      )
    )
    l_1
  )
  l_2
)

(princ "\t...загружен.\n")
 ;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

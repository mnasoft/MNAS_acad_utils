;;;(princ "\nЗагружаю Otvjerstija/f_otv     ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "Otvjerstija/f_otv     "))

(defun f_otv (d) (* 0.25 pi d d))

(defun d_ek (f)
  (sqrt (/ (* 4.0 f) pi))
)

;;; Прощадь жиклера

(defun f_zikl (f_e ; - эквивалентная площадь всех сопротивлений которую необходимо получить за счет постновки жиклера.
	       f_1 ; - эквивалентная площадь всех остальных сопротивлений.
	       )
  (sqrt
    (/ 1.0
       (- (/ 1.0 (* f_e f_e)) (/ 1.0 (* f_1 f_1)))
    )
  )
)

;;; Вычисляет площадь, эквивалентную площади последовательно расположенных сопротивлений.
;;; Предполагается, что среда протекающая через площади не сжимается.
(defun f_ek_zikl (l_f ; - список, содержащий проходные сечения.
		  /	;
		  zero	;
		 )
  (mapcar (function (lambda (el)
		      (if (ZEROP el)
			(setq zero t)
		      )
		    )
	  )
	  l_f
  )
  (cond
    (zero 0.0)
    (t
     (sqrt
       (/ 1.0
	  (apply
	    (function +)
	    (mapcar
	      (function
		(lambda	(el)
		  (/ 1.0 (* el el))
		)
	      )
	      l_f
	    )
	  )
       )
     )
    )
  )
)






;;;;;;("f_kolca" "Вычисление площади кольца." "Расчеты")
(defun c:f_kolca (/ area p1 p1-p2 p2 p_mid p_mid-p_os p_os)
  (setq	p1	   (getpoint "Введите 1 точку на кольце:")
	p2	   (getpoint p1 "Введите 2 точку на кольце:")
	p_mid	   (mapcar
		     (function
		       (lambda (el1 el2)
			 (/ (+ el1 el2) 2.0)
		       )
		     )
		     p1
		     p2
		   )
	p_os	   (getpoint p_mid "Кратчайшее расстояние до оси:")
	p1-p2	   (distance p1 p2)
	p_mid-p_os (distance p_mid p_os)
	area	   (* p1-p2 p_mid-p_os 2.0 pi)
  )
  (princ "\nДлина кольца p1-p2: ")
  (princ p1-p2)
  (princ "\nРадиус кольца p_mid-p_os: ")
  (princ p_mid-p_os)
  (princ "\nПлощадь: ")
  (princ area)
  (princ)
)

(defun f_kolca (/ area p1 p1-p2 p2 p_mid p_mid-p_os p_os)
  (setq	p1	   (getpoint "Введите 1 точку на кольце:")
	p2	   (getpoint p1 "Введите 2 точку на кольце:")
	p_mid	   (mapcar
		     (function
		       (lambda (el1 el2)
			 (/ (+ el1 el2) 2.0)
		       )
		     )
		     p1
		     p2
		   )
	p_os	   (getpoint p_mid "Кратчайшее расстояние до оси:")
	p1-p2	   (distance p1 p2)
	p_mid-p_os (distance p_mid p_os)
	area	   (* p1-p2 p_mid-p_os 2. pi)
  )
  (princ "\nДлина кольца p1-p2: ")
  (princ p1-p2)
  (princ "\nРадиус кольца p_mid-p_os: ")
  (princ p_mid-p_os)
  (princ "\nПлощадь: ")
  (princ area)
  area
)

(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

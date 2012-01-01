;;Функция выводит характеристики пружины в табличной форме для просмотра в интернет браузере.
(defun print_html (/ fn fl)
  (setq
    fn (getfiled "Укажите файла для вывода" "Spring" "html" 1)
    fl (open fn "w")
  )
  (princ "<html>" fl)
  (princ "<head>" fl)
  (princ "</head>" fl)

  (princ "<body>" fl)
  (princ
    "<table border=\"2\" > \n <CAPTION ALIGN=\"top\">Результаты расчета пружины</CAPTION>"
    fl
  )
  (princ (strcat "<tr>"	      "<th>"	   "Нименование"
		 "</th>"      "<td>"	   "Обозначение"
		 "</th>"      "<th>"	   "Значение"	"</th>"
		 "</tr>"      "\n"
		)
	 fl
  )

  (mapcar
    (function
      (lambda (el1 el2)
	(princ (strcat "<tr>"
		       "<td>"
		       (cadr el2)
		       "</td>"
		       "<td>"
		       (car el1)
		       "</td>"
		       "<td>"
		       (cadr el1)
		       "</td>"
		       "</tr>"
		       "\n"
	       )
	       fl
	)
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

(defun get_key(key)
  (atof (cadr (assoc key setup_lst)))
)

(defun print_key(str)
  (princ (strcat  "\n" str "="))  (princ (eval(read str)))  
)

;;Функция производит отрисовку пружины.
(defun draw (/		 ;
	     p0		 ; Начало пружины (левая точка на оси пружины);
	     a		 ; Направление оси пружины;
	     L_rab	 ; Длина пружины в рабочем положении;
	     _d		 ; Диаметр проволоки;
	     D		 ; Средний диаметр пружины;
	     _n		 ; Количество полных витков;
	     _t		 ; Шаг витков
	     _d		 ; Диаметр проволоки
	     p1	    p2	   p2_1	  p2_1_1 p2_2	p2_2_1 p2_2_2 p3
	     p3_1   p3_1_1 p3_2	  p3_2_1 p3_2_2
	    )
  (setq p0 (getpoint "Начало пружины:"))
  (setq a (getangle p0 "Направление оси пружины:"))
  (setq
    L_rab (getdist p0 "Длина пружины:")
    _d	  (get_key "d")
    _n	  (get_key "n")
    D	  (get_key "D")
    _t	  (/ (- L_rab (* 1.5 _d)) _n)
  )
;;;  (dr:point p0 0)
  (setq p1 (polar p0 a L_rab))
;;;  (dr:point p1 0)
  (setq p2 (polar p0 a (* 0.75 _d)))
  (setq p3 (polar p1 (+ a pi) (* 0.75 _d)))
;;;  (dr:point p2 1)
;;;  (dr:point p3 2)
  (setq p2_1 (polar p2 (+ a (* pi 0.5)) (* 0.5 D)))
  (setq p2_2 (polar p2 (+ a (* pi -0.5)) (* 0.5 D)))
;;;  (dr:point p2_1 3)
;;;  (dr:point p2_2 4)
  (setq p3_1 (polar p3 (+ a (* pi 0.5)) (* 0.5 D)))
  (setq p3_2 (polar p3 (+ a (* pi -0.5)) (* 0.5 D)))
;;;  (dr:point p3_1 3)
;;;  (dr:point p3_2 4)
  (mapcar
    (function dr-cl)
    (div_pnts p2_1 p3_1 _n)
  )
  (setq p2_2_1 (polar p2_2 a (* _t 0.5)))
  (setq p3_2_1 (polar p3_2 a (* _t -0.5)))

  (mapcar
    (function dr-cl)
    (div_pnts p2_2_1 p3_2_1 (1- _n))
  )
  (setq p2_1_1 (polar p2_1 a (* _d -1.0)))
  (setq p3_1_1 (polar p3_1 a (* _d 1.0)))

  (dr:arc p2_1_1
	  (* 0.5 _d)
	  (- a (/ pi 3.0))
	  (+ a (/ pi 3.0))
	  0
  )
  (dr:arc p3_1_1
	  (* 0.5 _d)
	  (+ a (/ pi 1.5))
	  (- a (/ pi 1.5))
	  0
  )

  (setq p2_2_2 (polar p2_2 a (* _d -0.75)))
  (setq p3_2_2 (polar p3_2 a (* _d 0.75)))
  (dr:arc p2_2_2
	  (* 0.5 _d)
	  (- a (* 0.5 pi))
	  (+ a (* 0.5 pi))
	  0
  )
  (dr:arc p3_2_2
	  (* 0.5 _d)
	  (+ a (* 0.5 pi))
	  (- a (* 0.5 pi))
	  0
  )
  (dr:line p0 p1 0)
  (dr:line (polar p0 (+ a (* pi 0.5)) (* D 0.5)) (polar p1 (+ a (* pi 0.5)) (* D 0.5)) 0)
  (dr:line (polar p0 (+ a (* pi -0.5)) (* D 0.5)) (polar p1 (+ a (* pi -0.5)) (* D 0.5)) 0)
)

(defun dr-cl (el)
  (dr:circle el (* 0.5 _d) 0)
;  (dr:line (polar el a (* 0.5 _d)) (polar el a (* -0.5 _d)) 0 )
  (dr:line (polar el (+ a (* pi 0.5)) (* 0.5 _d)) (polar el (+ a (* pi 0.5)) (* -0.5 _d)) 0 )
)


(defun div_pnts	(p1 p2 n / lst i )
  (setq	lst (cons p2 lst)
	i   n
  )
  (while (>= (setq i (1- i)) 1)
    (setq lst
	   (cons
	     (polar p1 (angle p1 p2) (* i (/ (distance p1 p2) n)))
	     lst
	   )
    )
  )
  (setq lst (cons p1 lst))
  lst
)
;|«Visual LISP© Format Options»
(72 2 25 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

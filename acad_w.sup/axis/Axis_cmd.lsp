;;;;;;("a1"
;;;;;;"Построение полилинии в координатах двух шкал.\n
;;;;;; Задаются:\n
;;;;;; 1) ось Х;\n
;;;;;; 2) ось Y;\n
;;;;;; 3) имя переменной, которое содержит список точек." "Шкалы")
(defun c:a1 (/ scx scy str pts)
  (alert
    "Построение полилинии в координатах двух шкал
Задаются:
1) ось Х;
2) ось Y;
3) имя переменной, которое содержит список точек.
Чтобы преобразовать отрезок в ось нужно воспользоваться командой ea." 
  )
  (setq	scx (sh:get (sh:sel "Ось X"))
	scy (sh:get (sh:sel "Ось Y"))
	str (getstring "\nИмя переменной содержащей список точек:")
  )
  (print (vl-doc-ref(read str)))
  (setq
	pts
	    (mapcar
	      (function
		(lambda	(el)
		  (sc:pxy_pt el scx scy)
		)
	      )
	      (vl-doc-ref(read str))
	    )
  )
  (dr:pline pts 256)
)

;;;;;;("an" "Построение семейства полилиний в координатах двух шкал.\n
;;;;;;Задаются:\n
;;;;;; 1) ось Х;\n
;;;;;; 2) ось Y;\n
;;;;;; 3) имя переменной, которое содержит список точек.\n
;;;;;;Примечание: чтобы преобразовать отрезок в ось нужно воспользоваться командой ea." "Шкалы")
(defun c:an (/ scx scy str pts x a i_colors colors)
  (alert
    "Построение семейства полилиний в координатах двух шкал
Задаются:
1) ось Х;
2) ось Y;
3) имя переменной, которое содержит список точек.
Чтобы преобразовать отрезок в ось нужно воспользоваться командой ea.
" )
  (setq	scx (sh:get (sh:sel "Ось X"))
	scy (sh:get (sh:sel "Ось Y"))
	str (getstring "\nИмя переменной содержащей список точек:")
  )

  (setq
    i_colors 0
    colors
     '(1 2 3 4 5 6 7 25 45 65 85 105 125 145 165 185 205 225 245)
  )
  (print (vl-doc-ref (read str)))
  (setq pts (vl-doc-ref (read str)))

  (setq	pts (transpon pts)
	x   (car pts)
	a   (cdr pts)
  )

  (mapcar
    (function
      (lambda (el / p)
	(setq
	  p
	    (mapcar (function (lambda (el_x el_y) (list el_x el_y)))
		    x
		    el
	    )
	  p
	    (mapcar
	      (function
		(lambda	(el)
		  (sc:pxy_pt el scx scy)
		)
	      )
	      p
	    )
	)
	(dr:pline p (nth i_colors colors))
	(setq i_colors (1+ i_colors))
      )
    )
    a
  )
)


;;;;;;("a2"
;;;;;;"Построение точки в координатах шкалы.\n
;;;;;; Задаются:\n
;;;;;; 1) ось Х;\n
;;;;;; 2) координата X." "Шкалы")
(defun c:a2 (/ sc)
  (alert
    "Построение точки в координатах шкалы
Задаются:
1) ось Х;
2) координата X."
  )
  (setq sc (sh:get (sh:sel "Выберите ось:")))
  (while (setq x (getreal "Введите X :"))
    (dr:point (sc:val_pt x sc) 256)
  )
  (princ)
)

;;;;;;("a2t"
;;;;;;"Построение точки в координатах шкалы и нанесение текста.\n
;;;;;; Задаются:\n
;;;;;; 1) ось Х;\n
;;;;;; 2) координата X." "Шкалы")
(defun c:a2t (/ sc pt)
  (alert
    "Построение точки в координатах шкалы
Задаются:
1) ось Х;
2) координата X."
  )
  (setq sc (sh:get (sh:sel "Выберите ось:")))
  (while (setq x (getreal "Введите X :"))
    (setq pt  (sc:val_pt x sc) )
    (dr:point pt 256)
    (dr:text (rtos x) pt 3.5 0.0 256)
  )
  (princ)
)

;;;;;;("a2xy_t"
;;;;;;"Построение линий в координатах шкалы и нанесение текста.\n
;;;;;; Задаются:\n
;;;;;; 1) ось Х;\n
;;;;;; 2) ось Y;\n
;;;;;; 3) координата X." "Шкалы")
(defun c:a2xy_t (/ pt pt_0 pt_1 scx scx_end scx_st scy scy_end scy_st x)
  (setq	scx (sh:get (sh:sel "Ось X"))
	scy (sh:get (sh:sel "Ось Y"))
  )
  
  (while (setq x (getreal "Введите X :"))
    (setq
      pt	(sc:val_pt x scx)
      scx_st	(cdr (assoc 10 scx))
      scx_end	(cdr (assoc 11 scx))
      scy_st	(cdr (assoc 10 scy))
      scy_end	(cdr (assoc 11 scy))
      pt_0	(inters	pt
			(polar pt (angle scy_st scy_end) 1.0)
			scy_st
			(polar scy_st (angle scx_st scx_end) 1.0)
			nil
		)
      pt_1	(inters	pt
			(polar pt (angle scy_st scy_end) 1.0)
			scy_end
			(polar scy_end (angle scx_st scx_end) 1.0)
			nil
		)
    )
    (dr:line pt_0 pt_1 256)
    (dr:text (rtos x) pt 3.5 0.0 256)
  )
  (princ)
)

;;;;;;("a2xyn_t"
;;;;;;"Построение сетки в координатах 2-х шкал и нанесение текста.\n
;;;;;; Задаются:\n
;;;;;; 1) ось Х;\n
;;;;;; 2) ось Y;\n
;;;;;; 3) координата X." "Шкалы")
(defun c:a2xyn_t (/)
  (setq	scx (sh:get (sh:sel "Ось X"))
	scy (sh:get (sh:sel "Ось Y"))
  )

  (setq	x_min (getreal "Введите X_min :")
	x_max (getreal "Введите X_max :")
	n_div (getint "Введите n_div :")

  )
  (setq
    scx_st  (cdr (assoc 10 scx))
    scx_end (cdr (assoc 11 scx))
    scy_st  (cdr (assoc 10 scy))
    scy_end (cdr (assoc 11 scy))
  )
  (mapcar
    (function
      (lambda (el)
	(setq
	  pt   (sc:val_pt el scx)
	  pt_0 (inters pt
		       (polar pt (angle scy_st scy_end) 1.0)
		       scy_st
		       (polar scy_st (angle scx_st scx_end) 1.0)
		       nil
	       )
	  pt_1 (inters pt
		       (polar pt (angle scy_st scy_end) 1.0)
		       scy_end
		       (polar scy_end (angle scx_st scx_end) 1.0)
		       nil
	       )
	)
	(dr:line pt_0 pt_1 256)
	(dr:text (rtos el) pt 3.5 0.0 256)
      )
    )
    (sub_div x_min x_max n_div 0)
  )
  (princ)
)

;;;("a3"
;;;"Построение точек в координатах двух шкал.\n
;;; Задаются:\n
;;; 1) ось Х;\n
;;; 2) ось Y;\n
;;; 3) координата X.\n
;;; 4) координата Y." "Шкалы")
(defun c:a3 (/ x y scx scy)
  (alert
    "Построение точек в координатах двух шкал
Задаются:
1) ось Х;
2) ось Y;
3) координата X.
4) координата Y."
  )
  (setq scx (sh:get (sh:sel "Ось X:")))
  (setq scy (sh:get (sh:sel "Ось Y:")))
  (while
    (and
      (setq x (getreal "Введите X :"))
      (setq y (getreal "Введите Y :"))
    )
     (dr:point (sc:pxy_pt (list x y 0.0) scx scy) 256)
  )
)

;;;;;;("a4"
;;;;;;"Построение точек в координатах двух шкал.\n
;;;;;; Задаются:\n
;;;;;; 1) ось Х;\n
;;;;;; 2) ось Y;\n
;;;;;; 3) точка в координатах шкал X-Y." "Шкалы")
(defun c:a4 (/ p scx scy)
  (alert
    "Построение точек в координатах двух шкал
Задаются:
1) ось Х;
2) ось Y;
3) точка в координатах шкал X-Y."
  )
  (setq
    scx	(sh:get (sh:sel "Ось X:"))
    scy	(sh:get (sh:sel "Ось Y:"))
  )
  (while
    (setq p (getpoint "Введите точку P :"))
     (dr:point (sc:pxy_pt p scx scy) 256)
  )
)

;;;;;;("a5"
;;;;;;"Перевод точек из координат двух шкал в координаты экрана.\n
;;;;;; Задаются:\n
;;;;;; 1) ось Х;\n
;;;;;; 2) ось Y;\n
;;;;;; 3) точка в координатах шкал X-Y." "Шкалы")
(defun c:a5 (/ P SCX SCY)
  (alert
    "Перевод точек из координат двух шкал в координаты экрана
Задаются:
1) ось Х;
2) ось Y;
3) точка в координатах шкал X-Y."
  )
  (setq
    scx	(sh:get (sh:sel "Ось X:"))
    scy	(sh:get (sh:sel "Ось Y:"))
  )
  (while
    (setq p (getpoint "Введите точку P :")
	  p (sc:pt_pxy p scx scy)
    )
     (print p)
     (dr:point p 256)
  )
)


;;;;;;("a6"
;;;;;;"Перевод точек из координат одной пары шкал\n
;;;;;; в координаты другой пары шкал.\n
;;;;;; Задаются:\n
;;;;;; 1) ось Х по которой берутся точки;\n
;;;;;; 2) ось Y по которой берутся точки;\n
;;;;;; 3) ось Х в которой строятся точки;\n
;;;;;; 4) ось Y в которой строятся точки;\n
;;;;;; 5) точка в координатах шкал X-Y." "Шкалы")
(defun c:a6 (/ p scx0 scx1 scy0 scy1)
  (alert
    "Перевод точек из координат одной пары шкал
в координаты другой пары шкал
Задаются:
1) ось Х по которой берутся точки;
2) ось Y по которой берутся точки;
3) ось Х в которой строятся точки;
4) ось Y в которой строятся точки;
5) точка в координатах шкал X-Y."
  )
  (setq
    scx0 (sh:get (sh:sel "Ось X для указания точек"))
    scy0 (sh:get (sh:sel "Ось Y для указания точек"))
    scx1 (sh:get (sh:sel "Ось X для построения точек"))
    scy1 (sh:get (sh:sel "Ось Y для построения точек"))
  )
  (while
    (setq p (getpoint "Введите точку P :")
	  p (sc:pt_pxy p scx0 scy0)
    )
     (print p)
     (dr:point (sc:pxy_pt p scx1 scy1) 256)
  )
)

;;;;;;("c1" "Построение точки на шкале по значению." "Шкалы")
(defun c:c1 (/ sx scx v pt)
  (setq
    sx	(sh:sel "Шкала x")
    scx	(sh:get sx)
    v	(getreal "\nВведите значение:")
    pt	(sc:val_pt v scx)
  )
  (dr:point pt 1)
  (princ v)
  (princ)
)

;;;;;;("c2" "Определение значения на шкале по точке." "Шкалы")
(defun c:c2 (/ sx scx v pt)
  (setq
    sx	(sh:sel "Шкала x")
    scx	(sh:get sx)
    pt	(getpoint "\nУкажите точку на шкале:")
    v	(sc:pt_val pt scx)
  )
  (dr:point pt 1)
  (princ v)
  (princ)
)

;;;;;;("c3" "Построение точки в координатах 2-х шкал." "Шкалы")
(defun c:c3 (/ sx scx sy scy pxy pt)
  (setq
    sx	(sh:sel "Шкала x")
    scx	(sh:get sx)
    sy	(sh:sel "Шкала y")
    scy	(sh:get sy)
  )
  (while
    (setq pxy (getpoint "\n Укажите точку в координатах шкалы:"))
     (setq pt (sc:pxy_pt pxy scx scy))
     (princ "pxy")(princ pxy)
     (dr:point pt 1)
  )
)

;;;;;;("c4" "Выводит координаты отмеченных точек." "Шкалы")
(defun c:c4  (/ sx scx sy scy pxy pt)
  (setq
    sx	(sh:sel "Шкала x")
    scx	(sh:get sx)
    sy	(sh:sel "Шкала y")
    scy	(sh:get sy))
  (while (setq pt (getpoint "\n Укажите точку в на экране:"))
    (setq pxy (sc:pt_pxy pt scx scy))
    (princ "pxy")
    (princ pxy)
    (dr:point pt 2)))

;;;(princ "\nЗагружаю dims/rou/rou_draw   ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "dims/rou/rou_draw   "))

;;	pt_m(pt c)	- Точка с направлением выдавливания как у текущей ПСК.
(defun pt_m (pt c)
  (entmake
    (list
      (cons 0 "POINT")
      (cons 10 pt)
      (cons 62 c)
      (cons 210
	    (vect_vect* (getvar "ucsxdir") (getvar "ucsydir"))
      )
    )
  )
)

;;	draw_sher(p_top p_bas)	- Отрисовка шероховатости:
;;				p_top - точка над знаком шероховатости;
;;				p_bas - точка в основании знака шероховатости.
(defun draw_sher (p_top p_bas / bl_name d1 d2 d3 perev tb ed en ob)
  (setq
    d1	  4.0  ; Высота по y до верха левой линии зн.
    d2	  3.5  ; Высота текста.
    d3	  1.25 ; Расстояние до низа скобок.
    perev
	  (cond
	    ((= (cadr (assoc "tgl_1_perevern" setup_lst)) "1") t)
	    (t nil)
	  )
  )
  (entmake
    (list
      (cons 0 "block")
      (cons 2 "*U")
      (list 10 0.0 0.0 0.0)
      (cons 70 1)
    )
  )
  (setq tb (point_box (draw_1 d1 d2)))
  (cond
    ((= (cadr (assoc "rb_1_osn_ml_nesn" setup_lst)) "1") ; Без снятия осн. м-ла
     (setq tb (point_box (append tb (draw_3 d1 d2))))
    )
    ((= (cadr (assoc "rb_1_osn_ml_neobr" setup_lst)) "1") ; Необработка
     (setq tb (point_box (append tb (draw_2 d1 d2))))
    )
  )
  (if (= (cadr (assoc "tgl_1_po_konturu" setup_lst)) "1") ; По контуру
    (setq tb (point_box (append tb (draw_4 d1 d2 d3))))
    (setq d3 0.0)
  )
  (cond	       ; Текст для значения шероховатости
    ((and (= (cadr (assoc "tgl_1_max_val" setup_lst)) "1")
	  (= (cadr (assoc "tgl_1_min_val" setup_lst)) "1")
	  (= (cadr (assoc "tgl_1_perevern" setup_lst)) "0")
     )	       ; Максимальное и минимальное не перевернутое значение
     (setq tb (point_box
		(append	tb
			(draw_5 (+ d1 (* 2.0 d2)) d2 (cadr (assoc "eb_1_max_val" setup_lst)) perev)
		)
	      )
     )
     (setq tb (point_box
		(append	tb
			(draw_5 (+ d1 (* 0.5 d2)) d2 (cadr (assoc "eb_1_min_val" setup_lst)) perev)
		)
	      )
     )
    )	       ; Максимальное и минимальное перевернутое значение
    ((and (= (cadr (assoc "tgl_1_max_val" setup_lst)) "1")
	  (= (cadr (assoc "tgl_1_min_val" setup_lst)) "1")
	  (= (cadr (assoc "tgl_1_perevern" setup_lst)) "1")
     )
     (setq tb (point_box
		(append	tb
			(draw_5 (+ d1 (* 2.0 d2)) d2 (cadr (assoc "eb_1_min_val" setup_lst)) perev)
		)
	      )
     )
     (setq tb (point_box
		(append	tb
			(draw_5	(+ d1 (* 0.5 d2))
				d2
				(cadr (assoc "eb_1_max_val" setup_lst))
				perev
			)
		)
	      )
     )
    )
    ((and (= (cadr (assoc "tgl_1_max_val" setup_lst)) "1")
     )	       ; Максимальное значение
     (setq tb
	    (point_box
	      (append
		tb
		(draw_5 (+ d1 (* 0.5 d2)) d2 (cadr (assoc "eb_1_max_val" setup_lst)) perev)
	      )
	    )
     )
    )
  )
  (if (= (cadr (assoc "tgl_1_spos_pol" setup_lst)) "1")
	       ; Текст для обозначения способа получения шероховатости
    (setq tb
	   (point_box
	     (append
	       tb
	       (draw_6 d1 d2 d3 (cadr (assoc "eb_1_spos_pol" setup_lst)) perev)
	     )
	   )
    )
  )
  (if (= (cadr (assoc "rb_1_kr_sk" setup_lst)) "1") ; Скобки круглые
    (draw_7 d1 tb)
  )
  (if (= (cadr (assoc "rb_1_kv_sk" setup_lst)) "1") ; Скобки квадратные
    (draw_7_1 d1 tb)
  )
  (if (= (cadr (assoc "tgl_1_spos_pol" setup_lst)) "1") ; Полка
    (draw_8 d1 tb)
  )

  (setq bl_name (entmake (list (cons 0 "ENDBLK"))))

  (setq	ed
	   (list
	     (cons 0 "insert")
	     (cons 2 bl_name)
	     (cons 10 '(0.0 0.0 0.0))
	     (cons 50 0.0)
	     (cons 41 (distof (cadr (assoc "eb_1_masht" setup_lst))))
	     (cons 42 (distof (cadr (assoc "eb_1_masht" setup_lst))))
	     (cons 43 (distof (cadr (assoc "eb_1_masht" setup_lst))))
	     (cons 210 '(0.0 0.0 0.0))
	   )
	ed (pt_ang_o_u ed p_bas (- (angle p_bas p_top) (/ pi 2.)))
  )
  (entmake ed)
  (setq	en (entlast)
	ob (vlax-ename->vla-object en)
  )
  (vlax-ldata-put ob "rou" setup_lst)
  (vlax-ldata-put ob "rou-p_top" p_top)
  (vlax-ldata-put ob "rou-p_bas" p_bas)
)

;;;	draw_1(d1 d2)	- Отрисовка галочки.
(defun draw_1 (d1 d2 / l1 p0 p1 p2)
  (setq
    l1 (/ d1 (cos (/ pi 6.0)))
    p0 (list 0.0 0.0 0.0)
    p1 (polar p0 (/ pi 0.5 3.0) l1)
    p2 (polar p0 (/ pi 3.0) (* 2.0 l1))
  )
  (entmake (list (cons 0 "LINE")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 p0)
		 (cons 11 p1)
		 (cons 210 (list 0.0 0.0 1.0))
	   )
  )
  (entmake (list (cons 0 "LINE")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 p0)
		 (cons 11 p2)
		 (cons 210 (list 0.0 0.0 1.0))
	   )
  )
  (list (polar p0 (/ pi 2.0) (/ d1 5.0)) p1 p2)
)

;;;	draw_2(d1 d2)	- Отрисовка необработки.
(defun draw_2 (d1 d2 / r pc)
  (setq
    r  (/ d1 3.0)
    pc (polar (list 0.0 0.0 0.0) (/ pi 2.0) (* r 2.0))
  )
  (entmake (list (cons 0 "CIRCLE")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 pc)
		 (cons 40 r)
	   )
  )
  (list	(polar pc 0.0 r)
	(polar pc (/ pi 2.0) r)
	(polar pc pi r)
	(polar pc (/ pi -2.0) r)
  )
)

;;;	draw_3(d1 d2)	- Без снятия основного материала.
(defun draw_3 (d1 d2 / l1 p0 p1 p2)
  (setq
    l1 (/ d1 (cos (/ pi 6.0)))
    p0 (list 0.0 0.0 0.0)
    p1 (polar p0 (/ pi 0.5 3.0) l1)
    p2 (polar p0 (/ pi 3.0) l1)
  )
  (entmake (list (cons 0 "LINE")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 p1)
		 (cons 11 p2)
	   )
  )
  (list p1 p2)
)

;;	draw_4(d1 d2 d3)	- По контуру.
(defun draw_4 (d1 d2 d3 / pc p1 p2)
  (setq
    pc
     (polar
       (list 0.0 0.0 0.0)
       (/ pi 3.0)
       (/ d1 0.5 (cos (/ pi 6.0)))
     )
  )
  (entmake (list (cons 0 "CIRCLE")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 pc)
		 (cons 40 d3)
	   )
  )
  (list	(polar pc 0.0 d3)
	(polar pc (/ pi 2.0) d3)
	(polar pc pi d3)
	(polar pc (/ pi -2.0) d3)
  )
)

;;	draw_5(d1 d2 str per)	- Текст значения шероховатости.
(defun draw_5 (d1 d2 str per / p0 p1 p2 pt el tb)
  (setq
    p0 (list 0.0 0.0 0.0)
    pt (mapcar (function +) (list (* 0.5 d2) d1 0.0))
    el
       (append
	 (list (cons 0 "TEXT")
	       (cons 1 str)
	       (cons 8 "0")
	       (cons 7 "T")
	       (cons 62 0)
	       (cons 10 pt)
	       (cons 11 pt)
	       (cons 40 d2)
	 )
	 (cond
	   ((null per) (list (cons 50 0.0) (cons 72 2) (cons 73 0)))
	   (per (list (cons 50 pi) (cons 72 0) (cons 73 3)))
	 )
       )
    tb (textbox el)
  )
  (entmake el)
  (list	pt
	(list (- (car pt) (caadr tb)) (+ (cadr pt) (cadadr tb)))
  )
)

;;	draw_6(d1 d2 d3 str per)	- Текст над полкой о способе получения шероховатости.
(defun draw_6 (d1 d2 d3 str per / p0 p1 pt el tb)
  (setq
    p0 (list 0.0 0.0 0.0)
    p1
       (polar
	 p0
	 (/ pi 3.0)
	 (/ d1 0.5 (cos (/ pi 6.0)))
       )
    pt (mapcar '+ p1 (list (+ d3 (/ d2 2.0)) (/ d2 2.0) 0.0))
  )
  (setq
    el
       (append
	 (list (cons 0 "TEXT")
	       (cons 1 str)
	       (cons 8 "0")
	       (cons 7 "T")
	       (cons 62 0)
	       (cons 10 pt)
	       (cons 11 pt)
	       (cons 40 d2)
	 )
	 (cond
	   ((null per) (list (cons 50 0.0) (cons 72 0) (cons 73 0)))
	   (per (list (cons 50 pi) (cons 72 2) (cons 73 3)))
	 )
       )
    tb (textbox el)
  )
  (entmake el)
  (list pt (mapcar '+ pt (cadr tb)))
)
;;	draw_7(d1 tb)	- Отрисовка круглых скобок.
(defun draw_7 (d1 tb / x y r p1 p2)
  (setq
    tb (list (polar (car tb) pi (/ d1 4.0))
	     (polar (cadr tb) 0.0 (/ d1 4.0))
       )
    x  (mapcar 'car tb)
    y  (mapcar 'cadr tb)
    r
       (/ (apply '- (reverse y)) 2.0 (sin (/ pi 6.0)))
    p1 (polar (cadr tb) (/ (* 7.0 pi) 6.0) r)
    p2 (polar (car tb) (/ (* 1.0 pi) 6.0) r)
  )
  (entmake (list (cons 0 "ARC")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 p1)
		 (cons 40 r)
		 (cons 50 (/ (* 11 pi) 6.0))
		 (cons 51 (/ pi 6.0))
	   )
  )
  (entmake (list (cons 0 "ARC")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 p2)
		 (cons 40 r)
		 (cons 50 (/ (* 5.0 pi) 6.0))
		 (cons 51 (/ (* 7.0 pi) 6.0))
	   )
  )
)

;;	draw_7_1(d1 tb)	- Отрисовка квадратных скобок.
(defun draw_7_1	(d1 tb / x y r p_l_0 p_l_1 p_l_2 p_l_3 p_r_0 p_r_1 p_r_2 p_r_3)
  (setq
    tb	  (list	(polar (car tb) pi (/ d1 4.0))
		(polar (cadr tb) 0.0 (/ d1 4.0))
	  )
    x	  (mapcar 'car tb)
    y	  (mapcar 'cadr tb)

    p_l_0 (list (car x) (car y) 0.0)
    p_l_1 (polar p_l_0 pi (/ d1 4.0))
    p_l_3 (list (car x) (cadr y) 0.0)
    p_l_2 (polar p_l_3 pi (/ d1 4.0))

    p_r_0 (list (cadr x) (car y) 0.0)
    p_r_1 (polar p_r_0 0.0 (/ d1 4.0))
    p_r_3 (list (cadr x) (cadr y) 0.0)
    p_r_2 (polar p_r_3 0.0 (/ d1 4.0))
  )
  (entmake (list (cons 0 "LINE")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 p_l_0)
		 (cons 11 p_l_1)
	   )
  )
  (entmake (list (cons 0 "LINE")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 p_l_1)
		 (cons 11 p_l_2)
	   )
  )
  (entmake (list (cons 0 "LINE")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 p_l_2)
		 (cons 11 p_l_3)
	   )
  )

  (entmake (list (cons 0 "LINE")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 p_r_0)
		 (cons 11 p_r_1)
	   )
  )
  (entmake (list (cons 0 "LINE")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 p_r_1)
		 (cons 11 p_r_2)
	   )
  )
  (entmake (list (cons 0 "LINE")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 p_r_2)
		 (cons 11 p_r_3)
	   )
  )
)

;;	draw_8(d1 tb)	- Отрисовка полки.
;;			d1 - высота треугольника;
;;			d2 - высота надписей для текста;
;;			d3 - диаметр круга для обозначеия обраотки по замкнутому контуру;
;;			str - текст надписи;
;;			per (nil | t) - флажок перевернутый знак шероховатости или нет.

(defun draw_8 (d1 tb / l1 p0 p1 p2)
  (setq
    l1 (/ d1 (cos (/ pi 6.0)))
    p0 (list 0.0 0.0 0.0)
    p1 (polar p0 (/ pi 3.0) (* 2.0 l1))
    p2 (list (caadr tb) (cadr p1))
  )
  (entmake (list (cons 0 "LINE")
		 (cons 8 "0")
		 (cons 62 0)
		 (cons 10 p1)
		 (cons 11 p2)
	   )
  )
)

(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(150 2 15 2 nil "end of" 100 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

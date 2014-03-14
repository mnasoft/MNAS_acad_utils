;;;(princ "\nЗагружаю dims/rou/rou_draw_i3")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "dims/rou/rou_draw_i3"))

;;	rou_1-draw_sher(p_top p_bas)	- Отрисовка шероховатости:
;;				p_top - точка над знаком шероховатости;
;;				p_bas - точка в основании знака шероховатости.
(defun rou_1-draw_sher (p_top		p_bas	      /		    a_120	  a_60		a_90	      bl_name	    ed		  en
		  galka_color	hight_of_left_rou_line	    ob		  polca_color	p_0	      p_1	    p_10	  p_11
		  p_12		p_120	      p_13	    p_14	  p_15		p_16	      p_17	    p_2		  p_3
		  p_4		p_5	      p_6	    p_60	  p_7		p_8	      p_9	    r_circ_po_konturu
		  str_max_rou_val	      str_max_rou_val_tb	  str_min_rou_val	      str_spos_pol_tb		  str_spos_pol_val
		  str_type_of_mikro	      str_type_of_mikro_tb	  tb		text_color    text_hight    text_over_line
		  text_style
		 )
  (setq
    text_style
     (getvar "DIMTXSTY") ; Стиль текста
    text_hight
     (getvar "DIMTXT") ; Высота текста.
    text_over_line
     (* text_hight 0.5) ; Расстояние от текста до линии

    hight_of_left_rou_line ; Высота по y до верха левой линии зн.
     (* 1.25 text_hight)
    r_circ_po_konturu ; Радиус значка обозначающего по контуру
     (cond ((= (cadr (assoc "tgl_1_po_konturu" setup_lst)) "1") (* 0.25 text_hight))
	   ((= (cadr (assoc "tgl_1_po_konturu" setup_lst)) "0") 0.0)
     )
    text_color
     (getvar "DIMCLRT") ; Цвет текста
    polca_color
     (getvar "DIMCLRD") ; Цвет плоки
    galka_color
     (getvar "DIMCLRE") ; Цвет галки


  )

  (setq
    str_type_of_mikro ; Обозначение типа микронеровностей
;;"Параллельное" "Перпендикулярное" "Скрещенное" "Кольчужное" "Концентричное" "Радиальное" "Точечное"     
		      (cond
			((= (cadr (assoc "tgl_1_napr_miko_ner" setup_lst)) "0")
			 " "
			)
			((and
			   (= (cadr (assoc "tgl_1_napr_miko_ner" setup_lst)) "1")
			   (= (cadr (assoc "pl_1_napr_miko_ner" setup_lst)) "0")
			 )
			 "&Z"
			)
			((and
			   (= (cadr (assoc "tgl_1_napr_miko_ner" setup_lst)) "1")
			   (= (cadr (assoc "pl_1_napr_miko_ner" setup_lst)) "1")
			 )
			 "&g"
			)
			((and
			   (= (cadr (assoc "tgl_1_napr_miko_ner" setup_lst)) "1")
			   (= (cadr (assoc "pl_1_napr_miko_ner" setup_lst)) "2")
			 )
			 "&o"
			)
			((and
			   (= (cadr (assoc "tgl_1_napr_miko_ner" setup_lst)) "1")
			   (= (cadr (assoc "pl_1_napr_miko_ner" setup_lst)) "3")
			 )
			 "M"
			)
			((and
			   (= (cadr (assoc "tgl_1_napr_miko_ner" setup_lst)) "1")
			   (= (cadr (assoc "pl_1_napr_miko_ner" setup_lst)) "4")
			 )
			 "C"
			)
			((and
			   (= (cadr (assoc "tgl_1_napr_miko_ner" setup_lst)) "1")
			   (= (cadr (assoc "pl_1_napr_miko_ner" setup_lst)) "5")
			 )
			 "R"
			)
			((and
			   (= (cadr (assoc "tgl_1_napr_miko_ner" setup_lst)) "1")
			   (= (cadr (assoc "pl_1_napr_miko_ner" setup_lst)) "6")
			 )
			 "P"
			)
			(t " ")
		      )
    str_max_rou_val   (cadr (assoc "eb_1_max_val" setup_lst))
    str_min_rou_val   (cadr (assoc "eb_1_min_val" setup_lst))
    str_spos_pol_val
		      (cond
			((or (= (cadr (assoc "tgl_1_spos_pol" setup_lst)) "0")
			     (= (cadr (assoc "eb_1_spos_pol" setup_lst)) "")
			 )
			 " "
			)
			((= (cadr (assoc "tgl_1_spos_pol" setup_lst)) "1")
			 (cadr (assoc "eb_1_spos_pol" setup_lst))
			)
		      )
  )

  (setq
    a_60 (/ pi 3.0)
    a_90 (/ pi 2.0)
    a_120 (+ a_60 a_60)

    p_0	'(0.0 0.0 0.0)

    p_60 (polar p_0 a_60 1.0)
    p_120 (polar p_0 a_120 1.0)

    p_1	(polar p_0 a_90 hight_of_left_rou_line)
    p_2	(inters p_0 p_120 p_1 (polar p_1 0.0 1.0) nil)
    p_3	(polar p_0 (- a_60 a_90) text_over_line)
    p_4	(polar p_0 a_90 (* (/ 2. 3.) hight_of_left_rou_line))
    p_5	(polar p_0 a_90 (+ text_hight text_over_line))
    p_6	(polar p_0 a_90 (+ text_hight text_over_line text_over_line r_circ_po_konturu))
    p_7	(inters p_3 (polar p_3 a_60 1.0) p_5 (polar p_5 0.0 1.0) nil)
    str_type_of_mikro_tb
     (textbox
       (list
	 (cons 1 str_type_of_mikro)
	 (cons 7 text_style)
	 (cons 40 text_hight)
       )
     )
    p_8	(polar p_7 0.0 (caadr str_type_of_mikro_tb))
    p_9
     (cond
       ((= 0.0 (caadr str_type_of_mikro_tb)) p_7)
       (t (polar p_8 0.0 text_hight))
     )
    p_10 (inters p_6 (polar p_6 0.0 1.0) p_0 p_60 nil)
    str_max_rou_val_tb
     (textbox
       (list
	 (cons 1 str_max_rou_val)
	 (cons 7 text_style)
	 (cons 40 text_hight)
       )
     )
    p_11 (polar p_9 0.0 (caadr str_max_rou_val_tb))
    p_12 (inters p_11 (polar p_11 a_90 1.0) p_6 (polar p_6 0.0 1.0) nil)
    p_13 (polar p_10 0.0 r_circ_po_konturu)
    p_14 (mapcar (function +) p_13 (list text_over_line text_over_line 0.0))
    str_spos_pol_tb
     (textbox
       (list
	 (cons 1 str_spos_pol_val)
	 (cons 7 text_style)
	 (cons 40 text_hight)
       )
     )
    p_15 (polar p_14 0.0 (caadr str_spos_pol_tb))
    p_16 (inters p_15 (polar p_15 a_90 1.0) p_6 (polar p_6 0.0 1.0) nil)
    p_17 (mapcar (function max) p_12 p_16)
  )

  (entmake
    (list
      (cons 0 "block")
      (cons 2 "*U")
      (list 10 0.0 0.0 0.0)
      (cons 70 1)
    )
  )

  (setq tb (rou_1-point_box (list p_0))) ; Пределение границ прямоугольника

;;; Отрисовка галочки начало
  (entmake
    (list
      (cons 0 "LINE")
      (cons 8 "0")
      (cons 62 galka_color)
      (cons 10 p_0)
      (cons 11 p_2)
    )
  )
  (entmake
    (list
      (cons 0 "LINE")
      (cons 8 "0")
      (cons 62 galka_color)
      (cons 10 p_0)
      (cons 11 p_10)
    )
  )
  (setq tb (rou_1-point_box (append tb (list p_2) (list p_10))))
;;; Отрисовка галочки конец

;;; Без снятия осн. м-ла начало
  (cond
    ((= (cadr (assoc "rb_1_osn_ml_nesn" setup_lst)) "1")
     (entmake (list (cons 0 "LINE")
		    (cons 8 "0")
		    (cons 62 galka_color)
		    (cons 10 p_2)
		    (cons 11 (polar p_1 0.0 (distance p_1 p_2)))
	      )
     )
    )
  )
;;; Без снятия осн. м-ла конец

;;; Необработка начало
  (cond
    ((= (cadr (assoc "rb_1_osn_ml_neobr" setup_lst)) "1")
     (entmake (list (cons 0 "CIRCLE")
		    (cons 8 "0")
		    (cons 62 galka_color)
		    (cons 10 p_4)
		    (cons 40 (distance p_4 p_1))
	      )
     )
    )
  )
;;; Необработка конец


;;; По контуру начало
  (cond
    ((= (cadr (assoc "tgl_1_po_konturu" setup_lst)) "1")
     (entmake (list (cons 0 "CIRCLE")
		    (cons 8 "0")
		    (cons 62 polca_color)
		    (cons 10 p_10)
		    (cons 40 r_circ_po_konturu)
	      )
     )
     (setq tb (rou_1-point_box (append tb (list p_13 (polar p_10 (/ pi 2.0) r_circ_po_konturu)))))
    )
  )
;;; По контуру конец

;;; Полка начало

  (entmake
    (list (cons 0 "LINE")
	  (cons 8 "0")
	  (cons 62 polca_color)
	  (cons 10 p_10)
	  (cons 11 p_17)
    )
  )

;;; Полка  конец

;;; Текст для значения шероховатости начало
  (cond
;;; Максимальное и минимальное не перевернутое значение начало
    ((and (= (cadr (assoc "tgl_1_max_val" setup_lst)) "1")
	  (= (cadr (assoc "tgl_1_min_val" setup_lst)) "1")
	  (= (cadr (assoc "tgl_1_perevern" setup_lst)) "0")
     )
     (alert "Максимальное и минимальное не перевернутое значение")
     t
    )
;;; Максимальное и минимальное не перевернутое значение конец

;;; Максимальное и минимальное перевернутое значение начало
    ((and (= (cadr (assoc "tgl_1_max_val" setup_lst)) "1")
	  (= (cadr (assoc "tgl_1_min_val" setup_lst)) "1")
	  (= (cadr (assoc "tgl_1_perevern" setup_lst)) "1")
     )
     (alert "Максимальное и минимальное перевернутое значение")
     t
    )
;;; Максимальное и минимальное перевернутое значение конец

;;; Максимальное значение начало
    ((and (= (cadr (assoc "tgl_1_max_val" setup_lst)) "1")
     )
     (entmake
       (list (cons 0 "TEXT")
	     (cons 1 str_max_rou_val)
	     (cons 8 "0")
	     (cons 7 text_style)
	     (cons 62 text_color)
	     (cons 10 p_9)
	     (cons 11 p_9)
	     (cons 40 text_hight)
	     (cons 73 3)
       )
     )
     (setq tb (rou_1-point_box (append tb (list p_12))))
    )
;;; Максимальное значение конец

  )
;;; Текст для значения шероховатости конец

;;; Текст для обозначения способа получения шероховатости начало
  (cond
    (
     (= (cadr (assoc "tgl_1_spos_pol" setup_lst)) "1")
     (entmake
       (list (cons 0 "TEXT")
	     (cons 1 str_spos_pol_val)
	     (cons 8 "0")
	     (cons 7 text_style)
	     (cons 62 text_color)
	     (cons 10 p_14)
	     (cons 11 p_14)
	     (cons 40 text_hight)
       )
     )
     (setq tb (rou_1-point_box (append tb (list p_16 (polar p_14 a_90 text_hight)))))
    )
  )
;;; Текст для обозначения способа получения шероховатости конец

;;; Текст для обозначения направления микронеровностей начало
  (cond
    (
     (= (cadr (assoc "tgl_1_napr_miko_ner" setup_lst)) "1")
     (entmake
       (list (cons 0 "TEXT")
	     (cons 1 str_type_of_mikro)
	     (cons 8 "0")
	     (cons 7 text_style)
	     (cons 62 text_color)
	     (cons 10 p_7)
	     (cons 11 p_7)
	     (cons 40 text_hight)
	     (cons 73 3)
       )
     )
    )
  )
;;; Текст для обозначения направления микронеровностей конец


;;; Скобки круглые начало
  (cond
    ((= (cadr (assoc "rb_1_kr_sk" setup_lst)) "1")
     (rou_1-draw_7 text_over_line tb)
    )
  )
;;; Скобки круглые конец

;;; Скобки квадратные начало
  (cond
    ((= (cadr (assoc "rb_1_kv_sk" setup_lst)) "1")
     (rou_1-draw_7_1 text_over_line tb)
    )
  )
;;; Скобки квадратные конец

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

;;	rou_1-draw_7(d1 tb)	- Отрисовка круглых скобок.
(defun rou_1-draw_7 (d1 tb / x y r p1 p2)
  (setq
    tb (list (polar(polar (car tb) pi  d1) (/ pi 2) d1)
	     (polar (cadr tb) 0.0 d1)
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

;;	rou_1-draw_7_1(d1 tb)	- Отрисовка квадратных скобок.
(defun rou_1-draw_7_1	(d1 tb / x y r p_l_0 p_l_1 p_l_2 p_l_3 p_r_0 p_r_1 p_r_2 p_r_3)
  (setq
    tb	  (list (polar(polar (car tb) pi  d1) (/ pi 2) d1)
	     (polar (cadr tb) 0.0 d1)
       )
    x	  (mapcar 'car tb)
    y	  (mapcar 'cadr tb)

    p_l_0 (list (car x) (car y) 0.0)
    p_l_1 (polar p_l_0 pi  d1 )
    p_l_3 (list (car x) (cadr y) 0.0)
    p_l_2 (polar p_l_3 pi d1 )

    p_r_0 (list (cadr x) (car y) 0.0)
    p_r_1 (polar p_r_0 0.0  d1)
    p_r_3 (list (cadr x) (cadr y) 0.0)
    p_r_2 (polar p_r_3 0.0  d1)
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

(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(150 2 15 2 nil "end of" 100 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

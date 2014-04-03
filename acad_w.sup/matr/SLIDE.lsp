(defun round_int (a)
     ;Функция преобразования к целому.
  (cond
    ((> a 0) (fix (+ a 0.5)))
    ((< a 0) (fix (- a 0.5)))
    (t (fix a))
  )
)

(defun pt_round	(p)
     ;Функция преобразования координат точки к целым.
  (mapcar (function (lambda (el) (round_int el))) p)
)

(defun image_line (p_s p_e c)
     ; Функция для отрисовки линии в окне image;
  (setq p_s (pt_round p_s))
  (setq p_e (pt_round p_e))
  (vector_image (car p_s) (cadr p_s) (car p_e) (cadr p_e) c)
)
(defun point_preobr (p matr / temp)
  (setq	p
	     (cond
	       ((= (length p) 2) p)
	       ((= (length p) 3) (list (car p) (cadr p)))
	       (t '(0.0 0.0))
	     )
	temp (point_to_matr p)
	temp (matr_mult temp matr)
  )
  p
  (matr_to_point temp)
)

(defun matr_screen_slide (A B FI X Y / matr)
     ;Функция возвращает матрицу преобразования из
     ;координат экрана в координаты слайда,
     ;смещенную в точку (A,B) в координатах слайда (левая двойка)
     ;повернутую на FI против часовой стрелки
     ;с масштабными коэффициентами по осям X и Y.
  (setq
    y	 (- 0.0 y)
    matr (matr_eval matr_scale_xy)
    fi	 (- 0.0 fi)
    matr (matr_mult matr (matr_eval matr_rotate_fi))
  )
  (matr_mult matr (matr_eval matr_move_ab))
)

(defun matr_slide_screen (A B FI X Y / matr)
     ;Функция возвращает матрицу преобразования из 
     ;координат слайда в координаты экрана,
     ;смещенную в точку (A,B) в координатах слайда (левая двойка)
     ;повернутую на FI против часовой стрелки
     ;с масштабными коэффициентами по осям X и Y.
  (setq
    a	 (- 0.0 a)
    b	 (- 0.0 b)
    y	 (- 0.0 y)
    matr (matr_eval matr_move_ab)
    matr (matr_mult matr (matr_eval matr_rotate_fi))
  )
  (matr_eval matr_scale_xy)

)
 ;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

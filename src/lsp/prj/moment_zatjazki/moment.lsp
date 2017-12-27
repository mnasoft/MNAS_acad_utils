(setq
  p	(* 100. 10. 2.0 2.0 pi 0.25)	; Усилие затяжки, H
  d	0.010				; Номинальный диаметр резьбы, м
  s	0.0015				; Шаг резьбы (ход для многозаходной ребьзы), м
  f	0.1				; Коэффициент трения в резьбе
  D_gol_sr 0.000			; Диаметр головки винта, м
  f_01	0.1				; Коэффициент трения в головки по свинчиваемой поверхности
)


;; Момент, затрачиваемый на создание силы.
(defun m_1
	   (p				; Создаваемая сила
	    d				; Средний диаметр резьбы
	    s				; Ход резьбы
	   )
  (setq d_sr (d_sr_metr d s))
  (setq tg_phi (/ s d_sr pi))		; Тагенс угла наклона
  (* 0.5 p d_sr tg_phi)
)


;; Момент сопротивления в гайке
(defun m_2 (p				; Создаваемая сила
	    d				; Средний диаме тртрения по головке винта
	    f				; Коэффициент трения
	   )
  (* 0.5 p d f)
)


;;
(defun m_3 (p				; Создаваемая сила
	    d				; Средний диаметр резьбы
	    s				; Шаг резьбы
	    f				; Коэффициент трения
	    / d_sr			; Средний диаметр резьбы
	    alpha			; Половинный угол профиля, град
)
  (setq alpha 30.0); Угол между нормалью к поверхности и осью кезьбы, град
  (setq d_sr (d_sr_metr d s))
  (* 0.5 p d_sr (/ f (cos (dtr alpha))))
)

(defun d_sr_metr(d ; Номинальный диаметр
		 s ; Шаг резьбы
		 )
    (- d (* 0.54 s))
)

(defun m_summ (p d s f D_gol_sr f_01)
  (+
    (m_1 p d s)
    (m_2 p D_gol_sr f_01)
    (m_3 p d s f)
  )
)

(defun m_out (p d s f D_gol_sr f_01)
  (princ "\nP=") (princ p) (princ "[H];")
  (princ "\nd=") (princ (* 1000. d)) (princ "[мм];")
  (princ "\ns=") (princ (* 1000. s)) (princ "[мм];")
  (princ "\nD_gol_sr=") (princ (* 1000. D_gol_sr)) (princ "[мм];")
  (princ "\nf=") (princ f)
  (princ "\nf_01=") (princ f_01)
  
  (princ "\nm_1=")  (princ (m_1 p d s)) (princ "[H/м];")
  (princ "\nm_2=")  (princ (m_2 p D_gol_sr f_01)) (princ "[H/м];")
  (princ "\nm_3=")  (princ (m_3 p d s f)) (princ "H/м;")
  (princ "\nM=")  (princ (m_summ p d s f D_gol_sr f_01))   (princ "[H/м];")
)

(m_out p d s f D_gol_sr f_01)

;|«Visual LISP© Format Options»
(105 2 40 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** НЕ добавляйте текст под комментариями! ***|;

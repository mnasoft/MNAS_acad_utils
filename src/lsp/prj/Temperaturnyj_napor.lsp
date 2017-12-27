;;;Среднелогарифмический температурный напор.
;;;Спарвочник машиностроителя т.2 с 167. погрешность определения до 3%

(defun dt (dt_big dt_min)
  (cond
    ((< dt_big dt_min) nil)
    ((< (/ dt_big dt_min) 1.8)
     (* (+ dt_big dt_min) 0.5)
    )
    ((< (/ dt_big dt_min) 4.5)
     (+ (* (+ dt_big dt_min) 0.5) (* -0.1 (- dt_big dt_min)))
    )
    ((>= (/ dt_big dt_min) 4.5)
     (/ (- dt_big dt_min) (log (/ dt_big dt_min)))
    )
    (t)
  )
)

;;;Среднелогарифмический температурный напор.
(defun dt (dt_big dt_min)
    (/ (- dt_big dt_min) (log (/ dt_big dt_min)))
)


;;;Среднелогарифмический температурный напор c погрешностью определения до 0,5%.
(defun dt (dt_big dt_min)
  (cond
    ((< dt_big dt_min) nil)
    ((< (/ dt_big dt_min) 1.05)
     (+ (* (+ dt_big dt_min) 0.5) (* -0.1 (- dt_big dt_min)))
    )
    ((>= (/ dt_big dt_min) 1.05)
     (/ (- dt_big dt_min) (log (/ dt_big dt_min)))
    )
    (t)
  )
)

(setq
  tg	 1400.0	 ;С
  Cpw	 4200.0	 ;Дж/(кг*К)
  tw_in	 43.0	 ;С
  tw_out 51.0	 ;С
  Mw	 8.0	 ; кг
  tauw	 21.	 ; см
  Gw	 (/ Mw tauw) ;Массовый расход воды.
  Qw	 (* Cpw (- tw_out tw_in) Gw) ; Тепловой поток по воде.
  dtgw	 (dt (- 1400.0 20.0) (- 1400.0 51.0)) ; Тепловой напор при передаче тепла от газа к воздуху С.
  ta_in	 150.	 ;C, температура воздуха на входе
  Cpa	 1000.0	 ;Дж/(кг*К),
  Ga	 (* 220. (/ 1.0 3600.) 1.3)
  F	 0.5	 ; м2
)




(defun Q_balans (t_st )
  (* Qw (/ (- tg t_st) dtgw ))
)

(setq alfa 20.)

(defun Q_teplo (t_st)
  (setq
    Q_b	    (Q_balans t_st) ; Количество теплоты, подводимое по балансу.
    dta	    (/ Q_b Cpa Ga) ; Подогрев в аппарате
    ta_out  (+ ta_in dta) ; температура воздуха на выходе
    dt_st_a (dt (- t_st ta_in) (- t_st ta_out))
  )
  (princ "\nQ_b=")
  (princ Q_b)
  (setq	Q_t (* F alfa dt_st_a)  )
  (princ "\nQ_t=")
  (princ Q_t)
)






;|«Visual LISP© Format Options»
(105 2 17 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

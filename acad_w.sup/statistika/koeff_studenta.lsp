;;;Таблица коэффициентов Стьюдента
(setq
  t_st
       '(
	 (1 6.31 12.71 63.66)
	 (2 2.92 4.30 9.93)
	 (3 2.35 3.18 5.84)
	 (4 2.13 2.78 4.60)
	 (5 2.20 2.57 4.30)
	 (6 1.94 2.45 3.71)
	 (7 1.90 2.37 3.56)
	 (8 1.86 2.31 3.36)
	 (9 1.83 2.26 3.25)
	 (10 1.81 2.23 3.17)
	 (20 1.73 2.09 2.85)
	 (30 1.70 2.04 2.75)
	 (40 1.68 2.02 2.70)
	 (60 1.67 2.00 2.66)
	 (120 1.66 1.98 2.62)
	)
  q_zn '(0.1 0.05 0.01)
  n_zn '(1 2 3 4 5 6 7 8 9 10 20 30 40 60 120)
)

(defun koeff_ts	(n uz)
;;;n - количетсво степеней свободы
;;;uz - уровень значимости
  (cond
    (
     (and (member n n_zn) (member uz q_zn))
     (setq xx (assoc n t_st)
	   nn
	      (cond
		((= uz 0.1) 1)
		((= uz 0.05) 2)
		((= uz 0.01) 3)
	      )
     )
     (nth nn xx)
    )
    (t 0.0)
  )
)

(defun zn_t_st (n	  uz	    /	      X_MAX	X_MIN
		ZN_BIG	  ZN_BIG_MIN	      ZN_LOW	ZN_LOW_MAX
		ZN_MAX	  ZN_MIN
	       )
  (mapcar
    (function
      (lambda (el / qq)
	(setq qq (car el))
	(cond
	  ((<= n qq)
	   (setq zn_big (append zn_big (list el)))
	  )
	  ((>= n qq)
	   (setq zn_low (append zn_low (list el)))
	  )
	)
      )
    )
    t_st
  )

  (setq
    zn_low_max (apply (function max) (mapcar (function car) zn_low))
    zn_big_min (apply (function min) (mapcar (function car) zn_big))
  )
  (setq zn_max (assoc zn_big_min t_st))
  (setq zn_min (assoc zn_low_max t_st))

  (setq
    x_min (car zn_min)
    x_max (car zn_max)
    tbl
	  (mapcar
	    (function
	      (lambda (el_max el_min)
		(+ el_min
		   (/ (* 1.0 (- n x_min) (- el_max el_min)) (- x_max x_min))
		)
	      )
	    )
	    (cdr zn_max)
	    (cdr zn_min)
	  )
    
  )
  (inters_pline_x (mapcar (function list) q_zn tbl) uz)
)

;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

(setq vyazkost_1
		 '(
		   (550.0
		    0.065
		    (0.91e9 1.89e9 1.38e9 1.28e9 1.70e9 1.20e9 1.44e9 1.25e9)
		   )
		   (550.0
		    0.09
		    (2.44e9 1.32e9 1.20e9 0.69e9 0.53e9 0.51e9 0.83e9 0.82e9)
		   )
		   (550.0
		    0.20
		    (2.40e9 1.77e9 3.50e9 2.48e9 1.63e9 1.93e9 2.22e9 2.27e9)
		   )
		   (550.0
		    0.50
		    (3.10e9 1.81e9 1.95e9 2.14e9 2.51e9 2.40e9 2.79e9 2.53e9)
		   )
		   (550.0
		    0.70
		    (2.94e9 2.50e9 3.45e9 3.68e9 5.35e9 4.75e9 6.19e9 5.73e9)
		   )
		   (550.0
		    1.30
		    (7.50e9 5.53e9 5.22e9 6.04e9 5.39e9 10.0e9 9.95e9 9.53e9)
		   )
		   (600.0
		    0.65
		    (6.02e8 10.1e8 1.07e8 0.78e8 0.97e8 0.95e8 1.14e8)
		   )
		   (600.0
		    0.20
		    (18.9e8 1.74e8 1.36e8 1.67e8 1.69e8 1.37e8 2.44e8)
		   )
		   (600.0
		    0.50
		    (8.25e8 3.27e8 1.27e8 1.09e8 1.96e8 2.35e8 4.44e8)
		   )
		   (600.0
		    1.20
		    (6.93e8 4.03e8 2.88e8 3.89e8 4.90e8 7.68e8 9.37e8)
		   )
		  )
      vyazkost_2 '((550.0
		    0.2
		    (0.26e10 0.23e10 0.26e10 0.29e10 0.45e10 0.61e10 0.47e10 0.72e10 0.6e10)
		   )
		   (550.0
		    0.5
		    (0.34e10 0.31e10 0.33e10 0.49e10 0.77e10 0.95e10 0.99e10 1.57e10 1.69e10)
		   )
		   (550.0
		    0.34
		    (0.34e10 0.27e10 0.21e10 0.29e10 0.43e10 0.44e10 0.72e10 0.66e10 1.70e10)
		   )
		   (600.0
		    0.09
		    (0.83e9 0.63e9 0.48e9 0.48e9 0.46e9	0.54e9 0.87e9 0.97e9 1.05e9)
;;;1.05e10  - ???
		   )
		   (600.0
		    0.2
		    (3.18e9 2.23e9 1.95e9 2.75e9 2.94e9	3.84e9 4.83e9 6.55e9 6.52e9)
		   )
		   (600.0
		    0.5
		    (2.5e9 2.33e9 1.95e9 1.33e9	1.10e9 1.22e9 2.10e9 2.35e9 2.70e9)
		   )
		   (600.0
		    0.7
		    (2.56e9 1.80e9 1.38e9 0.97e9 1.68e9	2.17e9 6.01e9 7.74e9 7.65e9)
		   )
		   (600.0
		    1.3
		    (2.50e9 2.06e9 1.46e9 1.31e9 0.95e9	0.73e9 0.75e9 1.34e9 1.35e9)
		   )
		   (650.0
		    0.2
		    (31.5e8 22.9e8 20.2e8 16.8e8 14.2e8	10.2e8 10.0e8 7.79e8 6.07e8)
		   )
		   (650.0
		    1.2
		    (5.08e9 4.64e9 3.67e9 2.34e9 1.78e9	1.32e9 1.22e9 1.07e9 0.83e9)
		   )
		  )
)

(defun f_1
	   (vya)
  (mapcar
    (function
      (lambda (el / len)
	(setq el_1    (car el)
	      el_2    (cadr el)
	      el_3    (caddr el)
	      len     (length el_3)
	      sum     (apply '+ el_3)
	      sred    (/ sum len)
	      min_val (apply 'min el_3)
	      max_val (apply 'max el_3)
	)
	(prins "\nel_1" el_1)
	(prins "\tel_2" el_2)
	(prins "\tel_3" el_3)
	(prins "\nlen" len)
	(prins "\tsum" sum)
	(prins "\tsred" sred)
	(prins "\tmin_val" min_val)
	(prins "\tmax_val" max_val)
	(princ "\n")
	t
      )
    )
    vya
  )
  (princ)
)

(defun f_2 (vya)
;;;Вожвращает сиписок температур, встречающихся в данном списке vya.
  (bin_or
    (mapcar
      (function
	(lambda	(el)
	  (car el)
	)
      )
      vya
    )
  )
)

(defun f_3 (vya tt)
  (mapcar
    (function
      (lambda (el / tmp_vya v_elem ll_elem)
	(setq tmp_vya vya)
	(while tmp_vya
	  (setq	v_elem	(assoc el tmp_vya)
		tmp_vya	(cdr (member v_elem tmp_vya))
	  )
	  (if v_elem
	    (setq ll_elem (append (caddr v_elem) ll_elem))
	  )
	)
	(list el ll_elem)
      )
    )
    tt
  )
)

(defun f_4 (vya)
  (mapcar
    (function
      (lambda (el / lst)
        (setq lst (caddr el))
	(list (car el) (cadr el) (sr_arifm lst) (sr_kv_otkl lst) (koeff_var lst))
      )
    )
    vya
  )
)

(defun f_5 (vya / l_big)
  (setq
    l_big (f_3 vya (f_2 vya))
  )
  (mapcar
    (function
      (lambda (el / lst)
	(setq lst (cadr el))
	(list (car el)
	      (sr_arifm lst)
	      (sr_kv_otkl lst)
	      (koeff_var lst)
	)
      )
    )
    l_big
  )
)
;|«Visual LISP© Format Options»
(95 2 5 2 nil "end of " 60 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

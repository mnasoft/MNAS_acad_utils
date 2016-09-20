;;;"И.Е. Идельчик Справочник по гидравлическому сопротивлению фасонных и прямых частей трубопроводов. с 300."
;;;"Кинематический коэффициент вязкости воды. (t[С] nu[m^2/c])"
(setq nu_water_tbl
       '(
;	 (0.0 1.8e-6)
;	 (10.0 1.3e-6)
;	 (20.0 1.01e-6)
;	 (40.0 0.66e-6)
	 (60.0 0.48e-6)
	 (80.0 0.37e-6)
	 (100.0 0.3e-6)
	 (120.0 0.25e-6)
	 (140.0 0.22e-6)
	)
)

(mapcar
  (function
    (lambda (el)
      (list (* 0.01 (car el) 10.0) (* 1.0e6(cadr el)))
    )
  )
  nu_water_tbl
)

(osr_func
  '(X1 YY)
  '( (X1 X1) (X1) (1.0) (YY))
  
  (mapcar
    (function
      (lambda (el)
	(list (* 0.01 (car el) 10.0) (* 1.0e6 (cadr el)))
      )
    )
    nu_water_tbl
  )
  'nu_water
)


;|«Visual LISP© Format Options»
(130 2 5 2 nil "end of" 100 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

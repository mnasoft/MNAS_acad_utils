(defun cp_convert_C_to_K*0.001 (lst)
  (mapcar
    (function
      (lambda
	(el)
	 (list (* 0.001 (+ 273.15 (car el))) (cadr el))
      )
    )
    lst
  )
)

(defun cv_convert_C_to_K*0.001 (lst)
  (mapcar
    (function
      (lambda
	(el)
	 (list (* 0.001 (+ 273.15 (car el))) (caddr el))
      )
    )
    lst
  )
)

(osr_func
  '(XX  YY)
  '((1.0)
     (XX)
     (XX XX)
     (XX XX XX)
     (XX XX XX XX)
     (XX XX XX XX XX)
     (XX XX XX XX XX XX)
     (XX XX XX XX XX XX XX)
     (XX XX XX XX XX XX XX XX)
     (XX XX XX XX XX XX XX XX XX)
     (XX XX XX XX XX XX XX XX XX XX)
     (YY)
   )
  (cp_convert_C_to_K*0.001 o2_t_cp_cv)
  'cp_o2
)

(convert_C_to_K*0.001 o2_t_cp)
tbl_names

(mapcar  (function    (lambda (el)      (cp_o2 el)))
  (mapcar (function car) (convert_C_to_K*0.001 o2_t_cp))
)
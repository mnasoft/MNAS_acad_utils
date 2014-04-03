(defun sr_arifm	(x)
  (/ (apply '+ x) (length x))
)

(defun disp_n-1(x / N-1 SUMM X_SR)
  (setq	x_sr   (sr_arifm x)
	
	n-1    (1- (length x))
	summ   (apply '+
		      (mapcar
			(function
			  (lambda (el)
			    (* (- el x_sr) (- el x_sr))
			  )
			)
			x
		      )
	       )
  )
  (/ summ n-1)
)

(defun dispersiya (x)
  (-
    (/ (apply '+
	      (mapcar
		(function
		  (lambda (el)
		    (* el el)
		  )
		)
		x
	      )
       )
       (length x)
    )
    (* (SR_ARIFM X) (SR_ARIFM X))
  )
)

(defun sr_kv_otkl (x)
  (sqrt (disp_n-1 x))
)

(defun koeff_var (x)
  (/ (sr_kv_otkl x)
     (SR_ARIFM X)
  )
)
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

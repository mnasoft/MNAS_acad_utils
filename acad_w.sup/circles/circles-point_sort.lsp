(defun exclude_small_equal-center_circles
       (p_lst / lst p_cen p_curr rez_list ss)
  (setq	lst
	 (vl-sort
	   p_lst
	   (function
	     (lambda (el1 el2 / ed1 ed2 e1 e2 r1 r2)
	       (setq ed1 (entget el1)
		     ed2 (entget el2)
		     e1	 (cdr (assoc 10 ed1))
		     e2	 (cdr (assoc 10 ed2))
		     r1	 (cdr (assoc 40 ed1))
		     r2	 (cdr (assoc 40 ed2))
	       )
	       (cond
		 ((and (= (car e1) (car e2)) (= (cadr e1) (cadr e2)))
		  (> r1 r2)
		 )
		 ((= (car e1) (car e2))
		  (< (cadr e1) (cadr e2))
		 )
		 ((< (car e1) (car e2))
		 )
	       )
	     )
	   )
	 )
  )
  (setq ss (ssadd))
  (mapcar
    (function
      (lambda (en)
	(setq
	  el	(entget en)
	  p_cen	(cdr (assoc 10 el))
	)
	(cond
	  ((equal p_curr p_cen)
	  )
	  (t
	   (setq p_curr p_cen)
     ;(setq rez_list (cons el rez_list))
	   (ssadd en ss)
	   nil
	  )
	)
      )
    )
    lst
  )
  ss
)



  
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
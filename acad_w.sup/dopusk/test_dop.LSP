(mapcar
  (function
    (lambda (el)
      (print (car el))
      (print (mapcar
	       (function
		 (lambda (el1)
		   (length el1)
		 )
	       )
	       (cadr el)
	     )
      )
    )
  )
  dop_val
)

;|«Visual LISP© Format Options»
(180 2 40 2 nil "end of " 100 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

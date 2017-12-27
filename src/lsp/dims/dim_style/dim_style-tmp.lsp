

(defun sss ()
  (setq
    dst_list nil
    dst	     (tblnext "dimstyle" t)
    dst_list (cons dst dst_list)
  )
  (while
    (setq dst (tblnext "dimstyle"))
     (setq dst_list (cons dst dst_list))
  )
  (mapcar
    (function
      (lambda (el)
	(cdr (assoc 2 el))
      )
    )
    dst_list
  )
)
(setq dim_str_list
       '(
	 ("$0" "Linear")
	 ("$2" "Angular")
	 ("$3" "Diameter")
	 ("$4" "Radial")
	 ("$6" "Ordinate")
	 ("&7" "Leader")
	)
)








































































































































































































































;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

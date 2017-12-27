;;;(princ "\nЗагружаю utils/table_interpolation")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "For_lic/formuly     "))

(defun half_div	(lx ly x / l r i d y)
  (setq	l 0
	r (1- (length lx))
  )
  (if (> (nth l lx) (nth r lx))
    (setq lx (reverse lx)
	  ly (reverse ly)
    )
  )
  (while (> (- r l) 1)
    (setq
      d	(cond ((= d 1) 0)
	      ((= d 0) 1)
	      (t 1)
	)
      i	(/ (+ r l) 2)
    ) ;setq
    (cond
      (
       (= (nth i lx) x)
       (setq r i
	     l i
	     y (nth i ly)
       )
      )
      ((> (nth i lx) x) (setq r i))
      ((< (nth i lx) x) (setq l i))
    ) ;cond
  )  ;while
  (if
    (null y)
     (setq
       y
	(+
	  (nth l ly)
	  (/
	    (*
	      (- (nth r ly) (nth l ly))
	      (- x (nth l lx))
	    )
	    (- (nth r lx) (nth l lx))
	  )
	)
     )
  )
  y
)

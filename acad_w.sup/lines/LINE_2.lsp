(defun c:join_overlap_lines ()
  (princ "\nОбъединяет линии лежащие одна над другой.")
  (prompt "\nВыберите отрезки:")
;;;  (setq ent_last (entlast))
  (setq	li  (ssget '(
		     (-4 . "<OR")
		     (0 . "LINE")
		     (-4 . "OR>")
		    )
	    )
  )
  (mapcar
    (function
      (lambda (el)
	(entget el)
      )
    )
    (sort_lines (ss_to_list li))
  )
)

(defun sort_lines (p_lst / lst)
  (setq
    lst
     (vl-sort
       p_lst
       (function
	 (lambda (el1 el2 / ed1 ed2 a1 a2 d1 d2)
	   (setq ed1 (line_norma el1)
		 ed2 (line_norma el2)
		 a1  (car ed1)
		 d1  (cadr ed1)
		 a2  (car ed2)
		 d2  (cadr ed2)
	   )
	   (cond
	     ((= a1 a2)
	      (< d1 d2)
	     )
	     (t(< a1 a2))
	   )
	 )
       )
     )
  )
  lst
)








(defun line_norma (en / ed a a_pi2 p0 p00 p1 p_rez)
  (setq ed (entget en))
  (setq
    p00	  '(0.0 0.0 0.0)
    p0	  (cdr (assoc 10 ed))
    p1	  (cdr (assoc 11 ed))
    a	  (angle p0 p1)
    a_pi2 (+ a (/ pi 2.0))
    p_rez (inters p0 p1 p00 (polar p00 a_pi2 1.0) nil)
  )
  (list (angle p00 p_rez) (distance p00 p_rez))
)

(defun line_norma (en / vla_line a a_pi2 p0 p00 p1 p_rez)
  (setq	vla_line (vlax-ename->vla-object en)
	p00	 '(0.0 0.0 0.0)
	p_rez	 (vlax-curve-getClosestPointTo vla_line p00 t)
  )
  (list (angle p00 p_rez) (distance p00 p_rez))
)


'(
  ((-1 . <Entity name: 7efdc378>) (0 . "LINE") (330 . <Entity name: 7efc8cf8>) (5 . "1AF") (100 . "AcDbEntity") (67 . 0) (410 . "Model") (8 . "0") (62 . 5) (100 . "AcDbLine") (10 1190.03 1192.06 0.0) (11 1257.96 1085.34 0.0) (210 0.0 0.0 1.0))
  ((-1 . <Entity name: 7efdc370>) (0 . "LINE") (330 . <Entity name: 7efc8cf8>) (5 . "1AE") (100 . "AcDbEntity") (67 . 0) (410 . "Model") (8 . "0") (100 . "AcDbLine") (10 1029.9 1192.06 0.0) (11 1190.03 1192.06 0.0) (210 0.0 0.0 1.0))
  ((-1 . <Entity name: 7efdc368>) (0 . "LINE") (330 . <Entity name: 7efc8cf8>) (5 . "1AD") (100 . "AcDbEntity") (67 . 0) (410 . "Model") (8 . "0") (62 . 1) (100 . "AcDbLine") (10 753.32 968.925 0.0) (11 1029.9 1192.06 0.0) (210 0.0 0.0 1.0))
  )


;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

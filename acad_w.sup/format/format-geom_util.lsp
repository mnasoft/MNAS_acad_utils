(defun hid_re (p1 p2 p3 p4 ss1)
;;; Отбрачывает части линии заключенные внутри четырехугольника ограниченного точками p1-p2-p3-p4.
;;; Четырехугольник должен быть выпуклым.
;;;Возвращает набор из оставшихся частей линий.
  (setq pick2 (hid_tr p1 p2 p3 ss1))
  (setq pick3 (hid_tr p1 p3 p4 pick2))
)

(defun hid_tr (p1 p2 p3 ss1 / en1 ed1 en2 ss2 ss3 i1)
;;;Отбрасывает части линий из набора ss1 внутри границ треугольника p1 p2 p3.
;;;Возвращает набор из оставшихся частей линий.
  (setq ss2 (ssadd))
  (while (> (sslength ss1) 0)
    (if	(= (cdr	(assoc 0 (setq ed1 (entget (setq en1 (ssname ss1 0)))))
	   )
	   "LINE"
	)
      (progn
	(setq ss3 (tr_hide p1 p2 p3 ed1))

	(setq i1 (sslength ss3))
	(while
	  (>= (setq i1 (1- i1)) 0)
	   (setq en2 (ssname ss3 i1))
	   (setq dss
		  (distance
		    (cdr (assoc 10 (entget en2)))
		    (cdr (assoc 11 (entget en2)))
		  )
	   )
	   (if (>= 0.01 dss)
	     (progn
	       (entdel en2)
	       (setq ss3 (ssdel en2 ss3))
	     )
	   )
	)

	(while
	  (> (sslength ss3) 0)
	   (if (not (ssmemb (setq en2 (ssname ss3 0)) ss2))
	     (setq ss2 (ssadd en2 ss2))
	   )
	   (setq ss3 (ssdel en2 ss3))
	)
      )
    )
    (setq ss1 (ssdel en1 ss1))
  )
  (setq pick1 ss2)
  ss2
)

(defun tr_hide (p1 p2 p3 ed1 / i1 i2 i pt ed2 pt3 pt4 pt5 i3 ss4)
;;;Отбрасывает части линии ed1 внутри границ треугольника p1 p2 p3.
;;;Возвращает набор из оставшихся частей линий
  (setq ss4 (ssadd en1))
  (setq pt1 (cdr (assoc 10 ed1)))
  (setq pt2 (cdr (assoc 11 ed1)))
  (setq i1 (point_triang p1 p2 p3 pt1))
  (setq i2 (point_triang p1 p2 p3 pt2))
  (if (< i1 i2)
    (setq i   i1
	  i1  i2
	  i2  i
	  pt  pt1
	  pt1 pt2
	  pt2 pt
    )
  )
  (cond
    (
     (and (>= i1 0) (<= i1 1) (>= i2 0) (<= i2 1))
     (setq ss4 (ssdel en1 ss4))
     (entdel en1)
    )
    ((and (= i1 2) (= i2 0))
     (if (setq pt (inters p1 p2 pt1 pt2))
       (setq pt3 pt)
     )
     (if (setq pt (inters p2 p3 pt1 pt2))
       (setq pt3 pt)
     )
     (if (setq pt (inters p3 p1 pt1 pt2))
       (setq pt3 pt)
     )
     (setq ed1 (subst (cons 11 pt3) (assoc 11 ed1) ed1))
     (setq ed1 (subst (cons 10 pt1) (assoc 10 ed1) ed1))
     (entmod ed1)
     (setq ss4 (ssadd (cdr (assoc -1 ed1)) ss4))
    )
    ((and (= i1 i2 2))
     (setq pt3 nil
	   pt4 nil
	   pt5 nil
	   i3  0
     )
     (if (setq pt (inters p1 p2 pt1 pt2))
       (progn
	 (setq i3 (1+ i3))
	 (cond ((= i3 1) (setq pt3 pt))
	       ((= i3 2) (setq pt4 pt))
	       ((= i3 3) (setq pt5 pt))
	 )
       )
     )
     (if (setq pt (inters p2 p3 pt1 pt2))
       (progn
	 (setq i3 (1+ i3))
	 (cond ((= i3 1) (setq pt3 pt))
	       ((= i3 2) (setq pt4 pt))
	       ((= i3 3) (setq pt5 pt))
	 )
       )
     )
     (if (setq pt (inters p3 p1 pt1 pt2))
       (progn
	 (setq i3 (1+ i3))
	 (cond ((= i3 1) (setq pt3 pt))
	       ((= i3 2) (setq pt4 pt))
	       ((= i3 3) (setq pt5 pt))
	 )
       )
     )
     (if (>= i3 2)
       (progn
	 (if (> (distance pt1 pt3) (distance pt1 pt4))
	   (progn
	     (setq ed2 ed1)
	     (setq ed1 (subst (cons 10 pt1) (assoc 10 ed1) ed1))
	     (setq ed1 (subst (cons 11 pt4) (assoc 11 ed1) ed1))
	     (entmake
	       (subst (cons 10 pt2)
		      (assoc 10 ed2)
		      (subst (cons 11 pt3) (assoc 11 ed2) ed2)
	       )
	     )
	   )
	   (progn
	     (setq ed2 ed1)
	     (setq ed1 (subst (cons 10 pt1) (assoc 10 ed1) ed1))
	     (setq ed1 (subst (cons 11 pt3) (assoc 11 ed1) ed1))
	     (entmake
	       (subst (cons 10 pt2)
		      (assoc 10 ed2)
		      (subst (cons 11 pt4) (assoc 11 ed2) ed2)
	       )
	     )
	   )
	 )
	 (entmod ed1)
	 (setq ss4 (ssadd (entlast) ss4))
       )
     )
    )
    (
     (and (= i1 2) (= i2 1))
	  ;(getstring "\n Попали на границу!!!")
     (setq pt3 nil
	   pt4 nil
	   pt5 nil
	   i3  0
     )
     (if (setq pt (inters p1 p2 pt1 pt2))
       (progn
	 (setq i3 (1+ i3))
	 (cond ((= i3 1) (setq pt3 pt))
	       ((= i3 2) (setq pt4 pt))
	       ((= i3 3) (setq pt5 pt))
	 )
       )
     )
     (if (setq pt (inters p2 p3 pt1 pt2))
       (progn
	 (setq i3 (1+ i3))
	 (cond ((= i3 1) (setq pt3 pt))
	       ((= i3 2) (setq pt4 pt))
	       ((= i3 3) (setq pt5 pt))
	 )
       )
     )
     (if (setq pt (inters p3 p1 pt1 pt2))
       (progn
	 (setq i3 (1+ i3))
	 (cond ((= i3 1) (setq pt3 pt))
	       ((= i3 2) (setq pt4 pt))
	       ((= i3 3) (setq pt5 pt))
	 )
       )
     )
     (cond
       ((= i3 1)
	  ;(getstring "\n::1")
       )
       ((= i3 2)
	  ;(getstring "\n::2")
	(if (> (distance pt1 pt3) (distance pt1 pt4))
	  (progn
	    (setq ed2 ed1)
	    (setq ed1 (subst (cons 10 pt1) (assoc 10 ed1) ed1))
	    (setq ed1 (subst (cons 11 pt4) (assoc 11 ed1) ed1))
	  )
	  (progn
	    (setq ed2 ed1)
	    (setq ed1 (subst (cons 10 pt1) (assoc 10 ed1) ed1))
	    (setq ed1 (subst (cons 11 pt3) (assoc 11 ed1) ed1))
	  )
	)
	(entmod ed1)
       )
       ((= i3 3)
	(getstring "\n::3")
       )
     )
    )
  )
  ss4
)
;|«Visual LISP© Format Options»
(120 2 10 2 nil "end of " 60 10 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

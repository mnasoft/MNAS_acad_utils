;;;get_pt_lst - Возвращает список точек.
;;;get_rad_cen - 
;;;sum_kv_otkl_c_pts
;;;c:find_arc_by_cir_and_points 


(defun
      get_pt_lst (/ ss len nm ed pt lpts)
  (princ "\nТочки через которые будет проходить дуга:")
  (setq
    ss	(ssget)
    len	(sslength ss)
  )
  (while (> len 0)
    (setq
      len  (1- len)
      nm   (ssname ss len)
      ed   (entget nm)
      pt   (cdr (assoc 10 ed))
      lpts (cons pt lpts)
    )
  )
  lpts
)

(defun
      get_rad_cen (/ cen rad)
  (setq
    cen	(getpoint "\nЦентр окружности:")
    cen	(list (car cen) (cadr cen) 0.0)
    rad	(getdist cen "\nРадиус:")
  )
  (list rad (car cen) (cadr cen))
)


(defun
      sum_kv_otkl_c_pts	(cen rad pts / sum)
  (setq sum 0.0)
  (mapcar
    (function
      (lambda (el / delta)
	(setq
	  el	(list (car el) (cadr el) 0.0)
	  delta	(- (distance el cen) rad)
	  sum	(+ sum (* delta delta))
	)
      )
    )
    pts
  )
  (- 0.0 sum)
)

;;;;;;("find_arc_by_cir_and_points" "not defined" "not defined")
(defun
      c:find_arc_by_cir_and_points
				   (/		     ed
				    cen		     rad
				    ang		     pts
				    ang_r	     tan_rad
				    tan_cen
				    out_arc_by_cir_and_points
				    in_arc_by_cir_and_points
				   )
 ;________________________________________________________________________________
  (defun
	out_arc_by_cir_and_points
				 (ang rad / cen)
    (setq cen (polar tan_cen ang (+ rad tan_rad)))
    (sum_kv_otkl_c_pts cen rad pts)
  )
 ;________________________________________________________________________________
  (defun
	in_arc_by_cir_and_points
				(ang rad / cen)
    (setq cen (polar tan_cen ang (- tan_rad rad)))
    (sum_kv_otkl_c_pts cen rad pts)
  )
 ;________________________________________________________________________________
  (setq
    ed	    (entget (car (entsel "\nКасательная дуга(окружность):")))
    tan_rad (cdr (assoc 40 ed))
    tan_cen (cdr (assoc 10 ed))
    tan_cen (list (car tan_cen) (cadr tan_cen) 0.0)
    pts	    (get_pt_lst)
    cen	    (getpoint "\nЦентр окружности:")
    rad	    (getdist cen "\nРадиус окружности:")
    ang	    (angle tan_cen cen)
    ang_r   (list ang rad)
  )
  (cond
    (
     (>= (distance tan_cen cen) tan_rad)
     (setq ang_r (spusk	out_arc_by_cir_and_points
			ang_r		 '(0.1 1.0)
			'(1.6 1.6)	 '(0.6 0.6)
			500
		       )
     )

     (entmake
       (list
	 (cons 0 "CIRCLE")
	 (cons
	   10
	   (polar
	     tan_cen
	     (car ang_r)
	     (+ (cadr ang_r) tan_rad)
	   )
	 )
	 (cons 40 (cadr ang_r))
       )
     )

    )
    (
     (< (distance tan_cen cen) tan_rad)
     (setq ang_r (spusk	in_arc_by_cir_and_points
			ang_r		 '(0.1 1.0)
			'(1.6 1.6)	 '(0.6 0.6)
			50
		       )
     )

     (entmake
       (list
	 (cons 0 "CIRCLE")
	 (cons
	   10
	   (polar
	     tan_cen
	     (car ang_r)
	     (- tan_rad (cadr ang_r))
	   )
	 )
	 (cons 40 (cadr ang_r))
       )
     )

    )
  )
)

;;;;;;("find_arc_by_points"
;;;;;;"Производит поиск окружности, проходящей через несколько точек.\n
;;;;;;Расстояние от которой до определенного" "not defined")
(defun
      c:find_arc_by_points (/ pts rc)
 ;________________________________________________________________________________
  (defun
	arc_by_point (rad cen_x cen_y / cen)
    (setq cen (list cen_x cen_y 0.0))
    (sum_kv_otkl_c_pts cen rad pts)
  )	  ;arc_by_point
 ;________________________________________________________________________________
  (setq
    pts	(get_pt_lst)
    rc	(get_rad_cen)
    rc	(spusk arc_by_point
	       rc
	       '(10.0
		 10.0
		 10.0
		)
	       '(1.6 1.6 1.6)
	       '(0.6 0.6 0.6)
	       500
	)
  )
  (entmake
    (list
      (cons 0 "CIRCLE")
      (list 10 (cadr rc) (caddr rc) 0.0)
      (cons 40 (car rc))
    )
  )
)
;|«Visual LISP© Format Options»
(72 2 10 2 nil "end of " 60 5 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

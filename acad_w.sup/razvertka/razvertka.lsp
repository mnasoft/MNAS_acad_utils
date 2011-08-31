(VL-LOAD-COM)
(defun c:razvertka (/ ;
		    vo_1 ; Образующая листа, отображающая изгибы листа. (Полилиния).
		    vo_2 ; Первая линия реза.
		    vo_3 ; 
		    vo_4 ; Вторая линия реза.
		    n ;Количество точек для каждого сегмента полилинии.
		    a_23     a_43     dst      d_23	d_43	 e_par	  i	   n_delen  par
		    pnt	     p_bok_23 p_bok_43 p_mid	p_vo_2	 p_vo_3	  p_vo_4   start_pnt
		    s_par    vo_line  v_bok_23 v_bok_43	v_mid	 v_pnt_2  v_pnt_3  v_pnt_4
		   )
  (command "_vslide" "C:\\Program Files\\MNASoft\\MNAS_acad_db17_utils\\acad_w.sup\\prj\\razvertka\\razvertka.sld")
  (prompt "\nКогда будете готовы нажмите ВВОД.")
  (command pause "_redraw")
  (setq
    vo_1      (vlax-ename->vla-object
		(car (entsel "\nВыберите серединную образующую (вид на торец листа):"))
	      )
    vo_2      (vlax-ename->vla-object (car (entsel "\nПервую линию обрезки:")))
    vo_3      (vlax-ename->vla-object (car (entsel "\nЛинию направления развертки:")))
    vo_4      (vlax-ename->vla-object (car (entsel "\nВторую линию обрезки:")))
    start_pnt (getpoint "\nУкажите точку начала развертки:")
    n	      (getint "\nКоличество точек разбиения каждого сегмента полилинии <5> :")
    n	      (cond
		((null n) 5)
		(t n)
	      )
    s_par     (vlax-curve-getStartParam vo_1)
    e_par     (vlax-curve-getEndParam vo_1)
    n_delen   (* (- e_par s_par) n)
    par	      s_par
    i	      0
  )
  (dr:point start_pnt 7)

  (while (<= par e_par)
    (print par)
    (setq pnt (vlax-curve-getPointAtParam vo_1 par)
	  dst (vlax-curve-getDistAtParam vo_1 par)
    )
    (setq vo_line (dr:line pnt (polar pnt 0 1.) 2))
    (setq p_vo_2   (vlax-safearray->list
		     (vlax-variant-value
		       (vlax-invoke-method
			 vo_line
			 'IntersectWith
			 vo_2
	       ;acExtendNone;  Does not extend either object.
	       ;acExtendThisEntity ;	Extends the base object.
	       ;acExtendOtherEntity	;	Extends the object passed as an argument.
			 acExtendBoth ;	Extends both objects.
		       )
		     )
		   )
	  p_vo_3   (vlax-safearray->list
		     (vlax-variant-value
		       (vlax-invoke-method
			 vo_line
			 'IntersectWith
			 vo_3
	       ;acExtendBoth
	       ;acExtendNone;  Does not extend either object.
			 acExtendThisEntity ;	Extends the base object.
	       ;acExtendOtherEntity	;	Extends the object passed as an argument.
	       ;acExtendBoth	;	Extends both objects.

		       )
		     )
		   )
	  p_vo_4   (vlax-safearray->list
		     (vlax-variant-value
		       (vlax-invoke-method
			 vo_line
			 'IntersectWith
			 vo_4
	       ;acExtendBoth
	       ;acExtendNone;  Does not extend either object.
			 acExtendThisEntity ;	Extends the base object.
	       ;acExtendOtherEntity	;	Extends the object passed as an argument.
	       ;acExtendBoth	;	Extends both objects.
		       )
		     )
		   )


	  d_23	   (distance p_vo_2 p_vo_3)
	  d_43	   (distance p_vo_4 p_vo_3)

	  a_23	   (angle p_vo_3 p_vo_2)
	  a_43	   (angle p_vo_3 p_vo_4)

	  p_mid	   (polar start_pnt (* 0.5 pi) dst)
	  p_bok_23 (polar p_mid a_23 d_23)
	  p_bok_43 (polar p_mid a_43 d_43)
    )
    (setq
      v_pnt_2  (dr:point p_vo_2 2)
      v_pnt_3  (dr:point p_vo_3 3)
      v_pnt_4  (dr:point p_vo_4 3)

      v_mid    (dr:point p_mid 3)
      v_bok_23 (dr:point p_bok_23 3)
      v_bok_43 (dr:point p_bok_43 3)
    )
    (vlax-invoke-method vo_line 'Delete)
    (vlax-invoke-method v_pnt_2 'Delete)
    (vlax-invoke-method v_pnt_3 'Delete)
    (vlax-invoke-method v_pnt_4 'Delete)
    (setq
      i	  (1+ i)
      par (/ (* i (- e_par s_par)) n_delen)
    )
  )
  (princ "Развертка полностью построена!!!\n")
  (princ "УРА товарищи!\n")
  (princ)
)

(defun c:r_cone (/ A1 A2 L1 L2 P0 P01 P02 P1 P2 R1 R2)
  (setq p01 (getpoint "\nВведите первую точку на оси конуса:" ))
  (setq p02 (getpoint "\nВведите вторую точку на оси конуса:" ))
  (setq p1 (getpoint "\nВведите первую точку на образующей конуса:" ))
  (setq p2 (getpoint "\nВведите вторую точку на оси конуса:" ))
  (setq p0 (inters p01 p02 p1 p2 nil))
  (setq
    r1 (distance p0 p1); Длина первой образующей
    r2 (distance p0 p2); Длина второй образующей
    l1 (distance p1 (inters p1 (polar p1 (+ (* pi 0.5)(angle p01 p02)) (distance p01 p02) ) p01 p02 nil))
    l2 (distance p2 (inters p2 (polar p2 (+ (* pi 0.5)(angle p01 p02)) (distance p01 p02) ) p01 p02 nil))
    a1 (/ (* pi 2.0 l1) r1 )
    a2 (/ (* pi 2.0 l2) r2 )
  )
  (dr:arc p0 r1 0 a1 2)
  (dr:arc p0 r2 0 a2 2)
)

(defun c:r_cone_1 (/ A1 A2 L1 L2 P0 P01 P02 P1 P2 R1 R2)
  (setq p01 (getpoint "Введите первую точку на оси конуса:" ))
  (setq p02 (getpoint "Введите вторую точку на оси конуса:" ))
  (setq p1 (getpoint "Введите первую точку на образующей конуса:" ))
  (setq p2 (getpoint "Введите вторую точку на оси конуса:" ))
  (setq p0 (inters p01 p02 p1 p2 nil))
  (setq
    r1 (distance p0 p1); Длина первой образующей
    r2 (distance p0 p2); Длина второй образующей
    l1 (distance p1 (inters p1 (polar p1 (+ (* pi 0.5)(angle p01 p02)) (distance p01 p02) ) p01 p02 nil))
    l2 (distance p2 (inters p2 (polar p2 (+ (* pi 0.5)(angle p01 p02)) (distance p01 p02) ) p01 p02 nil))
    a1 (/ (* pi 2.0 l1) r1 )
    a2 (/ (* pi 2.0 l2) r2 )
  )
  (dr:arc p0 r1 0 a1 2)
  (dr:arc p0 r2 0 a2 2)
)
;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

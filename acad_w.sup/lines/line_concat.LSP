(vl-load-com)

(defun v3d->list (v3d)
  (vlax-safearray->list
    (vlax-variant-value v3d)
  )
)

(defun is-collinear (v_line_1 v_line_2 delta / v_tmp)
  (if (< (vlax-get-property v_line_1 'Length) (vlax-get-property v_line_2 'Length))
    (setq
      v_tmp    v_line_1
      v_line_1 v_line_2
      v_line_2 v_tmp
    )
  )
  (setq	sp (v3d->list(vlax-get-property v_line_2 'StartPoint))
	ep (v3d->list(vlax-get-property v_line_2 'EndPoint))
  )

  (and (< (distance sp (vlax-curve-getClosestPointTo v_line_1 sp t)) delta)
       (< (distance ep (vlax-curve-getClosestPointTo v_line_1 ep t)) delta)
  )
)

(defun is-pnt-on-line (pnt v_line delta)
  (< (distance pnt (vlax-curve-getClosestPointTo v_line pnt nil)) delta)
)

(defun dist-from-pnt-to-curve (pnt v_curve ext)
  (distance pnt (vlax-curve-getClosestPointTo vname pnt ext))
)

(defun c:concatenate_two_lines()
  (setq ss(ssget '((0 . "LINE"))))

;;;    delta 0.0001
;;;    v_line_1 (vlax-ename->vla-object (car (entsel)))
;;;    v_line_2 (vlax-ename->vla-object (car (entsel)))
)

(defun c:concatenate_two_lines (v_line_1 v_line_2 delta /)

  (setq
    lns_clnr (is-collinear v_line_1 v_line_2 delta)
    vl1s (v3d->list(vlax-get-property v_line_1 'StartPoint))
    vl1e (v3d->list(vlax-get-property v_line_1 'EndPoint))
    vl2s (v3d->list(vlax-get-property v_line_2 'StartPoint))
    vl2e (v3d->list(vlax-get-property v_line_2 'EndPoint))	      
    vl2s_on_vl1 (is-pnt-on-line vl2s v_line_1 delta)
    vl2e_on_vl1 (is-pnt-on-line vl2e v_line_1 delta)
    vl1s_on_vl2 (is-pnt-on-line vl1s v_line_2 delta)
    vl1e_on_vl2 (is-pnt-on-line vl1e v_line_2 delta)
  )
  
  (cond
    ((not lns_clnr) (princ "Нет коллинеарности.\n")
    )
    ((and vl1s_on_vl2 vl1e_on_vl2) (princ "\nПервый отрезок полностью лежит на втором отрезке.\n")
     (vlax-invoke-method v_line_1 'Delete)
    )
    ((and vl2s_on_vl1 vl2e_on_vl1)(princ "\nВторой отрезок полностью лежит на первом отрезке.\n")
     (vlax-invoke-method v_line_2 'Delete)
    )
    ((and (null vl2s_on_vl1) vl2e_on_vl1 (null vl1s_on_vl2) vl1e_on_vl2)
      (princ (strcat "\nКонечная точка второго отрезка лежит на первом отрезке"
		     "\nКонечная точка первого отрезка лежит на втором отрезке"
		     "\n"
	     )
      )
      (vlax-put-property v_line_1 'EndPoint (vlax-get-property v_line_2 'StartPoint))
     (vlax-invoke-method v_line_2 'Delete)
    )
    ((and (null vl2s_on_vl1) vl2e_on_vl1 vl1s_on_vl2 (null vl1e_on_vl2))
      (princ (strcat "\nКонечная точка второго отрезка лежит на первом отрезке"
		     "\nНачальная точка первого отрезка лежит на втором отрезке"
		     "\n"
	     )
      )
      (vlax-put-property v_line_1 'StartPoint (vlax-get-property v_line_2 'StartPoint))
     (vlax-invoke-method v_line_2 'Delete)
    )
    ((and  vl2s_on_vl1 (null vl2e_on_vl1) (null vl1s_on_vl2) vl1e_on_vl2)
     (princ (strcat "\nНачальная точка второго отрезка лежит на первом отрезке"
		     "\nКонечная точка первого отрезка лежит на втором отрезке"
		     "\n"
	     )
      )
      (vlax-put-property v_line_1 'EndPoint (vlax-get-property v_line_2 'EndPoint))
     (vlax-invoke-method v_line_2 'Delete)
    )
    ((and vl2s_on_vl1 (null vl2e_on_vl1) vl1s_on_vl2 (null vl1e_on_vl2))
     (princ (strcat "\nНачальная точка второго отрезка лежит на первом отрезке"
		     "\nНачальная точка первого отрезка лежит на втором отрезке"
		     "\n"
	     )
      )
     (vlax-put-property v_line_1 'StartPoint (vlax-get-property v_line_2 'EndPoint))
     (vlax-invoke-method v_line_2 'Delete)
    )
    ((and (null vl2s_on_vl1) (null vl2e_on_vl1) (null vl1s_on_vl2) (null vl1e_on_vl2))
      (princ "\nОтрезки коллинеарны но общих точек нет\n")
    )
    (t (princ "\nСлучай не обрабатывается\n"))
  )
  (princ "lns_clnr vl2s_on_vl1 vl2e_on_vl1 vl1s_on_vl2 vl1e_on_vl2")
  (PRINT (LIST lns_clnr vl2s_on_vl1 vl2e_on_vl1 vl1s_on_vl2 vl1e_on_vl2))
  (princ)
)

(defun c:obj-dump ()
  (vlax-dump-Object (vlax-ename->vla-object (car (entsel))) t)
)
  
(setq pnt (getpoint "aaa:"))

;|«Visual LISP© Format Options»
(120 2 40 2 nil "end of" 100 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

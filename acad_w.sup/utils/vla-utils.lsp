(vl-load-com)

;;;;;;("vla-obj-dump" "������� ���� ������������������ �� ������������ ���������." "�������")
(defun c:vla-obj-dump ()
  (vlax-dump-Object (vlax-ename->vla-object (car (entsel))) t)
)

;;;;;;("vla-obj" "���������� ��� vla �������." "�������")
(defun c:vla-obj (/ name)
  (setq name (getstring "������� ��� ����������:"))
  (set (read name) (vlax-ename->vla-object (car (entsel))))
)

;;;	���������� ��� vla �������.
(defun vla-obj (vla-name)
  (set (read vla-name) (vlax-ename->vla-object (car (entsel))))
)

;;; ����������� ���������� �� ����� �� ������ vobj-from,
;;; ���������� ���������� param, �� �������������� � ������.
(defun distance-from-curve-by-param-to-curve
					     (vobj-from	     param	    vobj-to	   /
					      pnt_at_param ;����� �� ������ ��������������� ������� ���������
					      FirstDeriv ; ������ ����������� �� ������ �� ���������
					      SecondDeriv ; ������ ����������� �� ������ �� ���������
					      pnt_center ; �����
					      vobj-line ; �������
					      ang_int ;
					      ang_first ;
					      ang_delta_int_first ;
					      pnt_first ; �����
					      dist_rez ;
					     )
  (setq	pnt_at_param
		     (vlax-curve-getPointAtParam vobj-from param)
	FirstDeriv
		     (vlax-curve-getFirstDeriv vobj-from param)
	SecondDeriv
		     (vlax-curve-getSecondDeriv vobj-from param)
	pnt_first    (mapcar (function +) pnt_at_param FirstDeriv)
	ang_first    (angle pnt_at_param pnt_first)
  )
  (cond
    (
     ;; ������ �� ����� ������ ����������
     (= (distance SecondDeriv '(0.0 0.0 0.0)) 0.0)
     (setq
       vobj-line
	(dr:line pnt_at_param
		 (polar	pnt_at_param
			(+ ang_first (/ pi 2))
			(DISTANCE pnt_first pnt_at_param)
		 )
		 1
	)
     )
    )
    (
     ;; ������ ����� ����� ����������
     (> (distance SecondDeriv '(0.0 0.0 0.0)) 0.0)
     (setq pnt_center
		      (mapcar (function +) pnt_at_param SecondDeriv)
	   vobj-line
		      (dr:line pnt_at_param pnt_center 1)
     )
    )
  )
  (setq
    pnt_inters
			(vlax-safearray->list
			  (vlax-variant-value
			    (vlax-invoke-method
			      vobj-line
			      'IntersectWith
			      vobj-to
			      acExtendThisEntity
     ;			      acExtendBoth
			    )
			  )
			)
    pnt_inters		(devide-list pnt_inters 3) ;
    pnt_inters		(distance-short pnt_at_param pnt_inters)

    ang_int		(angle pnt_at_param pnt_inters)
    ang_delta_int_first	(angle-normalize[-pi_pi] (- ang_int ang_first))
  )
  (vlax-invoke-method vobj-line 'Delete)
;;;  (dr:point pnt_inters 1)
  (setq	dist_rez (* (/ ang_delta_int_first (abs ang_delta_int_first))
		    (distance pnt_inters pnt_at_param)
		 )
  )
)

;;	���������� ���������� ��
(defun distances-from-curve-to-curve-ndiv
					  (vobj-from ndiv ; ���������� �������
					   vobj-to / delta-param s-param e-param pts)
  (setq	s-param	    (vlax-curve-getStartParam vobj-from)
	e-param	    (vlax-curve-getEndParam vobj-from)
	delta-param (/ (- e-param s-param) ndiv)
	i	    0
  )
  (while (<= i ndiv)
    (setq param	(+ s-param (* delta-param i))
	  pts	(cons
		  (list
		    param
		    (distance-from-curve-by-param-to-curve
		      vobj-from
		      param
		      vobj-to
		    )
		  )
		  pts
		)
    )
    (setq i (1+ i))
  )
  (reverse pts)
)

;;;f;;;("devide-list" "��������� ������ lst �� ������ �� n ���������.")
(defun devide-list (lst n / lst_rez group_lst el i)
  (setq i n)
  (while lst
    (setq
      el  (car lst)
      lst (cdr lst)
    )
    (cond
      ((= i 1)
       (setq
	 i	   n
	 group_lst (append group_lst (list el))
	 lst_rez   (append lst_rez (list group_lst))
	 group_lst nil
       )
      )
      (t
       (setq
	 i	   (1- i)
	 group_lst (append group_lst (list el))
       )
      )
    )
  )
  lst_rez
)

;;;f;;;("pnt-distance-short"
;;;f;;;"���������� ����� �� ������ ����� pnt-lst-to,\n
;;;f;;;���������� �� ������� �� ����� pnt-from �������� ����������.")
(defun distance-short (pnt-from pnt-lst-to /)
  (cadar
    (vl-sort
      (mapcar
	(function
	  (lambda (el)
	    (list (distance el pnt-from) el)
	  )
	)
	pnt-lst-to
      )
      (function (lambda (el1 el2) (< (car el1) (car el2))))
    )
  )
)

(defun find_ename_whis_handle (handle / do_it ename e_data i rez_ename ss ss_len)
  (setq	ss     (ssget "X")
	ss_len (sslength ss)
	i      0
	do_it  t
  )

  (while do_it
    (setq
      ename  (ssname ss i)
      e_data (entget ename)
      i	     (1+ i)
    )
    (cond
      (
       (= handle (cdr (assoc 5 e_data)))
       (setq
	 do_it nil
	 rez_ename ename
       )
      )
      ((< i ss_len)
      )
      (t (setq do_it nil))
    )
  )
  rez_ename
)
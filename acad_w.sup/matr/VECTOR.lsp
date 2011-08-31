;;;(princ "\n�������� Matr/vector         ")
(princ (strcat "\n�������� " (acad_sup) "/" "Matr/vector         "))

;;	vect_vect*(p1 p2)	- ��������� ������������ �����.
(defun vect_vect* (p1 p2)

  (list
    (- (* (cadr p1) (caddr p2)) (* (caddr p1) (cadr p2)))
    (- (* (caddr p1) (car p2)) (* (car p1) (caddr p2)))
    (- (* (car p1) (cadr p2)) (* (cadr p1) (car p2)))
  )
)

;;	vect_scal*(p1 p2)	- ��������� ������������ �����.
(defun vect_scal* (p1 p2)
  (apply (function +) (mapcar (function *) p1 p2))
)

;;	vect_sc*(p1 sc)	- ������������ ������� �� �����.
(defun vect_sc*	(p1 sc)
  (mapcar (function *) p1 (list sc sc sc))
)

;;	vect_sc/(p1 sc)	- ������� ������� �� �����.
(defun vect_sc/	(p1 sc)
  (mapcar '/ p1 (list sc sc sc))
)

;;	vect_+(p1 p2)	- ����� ���� ��������.
(defun vect_+ (p1 p2)
  (mapcar '+ p1 p2)
)
;;	vect_-(p1 p2)	- �������� ���� ��������.
(defun vect_-(p1 p2)
  (mapcar '- p1 p2)
)

;;	vect_norma(p1)	- ����� �������.
(defun vect_norma(p1)
  (sqrt (apply '+ (mapcar '* p1 p1)))
)
;;	axis_x_o(ax_z_o / ax_x_o)	- ���������� ����������� ��� x ��������� ������� ���������.
;;	��������� ��� z ��������� ������� ���������.
;;	���������� ��� x ��������� ������� ���������.
(defun axis_x_o	(ax_z_o / ax_x_o)
  (setq	ax_z_o (vect_sc/ ax_z_o (vect_norma ax_z_o))
     ; �������������� ����� ������� � 1.0
  )
  (if (and
	(< (abs (car ax_z_o)) (/ 1.0 64.0))
	(< (abs (cadr ax_z_o)) (/ 1.0 64.0))
      )
    (setq ax_x_o (vect_vect* '(0.0 1.0 0.0) ax_z_o))
    (setq ax_x_o (vect_vect* '(0.0 0.0 1.0) ax_z_o))
  )
  (vect_sc/ ax_x_o (vect_norma ax_x_o))
     ; �������������� ����� ������� � 1.0
)

;;	pt_ang_o_u (ed pt ang_u)	- �������� �������� ��������� ����� �������, ����� 
;;	1)��� x ��� ��������� ���� ����������� ��� x ��� ���������� 
;;	�� ���� ang_u.
;;	2)��� z OCK ��������� ���� ����������� ��� z ���.
;;	3)����� ������� pt_10 ��������� ������ ���������� � ���.
(defun pt_ang_o_u (ed	    pt	     ang_u    /	       ax_x_u
		   ax_y_u   ax_x_o   ax_y_o   ax_z_o   ang_o_u
		   pt_w
		  )
  (setq
    ax_x_u  (getvar "UCSXDIR")
    ax_y_u  (getvar "UCSYDIR")
    ax_z_o  (vect_vect* ax_x_u ax_y_u)

    ax_x_o  (axis_x_o ax_z_o)
    ax_y_o  (vect_vect* ax_z_o ax_x_o)
    pt_w    (trans pt 1 0)

    ang_o_u (atan (vect_scal* ax_x_o ax_y_u) (vect_scal* ax_x_o ax_x_u))
    ed	    (subst (cons 210 ax_z_o) (assoc 210 ed) ed)
    ed	    (subst (cons 50 (- ang_u ang_o_u)) (assoc 50 ed) ed)
    ed	    (subst (cons 10
			 (list (vect_scal* pt_w ax_x_o)
			       (vect_scal* pt_w ax_y_o)
			       (vect_scal* pt_w ax_z_o)
			 )
		   )
		   (assoc 10 ed)
		   ed
	    )
  )
)

(princ "\t...��������.\n")
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

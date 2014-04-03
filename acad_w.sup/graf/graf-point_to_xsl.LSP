(defun c:pnt_xls (/ ed en len pnt ss x y z lst fl fn p0 x0 y0 z0 tbl)
  (prompt "�������� ����� ��� ������ � html-����:")
  (setq
    ss	(ssget)
    len	(sslength ss)
  )
  (setq
    p0 (getpoint "������� ������ ���������:")
    x0 (car p0)
    y0 (cadr p0)
    z0 (caddr p0)
  )
  (while (>= (setq len (1- len)) 0)
    (setq en (ssname ss len)
	  ed (entget en)
    )
    (if	(= "POINT" (cdr (assoc 0 ed)))
      (progn
	(setq pnt (cdr (assoc 10 ed))
	      x	  (- (car pnt) x0)
	      y	  (- (cadr pnt) y0)
	      z	  (- (caddr pnt) z0)
	      tbl (cons (list x y z) tbl)
	)
      )
    )
  )
  (setq	tbl
	 (vl-sort
	   tbl
	   (function
	     (lambda (pnt1 pnt2)
	       (< (car pnt1) (car pnt2))
	     )
	   )
	 )
  )
  (setq fn (getfiled "������� ��� ����� ��� ������ ��������� �����" "" "html" 1))
  (setq fl (open fn "w"))
  (tbl_to_xls tbl fl)
  (close fl)
)

;;;f;;;("tbl_to_xls" "����� ������� � html �������"
;;;f;;;)
(defun tbl_to_xls (tbl ; ������� ��� ������
		   fl ; ���������� ��������� �����
		  )
  (princ "<table>" fl)
  (mapcar
    (function
      (lambda (lst)
	(princ "<tr>" fl)
	(mapcar
	  (function
	    (lambda (el)
	      (princ "<td>" fl)
	      (princ el fl)
	      (princ "</td>" fl)
	    )
	  )
	  lst
	)
	(princ "</tr>" fl)
      )
    )
    tbl
  )
  (princ "</table>" fl)
)

(defun c:d_di ()
  (setq	d1 (getdist "������ ����������:")
	d2 (getdist "������ ����������:")
  )
  (ANGTOS (atan (/ (- d2 d1) (+ d2 d1))) 0 4)
)
;|�Visual LISP� Format Options�
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** �� ���������� ����� ��� �������������! ***|;

;;;(princ "\n�������� Lines/line_1        ")
(princ (strcat "\n�������� " (acad_sup) "/" "Big_fnt/LITERA      "))

;;;;;;("xt" "���������|������������ ��������� �������� � ��� ����� �� dl." "������")
(defun c:xt (/ li dl cur num en ed PT1 PT2 PT_1 PT_2)
  (command "_.undo" "_begin")
  (prompt "\n����� ��� ��������� � ��� �������:")
  (setq li (ssget '((0 . "LINE"))))
  (setq dl (getdist "\n������� ����������:"))
  (setq cur 0)
  (setq num (sslength li))
  (while (< cur num)
    (setq
      en   (ssname li cur)
      ed   (entget en)
      pt1  (cdr (assoc 10 ed))
      pt2  (cdr (assoc 11 ed))
      pt_1 (polar pt2 (angle pt1 pt2) dl)
      pt_2 (polar pt1 (angle pt2 pt1) dl)
      ed   (dsubst ed (list (cons 10 pt_1) (cons 11 pt_2)))
    )
    (entmod ed)
    (setq cur (+ cur 1))
  )
  (command "_.undo" "_end")
  (princ)
)

;;;;;;("exl" "���������|������������ ������� � ���� ������� �� dl." "������")
(defun c:exl (/ dist en ed ename_pt pt pt1 pt2 pt3 pt4)
  (command "_.undo" "_begin")
  (setq	ename_pt (entsel "\n�������� ����� � ���������� �������:")
	en	 (car ename_pt)
	ed	 (entget en)
	pt	 (trans (last ename_pt) 1 0)
	dist	 (getdist "\n������� ���������� :")
	pt1	 (cdr (assoc 10 ed))
	pt2	 (cdr (assoc 11 ed))
  )
  (if (> (distance pt1 pt) (distance pt2 pt))
    (progn
      (setq pt3 (polar pt2 (angle pt1 pt2) dist))
      (ch_dxf en 11 pt3)
    )
    (progn
      (setq pt4 (polar pt1 (angle pt2 pt1) dist))
      (ch_dxf en 10 pt4)
    )
  )
  (command "_.undo" "_end")
  (princ)
)

;;;;;;("z0"
;;;;;;"������������ ������������� ��������� ����� �� ��������� Z=0.\n
;;;;;;����������� ��� ������������� � ������ ����� ����������\n
;;;;;;��� ����� ���������.(������� ���)." "������")
(defun c:z0 (/ en ed p0 p1 i SS)
  (setq
    ss (ssget)
    i  (sslength ss)
  )
  (while (>= (setq i (1- i)) 0)
    (setq
      en (ssname ss i)
      ed (entget en)
    )
    (cond
      ((= "LINE" (cdr (assoc 0 ed)))
       (setq
	 p0 (set_z0 10 ed)
	 p1 (set_z0 11 ed)
	 ed (subst p0 (assoc 10 ed) ed)
	 ed (subst p1 (assoc 11 ed) ed)
       )
       (entmod ed)
      )
    )
  )
  t
)

(defun set_z0 (code p)
  (setq
    p (assoc code p)
    p (reverse p)
    p (cdr p)
    p (append (list 0.0) p)
    p (reverse p)
  )
)

(princ "\t...��������.\n")
;|�Visual LISP� Format Options�
(72 2 20 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

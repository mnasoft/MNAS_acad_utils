;;;(princ "\n�������� Otvjerstija/f_otv     ")
(princ (strcat "\n�������� " (acad_sup) "/" "Otvjerstija/f_otv     "))

(defun f_otv (d) (* 0.25 pi d d))

(defun d_ek (f)
  (sqrt (/ (* 4.0 f) pi))
)

;;; ������� �������

(defun f_zikl (f_e ; - ������������� ������� ���� ������������� ������� ���������� �������� �� ���� ��������� �������.
	       f_1 ; - ������������� ������� ���� ��������� �������������.
	       )
  (sqrt
    (/ 1.0
       (- (/ 1.0 (* f_e f_e)) (/ 1.0 (* f_1 f_1)))
    )
  )
)

;;; ��������� �������, ������������� ������� ��������������� ������������� �������������.
;;; ��������������, ��� ����� ����������� ����� ������� �� ���������.
(defun f_ek_zikl (l_f ; - ������, ���������� ��������� �������.
		  /	;
		  zero	;
		 )
  (mapcar (function (lambda (el)
		      (if (ZEROP el)
			(setq zero t)
		      )
		    )
	  )
	  l_f
  )
  (cond
    (zero 0.0)
    (t
     (sqrt
       (/ 1.0
	  (apply
	    (function +)
	    (mapcar
	      (function
		(lambda	(el)
		  (/ 1.0 (* el el))
		)
	      )
	      l_f
	    )
	  )
       )
     )
    )
  )
)






;;;;;;("f_kolca" "���������� ������� ������." "�������")
(defun c:f_kolca (/ area p1 p1-p2 p2 p_mid p_mid-p_os p_os)
  (setq	p1	   (getpoint "������� 1 ����� �� ������:")
	p2	   (getpoint p1 "������� 2 ����� �� ������:")
	p_mid	   (mapcar
		     (function
		       (lambda (el1 el2)
			 (/ (+ el1 el2) 2.0)
		       )
		     )
		     p1
		     p2
		   )
	p_os	   (getpoint p_mid "���������� ���������� �� ���:")
	p1-p2	   (distance p1 p2)
	p_mid-p_os (distance p_mid p_os)
	area	   (* p1-p2 p_mid-p_os 2.0 pi)
  )
  (princ "\n����� ������ p1-p2: ")
  (princ p1-p2)
  (princ "\n������ ������ p_mid-p_os: ")
  (princ p_mid-p_os)
  (princ "\n�������: ")
  (princ area)
  (princ)
)

(defun f_kolca (/ area p1 p1-p2 p2 p_mid p_mid-p_os p_os)
  (setq	p1	   (getpoint "������� 1 ����� �� ������:")
	p2	   (getpoint p1 "������� 2 ����� �� ������:")
	p_mid	   (mapcar
		     (function
		       (lambda (el1 el2)
			 (/ (+ el1 el2) 2.0)
		       )
		     )
		     p1
		     p2
		   )
	p_os	   (getpoint p_mid "���������� ���������� �� ���:")
	p1-p2	   (distance p1 p2)
	p_mid-p_os (distance p_mid p_os)
	area	   (* p1-p2 p_mid-p_os 2. pi)
  )
  (princ "\n����� ������ p1-p2: ")
  (princ p1-p2)
  (princ "\n������ ������ p_mid-p_os: ")
  (princ p_mid-p_os)
  (princ "\n�������: ")
  (princ area)
  area
)

(princ "\t...��������.\n")
;|�Visual LISP� Format Options�
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

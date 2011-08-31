;;;;;;("read_dat" "not defined" "not defined")
(defun c:read_dat (/
		   fn ; ��� �����
		   fl ; ���������� �����
		   ln ; ������
		   
		  )
  (setq	fn
	 (getfiled "�������� ���� � ������� �������" "" "dat" 0)
  )
  (setq fl (open fn "r"))
  (cond
    ((/= 'str (type fn))
     (alert (princ "���������� fn �� �������� ����� �����."
	    )
     )
     
    )
    ((null fl)
     (alert
       (princ
	 (strcat "�� ���� ������� ���� :" fn".")
       )
     )
     (exit)
    )
  )
  (setq assa nil)
  (while
    (setq ln (read-line fl))
    (setq str (strcat "(" ln ")"))
    (setq rd (read str))
    (setq rd (list (car rd) (cadr rd) 0.0))
    (setq assa(append assa (list rd)))
  )
  (close fl)
)




;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

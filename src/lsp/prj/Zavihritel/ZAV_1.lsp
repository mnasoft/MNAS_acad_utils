;;;;;;("�����������" "not defined" "�������")
(defun c:����������� (/ fn fl_i fl_o )
  (setq	fn_i (getfiled "����� ����� ���" "" "scr" 0)
	fn_o "23.scr"
	fl_i (open fn_i "r")
        fl_o (open fn_o "w")
  )
  (cond
    ((/= 'str (type fn_i))
     (alert (princ "���������� fn_i �� �������� ����� �����."
	    )
     )
     
    )
    ((null fl_i)
     (alert
       (princ
	 (strcat "�� ���� ������� ����: " fn_i ".")
       )
     )
     (exit)
    )
  )
  (cond
    ((/= 'str (type fn_o))
     (alert (princ "���������� fn_o �� �������� ����� �����."
	    )
     )
     
    )
    ((null fl_o)
     (alert
       (princ
	 (strcat "�� ���� ������� ����: " fn_o ".")
       )
     )
     (exit)
    )
  )
  (while (setq str (read-char  fl_i))
    (if ( /= str (ascii " "))
      (write-char str fl_o)
    )
  )
  (close fl_i)
  (close fl_o)
  (command "script" fn_o)
)
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

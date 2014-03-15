;;;;;;("acad_pgp"
;;;;;;"���������� ����� � ������ ����� acad.pgp,
;;;;;; �������������� ��� ������� ���������� ������ � ������� ������ ACAD
;;;;;; ��� �������� ������������.
;;;;;; ������� �� ����� ���������� ������������ pgp �����.
;;;;;; ����� ������ ������������, ��������� � �������� �����,
;;;;;; ����������� ����������� ��������� �� ��� �� �������� �� � ������� ���������.
;;;;;; �������� pgp ���� �� ����������.
;;;;;; ���������, ��� �������������, ������� ������� �������,
;;;;;; ������� ��������� ������ ��������� ������ ����������� ��������� pgp �����." "not defined")
(defun c:acad_pgp (/ abrev_str abrev_str_tr command_str lst_str fl_in fn lst_abrev_command str str1 str2 str3 str4)
  (setq fn (findfile "acad.pgp"))
  (if (null fn)
    (progn (alert (princ "�� ���� ����� ���� acad.pgp.\n"))
	   (exit)
    )
  )
  (setq fl_in (open fn "r"))
  (if (null fl_in)
    (progn (file-open-err fn) (exit))
  )
  (write-line (strcat " ... " fn " ..." ))
  (while (setq str (read-line fl_in))
    (cond
      ((= str "")
       (write-line str)
      )
      ((= (substr str 1 1) " ")
       (write-line str)
      )
      ((= (substr str 1 1) ";")
       (write-line str)
      )
      (t
       (setq lst_str (str_token str ","))
       (cond
	 ((< (length lst_str) 2)
	  (write-line str)
	 )
	 ((> (length lst_str) 2)
	  (write-line str)
	 )
	 (t
	  (setq	abrev_str (car lst_str)
		abrev_str (vl-string-left-trim " \t\n" abrev_str)
		abrev_str (vl-string-right-trim " \t\n" abrev_str)
		abrev_str (vl-string-translate str_keyboard str_opchatka abrev_str)
	  )
	  (setq	command_str (cadr lst_str)
		command_str (vl-string-left-trim " \t\n" command_str)
		command_str (vl-string-right-trim " \t\n" command_str)
	  )
	  (write-line str)
	  (write-line (strcat abrev_str ", " command_str))
	 )
       )
      )
    )
  )
  (close fl_in)
  (write-line (strcat " ...  " fn "..." ))
  (princ)
)
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

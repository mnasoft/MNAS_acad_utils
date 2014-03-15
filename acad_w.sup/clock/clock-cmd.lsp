;;;(princ "\n�������� Clock/clock         ")
(princ (strcat "\n�������� " (acad_sup) "/" "Clock/clock         "))

;;;;;;("clock_off" "���������� �����." "not defined")
(defun c:clock_off()
  (if
    (/= (getvar "users1") "")
     (setvar "modemacro" (getvar "users1"))
     (setvar "modemacro" "")
  )
  (princ)
)

;;;;;;("clock_on" "��������� �����." "not defined")
(defun c:clock_on ()
  (if
    (/= (getvar "modemacro") "")
     (setvar "users1" (getvar "modemacro"))
     (setvar
       "users1"
       (strcat
	 " La $(substr,$(getvar,clayer),1,20)"
	 "$(if,$(getvar,orthomode), O)"
	 "$(if,$(getvar,snapmode), S)"
	 "$(if,$(getvar,tabmode), T)"
	 "$(if,$(=,$(getvar,tilemode),0),$(if,$(=,$(getvar,cvport),1), P))"
	)
     )
  )
  (setvar "modemacro"
	  (strcat
	    "$(eval,$(getvar,users1))"
     ;��������� � ������� 10 ���
     ;set 123=���������  � 12:30:00 �� 12:39:59
	    "$(getenv,$(substr,$(edtime,$(getvar,date),HHMM),1,3))"
     ;��������� �� ���� �����
     ;set 1207=� ���� �������� ����!
	    "$(getenv,$(edtime,$(getvar,date),DDMO))"
     ;��������� �� ������������ ���� ������ � ������������ �����
     ;
	    "$(getenv,$(edtime,$(getvar,date),DDDHHMM))"
     ;��������� � ������� HHMM
     ;set 1730=���������
     ;     "$(getenv,$(edtime,$(getvar,date),HHMM))"
     ;���� ���������� ������ ������ �� 10�
	    "$(if,"
	    "$(eq,$(substr,$(edtime,$(getvar,date),SS),1,1),0),"
	    "$(edtime,$(getvar,date),"
	    " DDD DD/MON/YYYY HH:MM:SS))"
	   ) ;strcat
  )  ;setvar
  (princ)
)

(princ "\t...��������.\n")

;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

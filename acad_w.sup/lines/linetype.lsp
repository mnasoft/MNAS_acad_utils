;;;(princ "\n�������� Linetype/linetype   ")
(princ (strcat "\n�������� " (acad_sup) "/" "Linetype/linetype   "))

;;;;;;("ltp" "�������� ������� �����." "���������")
(defun c:ltp ()
  (command "_ltscale" "10")
  (command "_psltscale" "1")
  (command "_-linetype"	 "_load"       "*"   (strcat (acad_sup) "/lines/eskd")  )
  (while (= 1 (getvar "CMDACTIVE"))
    (command "")
  )
  (command "_regen")
  (princ)
)

(princ "\t...��������.\n")
;|�Visual LISP� Format Options�
(105 2 15 2 nil "end of" 90 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
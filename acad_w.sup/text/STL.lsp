;;;(princ "\n�������� text/stl            ")
(princ (strcat "\n�������� " (acad_sup) "/" "text/stl            "))

;;;;;;("stl"
;;;;;;"������������� � ����������� �� ��������� ����� ������ T �� ��������� �������:\n
;;;;;;\"es_***,my_b_f\"." "���������")
(defun c:stl ()
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (stl)
  (err-handle "")
)
(princ "\t...��������.\n")
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

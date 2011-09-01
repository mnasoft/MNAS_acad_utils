;;;(princ "\n�������� text/Redaktirovanije tjekstov.lsp")
(princ (strcat "\n�������� " (acad_sup) "/" "text/Redaktirovanije tjekstov.lsp"))

;;;;;;("de"
;;;;;;"�������� ������ ��� �������������� ������ ���������� ��������� �����:
;;;;;;MTEXT, TEXT, DIMENSION." "������")
(defun c:de (/ en obj temp)
  (setq
    en	 (car (entsel "\n�������� ��������:"))
    obj	 (entget en)
    temp (cdr (assoc 0 obj))
  )
  (cond
    (
     (or
       (= "MTEXT" temp)
       (= "TEXT" temp)
       (= "DIMENSION" temp)
     )
     (command "ddedit" en)
    )
    (
     (OR
       (= "INSERT" temp)
     )
     (command "ddatte" en)
    )
  )
  (princ)
)


;;;;;;("ate" "�������������� ��������." "������")
(defun c:ate (/ en obj temp)
  (setq
    en	 (car (nentsel "\n�������� ��������:"))
    obj	 (entget en)
    temp (cdr (assoc 0 obj))
  )
  (cond
    (
     (or
       (= "MTEXT" temp)
       (= "TEXT" temp)
       (= "DIMENSION" temp)
     )
     (command "ddedit" en)
    )
    (
     (or
       (= "ATTRIB" temp)
     )
     (command "attedit" "_y" "*" "*" "*" en)
    )
  )
  (princ)
)
(princ "\t...��������.\n")
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
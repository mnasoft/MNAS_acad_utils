;;;(princ "\nЗагружаю text/stl            ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "text/stl            "))

;;;;;;("stl"
;;;;;;"Устанавливает в зависимости от платформы ситль текста T на основании шрифтов:\n
;;;;;;\"es_***,my_b_f\"." "Настройка")
(defun c:stl ()
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (stl)
  (err-handle "")
)
(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

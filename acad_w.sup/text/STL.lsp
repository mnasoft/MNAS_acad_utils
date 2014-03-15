;;;;;;("stl"
;;;;;;"Устанавливает в зависимости от платформы ситль текста T на основании шрифтов:\n
;;;;;;\"es_***,my_b_f\"." "Настройка")
(defun c:stl  ()
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (stl)
  (err-handle ""))

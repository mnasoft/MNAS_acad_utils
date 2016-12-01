(setq str_keyboard
       "zZxXcCvVbBnNmM,<.>/?`~qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"€яч„с—мћи»т“ь№бЅюё.,Є®й…ц÷у”к е≈нЌг√шЎщўз«х’ъЏф‘ыџв¬ајпѕр–оќлЋдƒж∆эЁ")
(setq str_opchatka
       "€яч„с—мћи»т“ь№бЅюё.,Є®й…ц÷у”к е≈нЌг√шЎщўз«х’ъЏф‘ыџв¬ајпѕр–оќлЋдƒж∆эЁzZxXcCvVbBnNmM,<.>/?`~qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"")

;;; ѕроизводит дл€ списка l_cmds, состо€щего из строк их трансл€цию в другую кодировку.
;;;_$ (l_op_str '("str" "l" "ашд"))
;;;("ыек" "д" "fil")
(defun l_op_str  (l_cmds / rez el)
  (foreach el l_cmds (setq rez (cons (vl-string-translate str_keyboard str_opchatka el) rez)) (reverse rez)))

;;; ѕроизводит трансл€цию списка, l_cmds в дугую кодировку и загружает их в пам€ть.
(defun opech_cmds-str  (l_cmds / op_cmds)
  (setq op_cmds (l_op_str l_cmds))
  (mapcar (function (lambda (cmd op)
                      (setq cmd (strcat "c:" cmd)
                            op  (strcat "c:" op))
                      (princ (strcat "\n(defun " op "() (" cmd "))"))))
          l_cmds
          op_cmds)
  (princ))


  





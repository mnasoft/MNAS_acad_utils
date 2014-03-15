(setq str_keyboard
       "zZxXcCvVbBnNmM,<.>/?`~qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"€яч„с—мћи»т“ь№бЅюё.,Є®й…ц÷у”к е≈нЌг√шЎщўз«х’ъЏф‘ыџв¬ајпѕр–оќлЋдƒж∆эЁ")
(setq str_opchatka
       "€яч„с—мћи»т“ь№бЅюё.,Є®й…ц÷у”к е≈нЌг√шЎщўз«х’ъЏф‘ыџв¬ајпѕр–оќлЋдƒж∆эЁzZxXcCvVbBnNmM,<.>/?`~qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"")

;;; ѕроизводит трансл€цию списка, l_cmds в дугую кодировку и загружает их в пам€ть.
(defun opech_cmds  (l_cmds / op_cmds)
  (setq op_cmds (l_op_str l_cmds))
  (mapcar (function (lambda (cmd op)
		      (setq cmd	(strcat "c:" cmd)
			    op	(strcat "c:" op))
		      (eval (read (strcat "(defun " op "() (" cmd "))")))))
	  l_cmds
	  op_cmds))

;;; ѕроизводит дл€ списка l_cmds, состо€щего из строк их трансл€цию в другую кодировку.
;;;_$ (l_op_str '("str" "l" "ашд"))
;;;("ыек" "д" "fil")
(defun l_op_str	 (l_cmds)
  (mapcar (function (lambda (el) (vl-string-translate str_keyboard str_opchatka el)))
	  l_cmds))

(defun autoload_cmds_and_op-cmds  (progr_loc cmd_list)
  (autoload progr_loc cmd_list)
  (opech_cmds cmd_list)
  (autoload progr_loc (l_op_str cmd_list)))

;;;;;;("translit" "¬ыполн€ет транслитерацию с английской раскладки в русскую." "–едактировани€ текста"
;;;;;;)
(defun c:translit  ()
  (prompt "¬ыберите текст дл€ преобразовани€ кодировки.")
  (setq	ss  (ssget)
	len (sslength ss))
  (while (<= 0 (setq len (1- len)))
    (setq es (ssname ss len))
    (setq ed (entget es))
    (setq txt (cdr (assoc 1 ed)))
    (if	txt
      (progn (setq txt (vl-string-translate str_keyboard str_opchatka txt))
	     (setq ed (subst (cons 1 txt) (assoc 1 ed) ed))
	     (entmod ed)
	     (entupd es)))))
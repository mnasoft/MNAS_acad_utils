(princ "\nLoading .../opechatka/rus_cmd_opechatka.lsp     ")


(setq str_keyboard "zZxXcCvVbBnNmM,<.>/?`~qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"€яч„с—мћи»т“ь№бЅюё.,Є®й…ц÷у”к е≈нЌг√шЎщўз«х’ъЏф‘ыџв¬ајпѕр–оќлЋдƒж∆эЁ")
(setq str_opchatka "€яч„с—мћи»т“ь№бЅюё.,Є®й…ц÷у”к е≈нЌг√шЎщўз«х’ъЏф‘ыџв¬ајпѕр–оќлЋдƒж∆эЁzZxXcCvVbBnNmM,<.>/?`~qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"")

;;; ѕроизводит трансл€цию списка, l_cmds в дугую кодировку и загружает их в пам€ть.
(defun opech_cmds (l_cmds / op_cmds)
  (setq op_cmds (l_op_str l_cmds))
  (mapcar
    (function
      (lambda (cmd op)
	(setq
	  cmd (strcat "c:" cmd)
	  op  (strcat "c:" op)
	)
	(eval (read (strcat "(defun " op "() (" cmd "))")))
      )
    )
    l_cmds
    op_cmds
  )
)

;;; ѕроизводит дл€ списка l_cmds, состо€щего из строк их трансл€цию в другую кодировку.
;;;_$ (l_op_str '("str" "l" "ашд"))
;;;("ыек" "д" "fil")

(defun l_op_str	(l_cmds)
  (mapcar
    (function
      (lambda (el)
	(vl-string-translate str_keyboard str_opchatka el)
      )
    )
    l_cmds
  )
)

(defun autoload_cmds_and_op-cmds (progr_loc cmd_list)
  (autoload progr_loc cmd_list)
  (opech_cmds cmd_list)
  (autoload progr_loc (l_op_str cmd_list))
)

;;;;;;("translit" "¬ыполн€ет транслитерацию с английской раскладки в русскую." "–едактировани€ текста"
;;;;;;)
(DEFUN c:translit ()
  (PROMPT "¬ыберите текст дл€ преобразовани€ кодировки.")
  (SETQ	ss  (SSGET)
	len (SSLENGTH ss)
  )
  (WHILE (<= 0 (SETQ len (1- len)))
    (SETQ es (SSNAME ss len))
    (SETQ ed (ENTGET es))
    (SETQ txt (CDR (ASSOC 1 ed)))
    (IF	txt
      (PROGN
	(SETQ txt (VL-STRING-TRANSLATE str_keyboard str_opchatka txt))
	(SETQ ed (SUBST (CONS 1 txt) (ASSOC 1 ed) ed))
	(ENTMOD ed)
	(ENTUPD es)
      )
    )
  )
)

(princ "\t...loaded.\n")

;|ЂVisual LISP© Format Optionsї
(120 2 40 2 nil "end of" 100 9 2 1 0 T T nil T)
;*** Ќ≈ добавл€йте текст под комментари€ми! ***|;

(princ "\nLoading .../opechatka/rus_cmd_opechatka.lsp     ")


(setq str_keyboard "zZxXcCvVbBnNmM,<.>/?`~qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"������������������.,������������������������������������������������")
(setq str_opchatka "������������������.,������������������������������������������������zZxXcCvVbBnNmM,<.>/?`~qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"")

;;; ���������� ���������� ������, l_cmds � ����� ��������� � ��������� �� � ������.
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

;;; ���������� ��� ������ l_cmds, ���������� �� ����� �� ���������� � ������ ���������.
;;;_$ (l_op_str '("str" "l" "���"))
;;;("���" "�" "fil")

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

;;;;;;("translit" "��������� �������������� � ���������� ��������� � �������." "�������������� ������"
;;;;;;)
(DEFUN c:translit ()
  (PROMPT "�������� ����� ��� �������������� ���������.")
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

;|�Visual LISP� Format Options�
(120 2 40 2 nil "end of" 100 9 2 1 0 T T nil T)
;*** �� ���������� ����� ��� �������������! ***|;

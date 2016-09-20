(setq str_keyboard
       "zZxXcCvVbBnNmM,<.>/?`~qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"������������������.,������������������������������������������������")
(setq str_opchatka
       "������������������.,������������������������������������������������zZxXcCvVbBnNmM,<.>/?`~qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"")

;;; ���������� ���������� ������, l_cmds � ����� ��������� � ��������� �� � ������.
(defun opech_cmds  (l_cmds / op_cmds)
  (setq op_cmds (l_op_str l_cmds))
  (mapcar (function (lambda (cmd op)
                      (setq cmd (strcat "c:" cmd)
                            op  (strcat "c:" op))
                      (eval (read (strcat "(defun " op "() (" cmd "))")))))
          l_cmds
          op_cmds))

(defun opech_cmds-str  (l_cmds / op_cmds)
  (setq op_cmds (l_op_str l_cmds))
  (mapcar (function (lambda (cmd op)
                      (setq cmd (strcat "c:" cmd)
                            op  (strcat "c:" op))
                      (princ (strcat "\n(defun " op "() (" cmd "))"))))
          l_cmds
          op_cmds)
  (princ))


;;; ���������� ��� ������ l_cmds, ���������� �� ����� �� ���������� � ������ ���������.
;;;_$ (l_op_str '("str" "l" "���"))
;;;("���" "�" "fil")
(defun l_op_str  (l_cmds)
  (mapcar (function (lambda (el) (vl-string-translate str_keyboard str_opchatka el))) l_cmds))


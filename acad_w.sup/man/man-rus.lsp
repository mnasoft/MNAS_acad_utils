(setq *man-command-list* '("check_command_category_list" "man"))
;;;; (opech_cmds-str *man-command-list*)

(defun c:�����_�������_��������_����() (c:check_command_category_list))
(defun c:���() (c:man))

(princ "Loaded project man.\n")
(setq *clock-command-list* '("clock_off" "clock_on"))
;;;; (opech_cmds-str *clock-command-list*)

(defun c:�����_���() (c:clock_off))
(defun c:�����_��() (c:clock_on))

(princ "Loaded project clock.\n")

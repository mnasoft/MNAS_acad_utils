(setq *kompas-command-list* '("kompas_in" "kompas_out"))
;;;; (opech_cmds-str *kompas-command-list*)

(defun c:������_��() (c:kompas_in))
(defun c:������_���() (c:kompas_out))

(princ "Loaded project kompas.\n")
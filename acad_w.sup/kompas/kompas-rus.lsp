(setq *kompas-command-list* '("kompas_in" "kompas_out"))
;;;; (opech_cmds-str *kompas-command-list*)

(defun c:כשüחפû_רע() (c:kompas_in))
(defun c:כשüחפû_שדו() (c:kompas_out))

(princ "Loaded project kompas.\n")
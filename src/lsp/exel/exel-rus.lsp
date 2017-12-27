(setq *exel-command-list* '("exel_read"))
;;;; (opech_cmds-str *exel-command-list*)

(defun c:учуд_куфв() (c:exel_read))

(princ "Loaded project exel.\n")
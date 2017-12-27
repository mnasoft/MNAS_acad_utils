(setq *clock-command-list* '("clock_off" "clock_on"))
;;;; (opech_cmds-str *clock-command-list*)

(defun c:סהשסכ_שאא() (c:clock_off))
(defun c:סהשסכ_שע() (c:clock_on))

(princ "Loaded project clock.\n")

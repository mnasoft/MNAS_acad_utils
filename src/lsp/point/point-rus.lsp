(setq *point-command-list* '("pd" "xy" "xy_sc" "rot_p"))
;;;; (opech_cmds-str *point-command-list*)

(defun c:��() (c:pd))
(defun c:��() (c:xy))
(defun c:��_��() (c:xy_sc))
(defun c:���_�() (c:rot_p))

(princ "Loaded project point.\n")
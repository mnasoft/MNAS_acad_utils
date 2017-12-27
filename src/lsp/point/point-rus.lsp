(setq *point-command-list* '("pd" "xy" "xy_sc" "rot_p"))
;;;; (opech_cmds-str *point-command-list*)

(defun c:зв() (c:pd))
(defun c:чн() (c:xy))
(defun c:чн_ыс() (c:xy_sc))
(defun c:кще_з() (c:rot_p))

(princ "Loaded project point.\n")
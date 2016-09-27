(setq *position-command-list* '("pos_export" "pozition_set_text_scale" "edpos" "ep"))
;;;; (opech_cmds-str *position-command-list*)

(defun c:חשû_ףקחשךו() (c:pos_export))
(defun c:חשÿרורשע_ûףו_וףקו_ûספהף() (c:pozition_set_text_scale))
(defun c:ףגחשû() (c:edpos))
(defun c:ףח() (c:ep))

(princ "Loaded project position.\n")
(setq *position-command-list* '("pos_export" "pozition_set_text_scale" "edpos" "ep"))
;;;; (opech_cmds-str *position-command-list*)

(defun c:���_������() (c:pos_export))
(defun c:��������_���_����_�����() (c:pozition_set_text_scale))
(defun c:�����() (c:edpos))
(defun c:��() (c:ep))

(princ "Loaded project position.\n")
(setq *position-command-list* '("edpos" "ep" "pozition_set_text_scale" "pos_export"))
;;;;(opech_cmds-str *position-command-list*)

(defun c:�����() (c:edpos))
(defun c:��() (c:ep))
(defun c:��������_���_����_�����() (c:pozition_set_text_scale))
(defun c:���_������() (c:pos_export))

(princ "Loaded project pozitopn.\n")
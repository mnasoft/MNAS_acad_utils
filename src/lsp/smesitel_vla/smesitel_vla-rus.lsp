(setq *smesitel_vla-command-list* '("clear:sm" "dr:sech" "prep:sm" "dr:sm" "sm:help" "vla-obj-dump" "vla-obj"))
;;;; (opech_cmds-str *smesitel_vla-command-list*)

(defun c:��������() (c:clear:sm))
(defun c:�������() (c:dr:sech))
(defun c:�������() (c:prep:sm))
(defun c:�����() (c:dr:sm))
(defun c:�������() (c:sm:help))
(defun c:���-���-����() (c:vla-obj-dump))
(defun c:���-���() (c:vla-obj))

(princ "Loaded project smesitel_vla.\n")
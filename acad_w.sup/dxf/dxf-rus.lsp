(setq *dxf-command-list* '("obj" "nobj" "objxd" "nobjxd"))
;;;; (opech_cmds-str *dxf-command-list*)

(defun c:���() (c:obj))
(defun c:����() (c:nobj))
(defun c:�����() (c:objxd))
(defun c:������() (c:nobjxd))

(princ "Loaded project dxf.\n")


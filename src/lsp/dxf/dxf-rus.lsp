(setq *dxf-command-list* '("obj" "nobj" "objxd" "nobjxd"))
;;;; (opech_cmds-str *dxf-command-list*)

(defun c:щио() (c:obj))
(defun c:тщио() (c:nobj))
(defun c:щиочв() (c:objxd))
(defun c:тщиочв() (c:nobjxd))

(princ "Loaded project dxf.\n")


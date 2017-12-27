(setq *edit-command-list* '("mr" "mcp" "off" "ofd" "cr"))
;;;; (opech_cmds-str *edit-command-list*)

(defun c:ьк() (c:mr))
(defun c:ьсз() (c:mcp))
(defun c:щаа() (c:off))
(defun c:щав() (c:ofd))
(defun c:ск() (c:cr))

(princ "Loaded project edit.\n")
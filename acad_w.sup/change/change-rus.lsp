(setq *change-command-list* '("block_block" "block_point" "ch_wid" "point_block"))
;;;; (opech_cmds-str *change-command-list*)

(defun c:טהשסכ_טהשסכ () (c:block_block))
(defun c:טהשסכ_חשרעו () (c:block_point))
(defun c:סנ_צרג () (c:ch_wid))
(defun c:חשרעו_טהשסכ () (c:point_block))

(princ "Loaded project change.\n")


(setq *smesitel_vla-command-list* '("clear:sm" "dr:sech" "prep:sm" "dr:sm" "sm:help" "vla-obj-dump" "vla-obj"))
;;;; (opech_cmds-str *smesitel_vla-command-list*)

(defun c:ñäóôêÆûü() (c:clear:sm))
(defun c:âêÆûóñğ() (c:dr:sech))
(defun c:çêóçÆûü() (c:prep:sm))
(defun c:âêÆûü() (c:dr:sm))
(defun c:ûüÆğóäç() (c:sm:help))
(defun c:ìäô-ùèî-âãüç() (c:vla-obj-dump))
(defun c:ìäô-ùèî() (c:vla-obj))

(princ "Loaded project smesitel_vla.\n")
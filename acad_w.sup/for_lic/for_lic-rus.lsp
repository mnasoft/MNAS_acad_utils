(setq *for_lic-command-list* '("for_prov" "for_prover" "for_proect" "gr" "pr1" "pr2" "rep"))
;;;; (opech_cmds-str *for_lic-command-list*)

(defun c:���_����() (c:for_prov))
(defun c:���_������() (c:for_prover))
(defun c:���_������() (c:for_proect))
(defun c:��() (c:gr))
(defun c:��1() (c:pr1))
(defun c:��2() (c:pr2))
(defun c:���() (c:rep))

(princ "Loaded project for_lic.\n")
(setq *for_lic-command-list* '("for_prov" "for_prover" "for_proect" "gr" "pr1" "pr2" "rep"))
;;;; (opech_cmds-str *for_lic-command-list*)

(defun c:ΰωκ_ηκωμ() (c:for_prov))
(defun c:ΰωκ_ηκωμσκ() (c:for_prover))
(defun c:ΰωκ_ηκωσρε() (c:for_proect))
(defun c:οκ() (c:gr))
(defun c:ηκ1() (c:pr1))
(defun c:ηκ2() (c:pr2))
(defun c:κση() (c:rep))

(princ "Loaded project for_lic.\n")
(setq *m_utils_loader-command-list* '("mnas-cad-utils-path" "MNASoft-registry-uninstall" "MNASoft-registry-install"))
;;;; (opech_cmds-str *m_utils_loader-command-list*)

(defun c:üעפû-ספג-דורהû-חפונ() (c:mnas-cad-utils-path))
(defun c:ÜÒÔÛשאו-ךףןרûוךם-דערעûופהה() (c:MNASoft-registry-uninstall))
(defun c:ÜÒÔÛשאו-ךףןרûוךם-רעûופהה() (c:MNASoft-registry-install))

(princ "Loaded project m_utils_loader.\n")
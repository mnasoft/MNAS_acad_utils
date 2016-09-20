(defun mnasoft-registry-install-dbx-elem  (str)
  (cond
;;;    (
;;;     (wcmatch str "*ObjectDBX\\R19`.*")
;;;     (MNASoft-registry-install-DBX-elem-19R str)
;;;    )
        ((wcmatch str "*ObjectDBX\\R18`.*") (mnasoft-registry-install-dbx-elem-18r str))
        ((wcmatch str "*ObjectDBX\\R17`.*") (mnasoft-registry-install-dbx-elem-17r str))
;;;    (
;;;     (wcmatch str "*ObjectDBX\\R16`.*")
;;;     (MNASoft-registry-install-DBX-elem-16R str)
;;;    )
        ))

(defun mnasoft-registry-install-dbx-elem-19r  (str)
  (setq mnasoft_root (read_mnas_reg_str "19"))
  (setq path (strcat str "\\Applications" "\\" "MNASDbx_PozitionAPP"))
  (vl-registry-write path)
  (vl-registry-write path "DESCRIPTION" "MNASDbx_PozitionAPPObj")
  (vl-registry-write path "LOADCTRLS" 13)
  (vl-registry-write path "LOADER" (strcat mnasoft_root "MNASDbx_Pozition_19.dbx"))
  (setq path (strcat str "\\Applications" "\\" "MNASDbx_WeldingAPP"))
  (vl-registry-write path)
  (vl-registry-write path "DESCRIPTION" "MNASDbx_WeldingAPPObj")
  (vl-registry-write path "LOADCTRLS" 13)
  (vl-registry-write path "LOADER" (strcat mnasoft_root "MNASDbx_Welding_19.dbx")))



(defun mnasoft-registry-install-dbx-elem-18r  (str / path)
  (setq mnasoft_root (read_mnas_reg_str "18"))
;;;  (setq path (strcat str "\\Applications" "\\" "MNASDbx_PozitionAPP"))
;;;
;;;  (VL-REGISTRY-WRITE path)
;;;  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASDbx_PozitionAPPObj")
;;;  (VL-REGISTRY-WRITE path "LOADCTRLS" 13)
;;;  (VL-REGISTRY-WRITE
;;;    path
;;;    "LOADER"
;;;    (strcat MNASoft_root "MNASDbx_Pozition_18.dbx")
;;;  )
;;;  (setq path (strcat str "\\Applications" "\\" "MNASDbx_WeldingAPP"))
;;;
;;;  (VL-REGISTRY-WRITE path)
;;;  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASDbx_WeldingAPPObj")
;;;  (VL-REGISTRY-WRITE path "LOADCTRLS" 13)
;;;  (VL-REGISTRY-WRITE
;;;    path
;;;    "LOADER"
;;;    (strcat MNASoft_root "MNASDbx_Welding_18.dbx")
;;;  )
  )

;;;MNAS_ARXPRJ_ACAD_W

(defun mnasoft-registry-install-dbx-elem-17r  (str)
  (setq mnasoft_root (read_mnas_reg_str "17"))
  (setq path (strcat str "\\Applications" "\\" "MNASDbx_PozitionAPP"))
  (vl-registry-write path)
  (vl-registry-write path "DESCRIPTION" "MNASDbx_PozitionAPPObj")
  (vl-registry-write path "LOADCTRLS" 13)
  (vl-registry-write path "LOADER" (strcat mnasoft_root "MNASDbx_Pozition_17.dbx"))
  (setq path (strcat str "\\Applications" "\\" "MNASDbx_WeldingAPP"))
  (vl-registry-write path)
  (vl-registry-write path "DESCRIPTION" "MNASDbx_WeldingAPPObj")
  (vl-registry-write path "LOADCTRLS" 13)
  (vl-registry-write path "LOADER" (strcat mnasoft_root "MNASDbx_Welding_17.dbx")))


(defun mnasoft-registry-install-dbx-elem-16r  (str)
  (setq mnasoft_root (read_mnas_reg_str "16"))
  (setq path (strcat str "\\Applications" "\\" "MNASDbx_PozitionAPP"))
  (vl-registry-write path)
  (vl-registry-write path "DESCRIPTION" "MNASDbx_PozitionAPPObj")
  (vl-registry-write path "LOADCTRLS" 13)
  (vl-registry-write path "LOADER" (strcat mnasoft_root "MNASDbx_Pozition_16.dbx"))
  (setq path (strcat str "\\Applications" "\\" "MNASDbx_WeldingAPP"))
  (vl-registry-write path)
  (vl-registry-write path "DESCRIPTION" "MNASDbx_WeldingAPPObj")
  (vl-registry-write path "LOADCTRLS" 13)
  (vl-registry-write path "LOADER" (strcat mnasoft_root "MNASDbx_Welding_16.dbx")))

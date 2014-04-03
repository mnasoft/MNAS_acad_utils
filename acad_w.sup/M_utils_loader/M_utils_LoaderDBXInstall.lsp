(defun MNASoft-registry-install-DBX-elem (str)
  (cond
;;;    (
;;;     (wcmatch str "*ObjectDBX\\R19`.*")
;;;     (MNASoft-registry-install-DBX-elem-19R str)
;;;    )
    (
     (wcmatch str "*ObjectDBX\\R18`.*")
     (MNASoft-registry-install-DBX-elem-18R str)
    )
    (
     (wcmatch str "*ObjectDBX\\R17`.*")
     (MNASoft-registry-install-DBX-elem-17R str)
    )
;;;    (
;;;     (wcmatch str "*ObjectDBX\\R16`.*")
;;;     (MNASoft-registry-install-DBX-elem-16R str)
;;;    )
  )
)

(defun MNASoft-registry-install-DBX-elem-19R (str)
  (setq	MNASoft_root (read_mnas_reg_str "19"))
  
  (setq path (strcat str "\\Applications" "\\" "MNASDbx_PozitionAPP"))

  (VL-REGISTRY-WRITE path)
  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASDbx_PozitionAPPObj")
  (VL-REGISTRY-WRITE path "LOADCTRLS" 13)
  (VL-REGISTRY-WRITE
    path
    "LOADER"
    (strcat MNASoft_root "MNASDbx_Pozition_19.dbx")
  )

  (setq path (strcat str "\\Applications" "\\" "MNASDbx_WeldingAPP"))

  (VL-REGISTRY-WRITE path)
  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASDbx_WeldingAPPObj")
  (VL-REGISTRY-WRITE path "LOADCTRLS" 13)
  (VL-REGISTRY-WRITE
    path
    "LOADER"
    (strcat MNASoft_root "MNASDbx_Welding_19.dbx")
  )
)



(defun MNASoft-registry-install-DBX-elem-18R (str / path)
  (setq	MNASoft_root (read_mnas_reg_str "18"))

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

(defun MNASoft-registry-install-DBX-elem-17R (str)
  (setq	MNASoft_root (read_mnas_reg_str "17"))

  (setq path (strcat str "\\Applications" "\\" "MNASDbx_PozitionAPP"))

  (VL-REGISTRY-WRITE path)
  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASDbx_PozitionAPPObj")
  (VL-REGISTRY-WRITE path "LOADCTRLS" 13)
  (VL-REGISTRY-WRITE
    path
    "LOADER"
    (strcat MNASoft_root "MNASDbx_Pozition_17.dbx")
  )

  (setq path (strcat str "\\Applications" "\\" "MNASDbx_WeldingAPP"))

  (VL-REGISTRY-WRITE path)
  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASDbx_WeldingAPPObj")
  (VL-REGISTRY-WRITE path "LOADCTRLS" 13)
  (VL-REGISTRY-WRITE
    path
    "LOADER"
    (strcat MNASoft_root "MNASDbx_Welding_17.dbx")
  )
)


(defun MNASoft-registry-install-DBX-elem-16R (str)
  (setq	MNASoft_root (read_mnas_reg_str "16"))

  (setq path (strcat str "\\Applications" "\\" "MNASDbx_PozitionAPP"))

  (VL-REGISTRY-WRITE path)
  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASDbx_PozitionAPPObj")
  (VL-REGISTRY-WRITE path "LOADCTRLS" 13)
  (VL-REGISTRY-WRITE
    path
    "LOADER"
    (strcat MNASoft_root "MNASDbx_Pozition_16.dbx")
  )


  (setq path (strcat str "\\Applications" "\\" "MNASDbx_WeldingAPP"))

  (VL-REGISTRY-WRITE path)
  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASDbx_WeldingAPPObj")
  (VL-REGISTRY-WRITE path "LOADCTRLS" 13)
  (VL-REGISTRY-WRITE
    path
    "LOADER"
    (strcat MNASoft_root "MNASDbx_Welding_16.dbx")
  )
)
;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** ÍÅ äîáàâëÿéòå òåêñò ïîä êîììåíòàðèÿìè! ***|;

(defun MNASoft-registry-install-ARX-elem (str)
  (cond
;;;    (
;;;     (wcmatch str "*AutoCAD\\R19`.*")
;;;     (MNASoft-registry-install-ARX-elem-19R str)
;;;    )
;;;    (
;;;     (wcmatch str "*AutoCAD\\R18`.*")
;;;     (MNASoft-registry-install-ARX-elem-18R str)
;;;    )
    (
     (wcmatch str "*AutoCAD\\R17`.*")
     (MNASoft-registry-install-ARX-elem-17R str)
    )
;;;    (
;;;     (wcmatch str "*AutoCAD\\R16`.*")
;;;     (MNASoft-registry-install-ARX-elem-16R str)
;;;    )
  )
)

(defun MNASoft-registry-install-ARX-elem-19R (str)
  t
)

(defun MNASoft-registry-install-ARX-elem-18R (str / path)
;;;  (setq	MNASoft_root (read_mnas_reg_str "18"))
;;;  
;;;  (setq path (strcat str "\\Applications" "\\" "MNASArx_AddDimstyle"))
;;;
;;;  (VL-REGISTRY-WRITE path)
;;;  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASArx_AddDimstyle")
;;;  (VL-REGISTRY-WRITE path "LOADCTRLS" 12)
;;;  (VL-REGISTRY-WRITE
;;;    path
;;;    "LOADER"
;;;    (strcat MNASoft_root "MNASArx_AddDimstyle_18.arx")
;;;  )
;;;  (foo_01 path (get-MNASArx_AddDimstyle_Commands))
;;;  (foo_01 path (get-MNASArx_AddDimstyle_Groups))
  t
)

(defun MNASoft-registry-install-ARX-elem-17R (str)
  (setq	MNASoft_root (read_mnas_reg_str "17"))
  
;;;  (setq path (strcat str "\\Applications" "\\" "MNASArx_AddDimstyle"))
;;;
;;;  (VL-REGISTRY-WRITE path)
;;;  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASArx_AddDimstyle")
;;;  (VL-REGISTRY-WRITE path "LOADCTRLS" 12)
;;;  (VL-REGISTRY-WRITE
;;;    path
;;;    "LOADER"
;;;    (strcat MNASoft_root "MNASArx_AddDimstyle_17.arx")
;;;  )
;;;  (foo_01 path (get-MNASArx_AddDimstyle_Commands))
;;;  (foo_01 path (get-MNASArx_AddDimstyle_Groups))

  (setq path (strcat str "\\Applications" "\\" "MNASArx_Pozition"))

  (VL-REGISTRY-WRITE path)
  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASArx_Pozition")
  (VL-REGISTRY-WRITE path "LOADCTRLS" 12)
  (VL-REGISTRY-WRITE
    path
    "LOADER"
    (strcat MNASoft_root "MNASArx_Pozition_17.arx")
  )
  (foo_01 path (get-MNASArx_Pozition_Commands))
  (foo_01 path (get-MNASArx_Pozition_Groups))
  
  (setq path (strcat str "\\Applications" "\\" "MNASArx_Welding"))

  (VL-REGISTRY-WRITE path)
  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASArx_Welding")
  (VL-REGISTRY-WRITE path "LOADCTRLS" 12)
  (VL-REGISTRY-WRITE
    path
    "LOADER"
    (strcat MNASoft_root "MNASArx_Welding_17.arx")
  )
  (foo_01 path (get-MNASArx_Welding_Commands))
  (foo_01 path (get-MNASArx_Welding_Groups))
)

(defun MNASoft-registry-install-ARX-elem-16R (str)
  (setq MNASoft_root (read_mnas_reg_str "16"))
  (setq path (strcat str "\\Applications" "\\" "MNASArx_AddDimstyle"))

  (VL-REGISTRY-WRITE path)
  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASArx_AddDimstyle")
  (VL-REGISTRY-WRITE path "LOADCTRLS" 12)
  (VL-REGISTRY-WRITE
    path
    "LOADER"
    (strcat MNASoft_root "MNASArx_AddDimstyle_16.arx")
  )
  (foo_01 path (get-MNASArx_AddDimstyle_Commands))
  (foo_01 path (get-MNASArx_AddDimstyle_Groups))


  (setq path (strcat str "\\Applications" "\\" "MNASArx_Pozition"))

  (VL-REGISTRY-WRITE path)
  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASArx_Pozition")
  (VL-REGISTRY-WRITE path "LOADCTRLS" 12)
  (VL-REGISTRY-WRITE
    path
    "LOADER"
    (strcat MNASoft_root "MNASArx_Pozition_16.arx")
  )
  (foo_01 path (get-MNASArx_Pozition_Commands))
  (foo_01 path (get-MNASArx_Pozition_Groups))


  (setq path (strcat str "\\Applications" "\\" "MNASArx_Welding"))

  (VL-REGISTRY-WRITE path)
  (VL-REGISTRY-WRITE path "DESCRIPTION" "MNASArx_Welding")
  (VL-REGISTRY-WRITE path "LOADCTRLS" 12)
  (VL-REGISTRY-WRITE
    path
    "LOADER"
    (strcat MNASoft_root "MNASArx_Welding_16.arx")
  )
  (foo_01 path (get-MNASArx_Welding_Commands))
  (foo_01 path (get-MNASArx_Welding_Groups))
)

;;; DESCRIPTION
;;;  (vl-registry-read
;;;    "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD\\R16.0\\ACAD-201:409\\Applications\\MNAS_ArxPrj"
;;;    "DESCRIPTION"
;;;  )
;;;  LOADCTRLS
;;;  (vl-registry-read
;;;    "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD\\R16.0\\ACAD-201:409\\Applications\\MNAS_ArxPrj"
;;;    "LOADCTRLS"
;;;  )
;;;(LOADER
;;;  (vl-registry-read
;;;    "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD\\R16.0\\ACAD-201:409\\Applications\\MNAS_ArxPrj"
;;;    "LOADER"
;;;  )
;;;)

(defun foo_01 (path Commands)
  (mapcar
    (function
      (lambda (el)
	(VL-REGISTRY-WRITE
	  (strcat path "\\" (car Commands))
	  (car el)
	  (cadr el)
	)
      )
    )
    (cadr Commands)
  )
)
;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

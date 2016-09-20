(defun mnasoft-registry-install-arx-elem  (str)
  (cond
;;;    (
;;;     (wcmatch str "*AutoCAD\\R19`.*")
;;;     (MNASoft-registry-install-ARX-elem-19R str)
;;;    )
;;;    (
;;;     (wcmatch str "*AutoCAD\\R18`.*")
;;;     (MNASoft-registry-install-ARX-elem-18R str)
;;;    )
        ((wcmatch str "*AutoCAD\\R17`.*") (mnasoft-registry-install-arx-elem-17r str))
;;;    (
;;;     (wcmatch str "*AutoCAD\\R16`.*")
;;;     (MNASoft-registry-install-ARX-elem-16R str)
;;;    )
        ))

(defun mnasoft-registry-install-arx-elem-19r (str) t)

(defun mnasoft-registry-install-arx-elem-18r  (str / path)
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
  t)

(defun mnasoft-registry-install-arx-elem-17r  (str)
  (setq mnasoft_root (read_mnas_reg_str "17"))
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
  (vl-registry-write path)
  (vl-registry-write path "DESCRIPTION" "MNASArx_Pozition")
  (vl-registry-write path "LOADCTRLS" 12)
  (vl-registry-write path "LOADER" (strcat mnasoft_root "MNASArx_Pozition_17.arx"))
  (foo_01 path (get-mnasarx_pozition_commands))
  (foo_01 path (get-mnasarx_pozition_groups))
  (setq path (strcat str "\\Applications" "\\" "MNASArx_Welding"))
  (vl-registry-write path)
  (vl-registry-write path "DESCRIPTION" "MNASArx_Welding")
  (vl-registry-write path "LOADCTRLS" 12)
  (vl-registry-write path "LOADER" (strcat mnasoft_root "MNASArx_Welding_17.arx"))
  (foo_01 path (get-mnasarx_welding_commands))
  (foo_01 path (get-mnasarx_welding_groups)))

(defun mnasoft-registry-install-arx-elem-16r  (str)
  (setq mnasoft_root (read_mnas_reg_str "16"))
  (setq path (strcat str "\\Applications" "\\" "MNASArx_AddDimstyle"))
  (vl-registry-write path)
  (vl-registry-write path "DESCRIPTION" "MNASArx_AddDimstyle")
  (vl-registry-write path "LOADCTRLS" 12)
  (vl-registry-write path "LOADER" (strcat mnasoft_root "MNASArx_AddDimstyle_16.arx"))
  (foo_01 path (get-mnasarx_adddimstyle_commands))
  (foo_01 path (get-mnasarx_adddimstyle_groups))
  (setq path (strcat str "\\Applications" "\\" "MNASArx_Pozition"))
  (vl-registry-write path)
  (vl-registry-write path "DESCRIPTION" "MNASArx_Pozition")
  (vl-registry-write path "LOADCTRLS" 12)
  (vl-registry-write path "LOADER" (strcat mnasoft_root "MNASArx_Pozition_16.arx"))
  (foo_01 path (get-mnasarx_pozition_commands))
  (foo_01 path (get-mnasarx_pozition_groups))
  (setq path (strcat str "\\Applications" "\\" "MNASArx_Welding"))
  (vl-registry-write path)
  (vl-registry-write path "DESCRIPTION" "MNASArx_Welding")
  (vl-registry-write path "LOADCTRLS" 12)
  (vl-registry-write path "LOADER" (strcat mnasoft_root "MNASArx_Welding_16.arx"))
  (foo_01 path (get-mnasarx_welding_commands))
  (foo_01 path (get-mnasarx_welding_groups)))

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

(defun foo_01  (path commands)
  (mapcar (function (lambda (el) (vl-registry-write (strcat path "\\" (car commands)) (car el) (cadr el))))
          (cadr commands)))


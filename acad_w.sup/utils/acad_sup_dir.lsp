(princ "\n�������� Utils/acad_sup_dir  ")


;(vl-registry-write reg-key [val-name val-data])


(defun c:mnas-cad-utils-path (/ reg-key val-name acad_path)
  (setq
    reg-key
	      "HKEY_CURRENT_USER\\Software\\Autodesk\\AutoCAD\\R16.2\\ACAD-4013:409\\Profiles\\<<VANILLA>>\\General"
    val-name
	      "ACAD"
    acad_path
	      (vl-registry-read
		reg-key
		val-name
	      )
  )
  (vl-registry-write
    reg-key
    val-name
    (strcat
      acad_path
      (MNAS_ArxPrj_root)
      "\\acad.fnt"
      ";"
      (MNAS_ArxPrj_root)
      "acad.fnt\\Kompas"
      ";"
      (MNAS_ArxPrj_root)
      "\\acad_w.sup"
      ";"
      (MNAS_ArxPrj_root)
      "\\Acad.mnu\\Acad_mnu_icon"
      ";"
    )
  )
)

(defun MNAS_ArxPrj_root (/ LOADER)
  (setq
    LOADER
     (vl-registry-read
       (strcat "HKEY_LOCAL_MACHINE\\SOFTWARE\\MNASoft\\" (substr (getvar "acadver") 1 2))
       "ROOT"
     )
  )
  (if (null LOADER)
    (setq
    LOADER
     (vl-registry-read
       (strcat "HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\MNASoft\\" (substr (getvar "acadver") 1 2))
       "ROOT"
     )
  )
    
  )
  (VL-STRING-TRANSLATE
    "\\"
    "/"
    (cond
      (
       mnasoft-debug
       mnasoft-debug-path
      )
      ((null LOADER)
       (strcat "C:" "\\" "MNAS_acad_db17_utils")
      )
      (t LOADER)
    )
  )
)

(defun MNAS_ArxPrj_acad_w ()
  (strcat (MNAS_ArxPrj_root) "\\" "acad_w.sup")
)

(defun MNAS_ArxPrj_acad_help ()
  (strcat (MNAS_ArxPrj_root) "\\" "acad.help")
)

(defun MNAS_ArxPrj_vlx ()
  (strcat (MNAS_ArxPrj_root) "\\" "vlx")
)

(defun acad_sup	() (MNAS_ArxPrj_acad_w))

(defun acad_help() (MNAS_ArxPrj_acad_help))

;;;(is_path_full (cdr (assoc 2 (cadr ll2))))
(defun is_path_full (str)
  (wcmatch str "@:*")
)

;;;(extend_path (cdr (assoc 2 (cadr ll2))))
(defun extend_path (str)
  (if (is_path_full str)
    str
    (strcat (acad_sup) str)
  )
)

(princ "\t...��������.\n")
;|�Visual LISP� Format Options�
(130 2 5 2 nil "end of" 100 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

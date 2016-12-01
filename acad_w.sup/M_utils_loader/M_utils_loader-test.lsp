(setq *hcu-autocad* "HKEY_CURRENT_USER\\Software\\Autodesk\\AutoCAD")

(defun string-split  (delimiter string / l i a b q n)
  (if (and string
           (= 'str (type string))
           (setq q (strlen string)
                 i 1))
    (while (<= i q)
      (while (and (= (substr string i 1) delimiter) (<= i q)) (setq i (1+ i)))
      (setq n i)
      (while (and (/= (substr string i 1) delimiter) (<= i q)) (setq i (1+ i)))
      (setq a (substr string n (- i n))
            i (1+ i))
      (if (and a (/= "" a))
        (setq l (cons a l)))))
  (if l
    (reverse l)))

(defun hcu-autocad-curver  (/ hcu-autocad)
  (setq hcu-autocad *hcu-autocad*)
  (repeat 2 (setq hcu-autocad (strcat hcu-autocad "\\" (vl-registry-read hcu-autocad "CurVer")))))

(defun hcu-autocad-curver-profiles-general-key  ()
  (strcat (hcu-autocad-curver) "\\" "Profiles" "\\" (getvar "CPROFILE") "\\" "General"))

(defun hcu-autocad-curver-profiles-general-acad  ()
  (vl-registry-read (hcu-autocad-curver-profiles-general-key) "ACAD"))

(defun hcu-autocad-curver-profiles-general-acad-list  ()
  (string-split ";" (hcu-autocad-curver-profiles-general-acad)))

(defun string-list-wcmatch-not-pattern  (string-lst pattern / new-string-lst)
  (foreach string  string-lst
    (if (null (wcmatch string pattern))
      (setq new-string-lst (cons string new-string-lst))))
  (reverse new-string-lst))

(defun string-list-wcmatch-pattern  (string-lst pattern / new-string-lst)
  (foreach string  string-lst
    (if (wcmatch string pattern)
      (setq new-string-lst (cons string new-string-lst))))
  (reverse new-string-lst))

(defun filename-directory  (filename / new-string)
  (setq new-string "")
  (vl-string-right-trim
    "\\/"
    (foreach string  (reverse (cdr (reverse (string-split "\\" filename))))
      (setq new-string (strcat new-string string "\\")))))

(defun c:mnasoft-install-path  (/ not-mnas_acad_utils-path-lst menu-mnasoft.cuix-path new-string)
  (setq not-mnas_acad_utils-path-lst
         (string-list-wcmatch-not-pattern
           (hcu-autocad-curver-profiles-general-acad-list)
           "*mnas_acad_utils*")
        menu-mnasoft.cuix-path
         (filename-directory (getfiled "Select MNASoft.cuix" "MNASoft.cuix" "cuix" 0)))
  (foreach string  '("" "acad_w.sup" "acad_fnt" "acad_fnt\\Kompas")
    (setq not-mnas_acad_utils-path-lst
           (append
             not-mnas_acad_utils-path-lst
             (list (vl-string-right-trim "\\/" (strcat menu-mnasoft.cuix-path "\\" string))))))
  (setq new-string "")
  (foreach string not-mnas_acad_utils-path-lst (setq new-string (strcat new-string string ";")))
  (vl-registry-write (hcu-autocad-curver-profiles-general-key) "ACAD" new-string))

(defun c:mnasoft-uninstall-path  (/ not-mnas_acad_utils-path-lst new-string)
  (setq not-mnas_acad_utils-path-lst
         (string-list-wcmatch-not-pattern
           (hcu-autocad-curver-profiles-general-acad-list)
           "*mnas_acad_utils*"))
  (setq new-string "")
  (foreach string not-mnas_acad_utils-path-lst (setq new-string (strcat new-string string ";")))
  (vl-registry-write (hcu-autocad-curver-profiles-general-key) "ACAD" new-string))

(hcu-autocad-curver-profiles-general-key)

;;(dos_reggetstr "HKEY_CURRENT_USER"  key name)


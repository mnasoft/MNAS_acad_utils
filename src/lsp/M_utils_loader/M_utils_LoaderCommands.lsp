(defun c:mnas-cad-utils-path  (/ reg-key val-name acad_path)
  (setq reg-key   "HKEY_CURRENT_USER\\Software\\Autodesk\\AutoCAD\\R16.2\\ACAD-4013:409\\Profiles\\<<VANILLA>>\\General"
        val-name  "ACAD"
        acad_path (vl-registry-read reg-key val-name))
  (vl-registry-write
    reg-key
    val-name
    (strcat acad_path
            (mnas_arxprj_root)
            "\\acad.fnt"
            ";"
            (mnas_arxprj_root)
            "acad.fnt\\Kompas"
            ";"
            (mnas_arxprj_root)
            "\\src/lsp"
            ";"
            (mnas_arxprj_root)
            "\\Acad.mnu\\Acad_mnu_icon"
            ";")))


;;;;;;("MNASoft-registry-uninstall"
;;;;;;"������� MNASoft-registry-uninstall () ��������� ������� ���������� ������� �� ������� ���������� MNASoft."
;;;;;;"���������"
;;;;;;)

(defun c:mnasoft-registry-uninstall  (/ str-lst)
;;;�������� ������ ������� ��������� � ARX-������������.
  (setq str-lst (registry-dir (registry-dir (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD"))))
;;;  (registry-delete-recursive
;;;    (mapcar (function (lambda (el)
;;;			(strcat el "\\Applications\\" "MNASArx_AddDimstyle")
;;;		      )
;;;	    )
;;;	    str-lst
;;;    )
;;;  )
  (registry-delete-recursive
    (mapcar (function (lambda (el) (strcat el "\\Applications\\" "MNASArx_Pozition"))) str-lst))
  (registry-delete-recursive
    (mapcar (function (lambda (el) (strcat el "\\Applications\\" "MNASArx_Welding"))) str-lst))
;;;�������� ������ ������� ��������� � DBX-������������.
  (setq str-lst (registry-dir (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\ObjectDBX")))
  (registry-delete-recursive
    (mapcar (function (lambda (el) (strcat el "\\Applications\\" "MNASDbx_PozitionAPP"))) str-lst))
  (registry-delete-recursive
    (mapcar (function (lambda (el) (strcat el "\\Applications\\" "MNASDbx_WeldingAPP"))) str-lst))
  (mapcar (function (lambda (el) (princ (strcat el "\n")))) (mnasoft-registry-key))
  (princ "������������� ���� ����� ������� �� �������.")
  (princ))

;;;;;;("MNASoft-registry-install"
;;;;;;"������� MNASoft-registry-uninstall () ��������� ���������� ������, ����������� ��� �������� �� ���������� ������, ���������� � �������������� OARX �� ������ MNAS_acad_utils."
;;;;;;"���������"
;;;;;;)
(defun c:mnasoft-registry-install  (/ str-lst)
  (setq str-lst (registry-dir (registry-dir (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD"))))
  (mapcar (function mnasoft-registry-install-arx-elem) str-lst)
  (setq str-lst (registry-dir (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\ObjectDBX")))
  (mapcar (function mnasoft-registry-install-dbx-elem) str-lst)
  (mapcar (function (lambda (el) (princ (strcat el "\n")))) (mnasoft-registry-key))
  (princ "������������� ���� ����� ��������� � ������.")
  (princ))

(defun mnasoft-registry-key  ()
  (append (vl-sort (registry-dir-recursive
                     (apply (function append)
                            (mapcar (function
                                      (lambda (app_name)
                                        (mapcar (function (lambda (el) (strcat el "\\Applications\\" app_name)))
                                                (registry-dir (registry-dir (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD"))))))
                                    (list ;;"MNASArx_AddDimstyle"
                                          "MNASArx_Pozition"
                                          "MNASArx_Welding"))))
                   (function <))
          (vl-sort (registry-dir-recursive
                     (apply (function append)
                            (mapcar (function (lambda (app_name)
                                                (mapcar (function (lambda (el) (strcat el "\\Applications\\" app_name)))
                                                        (registry-dir (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\ObjectDBX")))))
                                    (list "MNASDbx_PozitionAPP" "MNASDbx_WeldingAPP"))))
                   (function <))))


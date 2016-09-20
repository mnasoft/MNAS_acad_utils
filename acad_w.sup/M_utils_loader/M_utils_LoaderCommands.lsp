
;;;;;;("MNASoft-registry-uninstall"
;;;;;;"Команда MNASoft-registry-uninstall () выполняет очистку системного реестра от записех приложения MNASoft."
;;;;;;"Настройка"
;;;;;;)

(defun c:mnasoft-registry-uninstall  (/ str-lst)
;;;Удаление ветвей реестра связанных с ARX-приложениями.
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
;;;Удаление ветвей реестра связанных с DBX-приложениями.
  (setq str-lst (registry-dir (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\ObjectDBX")))
  (registry-delete-recursive
    (mapcar (function (lambda (el) (strcat el "\\Applications\\" "MNASDbx_PozitionAPP"))) str-lst))
  (registry-delete-recursive
    (mapcar (function (lambda (el) (strcat el "\\Applications\\" "MNASDbx_WeldingAPP"))) str-lst))
  (mapcar (function (lambda (el) (princ (strcat el "\n")))) (mnasoft-registry-key))
  (princ "Перечисленные выше ключи удалены из реестра.")
  (princ))

;;;;;;("MNASoft-registry-install"
;;;;;;"Команда MNASoft-registry-uninstall () выполняет добавление данных, необходимых для загрузки по требованию команд, написанных с использованием OARX из пакета MNAS_acad_utils."
;;;;;;"Настройка"
;;;;;;)
(defun c:mnasoft-registry-install  (/ str-lst)
  (setq str-lst (registry-dir (registry-dir (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD"))))
  (mapcar (function mnasoft-registry-install-arx-elem) str-lst)
  (setq str-lst (registry-dir (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\ObjectDBX")))
  (mapcar (function mnasoft-registry-install-dbx-elem) str-lst)
  (mapcar (function (lambda (el) (princ (strcat el "\n")))) (mnasoft-registry-key))
  (princ "Перечисленные выше ключи добавлены в реестр.")
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


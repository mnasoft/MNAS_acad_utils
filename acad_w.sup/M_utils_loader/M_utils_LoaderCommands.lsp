
;;;;;;("MNASoft-registry-uninstall"
;;;;;;"Команда MNASoft-registry-uninstall () выполняет очистку системного реестра от записех приложения MNASoft."
;;;;;;"Настройка"
;;;;;;)

(defun c:MNASoft-registry-uninstall (/ str-lst)
;;;Удаление ветвей реестра связанных с ARX-приложениями.
  (setq	str-lst
	 (registry-dir
	   (registry-dir
	     (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD")
	   )
	 )
  )
;;;  (registry-delete-recursive
;;;    (mapcar (function (lambda (el)
;;;			(strcat el "\\Applications\\" "MNASArx_AddDimstyle")
;;;		      )
;;;	    )
;;;	    str-lst
;;;    )
;;;  )
  (registry-delete-recursive
    (mapcar (function (lambda (el)
			(strcat el "\\Applications\\" "MNASArx_Pozition")
		      )
	    )
	    str-lst
    )
  )
  (registry-delete-recursive
    (mapcar (function (lambda (el)
			(strcat el "\\Applications\\" "MNASArx_Welding")
		      )
	    )
	    str-lst
    )
  )
;;;Удаление ветвей реестра связанных с DBX-приложениями.
  (setq	str-lst
	 (registry-dir
	   (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\ObjectDBX")
	 )
  )
  (registry-delete-recursive
    (mapcar (function (lambda (el)
			(strcat el "\\Applications\\" "MNASDbx_PozitionAPP")
		      )
	    )
	    str-lst
    )
  )
  (registry-delete-recursive
    (mapcar (function (lambda (el)
			(strcat el "\\Applications\\" "MNASDbx_WeldingAPP")
		      )
	    )
	    str-lst
    )
  )
  (mapcar
    (function
      (lambda (el) (princ (strcat el "\n")  ))
    )
    (MNASoft-registry-key)
  )
  (princ "Перечисленные выше ключи удалены из реестра.")
  (princ)
)

;;;;;;("MNASoft-registry-install"
;;;;;;"Команда MNASoft-registry-uninstall () выполняет добавление данных, необходимых для загрузки по требованию команд, написанных с использованием OARX из пакета MNAS_acad_utils."
;;;;;;"Настройка"
;;;;;;)
(defun c:MNASoft-registry-install (/ str-lst)
  (setq	str-lst
	 (registry-dir
	   (registry-dir
	     (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD")
	   )
	 )
  )
  (mapcar (function MNASoft-registry-install-ARX-elem) str-lst)

  (setq	str-lst
	 (registry-dir
	   (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\ObjectDBX")

	 )
  )
  (mapcar (function MNASoft-registry-install-DBX-elem) str-lst)

  (mapcar
    (function
      (lambda (el) (princ (strcat el "\n")  ))
    )
    (MNASoft-registry-key)
  )
  (princ "Перечисленные выше ключи добавлены в реестр.")
  (princ)
)

(defun MNASoft-registry-key ()
  (append
    (vl-sort
      (registry-dir-recursive
	(apply
	  (function append)
	  (mapcar
	    (function
	      (lambda (app_name)
		(mapcar
		  (function
		    (lambda (el)
		      (strcat el "\\Applications\\" app_name)
		    )
		  )
		  (registry-dir
		    (registry-dir
		      (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD")
		    )
		  )
		)
	      )
	    )
	    (list ;;"MNASArx_AddDimstyle"
	      "MNASArx_Pozition" "MNASArx_Welding")
	  )
	)
      )
      (function <)
    )
    (vl-sort
      (registry-dir-recursive
	(apply
	  (function append)
	  (mapcar
	    (function
	      (lambda (app_name)
		(mapcar
		  (function
		    (lambda (el)
		      (strcat el "\\Applications\\" app_name)
		    )
		  )
		  (registry-dir
		    (list "HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\ObjectDBX")
		  )
		)
	      )
	    )
	    (list "MNASDbx_PozitionAPP" "MNASDbx_WeldingAPP")
	  )
	)
      )
      (function <)
    )
  )
)
;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** НЕ добавляйте текст под комментариями! ***|;

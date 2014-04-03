
;;;;;;("MNASoft-registry-uninstall"
;;;;;;"������� MNASoft-registry-uninstall () ��������� ������� ���������� ������� �� ������� ���������� MNASoft."
;;;;;;"���������"
;;;;;;)

(defun c:MNASoft-registry-uninstall (/ str-lst)
;;;�������� ������ ������� ��������� � ARX-������������.
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
;;;�������� ������ ������� ��������� � DBX-������������.
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
  (princ "������������� ���� ����� ������� �� �������.")
  (princ)
)

;;;;;;("MNASoft-registry-install"
;;;;;;"������� MNASoft-registry-uninstall () ��������� ���������� ������, ����������� ��� �������� �� ���������� ������, ���������� � �������������� OARX �� ������ MNAS_acad_utils."
;;;;;;"���������"
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
  (princ "������������� ���� ����� ��������� � ������.")
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
;|�Visual LISP� Format Options�
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** �� ���������� ����� ��� �������������! ***|;

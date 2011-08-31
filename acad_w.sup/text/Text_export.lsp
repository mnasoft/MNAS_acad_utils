;;;(princ "\nЗагружаю text/Text_export.lsp")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "text/Text_export.lsp"))

;;;;;;("text_export" "Экспортирует текст примитмвов во внешний файл." "Тексты")
(defun c:text_export (/ fd fn i name ss txt)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq	fn (getfiled "" "" "txt" 1)
	fd (open fn "W")
  )
  (if fd
    (progn
      (setq ss (ssget '((0 . "TEXT")))
	    i  (sslength ss)
      )
      (while (>= (setq i (1- i)) 0)
	(setq name (ssname ss i)
	      txt
		   (cdr (assoc 1 (entget name)))
	)
	(princ txt fd)
	(princ "\n" fd)
      )
      (close fd)
    )
    (file-open-err fn)
  )
  (err-handle "")
)


(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

;;;(princ "\nЗагружаю utils/err           ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "utils/err           "))

(defun file-open-err (fn)
  (alert (princ (strcat "\nНе могу открыть файл: " fn ".\n")))
  (exit)
)


(defun err (msg) (setq *error* old_err) (princ))

;;;f;;;("set-sys-var-lst (variable-lst)"
;;;f;;;"Устанавливает значения системных переменных\n
;;;f;;;variable-lst - список, каждый элемент которого должен содержать список, состоящий из:
;;;f;;;1 строки - пердставляющей системную переменную ACAD;
;;;f;;;2 значения, которое устанавливается для этой системной переменной.
;;;f;;;(set-sys-var-lst '((\"cmdecho\" 1) (\"orthomode\" 0)))
;;;f;;;")
(defun set-sys-var-lst (variable-lst)
  (mapcar
    (function
      (lambda (el)
	(setvar (car el) (cadr el))
      )
    )
    variable-lst
  )
)

;;;f;;;("get-sys-var-lst (variable-lst)"
;;;f;;;"Считывает значения системных переменных\n
;;;f;;;variable-lst - список, каждый элемент которого строка - являющаяся системной переменной ACAD.
;;;f;;;(get-sys-var-lst '(\"cmdecho\" \"orthomode\" ))
;;;f;;;")
(defun get-sys-var-lst (variable-lst)
  (mapcar
    (function
      (lambda (el)
	(list el (getvar el))
      )
    )
    variable-lst
  )
)




(defun err-init	(variable-lst		; Спиок, элементы которого - это строки со значениями системных переменных.
		 / echo
		)
  (setq	*old_error* *error*
	*error*	    err-handle
  )
  (setq echo (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (VL-CMDF "_undo" "_begin")
  (setvar "cmdecho" echo)
  (setq *variable-lst* (get-sys-var-lst variable-lst))
)

(defun err-handle (msg / echo)
  (set-sys-var-lst *variable-lst*)
  (setq echo (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (VL-CMDF "_undo" "_end")
  (setvar "cmdecho" echo)
  (setq *error* *old_error*)
  (princ msg)
  (princ)
)


(defun c:test_err ()
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (/ (car (getpoint "getpoint:")) (getdist "getdist:"))
  (err-handle "")
)
(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

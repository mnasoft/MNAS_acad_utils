(defun file-open-err (fn) (alert (princ (strcat "\nЌе могу открыть файл: " fn ".\n"))) (exit))


(defun err (msg) (setq *error* old_err) (princ))

;;;f;;;("set-sys-var-lst (variable-lst)"
;;;f;;;"”станавливает значени€ системных переменных\n
;;;f;;;variable-lst - список, каждый элемент которого должен содержать список, состо€щий из:
;;;f;;;1 строки - пердставл€ющей системную переменную ACAD;
;;;f;;;2 значени€, которое устанавливаетс€ дл€ этой системной переменной.
;;;f;;;(set-sys-var-lst '((\"cmdecho\" 1) (\"orthomode\" 0)))
;;;f;;;")
(defun set-sys-var-lst  (variable-lst)
  (mapcar (function (lambda (el) (setvar (car el) (cadr el)))) variable-lst))

;;;f;;;("get-sys-var-lst (variable-lst)"
;;;f;;;"—читывает значени€ системных переменных\n
;;;f;;;variable-lst - список, каждый элемент которого строка - €вл€юща€с€ системной переменной ACAD.
;;;f;;;(get-sys-var-lst '(\"cmdecho\" \"orthomode\" ))
;;;f;;;")
(defun get-sys-var-lst  (variable-lst)
  (mapcar (function (lambda (el) (list el (getvar el)))) variable-lst))




(defun err-init  (variable-lst          ; —пиок, элементы которого - это строки со значени€ми системных переменных.
                  /
                  echo)
  (setq *old_error* *error*
        *error* err-handle)
  (setq echo (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (command-s "_undo" "_begin")
  (setvar "cmdecho" echo)
  (setq *variable-lst* (get-sys-var-lst variable-lst)))

(defun err-handle  (msg / echo)
  (set-sys-var-lst *variable-lst*)
  (setq echo (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (command-s "_undo" "_end")
  (setvar "cmdecho" echo)
  (setq *error* *old_error*)
  (princ msg)
  (princ))


(defun c:test_err  ()
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (/ (car (getpoint "getpoint:")) (getdist "getdist:"))
  (err-handle ""))

﻿;;;;;;("text_export" "Экспортирует текст примитмвов во внешний файл." "Тексты")
(defun c:text_export  (/ fd fn i name ss txt)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq fn (getfiled "" "" "txt" 1)
        fd (open fn "W"))
  (if fd
    (progn (setq ss (ssget '((-4 . "<OR") (0 . "MTEXT") (0 . "TEXT") (-4 . "OR>")))
                 i  (sslength ss))
           (while (>= (setq i (1- i)) 0)
             (setq name (ssname ss i)
                   txt  (cdr (assoc 1 (entget name))))
             (princ txt fd)
             (princ "\n" fd))
           (close fd))
    (file-open-err fn))
  (err-handle ""))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun c:export-text-dxf  (/ fd fn i en ss txt)
  (if (null (setq fd (open (getfiled "" "" "txt" 1) "W")))
    (exit))
  (setq ss (ssget '((0 . "TEXT")))
        i  (sslength ss))
  (while (>= (setq i (1- i)) 0)
    (setq en (ssname ss i)
          ed (cdr (entget en)))
    (print ed fd))
  (close fd))
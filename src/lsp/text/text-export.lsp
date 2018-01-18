(defun text-p (ed) (= (cdr (assoc 0 ed)) "TEXT"))

(defun mtext-p (ed) (= (cdr (assoc 0 ed)) "MTEXT"))

(defun insert-p (ed) (= (cdr (assoc 0 ed)) "INSERT"))

(defun mnas-text:translate-text	 (str)
  (setq	str (string-subst-all "°" "%%d" str)
	str (string-subst-all "°" "%%D" str)
	str (string-subst-all "Ф" "%%c" str)
	str (string-subst-all "Ф" "%%C" str)
	str (string-subst-all " " "\\~" str)
	str (string-subst-all " " "\\P" str)
	str (string-subst-all " " "\\p" str)
	str (string-subst-all "\"" "''" str)))

 
(defun mnas-text:export-text  (text-ed file)
  (print (mnas-text:translate-text (cdr (assoc 1 text-ed))) file))

(defun mnas-text:export-mtext  (mtext-ed file)
  (print (mnas-text:translate-text (cdr (assoc 1 mtext-ed))) file))

(defun mnas-text:export-attrib	(attrib-ed file)
  (princ (strcat "\""
		 (cdr (assoc 2 attrib-ed))
		 "\" \""
		 (mnas-text:translate-text (cdr (assoc 1 attrib-ed)))
		 "\"\n")
	 file))

(defun mnas-text:export-insert	(insert-ed file / en)
  (setq en (cdr (assoc -1 insert-ed)))
  (princ (strcat "(\"" "INSERT" "\" \"" (cdr (assoc 2 insert-ed)) "\"\n") file)
  (while (setq en (sh-next-attrib-or-nil en)) (mnas-text:export-attrib (entget en) file))
  (princ  ")\n" file))

(defun mnas-text-export-ename  (ename file / ed)
  (setq ed (entget ename))
  (cond	((text-p ed) (mnas-text:export-text ed file))
	((mtext-p ed) (mnas-text:export-mtext ed file))
	((insert-p ed) (mnas-text:export-insert ed file))))


;;;;;;("mnas-text-export" "Экспортирует текст примитмвов во внешний файл." "Тексты")
(defun c:mnas-text-export  (/ file fname i ss-len ss)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq	fname (getfiled "" "" "txt" 1)
	file  (open fname "W"))
  (if file
    (progn (setq ss	(ssget '((-4 . "<OR") (0 . "TEXT") (0 . "MTEXT") (0 . "INSERT") (-4 . "OR>")))
		 ss-len	(sslength ss)
		 i	-1)
	   (while (< (setq i (1+ i)) ss-len) (mnas-text-export-ename (ssname ss i) file))
	   (close file))
    (file-open-err file))
  (err-handle ""))

;;;;;;("text_export" "См. mnas-text-export" "Тексты")
(defun c:text_export () (c:mnas-text-export))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;(princ "\nЗагружаю text/Skobka.lsp     ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "text/Skobka.lsp     "))

(setq scale_mult '(1.0 1.25 1.600 2.0 2.5 3.2000 4.00 5.0 6.25 8.000 10.)
      scale_dev	 '(1.0 0.80 0.625 0.5 0.4 0.3125 0.25 0.2 0.16 0.125 0.1)
)

;;;;;;("te+" "Добавляет круглые скобки вокруг текста размерного примитива." "Тексты")
(defun c:te+ (/ en ed str ss ss_td old_err err dcl_id)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (prompt "\nВыберите тексты или размеры :")
  (setq
    ss (ssget '(
		(-4 . "<OR")
		(0 . "DIMENSION")
		(0 . "TEXT")
		(0 . "MTEXT")
		(-4 . "OR>")
	       )
       )
    i  (sslength ss)
  )
  (while
    (>= (setq i (1- i)) 0)
     (setq
       en  (ssname ss i)
       ed  (entget en)
       str (cdr (assoc 1 ed))
     )
     (cond
       (
	(= str "")
	(setq str "(<>)")
       )
       (
	(= str "<>")
	(setq str "(<>)")
       )
       (t
	(setq str (strcat "(" str ")"))
       )
     )
     (setq ed (SUBST (cons 1 str) (assoc 1 ed) ed))
     (entmod ed)
  )
  (err-handle "")
)

;;;;;;("te+" "Добавляет круглые скобки увеличенного размера вокруг текста размерного примитива." "Тексты")
(defun c:te++ (/ en ed str ss ss_td old_err err dcl_id)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (prompt "\nВыберите тексты или размеры :")
  (setq
    ss (ssget '(
		(-4 . "<OR")
		(0 . "DIMENSION")
		(0 . "TEXT")
		(0 . "MTEXT")
		(-4 . "OR>")
	       )
       )
    i  (sslength ss)
  )
  (while
    (>= (setq i (1- i)) 0)
     (setq
       en  (ssname ss i)
       ed  (entget en)
       str (cdr (assoc 1 ed))
     )
     (cond
       (
	(= str "")
	(setq str "{\\H2x(\\H0.5x}<>{\\H2x)\\H0.5x}")
       )
       (
	(= str "<>")
	(setq str "{\\H2x(\\H0.5x}<>{\\H2x)\\H0.5x}")
       )
       (t
	(setq str (strcat "{\\H2x(\\H0.5x}" str "{\\H2x)\\H0.5x}"))
       )
     )
     (setq ed (SUBST (cons 1 str) (assoc 1 ed) ed))
     (entmod ed)
  )
  (err-handle "")
)


;;;;;;("te+kvsk" "Добавляет квадратные скобки вокруг текста размерного примитива." "Тексты")
(defun c:te+kvsk (/ en ed str ss ss_td old_err err dcl_id)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (prompt "\nВыберите тексты или размеры :")
  (setq
    ss (ssget '((-4 . "<OR")
		(0 . "DIMENSION")
		(0 . "TEXT")
		(0 . "MTEXT")
		(-4 . "OR>")
	       )
       )
    i  (sslength ss)
  )
  (while
    (>= (setq i (1- i)) 0)
     (setq
       en  (ssname ss i)
       ed  (entget en)
       str (cdr (assoc 1 ed))
     )
     (cond
       (
	(or (= str "") (= str "<>"))
	(setq str "[<>]")
       )
       (t
	(setq str (strcat "[" str "]"))
       )
     )
     (setq ed (SUBST (cons 1 str) (assoc 1 ed) ed))
     (entmod ed)
  )
  (err-handle "")
)

;;;;;;("te++kvsk" "Добавляет квадратные скобки увеличенного размера вокруг текста размерного примитива." "Тексты")
(defun c:te++kvsk (/ en ed str ss ss_td old_err err dcl_id)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (prompt "\nВыберите тексты или размеры :")
  (setq
    ss (ssget '(
		(-4 . "<OR")
		(0 . "DIMENSION")
		(0 . "TEXT")
		(0 . "MTEXT")
		(-4 . "OR>")
	       )
       )
    i  (sslength ss)
  )
  (while
    (>= (setq i (1- i)) 0)
     (setq
       en  (ssname ss i)
       ed  (entget en)
       str (cdr (assoc 1 ed))
     )
     (cond
       (
	(= str "")
	(setq str "{\\H2x[\\H0.5x}<>{\\H2x]\\H0.5x}")
       )
       (
	(= str "<>")
	(setq str "{\\H2x[\\H0.5x}<>{\\H2x]\\H0.5x}")
       )
       (t
	(setq str (strcat "{\\H2x[\\H0.5x}" str "{\\H2x]\\H0.5x}"))
       )
     )
     (setq ed (SUBST (cons 1 str) (assoc 1 ed) ed))
     (entmod ed)
  )
  (err-handle "")
)


;;;;;;("te-" "Удаляет круглые скобки, находившиеся вокруг текста размерного примитива." "Тексты")
(defun c:te-
	     (/ ed en i sk_close sk_open ss str str_1 str_2 str_3)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (prompt "\nВыберите размеры :")
  (setq
    ss (ssget	'(
		  (-4 . "<OR")
		  (0 . "DIMENSION")
		  (0 . "TEXT")
		  (0 . "MTEXT")
		  (-4 . "OR>")
		 )
	 )
    i  (sslength ss)
  )
  (while
    (>= (setq i (1- i)) 0)
     (setq
       en  (ssname ss i)
       ed  (entget en)
       str (cdr (assoc 1 ed))
     )
     (setq
       sk_open	(vl-string-position (ascii "(") str)
       sk_close	(vl-string-position (ascii ")") str nil t)
     )
     (if (and (and sk_open sk_close) (< sk_open sk_close))
       (setq
	 str_1 (substr str 1 sk_open)
	 str_2 (substr str (+ 2 sk_open) (- sk_close sk_open 1))
	 str_3 (substr str (+ 2 sk_close))
	 str   (strcat str_1 str_2 str_3)
       )
     )
     (setq str (string-subst-all "" "{\\H2x\\H0.5x}" str))
     (setq str (strcat "\\A1;" (string-subst-all "" "\\A1;" str)))
     (setq ed (SUBST (cons 1 str) (assoc 1 ed) ed))
     (entmod ed)
  )
  (err-handle "")
)



;;;;;;("te-kvsk" "Удаляет квадратные скобки, находившиеся вокруг текста размерного примитива." "Тексты")
(defun c:te-kvsk
		 (/ ed en i sk_close sk_open ss str str_1 str_2 str_3)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (prompt "\nВыберите размеры :")
  (setq
    ss (ssget '(
		(-4 . "<OR")
		(0 . "DIMENSION")
		(0 . "TEXT")
		(0 . "MTEXT")
		(-4 . "OR>")
	       )
       )
    i  (sslength ss)
  )
  (while
    (>= (setq i (1- i)) 0)
     (setq
       en  (ssname ss i)
       ed  (entget en)
       str (cdr (assoc 1 ed))
     )
     (setq
       sk_open	(vl-string-position (ascii "[") str)
       sk_close	(vl-string-position (ascii "]") str nil t)
     )
     (if (and (and sk_open sk_close) (< sk_open sk_close))
       (setq
	 str_1 (substr str 1 sk_open)
	 str_2 (substr str (+ 2 sk_open) (- sk_close sk_open 1))
	 str_3 (substr str (+ 2 sk_close))
	 str   (strcat str_1 str_2 str_3)
       )
     )
     (setq str (string-subst-all "" "{\\H2x\\H0.5x}" str))
     (setq str (strcat "\\A1;" (string-subst-all "" "\\A1;" str)))

     (setq ed (SUBST (cons 1 str) (assoc 1 ed) ed))
     (entmod ed)
  )
  (err-handle "")
)


;;;;;;("te%%c" "Добавляет знак диаметра перед текстом размерного примитива." "Тексты")
(defun c:te%%c
	       (/ en ed str ss ss_td old_err err dcl_id)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (prompt "\nВыберите размеры :")
  (setq
    ss (ssget	'(
		  (-4 . "<OR")
		  (0 . "DIMENSION")
		  (0 . "TEXT")
		  (0 . "MTEXT")
		  (-4 . "OR>")
		 )
	 )
    i  (sslength ss)
  )
  (while
    (>= (setq i (1- i)) 0)
     (setq
       en  (ssname ss i)
       ed  (entget en)
       str (cdr (assoc 1 ed))
     )
     (cond
       (
	(or (= str "") (= str "<>"))
	(setq str "%%C<>")
       )
       (t
	(setq
	  str (vl-string-subst "%%C<>" "<>" str)
	)
       )
     )
     (setq ed (SUBST (cons 1 str) (assoc 1 ed) ed))
     (entmod ed)
  )
  (err-handle "")
)

;;;;;;("te-%%c" "Удаляет знак диаметра, находившийся перед текстом размерного примитива." "Тексты")
(defun c:te-%%c
		(/ en ed str ss ss_td old_err err dcl_id)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (prompt "\nВыберите размеры :")
  (setq
    ss (ssget	'(
		  (-4 . "<OR")
		  (0 . "DIMENSION")
		  (0 . "TEXT")
		  (0 . "MTEXT")
		  (-4 . "OR>")
		 )
	 )
    i  (sslength ss)
  )
  (while
    (>= (setq i (1- i)) 0)
     (setq
       en  (ssname ss i)
       ed  (entget en)
       str (cdr (assoc 1 ed))
     )
     (cond
       (
	(= str "%%C<>")
	(setq str "")
       )
       (t
	(setq
	  str (vl-string-subst "<>" "%%C<>" str)
	)
       )
     )
     (setq ed (SUBST (cons 1 str) (assoc 1 ed) ed))
     (entmod ed)
  )
  (err-handle "")
)

;;;;;;("x45%%d" "Добавляет знак \"на 45 градусов\" после текста размерного примитива." "Тексты")
(defun c:x45%%d	(/ en ed str ss ss_td old_err err dcl_id)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (prompt "\nВыберите тексты или размеры :")
  (setq
    ss (ssget	'(
		  (-4 . "<OR")
		  (0 . "DIMENSION")
		  (0 . "TEXT")
		  (0 . "MTEXT")
		  (-4 . "OR>")
		 )
	 )
    i  (sslength ss)
  )
  (while
    (>= (setq i (1- i)) 0)
     (setq
       en  (ssname ss i)
       ed  (entget en)
       str (cdr (assoc 1 ed))
     )
     (cond
       (
	(= str "")
	(setq str "<>&L45%%d")
       )
       (
	(= str "<>")
	(setq str "<>&L45%%d")
       )
       (t
	(setq str (strcat str "&L45%%d"))
       )
     )
     (setq ed (SUBST (cons 1 str) (assoc 1 ed) ed))
     (entmod ed)
  )
  (err-handle "")
)


;;;;;;("&A&B&C" "Добавляет к тексту размерного примитива обозначение предельных отклонений." "Тексты")
(defun c:&A&B&C	(/ en ed str ss ss_td old_err err dcl_id)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (prompt "\nВыберите тексты или размеры :")
  (setq
    ss (ssget	'(
		  (-4 . "<OR")
		  (0 . "DIMENSION")
		  (0 . "TEXT")
		  (0 . "MTEXT")
		  (-4 . "OR>")
		 )
	 )
    i  (sslength ss)
  )  ;setq

  (while
    (>= (setq i (1- i)) 0)
     (setq
       en  (ssname ss i)
       ed  (entget en)
       str (cdr (assoc 1 ed))
     )
     (cond
       (
	(or (= str "") (= str "<>"))
	(setq str "\\A1;<>{\\H0.725x;\\S+0.03^-0.06;}")
       )
       (t
	(setq str (strcat "\\A1;" str "{\\H0.725x;\\S+0.025^-0.001;}"))
       )
     )
     (setq ed (SUBST (cons 1 str) (assoc 1 ed) ed))
     (entmod ed)
  )
  (err-handle "")
)

;;;;;;("te_*" "Добавляет к тексту размерного примитива значок звездочка." "Тексты")
(defun c:te_* (/ en ed str ss ss_td old_err err dcl_id)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (prompt "\nВыберите тексты или размеры :")
  (setq
    ss (ssget	'(
		  (-4 . "<OR")
		  (0 . "DIMENSION")
		  (0 . "TEXT")
		  (0 . "MTEXT")
		  (-4 . "OR>")
		 )
	 )
    i  (sslength ss)
  )  ;setq
  (while
    (>= (setq i (1- i)) 0)
     (setq
       en  (ssname ss i)
       ed  (entget en)
       str (cdr (assoc 1 ed))
     )
     (cond
       (
	(or (= str "") (= str "<>"))
	(setq str "<>\\A1;{\\S*^;}")
       )
       (t
	(setq str (strcat str "\\A1;{\\S*^;}"))

       )
     )
     (setq ed (SUBST (cons 1 str) (assoc 1 ed) ed))
     (entmod ed)
  )
  (err-handle "")
)

;;;;;;("te_<>_" "Добавляет для неразрывные пробелы вокруг текста размера." "Тексты")
(defun c:te_<>_	(/ en ed str ss ss_td old_err err dcl_id)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (prompt "\nВыберите тексты или размеры :")
  (setq
    ss (ssget	'(
		  (-4 . "<OR")
		  (0 . "DIMENSION")
		  (0 . "TEXT")
		  (0 . "MTEXT")
		  (-4 . "OR>")
		 )
	 )
    i  (sslength ss)
  )
  (while
    (>= (setq i (1- i)) 0)
     (setq
       en  (ssname ss i)
       ed  (entget en)
       str (cdr (assoc 1 ed))
     )
     (cond
       (
	(or (= str "") (= str "<>"))
	(setq str "\\~\\~\\~<>\\~\\~\\~")
       )
       (t
	(setq str (strcat "\\~\\~\\~" str "\\~\\~\\~"))

       )
     )
     (setq ed (SUBST (cons 1 str) (assoc 1 ed) ed))
     (entmod ed)
  )
  (err-handle "")
)

(princ "\t...загружен.\n")
 ;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

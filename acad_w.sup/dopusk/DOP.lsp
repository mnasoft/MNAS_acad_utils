;;;(princ "\nЗагружаю Dop/dop             ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "Dop/dop             "))

(setq str_specsymbol"\A1;H7 ({\A2\C1\H0.75x;\Sверхний_1^нижний_1;})\P%%c<>{\S            /;}   .\Pd8 ({\A0\H0.75x;\Sверхний_2^нижний_2;})")
"\A1;<>H7{\H1.5x(}{\H0.66x;\S+0.025^-0.001;}{\H1.5x)}"

;;;;;;("dop"
;;;;;;"Добавление к тексту размерного примитива
;;;;;; обозначения квалитета и значений предельных отклонений." "Размеры")
(defun c:dop
	     (/ ss1 kval en ed p10 p13 p14 p15 a50 p0 l)

  (princ "\nВыберите размерные примитивы :")
  (setq ss1 (ssget))
  (setq kval (getstring "\nВведите квалитет :"))
  (if (null ss1)
    (exit)
  )
  (while (> (sslength ss1) 0)
    (setq en (ssname ss1 0)
	  ed (entget en)
    )
    (print ed)
    (if	(= (cdr (assoc 0 ed)) "DIMENSION")
      (cond
	(
	 (= (rem (cdr (assoc 70 ed)) 32) 0)
	 (princ "\nПовернутый, Горизонтальный, Вертикальный:")
	 (mapcar (function gdf) '(p10 p13 p14 a50) '(10 13 14 50))
	 (setq p0 (inters p13 (polar p13 a50 10.) p14 p10 nil))
	 (setq l (find_kv (distance p13 p0) kval))
	 (str_dop l)
	 (entmod ed)
	)
	(
	 (= (rem (cdr (assoc 70 ed)) 32) 1)
	 (princ "\nПаралельный:")
	 (mapcar (function gdf) '(p13 p14) '(13 14))
	 (setq l (find_kv (distance p13 p14) kval))
	 (str_dop l)
	 (entmod ed)
	)
	(
	 (= (rem (cdr (assoc 70 ed)) 32) 2)
	 (princ "\nУгловой без вершины :")
	 (mapcar (function gdf) '(p10 p13 p14 p15 p16) '(10 13 14 15 16))
	)
	(
	 (= (rem (cdr (assoc 70 ed)) 32) 3)
	 (princ "\nДиаметр:")
	 (mapcar (function gdf) '(p10 p15) '(10 15))
	 (setq l (find_kv (distance p10 p15) kval))
	 (str_dop l)
	 (entmod ed)
	)
	(
	 (= (rem (cdr (assoc 70 ed)) 32) 4)
	 (princ "\nРадиус:")
	 (mapcar (function gdf) '(p10 p15) '(10 15))
	 (setq l (find_kv (distance p10 p15) kval))
	 (str_dop l)
	 (entmod ed)
	)
	(
	 (= (rem (cdr (assoc 70 ed)) 32) 5)
	 (princ "\nУгловой с вершиной:")
	 (mapcar (function gdf) '(p10 p13 p14 p15) '(10 13 14 15))
	)
      )
    )
    (setq ss1 (ssdel en ss1))
  )
  (princ)
)

(defun find_kv (val kv / l1 l2)
  (if (null dop_val)
    (load "dopusk\\dop_data_new_01")
  )
  (setq l1 (cadr (assoc kv dop_val)))
  (if (null l1)
    (progn
      (princ (strcat "\nВ таблице допусков нет КВАЛИТЕТА :" kv))
      (exit)
    )
  )
  (mapcar
    (function
      (lambda (el)
	(if (and (> val (car el)) (<= val (cadr el)))
	  (setq l2 el)
	)
      )
    )
    l1
  )
  l2
)

(defun str_dop (l / str t_pl t_ot zn_pl zn_ot)
  (if (null l)
    (progn (princ "\nДопуск не найден.") (exit))
  )
  (setq
    t_pl (caddr l)
    t_ot (cadddr l)
  )
  (setq
    str	(strcat	"\\A1;%%c<> "
		kval
		"{\\H1.6x(}"
		"{\\H0.725x;\\S"
		(cond
;;;		  ((< t_pl 0) (rtos (* 0.001 t_pl) 2 3))
		  ((< t_pl 0) (rtos (* 1.000 t_pl) 2 3))
		  ((= t_pl 0) "")
;;;		  ((> t_pl 0) (strcat "+" (rtos (* 0.001 t_pl) 2 3)))
		  ((> t_pl 0) (strcat "+" (rtos (* 1.000 t_pl) 2 3)))
		)
		"^"
		(cond
		  ((< t_ot 0) (rtos (* 1.000 t_ot) 2 3))
		  ((= t_ot 0) "")
		  ((> t_ot 0)
		   (strcat "+" (rtos (* 1.000 t_ot) 2 3))
		  )
		)
		";}"
		"{\\H1.5x)}"
	)
  )
  (setq ed (dsubst ed (list (cons 1 str))))
)

(defun gdf (d cod) (set d (cdr (assoc  cod ed))))



(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;

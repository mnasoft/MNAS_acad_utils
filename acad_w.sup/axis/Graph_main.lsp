(setq l1
       (list
	 (cons 40 20.0) ; Координата по оси x
	 (cons 41 -5.0) ; Смещение от оси
	 (cons 42 50.0) ; Координата вдоль оси
	 (cons 43 -10.0) ; Смещение текста от оси
	 (cons 44 3.5) ; Высота текста
	 (cons 62 2)
	 (cons 6 "center")
	 (cons 8 "2")
	 (cons 70 3)
       )
)

(setq l2
       (list
	 (list
	   (cons 40 20.0) ; Координата по оси x
	   (cons 41 -5.0) ; Смещение от оси
	   (cons 42 50.0) ; Координата вдоль оси
	   (cons 43 -10.0) ; Смещение текста от оси
	   (cons 44 3.5) ; Высота текста
	   (cons 62 2)
	   (cons 6 "center")
	   (cons 8 "2")
	   (cons 70 3)
	 )
	 (list
	   (cons 40 10.0) ; Коордиеата по оси x
	   (cons 41 -5.0) ; Смещение от оси
	   (cons 42 50.0) ; Координата вдоль оси
	   (cons 43 -10.0) ; Смещение текста от оси
	   (cons 44 3.5) ; Высота текста
	   (cons 62 2)
	   (cons 6 "center")
	   (cons 8 "2")
	   (cons 70 1)
	 )
	 (list
	   (cons 40 30.0) ; Коордиеата по оси x
	   (cons 41 -5.0) ; Смещение от оси
	   (cons 42 50.0) ; Координата вдоль оси
	   (cons 43 -10.0) ; Смещение текста от оси
	   (cons 44 3.5) ; Высота текста
	   (cons 62 2)
	   (cons 6 "center")
	   (cons 8 "2")
	   (cons 70 2)
	 )
       )
)

;;;;;;("ax" "not defined" "Шкалы")
(defun c:ax (/ act dcl_id do-dialog)
  (if n
    (ax:init n)
    (progn (setq n 0) (ax:init 0))
  )

  (setq dcl_id (load_dialog (strcat (acad_sup) "/axis/axis.dcl")))
  (if (< dcl_id 0)
    (exit)
  )
  (setq do-dialog t)
  (while do-dialog
    (if	(not (new_dialog "axis" dcl_id))
      (exit)
    )
    (ax:setup)
    (ax:ac_tile)
    (setq act (start_dialog))
    (cond
      ((= act 0)
       (ax:ok)
       (setq do-dialog nil)
      )
      ((= act 1)
       (entmake sc-x-gr)
       (setq scx (entlast))
       (entmake sc-y-gr)
       (setq scy (entlast))
       (dr-axis-points sc-x-gr sc-y-gr pts-gr 3)
       (ax:ok)
       (setq do-dialog nil)
      )
      ((= act 3) (ax:ac_b8))
      ((= act 4) (setq sc-x-gr (ea:eaxis sc-x-gr)))
      ((= act 5) (setq sc-y-gr (ea:eaxis sc-y-gr)))
    )
  )
  (unload_dialog dcl_id)
)

(defun ax:ok ()
  (setq scal (list (list "Шкала X" sc-x-gr) (list "Шкала Y" sc-y-gr)))
  (setq
    gr
     (subst
       (list
	 (cons 1 n-gr)
	 (cons 10 pot)
	 (cons "Точки графика" pts-gr)
	 (cons 40 c-pt-gr)
	 (cons 41 n-pt-gr)
	 (cons "Параметры точек" p-ptgr)
       )
       l-gr
       gr
     )
  )
)

(defun ax:init (n)
  (if (null gr)
    (setq
      gr
       (list
	 (list
	   (cons 1 "Безымянный")
	   (cons 10 '(1 1))
	   (cons "Точки графика" nil)
	   (cons 40 0)
	   (cons 41 0)
	   (cons "Параметры точек"
		 (list
		   (cons 70 2)
		   (list
		     "Блок"
		     (cons 2 "")
		     (cons 40 1.0)
		     (cons 41 1.0)
		     (cons 6 "ПОСЛОЮ")
		     (cons 8 "0")
		     (cons 62 256)
		   )
		   (list
		     "Линия"
		     (cons 40 1.0)
		     (cons 6 "ПОСЛОЮ")
		     (cons 8 "0")
		     (cons 62 256)
		   )
		 )
	   )
	 )
       )
    )
  )	       ;if
  (if
    (null scal)
     (setq scal
	    (list
	      (list
		"Шкала X"
		(list '(0 . "LINE")
		      '(10 0 0 0)
		      '(11 150 0 0)
		      (list -3
			    (list "SHCKALA"
				  '(1002 . "{")
				  '(1040 . 0.0)
				  '(1040
				    .
				    100.0
				   )
				  '(1070 . 0)
				  '(1000
				    .
				    "X-шкала"
				   )
				  '(1002 . "}")
			    )
		      )
		)
	      )
	      (list
		"Шкала Y"
		(list '(0 . "LINE")
		      '(10 0 0 0)
		      '(11 0 250 0)
		      (list -3
			    (list "SHCKALA"
				  '(1002 . "{")
				  '(1040 . 0.0)
				  '(1040
				    .
				    100.0
				   )
				  '(1070 . 0)
				  '(1000
				    .
				    "Y-шкала"
				   )
				  '(1002 . "}")
			    )
		      )
		)
	      )
	    )
     )
     (princ scal)
  )
  (setq
    l-gr    (nth n gr)
    n-gr    (cdr (assoc 1 l-gr))
    pot	    (cdr (assoc 10 l-gr))
    sc-x-gr (cadr (assoc "Шкала X" scal))
    sc-y-gr (cadr (assoc "Шкала Y" scal))
    pts-gr  (cdr (assoc "Точки графика" l-gr))
    c-pt-gr (cdr (assoc 40 l-gr))
    n-pt-gr (cdr (assoc 41 l-gr))
    p-ptgr  (cdr (assoc "Параметры точек" l-gr))
  )
)

(defun ax:setup	(/ i)
  (set_tile "e4" n-gr)
  (set_tile "e1" (RTOS C-pt-gr))

  (defun
		  l-s
		     (p)
    (strcat
      (rtos (setq i (1+ i)) 2 0)
      " ("
      (rtos (car p))
      " "
      (rtos (cadr p))
      ")"
    )
  )
  (setq i -1)
  (start_list "l1")
  (mapcar 'add_list (mapcar 'l-s pts-gr))
  (end_list)
  (set_tile "l1" (rtos c-pt-gr))
  (if pts-gr
    (setq ptt (nth c-pt-gr pts-gr))
  )
  (if
    ptt
     (set_tile
       "t1"
       (strcat "(" (rtos (car ptt)) " " (rtos (cadr ptt)) ")")
     )
     (set_tile "t1" "")
  )
  (set_tile "e2" (rtos (car pot)))
  (set_tile "e3" (rtos (cadr pot)))
  (set_tile "e4" n-gr)
  (set_tile "e5" (xdgetn sc-x-gr "SHCKALA" 3))
  (set_tile "e6" (xdgetn sc-y-gr "SHCKALA" 3))
)

(defun ax:add-gr (/ i ls)
  (setq	i  0
	ls nil
  )

  (while (< i c-pt-gr)
    (setq ls (cons (nth i pts-gr) ls)
	  i  (1+ i)
    )
  )
  (setq ls (cons pot ls))
  (while (< i n-pt-gr)
    (setq ls (cons (nth i pts-gr) ls)
	  i  (1+ i)
    )
  )
  (setq pts-gr (reverse ls))
  (setq n-pt-gr (1+ n-pt-gr))
)

(defun ax:ac_b1 () (setq c-pt-gr 0) (ax:setup))

(defun ax:ac_b2	()
  (if (> c-pt-gr 0)
    (setq c-pt-gr (1- c-pt-gr))
  )
  (ax:setup)
)


(defun ax:ac_b3	()
  (if (< c-pt-gr n-pt-gr)
    (setq c-pt-gr (1+ c-pt-gr))
  )
  (ax:setup)
)


(defun ax:ac_b4 () (setq c-pt-gr n-pt-gr) (ax:setup))

(defun
		ax:ac_b5
			()
  (ax:add-gr)
  (setq c-pt-gr (1+ c-pt-gr))
  (ax:setup)
)

(defun
		ax:ac_b6
			(/ i ls)
  (setq	i  0
	ls nil
  )

  (while (< i c-pt-gr)
    (setq ls (cons (nth i pts-gr) ls)
	  i  (1+ i)
    )
  )
  (setq i (1+ i))
  (while (< i n-pt-gr)
    (setq ls (cons (nth i pts-gr) ls)
	  i  (1+ i)
    )
  )
  (setq pts-gr (reverse ls))

  (setq n-pt-gr (length pts-gr))
  (if (> c-pt-gr 0)
    (setq c-pt-gr (1- c-pt-gr))
    (setq c-pt-gr 0)
  )
  (ax:setup)
)

(defun
		ax:ac_b7
			()
  (setq	pts-gr
	 (car
	   (an:analitic
	     (list (cons 40 10.0)
		   (cons 41 20.0)
		   (cons 60 50)
		   (cons 70 0)
		   (cons 1 "x_p")
		   (cons 2 "y_p")
		   (cons 3 "(defun x_p(p)p)(defun y_p(p)p)")
	     )
	   )
	 )
  )
  (setq n-pt-gr (length pts_gr))
  (setq c-pt-gr 0)
  (ax:setup)
)

(defun
		ax:ac_b8
			(/ p0x p1x p0y p1y l0x l1x flx l0y l1y fly)
  (if pot
    (setq pot1 pot)
    (setq pot1 '(1 1))
  )
  (setq pot (getpoint "\nУкажите точку :"))
  (cond
    (
     (null pot)
     (setq pot pot1)
    )
    (pot
     (setq
       p0x (cdr (assoc 10 sc-x-gr))
       p1x (cdr (assoc 11 sc-x-gr))
       p0y (cdr (assoc 10 sc-y-gr))
       p1y (cdr (assoc 11 sc-y-gr))
       ptx (inters p0x p1x pot (polar pot (angle p0y p1y) 1.0) nil)
       pty (inters p0y p1y pot (polar pot (angle p0x p1x) 1.0) nil)
       l0x (xdgetn sc-x-gr "SHCKALA" 0)
       l1x (xdgetn sc-x-gr "SHCKALA" 1)
       flx (xdgetn sc-x-gr "SHCKALA" 2)
       l0y (xdgetn sc-y-gr "SHCKALA" 0)
       l1y (xdgetn sc-y-gr "SHCKALA" 1)
       fly (xdgetn sc-y-gr "SHCKALA" 2)
     )
    )
  )

  (if
    (= flx 0)
     (if (equal (angle p0x ptx) (angle p0x p1x) 0.1)
       (setq lptx (+ l0x
		     (*	(- l1x l0x)
			(/ (distance ptx p0x) (distance p1x p0x))
		     )
		  )
       )
       (setq lptx (+ l0x
		     (*	(- l0x l1x)
			(/ (distance ptx p0x) (distance p1x p0x))
		     )
		  )
       )
     )
     (if (equal (angle p0x ptx) (angle p0x p1x) 0.1)
       (setq lptx (* l0x
		     (exp ((log (/ l1x l0x))
			    ;;!!!
			    (/ (distance ptx p0x) (distance p1x p0x))
			  )
		     )
		  )
       )
       (setq lptx (* l0x
		     (exp ((log (/ l0x l1x))
			    ;;!!!
			    (/ (distance ptx p0x) (distance p1x p0x))
			  )
		     )
		  )
       )
     )
  )
  (if
    (= fly 0)
     (if (equal (angle p0y pty) (angle p0y p1y) 0.1)
       (setq lpty (+ l0y
		     (*	(- l1y l0y)
			(/ (distance pty p0y) (distance p1y p0y))
		     )
		  )
       )
       (setq lpty (+ l0y
		     (*	(- l0y l1y)
			(/ (distance pty p0y) (distance p1y p0y))
		     )
		  )
       )
     )
     (if (equal (angle p0y pty) (angle p0y p1y) 0.1)
       (setq lpty (* l0y
		     (exp ((log (/ l1y l0y))
			    ;;!!!
			    (/ (distance pty p0y) (distance p1y p0y))
			  )
		     )
		  )
       )
       (setq lpty (* l0y
		     (exp ((log (/ l0y l1y))
			    ;;!!!
			    (/ (distance pty p0y) (distance p1y p0y))
			  )
		     )
		  )
       )
     )
  )
  (setq pot (list lptx lpty))
)

(defun
		ax:ac_b9
			(/ i ls)
  (setq	i  0
	ls nil
  )
  (while (< i c-pt-gr)
    (setq ls (cons (nth i pts-gr) ls)
	  i  (1+ i)
    )
  )
  (setq	ls (cons pot ls)
	i  (1+ i)
  )

  (while (< i n-pt-gr)
    (setq ls (cons (nth i pts-gr) ls)
	  i  (1+ i)
    )
  )
  (setq pts-gr (reverse ls))

  (setq n-pt-gr (length pts-gr))
  (ax:setup)
)

(defun ax:ac_b16 ()
  (alert
    "Разработал Матвеев Н.А.,\nг.Николаев, Украина\n\nТелефоны :\n\nдомашний - (0512) 228873\nрабочий  - (0512) 297411"
  )
)


(defun ax:ac_b17 () (setq p-ptgr (epr p-ptgr)))

(defun ax:ac_e2-3 ()
  (setq	pot
	 (list
	   (atof (get_tile "e2"))
	   (atof (get_tile "e3"))
	   0
	 )
  )
  (print pot)
)

(defun ax:ac_e1	(/ a)
  (setq a (atof (get_tile "e1")))
  (cond
    ((< a 0) (setq c-pt-gr 0))
    ((> a n-pt-gr) (setq c-pt-gr n-pt-gr))
    ((and (>= a 0) (<= a n-pt-gr))
     (setq c-pt-gr a)
    )
  )
  (ax:setup)
)

(defun ax:ac_e4 () (setq n-gr (get_tile "e4")))

(defun ax:ac_e5 () (princ "\nИзменеие имени шкалы x"))

(defun ax:ac_e6 () (princ "\nИзменеие имени шкалы y"))

(defun ax:ac_l1 (v) (setq c-pt-gr (atoi v)) (ax:setup))

(defun ax:ac_tile ()
  (action_tile "e1" "(ax:ac_e1)")
  (action_tile "e2" "(ax:ac_e2-3)")
  (action_tile "e3" "(ax:ac_e2-3)")

  (action_tile "e4" "(ax:ac_e4)")

  (action_tile "e5" "(ax:ac_e5)")
  (action_tile "e6" "(ax:ac_e6)")

  (action_tile "b1" "(ax:ac_b1)") ;"<<"
  (action_tile "b2" "(ax:ac_b2)") ;"<"
  (action_tile "e5" "(ax:ac_e5)")
  (action_tile "b3" "(ax:ac_b3)") ;">"
  (action_tile "b4" "(ax:ac_b4)") ;">>"
  (action_tile "b5" "(ax:ac_b5)") ;"Ins"
  (action_tile "b6" "(ax:ac_b6)") ;"Del"
  (action_tile "b7" "(ax:ac_b7)") ;"Del"
  (action_tile "b8" "(done_dialog 3)") ;"Pick"
  (action_tile "b9" "(ax:ac_b9)") ;"Edit"
  (action_tile "b12" "(done_dialog 4)") ;
  (action_tile "b14" "(done_dialog 5)") ;
  (action_tile "b16" "(ax:ac_b16)")
  (action_tile "b17" "(ax:ac_b17)")
  (action_tile "l1" "(ax:ac_l1 $value)") ;
)

(defun dr-axis-points  (sc-x-gr sc-y-gr pts-gr color)
  (princ sc-x-gr)
  (princ sc-y-gr)
  (princ pts-gr)
  (mapcar
    (function
      (lambda (el) (dr:point (sc:pxy_pt el (sh:get sc-x-gr) (sh:get sc-y-gr)) color)))
    pts-gr))
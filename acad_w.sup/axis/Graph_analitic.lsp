;;; an:analitic	- Функция выводит на экран диалог в котором можно задать в
;;;		  параметрическом виде функцию 2-х координат.
;;;		  Возвращает список координат.
;;; (an:analitic '((40 . 10.0) (41 . 20.0) (60 . 50) (70 . 0) (1 . "x_p") (2 . "y_p") (3 . "(defun x_p(p)p)")))
(defun an:analitic (l1 / t-min t-max n x-t y-t def fl l_pts act	do_dialog dcl_id ret)
  (if l1
    (setq
      t-min (cdr (assoc 40 l1))
      t-max (cdr (assoc 41 l1))
      fl    (cdr (assoc 70 l1))
      n	    (cdr (assoc 60 l1))
      x-t   (cdr (assoc 1 l1))
      y-t   (cdr (assoc 2 l1))
      def   (cdr (assoc 3 l1))
    )
  )

  (setq dcl_id (load_dialog (findfile "acad_w.sup/axis/axis.dcl")))
  (if (< dcl_id 0)
    (exit)
  )
  (setq do_dialog t)
  (while do_dialog
    (if	(not (new_dialog "panal" dcl_id))
      (exit)
    )
    (an:setup)
    (an:ac_tile)
    (setq act (start_dialog))
    (cond
      ((= act 0) (setq do_dialog nil) (setq ret (list nil l1)))
      ((= act 1)
       (setq do_dialog nil)
       (an:ac_b21)
       (setq l_pts
	      (mapcar
		(function (lambda (el) (list (cadr el) (caddr el))))
		l_pts
	      )
       )
       (setq ret
	      (list l_pts
		    (dsubst
		      l1
		      (list
			(cons 40 t-min)
			(cons 41 t-max)
			(cons 60 n)
			(cons 70 fl)
			(cons 1 x-t)
			(cons 2 y-t)
			(cons 3 def)
		      )
		    )
	      )
       )
      )
    )
  )
  (unload_dialog dcl_id)
  ret
)

(defun an:setup	()
  (set_tile "e20" (rtos t-min))
  (set_tile "e21" (rtos n))
  (set_tile "e22" (rtos t-max))
  (set_tile "e23" def)
  (set_tile "e24" x-t)
  (set_tile "e25" y-t)
  (cond
    ((= fl 0) (set_tile "r21" "1"))
    ((= fl 1) (set_tile "r22" "1"))
  )
)

(defun an:ac_b22 () (eval (read def)))

(defun an:ac_b21 (/ i nn)
  (setq
    xf	  (eval (read x-t))
    yf	  (eval (read y-t))
    l_pts nil
  )
  (if (null xf) (exit))
  (if (null yf) (exit))
  (setq i 0)
  (if (<= n 0)
    (setq nn 1)
    (setq nn n)
  )
  (while (<= i n)
    (if	(= fl 0)
      (setq tt (+ t-min (/ (* i (- t-max t-min)) nn)))
      (setq tt (* t-min (exp (/ (* (log (/ t-max t-min)) i) nn))))
    )
    (setq l_pts (cons (list tt (xf tt) (yf tt)) l_pts))
    (setq i (1+ i))
  )
  (setq l_pts (reverse l_pts))

  (setq
    l_txt
     (mapcar
       (function
	 (lambda (el)
	   (strcat
	     (rtos (car el))
	     " "
	     (rtos (cadr el))
	     " "
	     (rtos (caddr el))
	   )
	 )
       )
       l_pts
     )
  )
  (start_list "l21")
  (mapcar 'add_list l_txt)
  (end_list)
)


(defun an:ac_e20 () (setq t-min (atof (get_tile "e20"))))

(defun an:ac_e21 () (setq n (atoi (get_tile "e21"))))

(defun an:ac_e22 () (setq t-max (atof (get_tile "e22"))))

(defun an:ac_e23 () (setq def (get_tile "e23")))

(defun an:ac_r21 () (setq fl 0) (princ fl))

(defun an:ac_r22 () (setq fl 1) (princ fl))

(defun an:ac_tile  ()
  (action_tile "b22" "(an:ac_b22)")
  (action_tile "e20" "(an:ac_e20)")
  (action_tile "e21" "(an:ac_e21)")
  (action_tile "e22" "(an:ac_e22)")
  (action_tile "e23" "(an:ac_e23)")
  (action_tile "b21" "(an:ac_b21)")
  (action_tile "r21" "(an:ac_r21)")
  (action_tile "r22" "(an:ac_r22)"))
